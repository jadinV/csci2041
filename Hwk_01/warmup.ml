let dec (num: int) : int =
  num - 1

let cube (num: int) : int =
  num * num * num

let rec last_digit (num: int) : int =
  if (x >= 0 && x < 10)
    then x
  else if (x >= 10)
    then last_digit (x mod 10)
  else if (x < 0)
    then last_digit (x * -1)

let rec sum (nums: int list) : int =
  match nums with
  | [] -> 0
  | x::xs -> x + sum xs

let rec product (nums: int list) : int =
  match nums with
  | [] -> 1
  | x::xs -> x * product xs

let rec all_odds (nums: int list) : int list =
  match nums with
  | [] -> []
  | x::xs when x mod 2 = 0 -> all_odds xs
  | x::xs -> x :: all_odds xs

let rec square_all (nums: int list) : int list =
  match nums with
  | [] -> []
  | x::xs -> (x * x) :: square_all xs
