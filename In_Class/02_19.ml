let rec find_all_by func lst = (* Given *)
  match lst with
  | [] -> []
  | x::xs ->
      let rest = find_all_by func xs
      in if func x then x::rest else rest

let big_nums (n: int) (nums: int list) : int list =
  find_all_by ((<) n) nums

let find_all (x: 'a) (lst: 'a list) : 'a list =
  find_all_by ((=) x) lst

let big_strs (n: int) (strs: string list) : string list =
  find_all_by (fun x -> String.length x > n) strs

let rec merge (lst1: 'a list) (lst2: 'a list) : 'a list =
  match (lst1, lst2) with
  | ([], []) -> []
  | (_, []) -> lst1
  | ([], _) -> lst2
  | (x::xs, y::ys) -> if compare x y >= 1
                      then x :: merge xs lst2
                      else y :: merge ys lst1

