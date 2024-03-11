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

