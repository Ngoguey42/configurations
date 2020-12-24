(* Misc ********************************************************************* *)

let print s =
  (* Ecaml.Point.insert (s ^ "\n"); *)
  Ecaml.message s

let ( -- ) start stop =
  let rec aux n acc = if n < start then acc else aux (n - 1) (n :: acc) in
  aux (stop - 1) []

let string_endswith s suf =
  let open String in
  let len = length s in
  let len' = length suf in
  len >= len' && sub s (len - len') len' = suf

let classify_filename s =
  let open String in
  let len = length s in
  if string_endswith s "_intf.ml" then (sub s 0 (len - 8), `Intf)
  else if string_endswith s ".mli" then (sub s 0 (len - 4), `Mli)
  else if string_endswith s ".ml" then (sub s 0 (len - 3), `Ml)
  else (s, `None)

let first_line_of_cmd cmd =
  let rec read_lines chan =
    match input_line chan with
    | exception End_of_file -> []
    | s -> s :: read_lines chan
  in
  let chan = Unix.open_process_in cmd in
  let l = read_lines chan in
  match (Unix.close_process_in chan, l) with
  | Unix.WEXITED 0, [ s ] -> Some s
  | _, _ -> None

(* Real path manipulations ************************************************** *)

let same_path p q = Core.Filename.realpath p = Core.Filename.realpath q

let buffer_filename b =
  Ecaml.Buffer.file_name b |> Option.map Core.Filename.realpath

let current_filename () =
  Ecaml.Current_buffer.file_name () |> Option.map Core.Filename.realpath

(* Set and unset commands and shortcuts ************************************* *)

let unset_key ~seq =
  let gkm = Ecaml.Keymap.global () in
  let seq = Ecaml.Key_sequence.create_exn seq in
  let abs = Ecaml.Keymap.Entry.Absent in
  [ gkm ]
  @ Ecaml.Current_buffer.minor_mode_keymaps ()
  @ (Ecaml.Current_buffer.local_keymap () |> Option.to_list)
  |> List.iter (fun km -> Ecaml.Keymap.define_key km seq abs);
  ()

let set_key ~command ~seq =
  unset_key ~seq;
  let seq = Ecaml.Key_sequence.create_exn seq in
  let gkm = Ecaml.Keymap.global () in
  let command =
    Ecaml.Keymap.Entry.Command
      (Ecaml.Value.intern command |> Ecaml.Command.of_value_exn)
  in
  Ecaml.Keymap.define_key gkm seq command;
  ()

let defun_noarg thingy f ?seq command =
  Ecaml.defun_nullary_nil
    (Ecaml.Symbol.intern command)
    thingy ~interactive:No_arg f;
  match seq with None -> () | Some seq -> set_key ~command ~seq

(* Window location in frame ************************************************* *)

type winloc = [ `Node of int * winloc | `Leaf ]

let string_of_winloc wl =
  let rec aux = function
    | `Leaf -> []
    | `Node (i, wl) -> string_of_int i :: aux wl
  in
  "[" ^ String.concat " ; " (aux wl) ^ "]"

let winloc_of_window_exn needle : winloc =
  let open Ecaml.Window.Tree in
  let rec fold_window_tree wintree k : winloc option =
    match wintree with
    | Window win when Ecaml.Window.eq win needle -> k (Some `Leaf)
    | Window _ -> k None
    | Combination { children; _ } -> fold_children children 0 k
  and fold_children children i k : winloc option =
    match children with
    | [] -> k None
    | hd :: tl -> (
        fold_window_tree hd @@ function
        | Some winloc -> k (Some (`Node (i, winloc)))
        | None -> fold_children tl (i + 1) k )
  in
  match fold_window_tree Ecaml.Frame.(selected () |> window_tree) Fun.id with
  | None -> failwith "Could not find window in wintree"
  | Some winloc -> winloc

let window_of_winloc_exn winloc : Ecaml.Window.t =
  let open Ecaml.Window.Tree in
  let rec aux winloc wintree =
    match (winloc, wintree) with
    | `Leaf, Window win -> win
    | `Leaf, Combination _ ->
        failwith "Could not find winloc in wintree (expected no Combination)"
    | `Node _, Window _ ->
        failwith "Could not find winloc in wintree (expected a Combination)"
    | `Node (i, _), Combination { children; _ } when List.length children <= i
      ->
        failwith "Could not find winloc in wintree (expected more children)"
    | `Node (i, winloc), Combination { children; _ } ->
        aux winloc (List.nth children i)
  in
  aux winloc Ecaml.Frame.(selected () |> window_tree)

(* Misc again *************************************************************** *)

(* Safe version of ecaml's get_buffer_window
   https://github.com/janestreet/ecaml/issues/10 *)
let get_buffer_window_opt buffer =
  let v =
    Ecaml.Value.intern "get-buffer-window"
    |> (Fun.flip Ecaml.Value.funcall1) (Ecaml.Buffer.to_value buffer)
  in
  if Ecaml.Value.is_window v then Some (Ecaml.Window.of_value_exn v) else None

(* Safe and sync `find_file` *)
let find_file_safe path =
  let act =
    match
      Ecaml.Selected_window.get () |> Ecaml.Window.buffer_exn |> buffer_filename
    with
    | None -> false
    | Some path' -> not (same_path path path')
  in
  if act then
    Ecaml.Value.Private.block_on_async [%here] (fun () ->
        Ecaml.Selected_window.find_file path)

(* End ********************************************************************** *)
