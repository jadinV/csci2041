let squared_list (lst: int list) : int list =
  List.map (fun x -> x * x) lst

let list_evens (lst: int list) : int list =
  List.filter (fun x -> x mod 2 = 0) lst

let list_product (lst: int list) : int =
  List.fold_left ( * ) 1 lst

