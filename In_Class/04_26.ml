type 'a hidden = Value of 'a
               | Thunk of (unit -> 'a)

type 'a lazee = 'a hidden ref

let force (l: 'a lazee) : unit =
  match ! l with
  | value _ -> ()
  | Thunk f -> l := Value (f ())

let demand (l: 'a lazee) : 'a = 
  force l;
  match ! l with
  | Value v -> v
  | Thunk _ -> raise (Failure "this should never occur.")

let delay (unit_to_x : unit -> 'a) : 'a lazee =
  ref (Thunk unit_to_x)

type 'a stream = Cons of 'a * 'a stream lazee

let rec from (n: int) : int stream =
  print_endline ("step:" ^ string__of_int n);
  Cons (n, delay (fun () -> from (n+1)))

let nats = from 1

let rec take (n: int) (s: 'a stream) : 'a list =
  match n with
  | 0 -> []
  | _ -> ( match s with
           | Cons (h, t) -> h :: take (n-1) (demand t)
         )

let rec squares_from (n: int) : int stream =
  Cons (n*n, delay (fun () -> squares_from (n+1)))

let sqs = squares_from 1

let rec map (f: 'a -> 'b) (s: 'a stream) : 'b stream =
  match s with
  | Cons (h, t) -> Cons (f h, delay (fun () -> map f (demand t)))

let sq2 = map (fun x -> x*x) nats

let odd n = n mod 2 <> 0

let rec filter (f: 'a -> bool) (s: 'a stream) : 'a stream =
  match s with
  | Cons (h, t) when f h -> Cons (h, delay (fun () -> filter f (demand t)))
  | _ -> filter f (demand t)

let odds = filter odd nats

let rec zip (f: 'a -> 'b -> 'c) (s1: 'a stream) (s2: 'b stream) : 'c stream =
  match s1, s2 with
  | Cons (h1, t1), Cons (h2, t2) -> Cons (f h1 h2, delay (fun () -> zip f (demand t1) (demand t2)))

let rec factorials () =
  Cons (1, delay (fun () -> zip ( * ) nats (factorials ())))
