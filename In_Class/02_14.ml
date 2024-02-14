let rec minList (nums: int list) : int option =
  match nums with
  | [] -> None
  | x::[] -> Some x
  | x::xs when Some x < minList xs -> Some x
  | _::xs -> minList xs

let rec minListV2 (nums: int list ) : int option =
  let rec current_smallest (min_so_far: int) (ns: int list) : int =
    match ns with 
    | [] -> min_so_far
    | x::xs -> if x < min_so_far
               then current_smallest x xs
               else current_smallest min_so_far xs
  in match nums with
  | [] -> None
  | n::ns -> Some current_smallest n ns

type msg = StringMsg of string * int
         | BoolMsg of bool * int
         | FloatMsg of float * int

type color = Red
           | Blue
           | Green

let isRed c =
  match c with
  | Red -> true
  | Blue -> false
  | Green -> false

type weekday = Mon | Tue | Wed | Thr | Fri | Sat | Sun
(* The < > operators give a return based on the order of the list: Mon < Tue = True*)

let isWorkday (day: weekday) : bool =
  match day with
  | Sat | Sun -> false
  | _ -> true

type coord = float * float
type circ_desc = coord * float
type tri_desc = coord * coord * coord
type sqr_desc = coord * coord * coord * coord

type shape = Circle of circ_desc | Triangle of tri_desc | Square of sqr_desc

let isQuadrilateral s =
  match s with
  | Square _ -> true
  | _ -> false