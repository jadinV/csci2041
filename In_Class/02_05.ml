let first_of_3 ((n, _, _): 'a * 'b * 'c) : 'a =
  n

type fraction = int * int

let add_fractions (f1: fraction) (f2: fraction) : fraction =
  let (n1, d1) = f1 in
  let (n2, d2) = f2 in
  if (d1 == d2)
    then (n1 + n2, d1)
  else (n1 * d2 + n2 * d1, d1 * d2)

let rec lookup_all (word: string) (lst: (string * int) list) : int list =
  match lst with
  | [] -> []
  | (s, n)::t -> if s = word
                  then n :: lookup_all word t
                 else lookup_all word t

let rec fib = function
  match x with
  | 0 -> 0
  | 1 -> 1
  | _ -> fib (x-1) + fib (x-2)