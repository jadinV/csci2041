module type S = sig
  type ('k,'v) t

  val empty : ('k,'v) t
  val lookup : 'k -> ('k, 'v) t -> 'v option
  val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
  val remove : 'k -> ('k, 'v) t -> ('k, 'v) t

end

module ListMap : S = MapImpl.ListMapImpl

module TreeMap : S = MapImpl.TreeMapImpl
