
(*
let get_line () = flush stdout; input_line stdin
let put_line s = output_string stdout (s ^ "\n"); flush stdout

let chan = open_in "tests/test" 

let get_line () = flush stdout; input_line chan

let put_line s = output_string stdout (s ^ "\n"); flush stdout

*)

let get_line = read_line

let put_line = print_endline
