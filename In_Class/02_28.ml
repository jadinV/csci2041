let even_length_fr (lst: 'a list) : bool =
  List.fold_left (fun _ b -> not b) lst true

let sum_even_positions (lst: int list) : int =
  let (_, result) = 
    List.fold_left
      (fun (b, s) x ->
        (not b, (if b then s + x else s)))
      (true, 0)
      lst
  in 
  result

let rec tree_map (f: 'a -> 'b) (tr: 'a tree) : 'b tree =
  match tr with
  | Empty -> Empty
  | Fork (l, v, r) -> Fork (tree_map l, f v, tree_map r)

