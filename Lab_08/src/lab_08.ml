open Io

let rec get_num () = 
  let num = int_of_string_opt (get_line ())
  in match num with
  | None -> print_endline "Please enter only digits. Try again.";
            get_num ()
  | Some x -> x

let get_nums (n: int) : int list =
  let rec helper (numb: int) (nums: int list) : int list =
    print_endline ("Please enter a number (" ^ (Int.to_string numb) ^ "/" ^ (Int.to_string n) ^ ")");
    match numb with
    | x when x == n -> List.append nums [get_num ()]
    | _ -> helper (numb + 1) (List.append nums [get_num ()])
  in helper 1 []

let rec put_nums (nums: int list) : unit =
  match nums with
  | [] -> ()
  | x::xs -> print_endline (Int.to_string x);
             put_nums xs

let run () =
  print_endline "How many numbers do oyu want to square?";
  let numb_nums = get_num ();
  in let lst = get_nums numb_nums
  in print_endline "Your squared numbers are:";
     put_nums (List.map (fun x -> x * x) lst)
