module IntMap = Map.Make (struct
  type t = int

  let compare = compare
end)

let pat0 =
  "^\\([ ]*\\)" ^ "\\(" ^ "let +rec\\|module +type\\|class +type"
  ^ "\\|let\\|module\\|and\\|class\\|val\\|method" ^ "\\)" ^ "[ ]+" ^ "\\("
  ^ "\\([a-zA-Z0-9_]+\\)" ^ "\\)"
  |> Str.regexp

let info_of_line line =
  let m = Str.string_match pat0 line 0 in
  if m then
    let spaces = Str.matched_group 1 line in
    let kw = Str.matched_group 2 line in
    let tok = Str.matched_group 3 line in
    `Match (String.length spaces, kw, tok)
  else
    let depth =
      Seq.fold_left
        (fun acc c ->
          match (c, acc) with
          | _, `Stop _ -> acc
          | ' ', `Continue i -> `Continue (i + 1)
          | _, `Continue i -> `Stop i)
        (`Continue 0) (String.to_seq line)
    in
    match depth with `Stop i | `Continue i -> `Nomatch i

let string_of_map_rev m =
  List.fold_right
    (fun (depth, v) s -> Printf.sprintf "%s | %d:%s" s depth v)
    (IntMap.to_seq m |> List.of_seq)
    ""

let string_of_map m = IntMap.bindings m |> List.map snd |> String.concat " | "

let fold_lines lines =
  let rec aux acc = function
    | [] -> acc
    | line :: tl -> (
        match info_of_line line with
        | `Nomatch 0 ->
            (* Printf.printf "%100s -> %s\n%!" (string_of_map acc) line; *)
            aux acc tl
        | `Nomatch depth ->
            let acc, _, _ = IntMap.split depth acc in
            (* Printf.printf "%100s -> %s\n%!" (string_of_map acc) line; *)
            aux acc tl
        | `Match (depth, _, tok) ->
            let acc, _, _ = IntMap.split depth acc in
            let acc = IntMap.add depth tok acc in
            (* let acc = IntMap.add depth (kw ^ " " ^ tok) acc in *)
            (* Printf.printf "%100s +> %s\n%!" (string_of_map acc) line; *)
            aux acc tl )
  in
  aux IntMap.empty lines
