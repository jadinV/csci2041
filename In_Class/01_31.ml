let rec capitalize (words: string list) : string list =
  match words with
  | [] -> []
  | h::t -> String.capitalize_ascii h :: capitalize t

let rec evens' (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t when h mod 2 = 0 -> h :: evens' t
  | h::t -> evens' t

let rec triplemod6 (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t when (h * 3) mod 6 = 0 -> (h * 3) :: triplemod6 t
  | h::t -> triplemod6 t

let rec even2ways (nums: int list) : bool = (* must be even elements with even length *)
  match nums with
  | [] -> true
  | _::[] -> false
  | x1::x2::t -> x1 mod 2 = 0 && x2 mod 2 = 0 && even2ways t

let string_concat (separator: string) (strs: string list) : string = (* concats 2 strings with a separator inbetween *)
  match strs with
  | [] -> ""
  | [s] -> s (* can be written s::[] or [s] *)
  | s::ss -> s ^ separator ^ string_concat separator ss

let everyother (nums: int list) : int list = 
  match nums with
  | [] -> []
  | x::[] -> []
  | x1::x2::t -> x1 :: everyother t

