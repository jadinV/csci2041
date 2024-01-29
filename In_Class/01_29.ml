let lcm (x: int) (y: int) : int =
  let max = if x > y then x else y
  in let rec increment (d: int) : int =
    if x mod d = 0 && y mod d = 0 then d
    else increment (d + 1)
  in increment max

let rec all (lst: bool list) : bool =
  match lst with
  | [] -> true
  | x::rest -> x && all rest

let rec inc_all (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t -> (h + 1) :: inc_all t

let rec evens (nums: int list) : int list = 
  match nums with
  | [] -> []
  | h::t -> if h mod 2 = 0
            then h :: evens
            else evens t