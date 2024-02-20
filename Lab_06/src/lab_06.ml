let rec list_sum (nums: int list) : int =
  match nums with
  | [] -> 0
  | x::xs -> x + list_sum xs
(*
  If all the elements in a list are positive then their sum is positive
  If all the elements in a list are negative then their sum is negative
  If all the elements in a list are 0 then their sum is 0
*)

let rec list_add (n: int) (nums: int list) : int list =
  match nums with
  | [] -> []
  | x::xs -> x + n :: list_add n xs

