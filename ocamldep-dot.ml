(*
  From a list of files (in the same directory) to a png
  ocaml unix.cma ~/configurations/ocamldep-dot.ml $FILES > d.dot && dot -Tpng d.dot -o d.png && open d.png

  From a repo made of several dune packages and optionally the name of one of those package
  dune-deps $DIR -h $MODNAME --no-ext | tred > dunedeps.dot && dot -Tpng dunedeps.dot -o dunedeps.png && open dunedeps.png
 *)

module String_set = Set.Make (struct
  type t = string

  let compare = compare
end)

let rec read_lines chan =
  match input_line chan with
  | exception End_of_file -> []
  | s -> s :: read_lines chan

let process_file_dep s =
  match String.split_on_char ':' s with
  | [ fpath; deps ] ->
      let fpath, deps = (String.trim fpath, String.trim deps) in
      let fname = Filename.basename fpath in
      assert (Filename.check_suffix fname ".ml");
      let modname =
        Filename.chop_suffix fname ".ml" |> String.capitalize_ascii
      in
      let deps = String.split_on_char ' ' deps |> String_set.of_list in
      (modname, deps)
  | _ -> failwith "Bad ocamldep output"

let () =
  let args = Array.append Sys.argv [| "-modules" |] in
  (* TODO: merge .ml et _intf.ml *)
  (* TODO: Autopath or raise *)
  let chan =
    Unix.open_process_args_in "/home/nico/.opam/4.10.0/bin/ocamldep" args
  in
  let lines = read_lines chan in
  let modnames, deps = List.map process_file_dep lines |> List.split in
  let modnames_set = String_set.of_list modnames in

  let deps = List.map (fun set -> String_set.inter set modnames_set) deps in

  let lines =
    List.map2
      (fun modname deps ->
        let string_of_dep = Printf.sprintf "        \"%s\" -> \"%s\";" modname in
        List.map string_of_dep (deps |> String_set.to_seq |> List.of_seq))
      modnames deps
    |> List.concat
  in
  Printf.printf "digraph {\n%s\n}\n" (String.concat "\n" lines);

  ()
