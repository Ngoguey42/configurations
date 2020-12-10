(*
  https://blag.bcc32.com/ecaml-getting-started/2017/11/12/emacs-plugins-in-ocaml-3
  https://b0-system.github.io/odig/doc/ecaml/Ecaml/index.html
  http://diobla.info/blog-archive/modules-tut.html

(fake-module-reload "/home/nico/configurations/my_ecaml/_build/default/my-ecaml.so")

*)
open Misc
open Persp

let del_forward_blanks () =
  let rec aux () =
    let start = Ecaml.Point.get () in
    if Ecaml.Position.(start <= Ecaml.Point.max ()) then (
      let end_ = Ecaml.Position.add start 1 in
      let s =
        Ecaml.Current_buffer.contents ~start ~end_ ()
        |> Ecaml.Text.to_utf8_bytes
      in
      match s with
      | " " | "\t" | "\n" ->
         Ecaml.Current_buffer.delete_region ~start ~end_;
         aux ()
      | _ -> ()
    )
  in
  aux ()

type horizontal = [ `Left | `Right ]
type vertical = [ `Up | `Down ]

let dicho_move () =
  let input history =
    let prompt =
      match history with
      | `H (a, b) -> Printf.sprintf "Dicho h-%3d" (b - a)
      | `V (a, b) -> Printf.sprintf "Dicho v-%3d" (b - a)
    in
    let seq = Ecaml.Key_sequence.read ~prompt () in
    assert (Ecaml.Key_sequence.length seq = 1);
    let k = Ecaml.Key_sequence.get seq 0 |> Ecaml.Input_event.description in
    match k with
    | "<left>" -> Some `Left
    | "<right>" -> Some `Right
    | "<up>" -> Some `Up
    | "<down>" -> Some `Down
    | _ -> None
  in

  let line_count =
    Ecaml.Point.count_lines ~start:(Ecaml.Point.min ()) ~end_:(Ecaml.Point.max ())
  in

  let get_cols_min_max () =
    let p = Ecaml.Point.column_number () in
    let left = Ecaml.Point.beginning_of_line (); Ecaml.Point.column_number () in
    let right = Ecaml.Point.end_of_line (); Ecaml.Point.column_number () in
    Ecaml.Point.goto_column p;
    left, right
  in

  let get_rows_min_max () = 1, line_count in

  let (>>=) o f = Option.iter f o in
  let rec move history =
    input history >>= fun input ->

    match input with
    | #horizontal as input ->
       let a, z = match history with `H d -> d | `V _ -> get_cols_min_max () in
       begin match input with
       | `Left ->
          let z = Ecaml.Point.column_number () in
          if a <> z then (
            Ecaml.Point.goto_column ((a + z) / 2);
            move (`H (a, z))
          )
       | `Right ->
          let a = Ecaml.Point.column_number () in
          if a <> z then (
            Ecaml.Point.goto_column ((a + z + 1) / 2);
            move (`H (a, z))
          )
       end
    | #vertical as input ->
       let a, z = match history with `V d -> d | `H _ -> get_rows_min_max () in
       begin match input with
       | `Up ->
          let z = Ecaml.Point.line_number () in
          if a <> z then (
            Ecaml.Point.goto_line ((a + z) / 2);
            move (`V (a, z))
          )
       | `Down ->
          let a = Ecaml.Point.line_number () in
          if a <> z then (
            Ecaml.Point.goto_line ((a + z + 1) / 2);
            move (`V (a, z))
          )
       end
  in
  move (`V (get_rows_min_max ()))

(** Cycle between: 1. .ml -> 2. _inf.ml (if any) -> 3. .mli -> 1. *)
let my_find_alternate_file () =
  match Ecaml.Current_buffer.file_name () with
  | None -> ()
  | Some s ->
     let prefix, klass = classify_filename s in
     let intf = prefix ^ "_intf.ml" in
     let mli = prefix ^ ".mli" in
     let ml = prefix ^ ".ml" in
     let cycle = match klass with
       | `Ml -> [intf; mli]
       | `Intf -> [mli; ml]
       | `Mli -> [ml; intf]
       | `None -> []
     in
     let file_exists s =
       let open Unix in
       match access s [R_OK] with
       | exception Unix_error _ -> false
       | () -> true
     in
     match List.find_opt file_exists cycle with
     | None -> Ecaml.message "No alternate file found"
     | Some path ->
        Ecaml.message ("Going to: " ^ path);
        Ecaml.Selected_window.find_file path |> ignore


let find_pname_and_buffer_for_path needle : (string * _) option =
  let nprefix, nklass = classify_filename needle in

  let folder pname path buffer previous_match =
    let prefix, klass = classify_filename path in
    match prefix = nprefix, klass = nklass with
    | true, true ->
       (* Found the exact path, stop iteration *)
       false, `Perfect (pname, buffer)
    | true, false ->
       (* Found a file with the right prefix, continue looking for a perfect
          match. If previous was `Partial too, discard it. *)
       true, `Partial (pname, buffer)
    | false, (true | false) ->
       true, previous_match
  in

  let rec fold_buffers pname buffers acc k =
    match buffers with
    | [] -> k acc
    | (path, buffer)::tl ->
       let continue, acc = folder pname path buffer acc in
       let interdead = Ecaml.Buffer.is_internal_or_dead buffer in
       let _win =
         Ecaml.Value.intern "get-buffer-window"
         |> (Fun.flip Ecaml.Value.funcall1) (Ecaml.Buffer.to_value buffer)
         |> Ecaml.Value.sexp_of_t
         |> Sexplib.Sexp.to_string
         (* |> Ecaml.to_utf8_bytes_exn *)
         (* if interdead then "none" *)
         (* else *)
           (* Ecaml.Window.(get_buffer_window buffer |> buffer_exn) == buffer *)
       in
       (* let live = Ecaml.Buffer.is_live buffer in *)
       let name = match Ecaml.Buffer.name buffer with None -> "none" | Some s -> s in
       Printf.sprintf "  %s %s cont=%b interdead=%b win=%s" path name continue interdead _win |> print;
       if continue then (fold_buffers [@tailrec]) pname tl acc k else acc

  and fold_pnames pnames acc =
    match pnames with
    | [] -> acc
    | pname::tl ->
       let buffers = persp_of_pname pname |> buffers_with_filename_of_persp in
       Printf.sprintf "<%s> %d buffers" pname (List.length buffers) |> print;
       let k = (fun acc -> (fold_pnames [@tailrec]) tl acc) in
       (fold_buffers [@tailrec]) pname buffers acc k
  in

  match (fold_pnames [@tailrec]) (pnames ()) `None with
  | `None -> None
  | `Partial tup | `Perfect tup -> Some tup

let goto pname window buffer position start =
  let current_pname = current_persp () |> pname_of_persp in
  if current_pname <> pname then activate_pname pname;
  Ecaml.Selected_window.set window;
  Ecaml.Selected_window.Blocking.switch_to_buffer buffer;
  (match start with
  | None -> ()
  | Some start -> Ecaml.Window.set_start window start);
  (match position with
  | `Pos position -> Ecaml.Point.goto_char position
  | `Linecol (line, column) ->
     Ecaml.Point.goto_line_and_column Ecaml.Line_and_column.{line; column})

let my_merlin_pop_stack_undo () =
  match Stack.pop_opt action_history.a_done with
  | None -> print "Nothing to undo"
  | Some ({ pname = (`Stay pname | `Switch (pname, _))
         ; window = (`Stay window | `Switch (window, _))
         ; buffer = `Switch (_path, buffer, _path', buffer')
         ; new_buffer
         ; position = (position, _)
         ; start = (start, _) } as a) ->
     Printf.sprintf "Gone back to %s %s" pname _path |> print;
     goto pname window buffer (`Pos position) (Some start);
     if new_buffer then Ecaml.Buffer.Blocking.kill buffer';
     Stack.push a action_history.a_undone
  | Some ({ pname = (`Stay pname | `Switch (pname, _))
         ; window = (`Stay window | `Switch (window, _))
         ; buffer = `Stay (_path, buffer)
         ; new_buffer = _
         ; position = (position, _)
         ; start = (start, _) } as a) ->
     Printf.sprintf "Gone back to %s %s" pname _path |> print;
     goto pname window buffer (`Pos position) (Some start);
     Stack.push a action_history.a_undone

(* let my_merlin_pop_stack_redo () =
 *   match Stack.pop_opt action_history.a_undone with
 *   | None -> print "Nothing to redo"
 *   | Some ({ pname = (`Stay pname' | `Switch (_, pname'))
 *          ; window = (`Stay window' | `Switch (_, window'))
 *          ; buffer = `Switch (_, _, _, buffer')
 *          ; new_buffer
 *          ; position = (position, _)
 *          ; start = (start, _) } as a) ->
 *      goto pname' window' buffer' position' start';
 *      if new_buffer then Ecaml.Buffer.Blocking.kill buffer';
 *      Stack.push a action_history.a_done
 *   | Some ({ pname = (`Stay pname | `Switch (pname, _))
 *          ; window = (`Stay window | `Switch (window, _))
 *          ; buffer = `Stay (_path, buffer)
 *          ; new_buffer = _
 *          ; position = (position, _)
 *          ; start = (start, _) } as a) ->
 *      goto pname' window' buffer' position' start';
 *      Stack.push a action_history.a_done *)

let my_merlin_locate () =
  print "Retrieving current location...";
  let pname = current_persp () |> pname_of_persp in
  let window = Ecaml.Selected_window.get () in
  let buffer = Ecaml.Window.buffer_exn window in
  let path = Ecaml.Buffer.file_name buffer |> Option.get in
  let position = Ecaml.Window.point_exn window in
  let start = Ecaml.Window.start window in

  print "Waiting for (merlin/locate)...";
  (* let path', line', col' = "/home/nico/r/irmin/src/irmin/commit.mli", 20, 20 in *)
  let path', line', col' = locate_symbol_at_point_exn () in
  let path' = Core.Filename.realpath path' in

  begin
    match find_window_for_file path' with
    | None ->
       let pname' = pname in
       let window' = window in

       Ecaml.Value.Private.block_on_async [%here]
         (fun () -> Ecaml.Selected_window.find_file path');
       Ecaml.Point.goto_line_and_column Ecaml.Line_and_column.{
           line = line'; column = col'
       };
       (* Ecaml.Point.recenter (); *)

       let position' = Ecaml.Window.point_exn window' in
       let start' = Ecaml.Window.start window' in
       let buffer' = Ecaml.Window.buffer_exn window' in
       ignore (pname', window', buffer', path', position', start')

    | Some (pname', window') ->
       activate_pname pname';
       Ecaml.Selected_window.set window';
       Ecaml.Value.Private.block_on_async [%here]
         (fun () -> Ecaml.Selected_window.find_file path');
       Ecaml.Point.goto_line_and_column Ecaml.Line_and_column.{
           line = line'; column = col'
       };
       (* Ecaml.Point.recenter (); *)

       let position' = Ecaml.Window.point_exn window' in
       let start' = Ecaml.Window.start window' in
       let buffer' = Ecaml.Window.buffer_exn window' in
       ignore (pname', window', buffer', path', position', start')


    (* match find_pname_and_buffer_for_path path' with
     * | None ->
     *    Printf.sprintf "Showing %s %d %d in current window." path' line' col'
     *    |> print;
     *
     *    (\* Ecaml.Value.Private.block_on_async [%here]
     *     *   (fun () -> Ecaml.Selected_window.find_file path');
     *     * let buffer' = Ecaml.Window.buffer_exn window in
     *     *
     *     * Ecaml.Point.goto_line_and_column Ecaml.Line_and_column.{
     *     *     line = line'; column = col'
     *     * };
     *     * let position' = Ecaml.Window.point_exn window in
     *     * let start' = Ecaml.Window.start window in
     *     *
     *     * let a = {
     *     *     pname = `Stay pname
     *     *   ; window = `Stay window
     *     *   ; buffer = `Switch (path, buffer, path', buffer')
     *     *   ; new_buffer = true
     *     *   ; position = position, position'
     *     *   ; start = start, start'
     *     *   }
     *     * in
     *     * Stack.clear action_history.a_undone;
     *     * Stack.push a action_history.a_done; *\)
     *
     * | Some (_pname', _buffer') ->
     * (\* | Some (pname', buffer') -> *\)
     *    Printf.sprintf "Showing %s %d %d in persp." path' line' col'
     *    |> print;
     *    (\* let window' = Ecaml.Window.get_buffer_window buffer' in
     *     * goto pname' window' buffer' (`Linecol (line', col')) None;
     *     *
     *     * let position' = Ecaml.Window.point_exn window in
     *     * let start' = Ecaml.Window.start window in
     *     * let a = {
     *     *     pname = if pname = pname' then `Stay pname
     *     *             else `Switch (pname, pname')
     *     *   ; window = `Stay window
     *     *   ; buffer = `Switch (path, buffer, path', buffer')
     *     *   ; new_buffer = true
     *     *   ; position = position, position'
     *     *   ; start = start, start'
     *     *   }
     *     * in
     *     * Stack.clear action_history.a_undone;
     *     * Stack.push a action_history.a_done; *\) *)

  end;

  ()

let set_key ~command ~seq =
  let gkm = Ecaml.Keymap.global () in
  let command = Ecaml.Keymap.Entry.Command (command_of_string command) in
  let seq = Ecaml.Key_sequence.create_exn seq in
  let abs = Ecaml.Keymap.Entry.Absent in
  (* Unset everywhere before *)
  [ gkm ]
  @ (Ecaml.Current_buffer.minor_mode_keymaps ())
  @ (Ecaml.Current_buffer.local_keymap () |> Option.to_list)
  |> List.iter (fun km -> Ecaml.Keymap.define_key km seq abs);
  (* Set in global *)
  Ecaml.Keymap.define_key gkm seq command;
  ()

let my_late_set_keys () =
  set_key ~command:"my-merlin-locate" ~seq:"C-c C-l"

let () =
  Ecaml.defun_nullary_nil
    ("del-forward-blanks" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    del_forward_blanks;
  set_key ~command:"del-forward-blanks" ~seq:"C-f";

  Ecaml.defun_nullary_nil
    ("dicho-move" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    dicho_move;
  set_key ~command:"dicho-move" ~seq:"C-q";

  Ecaml.defun_nullary_nil
    ("my-find-alternate-file" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    my_find_alternate_file;
  set_key ~command:"my-find-alternate-file" ~seq:"S-<f1>";

  Ecaml.defun_nullary_nil
    ("my-merlin-locate" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    my_merlin_locate;

  Ecaml.defun_nullary_nil
    ("my-merlin-pop-stack-undo" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    my_merlin_pop_stack_undo;

  Ecaml.defun_nullary_nil
    ("my-late-set-keys" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    my_late_set_keys;

  Ecaml.provide ("my-ecaml" |> Ecaml.Symbol.intern);
  ()
