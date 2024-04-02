module type S = sig
  type 'a t

  val empty : 'a t
  val add : 'a -> 'a t -> 'a t
  val elem : 'a -> 'a t -> bool 
  val size : 'a t -> int
end

module ListSet : S = struct
  type 'a t = 'a list

  let empty = []
  let add v lst = v::lst
  let elem v lst = List.exists (fun x -> x = v) lst
  let size lst = let rec sizeList (lis: 'a t) : int = 
                   match lis with
                   | [] -> 0
                   | x::xs when (elem x xs) -> sizeList xs
                   | _::xs -> sizeList xs + 1
                 in sizeList lst
end


module TreeSet : S = struct
  type 'a t = Empty
            | Node of 'a t * 'a * 'a t

  let empty = Empty
  let add v tr = Node (tr, v, Empty)
  let elem v tr = let rec findInTree (value: 'a) (tre: 'a t) : bool =
                    match tre with
                    | Empty -> false
                    | Node (l, n, r) -> findInTree value l || n = value || findInTree value r
                  in findInTree v tr
  let size tr = let rec sizeTree (tre: 'a t) : int = 
                  match tre with
                  | Empty -> 0
                  | Node (l, n, r) when (elem n l) || (elem n r) -> sizeTree l + sizeTree r
                  | Node (l, _, r) -> sizeTree l + 1 + sizeTree r
                in sizeTree tr
end

