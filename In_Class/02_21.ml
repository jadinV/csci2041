let rec merge (cmp: 'a -> 'a -> int) (lst1: 'a list) (lst2: 'a list) : 'a list =
  match (lst1, lst2) with
  | ([], []) -> []
  | (_, []) -> lst1
  | ([], _) -> lst2
  | (x::xs, y::ys) -> match cmp x y
                      | 1  -> merge cmp xs lst2
                      | 0  -> merge cmp ys lst1
                      | -1 -> merge cmp ys lst1

let rec map (f: 'a -> 'b) (lst: 'a list) : 'b list =
  match lst with
  | [] -> []
  | x::xs -> f x :: map f xs

let rec filter (f: 'a -> bool) (lst: 'a list) : 'a list =
  match lst with
  | [] -> []
  | x::xs when f x -> x :: filter f xs
  | _::xs -> filter f xs

let smush (chrs: char list) : char list =
  filter (fun c -> c <> ' ' && c <> '\t' && c <> '\n') chrs

let removeUpper (chars: char list) : char list =
  filter (fun c -> c <> 'A' && c <> 'B' && c <> 'C' && c <> 'D') chars

let fold (f: 'a -> 'a -> 'a) (arg: 'a) (lst: 'a list) -> 'a =
  match lst with
  | [] -> []
  | x::xs -> f x (fold f arg lst)
  | x::[] -> f x arg

