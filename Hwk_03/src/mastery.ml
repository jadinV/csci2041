
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

let rec map_ltree (f: 'a -> 'b) (tr: 'a ltree) : 'b ltree =
  match tr with
  | Leaf v -> Leaf (f v)
  | Branch (l, r) -> Branch (map_ltree f l, map_ltree f r)

let rec reduce_ltree (f: 'a -> 'b) (c: 'b -> 'b -> 'b) (tr:'a ltree): 'b =
  match tr with
  | Leaf v -> f v
  | Branch (l, r) -> c (reduce_ltree f c l) (reduce_ltree f c r)
                                    
let min_ltree (tr: int ltree) : int =
  reduce_ltree (fun x -> x) (fun x y -> if x > y then y else x) (tr)

let range_ltree (tr: int ltree) : (int * int) =
  (reduce_ltree (fun x -> x) (fun x y -> if x > y then y else x) (tr), reduce_ltree (fun x -> x) (fun x y -> if x < y then y else x) (tr))

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
