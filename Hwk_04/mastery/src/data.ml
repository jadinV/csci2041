module type Eq = sig
  type t
  val eq : t -> t -> bool
end

module type Ord = sig
  type t
  val eq : t -> t -> bool
  val cmp: t -> t -> int
end

(* Define the following modules:
   - IntEq
   - StringEq

   - IntOrd
    -StringOrd
 *)

module IntEq : (Eq with type t = int) = struct
  type t = int
  let eq = (fun x y -> x = y)
end

module StringEq : (Eq with type t = string) = struct
  type t = string
  let eq = (fun x y -> (String.capitalize_ascii x) = (String.capitalize_ascii y))
end

module IntOrd : (Ord with type t = int) = struct
  type t = int
  let eq = (fun x y -> x = y)
  let cmp = (fun x y -> if x = y then 0 else if x > y then 1 else -1)
end

module StringOrd : (Ord with type t = string) = struct
  type t = string
  let eq = (fun x y -> (String.capitalize_ascii x) = (String.capitalize_ascii y))
  let cmp = (fun x y -> if (String.capitalize_ascii x) = (String.capitalize_ascii y) then 0 else if (String.capitalize_ascii x) > (String.capitalize_ascii y) then 1 else -1)
end
