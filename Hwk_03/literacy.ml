type 'a ltree = Leaf of 'a
              | Branch of 'a ltree * 'a ltree

let rec map_ltree (f: 'a -> 'b) (tree: 'a ltree) : 'b ltree =
  match tree with
  | Leaf v -> Leaf (f v)
  | Branch (l, r) -> Branch (map_ltree f l, map_ltree f r)

let rec reduce_ltree (func: 'a -> 'b) (comb: 'b -> 'b -> 'b) (tree: 'a ltree) : 'b =
  match tree with
  | Leaf v -> func v
  | Branch (l, r) -> comb (reduce_ltree func comb l) (reduce_ltree func comb r)

let square_all_ltree (tree: int ltree) : int ltree =
  map_ltree (fun x -> x * x) tree

let lengths_ltree (tree: string ltree) : int ltree =
  Leaf 0

