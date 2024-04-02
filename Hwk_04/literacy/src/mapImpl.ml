module ListMapImpl = struct
  type ('k,'v) t = ('k * 'v) list

  let empty = []
  let lookup _ _ = None
  let insert _ _ _ = empty
  let remove _ _ = empty
end

module TreeMapImpl = struct
  type ('k, 'v) t = Empty
                  | Node of ('k, 'v) t * 'k * 'v * ('k, 'v) t

  let empty = Empty
  let lookup _ _ = None
  let insert k v _ = Node (Empty, k, v, Empty)
  let remove _ _ = Empty
end
