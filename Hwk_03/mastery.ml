let get_max (nums: (string * int) list) : (string * int) option =
  match nums with
  | [] -> None
  | x::xs -> Some (List.fold_left (fun (str1, x) (str2, z) -> if x > z then (str1, x) else (str2, z)) x xs)

let max_int_string_pairs (lst: (string * int) list) : (string * int) list =
  let pair = get_max lst
  in match pair with
     | None -> []
     | Some (_, max) -> List.filter (fun x -> match x with
                                              | (_, v) when v == max -> true
                                              | _ -> false
                                    ) lst

type 'a ltree = Leaf of 'a 
              | Branch of 'a ltree * 'a ltree

let rec flatten_tree (tr: 'a ltree) (c: 'a -> 'a -> 'a) : 'a =
  match tr with
  | Leaf v -> v
  | Branch (Leaf l, Leaf r) -> c l r
  | Branch (l, r) -> c (flatten_tree l c) (flatten_tree r c)
                                    
let min_ltree (tr: int ltree) : int =
  flatten_tree (tr) (fun x y -> if x > y then y else x)

let range_ltree (tr: int ltree) : (int * int) =
  (flatten_tree (tr) (fun x y -> if x > y then y else x), flatten_tree (tr) (fun x y -> if x > y then x else y))

let rev (lst: 'a list) : 'a list =
  List.fold_left (fun x xs -> xs :: x) [] lst

let elem (v: 'a) (lst: 'a list) : bool =
  List.fold_left (fun a b -> a || b) false (
                                            List.map (fun x -> x = v) lst
                                           )

let sieve (n: int) (lst: int list) : int list =
  List.filter (fun x -> (mod) x n != 0) lst
  
let range (n: int) : int list = List.init (n - 2) (fun i -> i + 2)

let rec list_iter_filter (lst: 'a list) (f: 'a -> 'a list -> 'a list) : 'a list =
  match lst with
  | [] -> []
  | x::xs -> x :: (list_iter_filter (f x xs) f)

let primes (lst: int list) : int list =
  list_iter_filter lst sieve

