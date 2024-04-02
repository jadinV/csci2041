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

