(*
  Requires ocaml>=4.11.0 (Map.S.filter_map)

  Plot modules using this script
  ocaml unix.cma ~/configurations/ocamldep-dot.ml $FILES > d.dot && dot -Tpng d.dot -o d.png && open d.png
  ocaml unix.cma ~/configurations/ocamldep-dot.ml *.ml > e.dot && dot -Tpng e.dot -o e.png && rm e.dot

  Plot packages using dune-deps
  dune-deps $DIR -h $MODNAME --no-ext | tred > dunedeps.dot && dot -Tpng dunedeps.dot -o dunedeps.png && open dunedeps.png
  dune-deps `groot` -h $(basename `pwd`) --no-ext | tred > d.dot && dot -Tpng d.dot -o d.png && rm d.dot

 *)

module String_set = Set.Make (struct
  type t = string

  let compare = compare
end)

module String_map = Map.Make (struct
  type t = string

  let compare = compare
end)

let rec read_lines chan =
  match input_line chan with
  | exception End_of_file -> []
  | s -> s :: read_lines chan

let path_of_ocamldep () =
  let chan = Unix.open_process_in "which ocamldep" in
  let l = read_lines chan in
  match (Unix.close_process_in chan, l) with
  | Unix.WEXITED 0, [ path ] -> path
  | _, _ -> failwith "Could not find ocamldep"

let interpretation_of_ocamldep_line s =
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

let string_endswith s suf =
  let open String in
  let len = length s in
  let len' = length suf in
  len >= len' && sub s (len - len') len' = suf

let intersect_map_values_with_map_keys m =
  let kset = String_map.to_seq m |> Seq.map fst |> String_set.of_seq in
  String_map.map (String_set.inter kset) m

let () =
  (* Step 1 - Get ocamldep output *)
  let ocamldep_path = path_of_ocamldep () in
  let args = Array.append Sys.argv [| "-modules" |] in
  let chan = Unix.open_process_args_in ocamldep_path args in
  let lines = read_lines chan in

  (* Step 2 - Parse ocamldep output *)
  let deps_per_modname =
    List.map interpretation_of_ocamldep_line lines
    |> List.to_seq |> String_map.of_seq
  in

  (* Step 3 - filter out ext deps *)
  let deps_per_modname = intersect_map_values_with_map_keys deps_per_modname in

  (* Step 4 - Merge _intf files with their implementation file *)
  let classify modname =
    if string_endswith modname "_intf" then
      let impl = String.sub modname 0 (String.length modname - 5) in
      if String_map.mem impl deps_per_modname then `Intf_with_impl
      else `Intf_without_impl
    else
      let intf = modname ^ "_intf" in
      match String_map.find_opt intf deps_per_modname with
      | Some deps -> `Impl_with_intf deps
      | None -> `Impl_without_intf
  in
  let deps_per_modname =
    let f modname deps =
      match classify modname with
      | `Impl_without_intf | `Intf_without_impl -> Some deps
      | `Intf_with_impl -> None
      | `Impl_with_intf deps' -> Some (String_set.union deps deps')
    in
    String_map.filter_map f deps_per_modname
  in

  (* Step 5 - filter out _intf occurences from impl *)
  let deps_per_modname = intersect_map_values_with_map_keys deps_per_modname in

  (* Step 6 - Make and print a string for dot *)
  let lines =
    let fmt = Printf.sprintf "        \"%s\" -> \"%s\";" in
    String_map.to_seq deps_per_modname
    |> Seq.map (fun (modname, deps) ->
           List.map (fmt modname) (deps |> String_set.to_seq |> List.of_seq))
    |> List.of_seq |> List.concat
  in
  Printf.printf "digraph {\n%s\n}\n" (String.concat "\n" lines)
