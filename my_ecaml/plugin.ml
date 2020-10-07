(*
  https://blag.bcc32.com/ecaml-getting-started/2017/11/12/emacs-plugins-in-ocaml-3
  https://b0-system.github.io/odig/doc/ecaml/Ecaml/index.html
  http://diobla.info/blog-archive/modules-tut.html

(fake-module-reload "/home/nico/configurations/my_ecaml/_build/default/my-ecaml.so")

*)

let (--) start stop =
  let rec aux n acc =
    if n < start then acc else aux (n - 1) (n :: acc)
  in
  aux (stop - 1) []

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

let command_of_string s = Ecaml.Value.intern s |> Ecaml.Command.of_value_exn

let () =
  Ecaml.defun_nullary_nil
    ("del-forward-blanks" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    del_forward_blanks;
  Ecaml.Keymap.(
    define_key
      (global ())
      (Ecaml.Key_sequence.create_exn "C-f")
      (Entry.Command (command_of_string "del-forward-blanks"))
  );


  Ecaml.defun_nullary_nil
    ("dicho-move" |> Ecaml.Symbol.intern)
    [%here]
    ~interactive:No_arg
    dicho_move;
  Ecaml.Keymap.(
    define_key
      (global ())
      (Ecaml.Key_sequence.create_exn "C-q")
      (Entry.Command (command_of_string "dicho-move"))
  );

  Ecaml.provide ("my-ecaml" |> Ecaml.Symbol.intern);

  ()
