let max_it_string_pairs (lst: (string * int) list) : (string * int) list =
  let get_max (nums: (string * int) list) : int option =
    match nums with
    | [] -> None
    | x::xs -> Some (List.fold_left (fun (_, x) (_, z) -> if x > z then x else z) x xs)
  in let max = get_max lst
  in if max == None
     then []
     else List.filter (fun _ x -> match x with Some v when v == max -> true | _ -> false) lst