include module type of Io

module MakeApp : functor (IO : Io.S) -> sig
  val run : IO.ctx -> IO.ctx
end
