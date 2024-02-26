let partition (f: 'a -> bool) (lst: 'a list) : ('a list * 'a list) =
  let ff (x: 'a) (sofar: ('a list * 'a list)) : ('a list * 'a list) =
    match sofar with
    | (yess, nos) ->
        if f x
        then (x :: yess, nos)
        else (yess, x::nos)
    in let base : ('a list * 'a list) = ([], [])
  in foldr ff base lst

let partition_fl (f: 'a -> bool) (lst: 'a list) : ('a list * 'a list) =
  let ff ((yess, nos): ()'a list * 'a list)) (x: 'a) : ('a list * 'a list) =
      if f x
      then (x :: yess, nos)
      else (yess, x::nos)
  in let accum : ('a list * 'a list) = ([], [])
  in (ys, ns) = foldl ff accum lst
  in 


let group_by_3 (lst: 'a list) : 'a list list =
  let collect (groups_of_3, partial) (x: 'a) =
    if List.length partial < 3
    then (groups_of_3, x::partial)
    else (partial :: groups_of_3, [x])
  in let accum : ('a list list * 'a list) = ([], [])
  in foldl collect accum lst

