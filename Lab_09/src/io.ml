module type S = sig
  type ctx

  val get_line : ctx -> string * ctx
  val put_line : string -> ctx -> ctx
end

module UncheckedIO : sig
  include S

  val new_ctx : unit -> ctx
end = struct
  type ctx = unit

  let new_ctx () : ctx = ()
  let get_line (() : ctx) : string * ctx = (read_line (), ())
  let put_line (line : string) (() : ctx) : ctx = print_endline line
end

module CheckIO (InnerIO : S) : sig
  include S

  val wrap_ctx : InnerIO.ctx -> ctx
end = struct
  type ctx = int * int ref * InnerIO.ctx

  let wrap_ctx (inner_ctx : InnerIO.ctx) : ctx = (0, ref 0, inner_ctx)

  let get_line (ctx : ctx) : string * ctx =
    let n, next, inner_ctx = ctx in
    if n = !next then (
      next := !next + 1;
      let line, inner_ctx' = InnerIO.get_line inner_ctx in
      (line, (n + 1, next, inner_ctx')))
    else
      failwith "misuse of IO.ctx -- make sure you're only using each one once"

  let put_line (line : string) (ctx : ctx) : ctx =
    let n, next, inner_ctx = ctx in
    if n = !next then (
      next := !next + 1;
      let inner_ctx' = InnerIO.put_line line inner_ctx in
      (n + 1, next, inner_ctx'))
    else
      failwith "misuse of IO.ctx -- make sure you're only using each one once"
end

module CheckedIO : sig
  include S

  val new_ctx : unit -> ctx
end = struct
  include CheckIO (UncheckedIO)

  let new_ctx () = wrap_ctx (UncheckedIO.new_ctx ())
end

module PureIO : sig
  include S

  val new_ctx : string list -> ctx
  val read_put_buffer : ctx -> string list
end = struct
  type ctx = string list * string list

  let new_ctx get = (get, [])

  let get_line (ctx : string list * string list) :
      string * (string list * string list) =
    match ctx with
    | [], _ -> failwith "EOF"
    | hd :: tl, put -> (hd, (tl, put))

  let put_line (line : string) (ctx : string list * string list) :
      string list * string list =
    let get, put = ctx in
    (get, line :: put)

  let read_put_buffer (ctx : ctx) : string list =
    let _, put = ctx in
    List.rev put
end
