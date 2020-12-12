(* All utilities involving persp-mode (but not merlin or such). *)

open Misc

(* Type shortcuts *)
type persp = [ `Persp of Ecaml.Value.t ]

type window = Ecaml.Window.t

type buffer = Ecaml.Buffer.t

type position = Ecaml.Position.t

(* Helper function *)
let pnames () : string list =
  let pnames =
    Ecaml.Value.intern "persp-names"
    |> Ecaml.Value.funcall0
    |> Ecaml.Value.to_list_exn ~f:Fun.id
    |> List.filter Ecaml.Value.is_string
    |> List.map Ecaml.Value.to_utf8_bytes_exn
  in
  let la, lb =
    pnames |> List.partition (fun s -> s = "none" || s = "default")
  in
  if List.length lb = 0 then la else lb

let persp_of_pname s : [ `Persp of _ ] =
  `Persp
    ( Ecaml.Value.intern "persp-get-by-name"
    |> (Fun.flip Ecaml.Value.funcall1) (Ecaml.Value.of_utf8_bytes s) )

let current_persp () : [ `Persp of _ ] =
  `Persp (Ecaml.Value.intern "get-current-persp" |> Ecaml.Value.funcall0)

let pname_of_persp (`Persp p) : string =
  Ecaml.Value.intern "safe-persp-name"
  |> (Fun.flip Ecaml.Value.funcall1) p
  |> Ecaml.Value.to_utf8_bytes_exn

let buffers_of_persp (`Persp p) : _ list =
  (* May not work well when a file was just opened... *)
  Ecaml.Value.intern "safe-persp-buffers"
  |> (Fun.flip Ecaml.Value.funcall1) p
  |> Ecaml.Value.to_list_exn ~f:Ecaml.Buffer.of_value_exn

let buffers_with_filename_of_persp p : (string * _) list =
  List.filter_map
    (fun buffer ->
      match buffer_filename buffer with
      | None -> None
      | Some s -> Some (s, buffer))
    (buffers_of_persp p)

let activate_pname_safe pname =
  let current_pname = current_persp () |> pname_of_persp in
  if current_pname <> pname then
    let (`Persp persp) = persp_of_pname pname in
    Ecaml.Value.funcall2
      (Ecaml.Value.intern "persp-activate")
      persp
      (Ecaml.Value.intern "selected-frame" |> Ecaml.Value.funcall0)
    |> ignore

(* Global states
   `start` cannot reliably extracted after a point movement,
   so let's not save it for destination locations (doesn't change anything)
 *)
type location = {
  pname : string;
  winloc : winloc;
  buffer : buffer;
  path : string;
  line : int;
  column : int;
  start : position option;
}

let goto { pname; winloc; buffer; path; line; column; start } =
  activate_pname_safe pname;
  let window = window_of_winloc_exn winloc in

  Ecaml.Selected_window.set window;
  if Ecaml.Buffer.is_live buffer then
    Ecaml.Selected_window.Blocking.switch_to_buffer buffer
  else find_file_safe path;

  Ecaml.Point.goto_line_and_column Ecaml.Line_and_column.{ line; column };
  (match start with
  | None -> ()
  | Some start -> Ecaml.Window.set_start window start);
  ()

type action = { oldloc : location; newloc : location; volatile_buffer : bool }

type actions = { a_done : action Stack.t; a_undone : action Stack.t }

let action_history = { a_done = Stack.create (); a_undone = Stack.create () }

let my_location_undo () =
  match Stack.pop_opt action_history.a_done with
  | None -> print "Nothing to undo"
  | Some ({ oldloc; newloc; volatile_buffer } as a) ->
      let kill = volatile_buffer && not (same_path oldloc.path newloc.path) in
      if kill then Ecaml.Buffer.Blocking.kill newloc.buffer;
      Stack.push a action_history.a_undone;
      goto oldloc;
      print
      @@ Printf.sprintf "Gone back to #%s %s %s %d %d%s" oldloc.pname oldloc.path
           (string_of_winloc oldloc.winloc)
           oldloc.line oldloc.column
           (if kill then " (and killed other)" else "")

let my_location_redo () =
  match Stack.pop_opt action_history.a_undone with
  | None -> print "Nothing to redo"
  | Some ({ newloc; _ } as a) ->
      Stack.push a action_history.a_done;
      goto newloc;
      print
      @@ Printf.sprintf "Gone again to #%s %s %s %d %d" newloc.pname newloc.path
           (string_of_winloc newloc.winloc)
           newloc.line newloc.column

(* Higher level helpers *)
let locate_symbol_at_point_exn () =
  let res = Ecaml.Value.intern "merlin/locate" |> Ecaml.Value.funcall0 in
  let path =
    res |> Ecaml.Value.cdr_exn |> Ecaml.Value.car_exn |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.to_utf8_bytes_exn
  in
  let line =
    res |> Ecaml.Value.cdr_exn |> Ecaml.Value.cdr_exn |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn |> Ecaml.Value.cdr_exn |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn |> Ecaml.Value.to_int_exn
  in
  let col =
    res |> Ecaml.Value.cdr_exn |> Ecaml.Value.cdr_exn |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn |> Ecaml.Value.cdr_exn |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn |> Ecaml.Value.cdr_exn |> Ecaml.Value.to_int_exn
  in
  (path, line, col)

let find_window_for_file needle : (string * window) option =
  (* Will change the perspective because we are only looking for buffers with
     a window attached.
     Record previous state before calling. *)
  let nprefix, nklass = classify_filename needle in

  let pname0 = current_persp () |> pname_of_persp in
  let buffer0_opt =
    let b = Ecaml.Selected_window.get () |> Ecaml.Window.buffer_exn in
    match buffer_filename b with None -> None | Some s -> Some (s, b)
  in

  let folder pname path buffer previous_match =
    let prefix, klass = classify_filename path in
    if prefix <> nprefix then (
      print @@ Printf.sprintf "  %s doesnt match" path;
      (true, previous_match) )
    else (
      activate_pname_safe pname;
      match (get_buffer_window_opt buffer, klass = nklass, previous_match) with
      | None, _, _ ->
          print @@ Printf.sprintf "  %s match but doesnt have a window" path;
          (true, previous_match)
      | Some window, true, _ ->
          print @@ Printf.sprintf "  %s match (stop iteration)" path;
          (false, `Perfect (pname, window))
      | Some window, false, `None ->
          (* Only keep very first `Partial match *)
          print @@ Printf.sprintf "  %s match (continue iteration)" path;
          (false, `Partial (pname, window))
      | Some _, false, _ ->
          print @@ Printf.sprintf "  %s match but already have a partial" path;
          (true, previous_match) )
  in

  let rec fold_buffers pname buffers acc k =
    match buffers with
    | [] -> k acc
    | (path, buffer) :: tl ->
        let continue, acc = folder pname path buffer acc in
        if continue then (fold_buffers [@tailrec]) pname tl acc k else acc
  and fold_pnames pnames acc =
    match pnames with
    | [] -> acc
    | pname :: tl ->
        let buffers = persp_of_pname pname |> buffers_with_filename_of_persp in
        let buffers =
          (* Start with current buffer (if current persp) in order to give it a
             higher priority *)
          match (pname = pname0, buffer0_opt) with
          | false, _ | _, None -> buffers
          | true, Some buffer0 ->
              let not_buffer0 b = not (Ecaml.Buffer.eq (snd buffer0) b) in
              buffer0::List.filter (fun (_, b) -> not_buffer0 b) buffers
        in

        print
        @@ Printf.sprintf "<%s> has %d buffers" pname (List.length buffers);
        (fold_buffers [@tailrec]) pname buffers acc @@ fun acc ->
        (fold_pnames [@tailrec]) tl acc
  in

  (* Start with current persp in order to give it a higher priority *)
  let pnames = pname0 :: (pnames () |> List.filter (( <> ) pname0)) in
  match (fold_pnames [@tailrec]) pnames `None with
  | `None -> None
  | `Perfect tup | `Partial tup -> Some tup
