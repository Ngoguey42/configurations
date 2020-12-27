(*
  https://blag.bcc32.com/ecaml-getting-started/2017/11/12/emacs-plugins-in-ocaml-3
  https://b0-system.github.io/odig/doc/ecaml/Ecaml/index.html
  http://diobla.info/blog-archive/modules-tut.html

(fake-module-reload "/home/nico/configurations/my_ecaml/_build/default/my-ecaml.so")

*)
open Misc
open Persp
open Context_of_line

(* My C-f ******************************************************************* *)
let del_forward_blanks () =
  let rec aux () =
    let start = Ecaml.Point.get () in
    if Ecaml.Position.(start <= Ecaml.Point.max ()) then
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
  in
  aux ()

(* My dichotomy movement **************************************************** *)

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
    Ecaml.Point.count_lines ~start:(Ecaml.Point.min ())
      ~end_:(Ecaml.Point.max ())
  in

  let get_cols_min_max () =
    let p = Ecaml.Point.column_number () in
    let left =
      Ecaml.Point.beginning_of_line ();
      Ecaml.Point.column_number ()
    in
    let right =
      Ecaml.Point.end_of_line ();
      Ecaml.Point.column_number ()
    in
    Ecaml.Point.goto_column p;
    (left, right)
  in

  let get_rows_min_max () = (1, line_count) in

  let ( >>= ) o f = Option.iter f o in
  let rec move history =
    input history >>= fun input ->
    match input with
    | #horizontal as input -> (
        let a, z =
          match history with `H d -> d | `V _ -> get_cols_min_max ()
        in
        match input with
        | `Left ->
            let z = Ecaml.Point.column_number () in
            if a <> z then (
              Ecaml.Point.goto_column ((a + z) / 2);
              move (`H (a, z)) )
        | `Right ->
            let a = Ecaml.Point.column_number () in
            if a <> z then (
              Ecaml.Point.goto_column ((a + z + 1) / 2);
              move (`H (a, z)) ) )
    | #vertical as input -> (
        let a, z =
          match history with `V d -> d | `H _ -> get_rows_min_max ()
        in
        match input with
        | `Up ->
            let z = Ecaml.Point.line_number () in
            if a <> z then (
              Ecaml.Point.goto_line ((a + z) / 2);
              move (`V (a, z)) )
        | `Down ->
            let a = Ecaml.Point.line_number () in
            if a <> z then (
              Ecaml.Point.goto_line ((a + z + 1) / 2);
              move (`V (a, z)) ) )
  in
  move (`V (get_rows_min_max ()))

(* Buffer cycle in window for ocaml ********************************************
  Cycle between: 1. .ml -> 2. _inf.ml (if any) -> 3. .mli -> 1. *)

let my_find_alternate_file () =
  match current_filename () with
  | None -> ()
  | Some s -> (
      let prefix, klass = classify_filename s in
      let intf = prefix ^ "_intf.ml" in
      let mli = prefix ^ ".mli" in
      let ml = prefix ^ ".ml" in
      let cycle =
        match klass with
        | `Ml -> [ intf; mli ]
        | `Intf -> [ mli; ml ]
        | `Mli -> [ ml; intf ]
        | `None -> []
      in
      let file_exists s =
        let open Unix in
        match access s [ R_OK ] with
        | exception Unix_error _ -> false
        | () -> true
      in
      match List.find_opt file_exists cycle with
      | None -> Ecaml.message "No alternate file found"
      | Some path ->
          Ecaml.message ("Going to: " ^ path);
          Ecaml.Selected_window.find_file path |> ignore )

(* My `merlin-locate` support with persp ************************************ *)

let my_merlin_locate () =
  print "Retrieving current location...";
  let pname = current_persp () |> pname_of_persp in
  let window = Ecaml.Selected_window.get () in
  let winloc = winloc_of_window_exn window in
  let buffer = Ecaml.Window.buffer_exn window in
  let path =
    match buffer_filename buffer with
    | None -> failwith "Current buffer has no path"
    | Some p -> p
  in
  let line, column =
    (Ecaml.Point.line_number (), Ecaml.Point.column_number ())
  in
  let start = Some (Ecaml.Window.start window) in
  let oldloc = { pname; winloc; buffer; path; line; column; start } in

  print "Waiting for (merlin/locate)...";
  (* let path', line', col' = "/home/nico/r/irmin/src/irmin/commit.mli", 20, 20 in *)
  let path', line', column' = locate_symbol_at_point_exn () in
  let path' = Core.Filename.realpath path' in

  ( match find_window_for_file path' with
  | None ->
      print
      @@ Printf.sprintf "Open %s %d %d (in current window)" path' line' column';
      let pname' = pname in
      let window' = window in
      let winloc' = winloc in

      Ecaml.Value.Private.block_on_async [%here] (fun () ->
          Ecaml.Selected_window.find_file path');
      Ecaml.Point.goto_line_and_column
        Ecaml.Line_and_column.{ line = line'; column = column' };
      let buffer' = Ecaml.Window.buffer_exn window' in
      let newloc =
        {
          pname = pname';
          winloc = winloc';
          buffer = buffer';
          path = path';
          line = line';
          column = column';
          start = None;
        }
      in
      let a = { oldloc; newloc; volatile_buffer = true } in
      Stack.push a action_history.a_done;
      Stack.clear action_history.a_undone;

      ()
  | Some (pname', window') ->
      let winloc' = winloc_of_window_exn window' in
      print
      @@ Printf.sprintf "Gone to %s %s %s %d %d (found window for file)" pname'
           path' (string_of_winloc winloc') line' column';
      activate_pname_safe pname';
      Ecaml.Selected_window.set window';
      find_file_safe path';
      Ecaml.Point.goto_line_and_column
        Ecaml.Line_and_column.{ line = line'; column = column' };

      let buffer' = Ecaml.Window.buffer_exn window' in
      let newloc =
        {
          pname = pname';
          winloc = winloc';
          buffer = buffer';
          path = path';
          line = line';
          column = column';
          start = None;
        }
      in
      let a = { oldloc; newloc; volatile_buffer = false } in
      Stack.push a action_history.a_done;
      Stack.clear action_history.a_undone;

      () );

  ()

(* Context of line ********************************************************** *)

let my_context_of_line () =
  let lhs =
    Ecaml.Current_buffer.file_name ()
    |> Option.map (fun s -> s ^ " | ")
    |> Option.value ~default:""
  in
  let rhs =
    Ecaml.Current_buffer.contents ~end_:(Ecaml.Point.get ()) ()
    |> Ecaml.Text.to_utf8_bytes |> String.split_on_char '\n' |> fold_lines
    |> string_of_map
  in
  Ecaml.message (lhs ^ rhs)

(* Open github ************************************************************** *)

let open_github page_type () =
  let aux () =
    let ( let* ) v f = Result.map f v in
    let ( let+ ) v f = Result.bind v f in
    let+ path =
      current_filename ()
      |> Option.to_result ~none:"open_github failed: buffer not a file"
    in
    let+ dir =
      if Sys.is_directory path then Ok path
      else if Sys.file_exists path then Ok (Filename.dirname path)
      else Error "open_github failed: buffer strange"
    in
    let+ origin =
      Printf.sprintf "git -C '%s' remote get-url origin 2>/dev/null" dir
      |> first_line_of_cmd
      |> Option.to_result ~none:"open_github failed: couldn't fetch origin url"
    in
    let+ origin =
      if Base.String.substr_index origin ~pattern:"http" = None then
        Error "open_github failed: origin is not an http url"
      else Ok origin
    in
    let+ repo_root =
      Printf.sprintf "git -C '%s' rev-parse --show-toplevel 2>/dev/null" dir
      |> first_line_of_cmd
      |> Option.to_result
           ~none:"open_github failed: couldn't get the root of the repo"
    in
    let repo_root = Core.Filename.realpath repo_root in
    let+ path =
      Base.String.chop_prefix path ~prefix:repo_root
      |> Option.to_result
           ~none:"open_github failed: couldn't relate repo root with file"
    in
    let path =
      Base.String.strip ~drop:(function '/' -> true | _ -> false) path
    in
    let line = Ecaml.Point.line_number () in
    let url =
      match page_type with
      | `Blob -> Printf.sprintf "%s/blob/master/%s#L%d" origin path line
      | `Blame -> Printf.sprintf "%s/blame/master/%s#L%d" origin path line
      | `Commits -> Printf.sprintf "%s/commits/master/%s" origin path
    in
    first_line_of_cmd ("open " ^ url ^ " 2>/dev/null") |> ignore;
    print ("Opening: " ^ url);
    Ok ()
  in
  (match aux () with Error e -> print e | Ok _ -> ())

(* The rest ***************************************************************** *)

let override_merlin_lighter () =
  let g () = " 🧙" in
  Ecaml.defun_nullary
    (Ecaml.Symbol.intern "merlin-lighter")
    [%here] (Ecaml.Defun.Returns.Returns Ecaml.Value.Type.string) g

(** Set those shortcuts after merlin and such *)
let my_late_set_keys () =
  (* Remove a merlin shortcut that blocks my buf-move shortcuts *)
  unset_key ~seq:"C-c C-x";
  set_key ~command:"buf-move-right" ~seq:"C-c C-x <right>";
  set_key ~command:"buf-move-left" ~seq:"C-c C-x <left>";
  set_key ~command:"buf-move-up" ~seq:"C-c C-x <top>";
  set_key ~command:"buf-move-down" ~seq:"C-c C-x <down>";

  set_key ~command:"merlin-occurrences" ~seq:"C-c C-o";
  set_key ~command:"my-merlin-locate" ~seq:"C-c C-l";
  set_key ~command:"my-location-undo" ~seq:"C-c [";
  set_key ~command:"my-location-redo" ~seq:"C-c ]";

  override_merlin_lighter ();
  ()

let () =
  defun_noarg [%here] del_forward_blanks ~seq:"C-f" "del-forward-blanks";
  (* defun_noarg [%here] dicho_move ~seq:"C-q" "dicho-move"; *)
  defun_noarg [%here] my_context_of_line ~seq:"C-q" "my-context-of-line";
  defun_noarg [%here] my_find_alternate_file ~seq:"S-<f1>"
    "my-find-alternate-file";
  defun_noarg [%here] my_merlin_locate "my-merlin-locate";
  defun_noarg [%here] my_location_undo "my-location-undo";
  defun_noarg [%here] my_location_redo "my-location-redo";
  defun_noarg [%here] my_late_set_keys "my-late-set-keys";
  defun_noarg [%here] (open_github `Blob) ~seq:"C-c 1" "open_github_blob";
  defun_noarg [%here] (open_github `Blame) ~seq:"C-c 2" "open_github_blame";
  defun_noarg [%here] (open_github `Commits) ~seq:"C-c 3" "open_github_commits";

  Ecaml.provide ("my-ecaml" |> Ecaml.Symbol.intern);
  ()
