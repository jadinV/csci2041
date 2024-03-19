module type S = sig
  type ctx

  val get_line : ctx -> string * ctx
  val put_line : string -> ctx -> ctx
end

module UncheckedIO : sig
  include S

  val new_ctx : unit -> ctx
end

module CheckedIO : sig
  include S

  val new_ctx : unit -> ctx
end

module PureIO : sig
  include S

  val new_ctx : string list -> ctx
  val read_put_buffer : ctx -> string list
end
