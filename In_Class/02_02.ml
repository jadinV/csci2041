let is_empty lst = 
  match lst with
  | [] -> true
  | _::_ -> false

let head (lst: 'a list) : 'a = 
  match lst with
  | x::_ -> x
  | [] -> raise (Invalid_argument "head requires a non empty list")

let minimum (nums: int list) : int =
  let rec current_smallest (curr_min: int) (ns: int list) : int =
    match ns with
    | [] -> curr_min
    | x::xs -> if x < curr_min
               then current_smallest x xs
               else current_smallest curr_min xs

  in
  match nums with
  | [] -> raise (Invalid_argument "minimum requires non empty list")
  | x::xs -> current_smallest x xs

(*  1.2 #9:
    No, the match has 3 cases when the 2nd and 3rd one are the same case with differenet variable names
*)

