let do_something = print_endline "Hello World"
let _ = print_endline "Hello"
let () = print_endline "Hello Again";
         print_endline "When will this end."

let say_hello =
  let _ = print_endline "Enter your name"
  in let name = read_line () (* replacable with read_line _ *)
  in print_endline ("Hello " ^ name ^ "!")

(* () is the unit symbol which can be used in various ways as seen above and below *)
let () =
  assert (sum [] = 0);
  assert (sum [1; 2; 3] = 6);
  assert (sum [5; 5; 5] = 15)

