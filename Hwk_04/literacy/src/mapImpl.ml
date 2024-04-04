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
  let lookup k tr = let rec helper ky tre =
                      match tre with
                      | Empty -> None
                      | Node (_, key, v, _) when key = ky -> Some v
                      | Node (l, _, _, _) when helper ky l != None -> helper ky l
                      | Node (_, _, _, r) -> helper ky r
                    in helper k tr
  let insert k v tr = let rec replace k v tr =
                      match tr with
                      | Empty -> Empty
                      | Node (l, ky, _, r) when ky = k -> Node (l, k, v, r)
                      | Node (l, ky, value, r) -> Node (replace k v l, ky, value, replace k v r)
                      in match lookup k tr with
                         | None -> Node (tr, k, v, Empty)
                         | Some _ -> replace k v tr
  let remove k tr = let rec shift_up ltr rtr =
                      match rtr with
                      | Empty -> Empty
                      | Node (rrl, rrk, rrv, rrr) -> Node (ltr, rrk, rrv, shift_up rrl rrr)
                    in let rec rmv k tr =
                      match tr with
                      | Empty -> Empty
                      | Node (l, ky, _, r) when ky = k -> shift_up l r
                      | Node (l, ky, v, r) -> Node (rmv k l, ky, v, rmv k r)
                    in rmv k tr
end
