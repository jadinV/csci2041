(* This makes the functions declared in lab_06.mli visible. *)
open Lab_06

let () = assert (list_sum [] = 0)
let () = assert (list_sum [1; 2; 3] = 6)
let () =
  let check_list_add_preserves_length (x: int) (ys: int list) : unit =
    assert (List.length (list_add x ys) = List.length ys)
  in

  check_list_add_preserves_length 0 [];
  check_list_add_preserves_length 1 [];
  check_list_add_preserves_length 13 [];
  check_list_add_preserves_length 16 [1; 1; 2];
  check_list_add_preserves_length (-2) [13; 2; 94];
  check_list_add_preserves_length (-12) [4; -64; 9]