let is_prime_faster (num: int) : bool =
  if num < 0 then raise (Failure "invalid input to is_prime")
  else if num = 0 || num = 1 then false
  else
    let rec helper x y : bool =
      if y > (x / 2) then true
      else if x mod y = 0 then false
      else helper x (y+1)
    in helper num 2

let rec big_squares (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t when h * h >= 50 -> h * h :: big_squares t
  | h::t -> big_squares t

let rec sum_of_squares (nums: int list) : int = 
  match nums with
  | [] -> 0
  | h::t -> h * h + sum_of_squares t

let rec product_of_primes (nums: int list) : int =
  match nums with 
  | [] -> 1
  | h::t when is_prime_faster h -> h * product_of_primes t
  | h::t -> product_of_primes t

let max_int_string_pairs (lst: (string * int) list) : (string * int) list =
  let rec helper (pairs: (string * int) list) (max: int) : int =
    match pairs with
    | [] -> max
    | h::t -> let (s, n) = h in if n > max
                             then helper t n
                             else helper t max
  in let biggest = helper lst 0
  in let rec picker (lst: (string * int) list) =
    match lst with
   | [] -> raise (Failure "invalid input to max_int_string_pairs")
   | (s, n)::[] -> if n == biggest
                   then [(s, n)]
                   else []
   | (s, n)::t when n == biggest -> picker t @ [(s, n)]
   | h::t -> picker t
  in picker lst
