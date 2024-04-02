open Data
open MapImpl

module type S = sig
  type key
  type 'v t

  val empty : 'v t
  val lookup : key -> 'v t -> 'v option
  val insert : key -> 'v -> 'v t -> 'v t
  val remove : key -> 'v t -> 'v t
end


(* Complete specification of the signature definition in the two
   functor declarations below.
*)
module ListMap (E: Eq) :  (* fill in signature information *)  = ListMapImpl (E)

module TreeMap (O: Ord) :  (* fill in signature information *)  = TreeMapImpl (O)

