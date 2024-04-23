type nat =
  Z
| S of nat

val reduce_nat : 'a -> ('a -> 'a) -> nat -> 'a
       
val nat_to_int : nat -> int

val int_to_nat : int -> nat
       
val ack : nat -> nat -> nat

val ack' : nat -> nat -> nat
