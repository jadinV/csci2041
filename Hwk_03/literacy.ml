type 'a ltree = Leaf of 'a
              | Branch of 'a ltree * 'a ltree

let rec map_ltree (f: 'a -> 'b) (tr: 'a ltree) : 'b ltree =
  match tr with
  | Leaf v -> Leaf (f v)
  | Branch (l, r) -> Branch (map_ltree f l, map_ltree f r)

let rec reduce_ltree (func: 'a -> 'b) (comb: 'b -> 'b -> 'b) (tr: 'a ltree) : 'b =
  match tr with
  | Leaf v -> func v
  | Branch (l, r) -> comb (reduce_ltree func comb l) (reduce_ltree func comb r)

let square_all_ltree (tr: int ltree) : int ltree =
  map_ltree (fun x -> x * x) tr

let lengths_ltree (tr: string ltree) : int ltree =
  map_ltree String.length tr

let sum_ltree (tr: int ltree) : int =
  reduce_ltree (fun x -> x) (fun x y -> x + y) tr

let product_ltree (tr: int ltree) : int =
  reduce_ltree (fun x -> x) (fun x y -> x * y) tr

 type 'a tree = Empty
              | Fork of 'a tree * 'a * 'a tree

let rec map_tree (f: 'a -> 'b) (tr: 'a tree) : 'b tree =
  match tr with
  | Empty -> Empty
  | Fork (l, v, r) -> Fork (map_tree f l, f v, map_tree f r)

let rec reduce_tree (e: 'b) (f: 'b -> 'a -> 'b -> 'b) (t: 'a tree) : 'b =
  match t with
  | Empty -> e
  | Fork(l, v, r) -> f (reduce_tree e f l) v (reduce_tree e f r)

let square_all_tree (tr: int tree) : int tree =
  map_tree (fun x -> x * x) tr

let sum_tree (tr: int tree) : int =
  reduce_tree 0 (fun l v r -> l + v + r) tr

let product_tree (tr: int tree) : int =
  reduce_tree 1 (fun l v r -> l * v * r) tr

let leghts_tree (tr: string tree) : int tree =
  map_tree String.length tr

let tree1 = Fork (
              Fork (
                Empty, Fork (
                        Fork (
                          Empty, -10, Empty),
                        -15,
                        Fork (
                          Empty, 3, Empty)),
                 Empty), 
              Fork (
                Fork (
                  Empty, 10, Empty),
                 -15, Fork (
                  Empty, 3, Empty)),
                 Fork (
                  Empty, Fork (
                    Fork (
                      Empty, -10, Empty),
                     15, Fork (
                      Empty, 3, Empty)),
                     Empty))

let tree2 = Fork (
             Fork (
               Empty, Fork (
                       Fork (
                         Empty, -16, Empty),
                       -2,
                       Fork (
                         Empty, 6, Empty)),
                Empty), 
             Fork (
               Fork (
                 Empty, 45, Empty),
                -32, Fork (
                 Empty, 7, Empty)),
                Fork (
                 Empty, Fork (
                   Fork (
                     Empty, -45, Empty),
                    32, Fork (
                     Empty, 9, Empty)),
                    Empty))
