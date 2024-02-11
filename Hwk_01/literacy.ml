let rec first_digit (num: int) : int =
  match num with
  | x when x >= 0 && x < 10 -> x
  | x when x > 10 -> first_digit (x / 10)
  | x when x < 0 -> first_digit (x * -1)

let rec product_to (num: int) : int =
  if num < 0 then raise (Failure "invalid input to product_to")
  else if num = 1 then 1
  else if num = 0 then 0
  else num * product_to (num - 1)

let is_prime (num: int) : bool =
  if num < 0 then raise (Failure "invalid input to is_prime")
  else if num = 0 || num = 1 then false
  else
    let rec helper x y : bool =
      if y > (x / 2) then true
      else if x mod y = 0 then false
      else helper x (y+1)
    in helper num 2

let rec last_digits (nums: int list) : int list =
  let rec last_digit (num: int) : int =
    match num with
    | x when x >= 0 && x < 10 -> x
    | x when x > 10 -> last_digit (x mod 10)
    | x when x < 0 -> last_digit (x * -1)
  in match nums with
  | [] -> []
  | h::t -> last_digit h :: last_digits t

let rec all_primes (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t when is_prime h -> h :: all_primes t
  | h::t -> all_primes t

let rec sum_pairs (pairs: (int * int) list) : int =
  match pairs with
  | [] -> 0
  | h::t -> let (n1, n2) = h in n1 + n2 + sum_pairs t

let rec max_pairs (pairs: (int * int) list) : int =
  let max x y = if x > y then x else y
  in
  match pairs with
  | [] -> raise (Failure "invalid input to max_pairs")
  | x::[] -> let (n1, n2) = x in max n1 n2
  | h::t -> let (n1, n2) = h in max (max n1 n2) (max_pairs t)
