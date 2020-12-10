open Misc

(* Type shortcuts *)
type persp = [ `Persp of Ecaml.Value.t ]
type window = Ecaml.Window.t
type buffer = Ecaml.Buffer.t
type position = Ecaml.Position.t

(* Helper function *)
let pnames () : string list =
  Ecaml.Value.intern "persp-names"
  |> Ecaml.Value.funcall0
  |> Ecaml.Value.to_list_exn ~f:Fun.id
  |> List.filter Ecaml.Value.is_string
  |> List.map Ecaml.Value.to_utf8_bytes_exn
  |> List.filter (fun s -> s <> "none" && s <> "default") (* TODO: Add back *)

let persp_of_pname s : [`Persp of _] =
  `Persp (Ecaml.Value.intern "persp-get-by-name"
          |> (Fun.flip Ecaml.Value.funcall1) (Ecaml.Value.of_utf8_bytes s))

let current_persp () : [`Persp of _] =
  `Persp (Ecaml.Value.intern "get-current-persp"
          |> Ecaml.Value.funcall0)

let pname_of_persp (`Persp p) : string =
  Ecaml.Value.intern "safe-persp-name"
  |> (Fun.flip Ecaml.Value.funcall1) p
  |> Ecaml.Value.to_utf8_bytes_exn

let buffers_of_persp (`Persp p) : _ list =
  (* May not work well when *)
  Ecaml.Value.intern "safe-persp-buffers"
  |> (Fun.flip Ecaml.Value.funcall1) p
  |> Ecaml.Value.to_list_exn ~f:Ecaml.Buffer.of_value_exn

let buffers_with_filename_of_persp p : (string * _) list =
  List.filter_map
    (fun buffer ->
      match Ecaml.Buffer.file_name buffer with
      | None -> None
      | Some s ->
         Some (Core.Filename.realpath s, buffer)
    )
    (buffers_of_persp p)

let activate_pname pname =
  let current_pname = current_persp () |> pname_of_persp in
  if current_pname <> pname then
    let `Persp persp = persp_of_pname pname in
    Ecaml.Value.funcall2
      (Ecaml.Value.intern "persp-activate")
      persp
      (Ecaml.Value.intern "selected-frame" |> Ecaml.Value.funcall0)
    |> ignore

(* (\* Global states *\)
 * type action = {
 *     pname : [ `Stay of string
 *             | `Switch of string * string ]
 *   ; window : [ `Stay of Ecaml.Window.t
 *              | `Switch of Ecaml.Window.t * Ecaml.Window.t ]
 *   ; buffer : [ `Stay of string * Ecaml.Buffer.t
 *              | `Switch of string * Ecaml.Buffer.t * string * Ecaml.Buffer.t ]
 *   ; new_buffer : bool
 *   ; position : Ecaml.Position.t * Ecaml.Position.t
 *   ; start : Ecaml.Position.t * Ecaml.Position.t
 *   }
 *
 * type actions = {
 *     a_done : action Stack.t
 *   ; a_undone : action Stack.t
 *   }
 *
 * let action_history = { a_done = Stack.create (); a_undone = Stack.create () } *)

(* Higher level helpers *)
let locate_symbol_at_point_exn () =
  let res =
    Ecaml.Value.intern "merlin/locate"
    |> Ecaml.Value.funcall0
  in
  let path =
    res
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.to_utf8_bytes_exn
  in
  let line =
    res
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.to_int_exn
  in
  let col =
    res
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.car_exn
    |> Ecaml.Value.cdr_exn
    |> Ecaml.Value.to_int_exn
  in
  path, line, col

let find_window_for_file needle : (string * window) option =
  (* Will change the perspective!!! Record previous state before calling *)

  let nprefix, _nklass = classify_filename needle in

  let folder pname path buffer previous_match =
    let prefix, _klass = classify_filename path in
    if prefix <> nprefix then (
      print @@ Printf.sprintf "  %s doesnt match" path;
      true, previous_match
    )
    else (
      activate_pname pname;
      match get_buffer_window_opt buffer with
      | None ->
         print @@ Printf.sprintf "  %s match but doesnt have a window" path;
         true, previous_match
      | Some window ->
         print @@ Printf.sprintf "  %s match (stop iteration)" path;
         false, Some (pname, window)
    )
  in

  let rec fold_buffers pname buffers acc k =
    match buffers with
    | [] -> k acc
    | (path, buffer)::tl ->
       let continue, acc = folder pname path buffer acc in
       if continue then (fold_buffers [@tailrec]) pname tl acc k else acc

  and fold_pnames pnames acc =
    match pnames with
    | [] -> acc
    | pname::tl ->
       let buffers = persp_of_pname pname |> buffers_with_filename_of_persp in
       print @@ Printf.sprintf "<%s> has %d buffers" pname (List.length buffers);
       (fold_buffers [@tailrec]) pname buffers acc
       @@ fun acc -> (fold_pnames [@tailrec]) tl acc
  in

  (fold_pnames [@tailrec]) (pnames ()) None
