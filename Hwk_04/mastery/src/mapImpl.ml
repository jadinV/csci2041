open Data

module ListMapImpl (E: Eq) = struct
  type key = E.t
  type 'v t = (E.t * 'v) list

  let empty = []

  let lookup (k: key) (lst: 'v t) : 'v option =
    match List.find_opt (fun (x, _) -> E.eq k x) lst with
    | None -> None
    | Some (_, v) -> Some v
  
  let insert (k: key) (v: 'v) (lst: 'v t) : 'v t =
    if (List.exists (fun (x, _) -> E.eq k x) lst)
    then List.map (fun (x, cv) -> if E.eq k x
                                  then (k, v)
                                  else (x, cv)
                  ) lst
    else (k, v)::lst
  
  let remove (k: key) (lst: 'v t) : 'v t =
    List.filter_map (fun (x, v) -> if (E.eq k x)
                                   then None
                                   else Some (x, v)
                    ) lst
end


module TreeMapImpl (O: Ord) = struct
  type key = O.t
  type 'v t = | Empty
              | Node of 'v t * O.t * 'v * 'v t

  let empty = Empty

  let rec lookup (k: key) (lst: 'v t) : 'v option = 
    match tr with
    | Empty -> None
    | Node (_, key, v, _) when O.eq key k -> Some v
    | Node (l, key, _, _) when O.cmp key k > 0 -> lookup k l
    | Node (_, _, _, r) -> lookup k r

  let rec add (ky: key) (value: 'v) (tre: 'v t) : 'v t =
    match tre with
    | Empty -> Node (Empty, ky, value, Empty)
    | Node (l, key, _, r) when O.eq key ky -> Node (l, ky, value, r)
    | Node (l, key, v, r) when O.cmp key ky < 0 -> Node (l, key, v, add ky value r)
    | Node (l, key, v, r) -> Node (add ky value l, key, v, r)

  let insert (k: key) (v: 'v) (lst: 'v t) : 'v t = add k v tr

  let rec tree_fix (tr: 'v t) (left: 'v t) : 'v t =
    match tr with
    | Empty -> raise (Failure "Empty tree")
    | Node (Empty, k, v, r) -> Node (left, k, v, r)
    | Node (l, _, _, _) -> tree_fix l left

  let rec remove (k: key) (lst: 'v t) : 'v t =
    match tr with
    | Empty -> raise (Failure ("No key with value k"))
    | Node (_, ky, _, _) when O.eq k ky -> (match tr with
                                            | Empty -> raise (Failure "How did you even get here?")
                                            | Node (Empty, _, _, Empty) -> Empty
                                            | Node (l, _, _, Empty) -> l
                                            | Node (Empty, _, _, r) -> r
                                            | Node (l, _, _, r) -> tree_fix r l
                                           )
    | Node (l, ky, v, r) when O.cmp k ky > 0 -> Node (l, ky, v, remove k r)
    | Node (l, ky, v, r) -> Node (remove k l, ky, v, r)
end

