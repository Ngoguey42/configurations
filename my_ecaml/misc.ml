let print s =
  (* Ecaml.Point.insert (s ^ "\n"); *)
  Ecaml.message s

let (--) start stop =
  let rec aux n acc =
    if n < start then acc else aux (n - 1) (n :: acc)
  in
  aux (stop - 1) []

let string_endswith s suf =
  let open String in
  let len = length s in
  let len' = length suf in
  len >= len' && sub s (len - len') len' = suf

let classify_filename s =
  let open String in
  let len = length s in
  if string_endswith s "_intf.ml" then sub s 0 (len - 8), `Intf
  else if string_endswith s ".mli" then sub s 0 (len - 4), `Mli
  else if string_endswith s ".ml" then sub s 0 (len - 3), `Ml
  else s, `None

let command_of_string s = Ecaml.Value.intern s |> Ecaml.Command.of_value_exn

let get_buffer_window_opt buffer =
  let v =
    Ecaml.Value.intern "get-buffer-window"
    |> (Fun.flip Ecaml.Value.funcall1) (Ecaml.Buffer.to_value buffer)
  in
  if Ecaml.Value.is_window v then Some (Ecaml.Window.of_value_exn v) else None
