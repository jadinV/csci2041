let sum (nums: int list) : int =
  List.fold_left (+) 0 nums

let product (nums: int list) : int =
  List.fold_left ( * ) 1 nums

let all_odds (nums: int list) : int list =
  List.filter
    (fun x -> if x mod 2 = 0
              then false
              else true)
    nums

let square_all (nums: int list) : int list =
  List.map (fun x -> x * x) nums

let negate_odd (nums: int list) : int list =
  List.map
    (fun x -> if x mod 2 = 0
              then x
              else x * (-1))
    nums

let string_of_chars (chrs: char list) : string =
  let char_cons (x : char) (str : string) : string = (String.make 1 x) ^ str
  in List.fold_right char_cons chrs ""

let sum_pairs (pairs: (int * int) list) : int =
  sum (List.map (fun (x, y) -> x + y) pairs)

let max_pairs (pairs: (int * int) list) : int =
  match pairs with
  | [] -> raise (Failure "invalid input to max_pairs")
  | (x, y)::[] -> if x > y then x else y
  | x::xs -> let (y::ys) = List.map (fun (x, y) -> if x > y then x else y)
                                 pairs
             in List.fold_left (fun x z -> if x > z then x else z) y ys

let max_opt (nums: int list) : int option =
  match nums with
  | [] -> None
  | x::xs -> Some (List.fold_left (fun x z -> if x > z then x else z) x xs)

let max_pairs_opt (pairs: (int * int) list) : int option =
  match pairs with
  | [] -> None
  | (x, y)::[] -> if x > y then Some x else Some y
  | x::xs -> let (y::ys) = List.map (fun (x, y) -> if x > y then x else y)
                                 pairs
             in Some (List.fold_left (fun x z -> if x > z then x else z) y ys)
