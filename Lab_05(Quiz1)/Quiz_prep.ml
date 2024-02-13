let rec decs (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t -> dec h :: decs t

let rec dec_positive (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t when positive dec h -> dec h :: dec_positive t
  | _::t -> dec_positive t

let rec incs (nums: int list) : int list =
  match nums with
  | [] -> []
  | h::t -> inc h :: incs t

