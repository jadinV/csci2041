module ListMapImpl = struct
  type ('k,'v) t = ('k * 'v) list

  let empty = []

  let lookup k lst = match List.find_opt (fun (x, _) -> x = k) lst with
                     | None -> None
                     | Some (_, v) -> Some v
  
  let insert k v lst = if (List.exists (fun (x, _) -> x = k) lst)
                          then List.map (fun (x, cv) -> if x = k
                                                        then (k, v)
                                                        else (x, cv)) lst
                          else (k, v)::lst
  
  let remove k lst = List.filter_map (fun (x, cv) -> if (x = k)
                                                          then None
                                                          else Some (x, cv)) lst
end

module TreeMapImpl = struct
  type ('k, 'v) t = Empty
                  | Node of ('k, 'v) t * 'k * 'v * ('k, 'v) t

  let empty = Empty
  
  let rec lookup k tr = 
    match tr with
    | Empty -> None
    | Node (_, key, v, _) when key = k -> Some v
    | Node (l, key, _, _) when key > k -> lookup k l
    | Node (_, _, _, r) -> lookup k r

  let rec add ky value tre =
    match tre with
    | Empty -> Node (Empty, ky, value, Empty)
    | Node (l, key, _, r) when key = ky -> Node (l, ky, value, r)
    | Node (l, key, v, r) when key < ky -> Node (l, key, v, add ky value r)
    | Node (l, key, v, r) -> Node (add ky value l, key, v, r)

  let insert k v tr = add k v tr

  let rec tree_fix tr left =
    match tr with
    | Empty -> raise (Failure "Empty tree")
    | Node (Empty, k, v, r) -> Node (left, k, v, r)
    | Node (l, _, _, _) -> tree_fix l left

  let rec remove k tr =
    match tr with
    | Empty -> Empty
    | Node (_, ky, _, _) when k = ky -> (match tr with
                                         | Empty -> raise (Failure "How did you even get here?")
                                         | Node (Empty, _, _, Empty) -> Empty
                                         | Node (l, _, _, Empty) -> l
                                         | Node (Empty, _, _, r) -> r
                                         | Node (l, _, _, r) -> tree_fix r l
                                        )
    | Node (l, ky, v, r) when k > ky -> Node (l, ky, v, remove k r)
    | Node (l, ky, v, r) -> Node (remove k l, ky, v, r)
end
