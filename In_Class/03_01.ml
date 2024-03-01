let rec reduce (e: 'b) (f: 'b -> 'a -> 'b -> 'b) (t: 'a tree) : 'b =
  match t with
  | Empty -> e
  | Fork(l, v, r) -> f (reduce e f l) v (reduce e f r)

let concat_r (t: string tree) : string =
  let conc3 l v r = l ^ v ^ r
  in
  reduce "" conc3 t

let flatten_r (t: 'a tree) : 'a list =
  let flat ll v rl = ll @ (v :: rl)
  in  
  reduce [] flat t

let inc_all_r (t: int tree) : int tree =
  let inc_tree tl v tr = Fork(tl, v + 1, tr)
  in
  reduce Empty inc_tree t

let tree_map_r (f: 'a -> 'b) (t: 'a tree) : 'b =
  let map tl v tr = Fork (tl, f v, tr)
  in
  reduce Empty map t

let rec reduce3 (n: 'b) (o: 'a -> 'b) (m: 'b -> 'a -> 'b -> 'b) (t: 'a tree3) : 'b =
  match t with
  | None -> n
  | One (v) -> o v
  | More (l, v, r) -> m (reduce3 l) v (reduce3 r)

let sum_tree3 (t: int tree) : int =
  reduce3 0 (fun v -> v) (fun l v r -> l + v + r) t

let rec reduce_rose (f: 'a -> 'b list -> 'b) (rt: 'a rosetree) : 'b =
  match rt with
  | v::ts -> f v (List.map (reduce_rose f) ts)

