include Io

module MakeApp (IO : Io.S) : sig
  val run : IO.ctx -> IO.ctx
end = struct

  let get_num (ctx : IO.ctx) : int * IO.ctx =
    let s, ctx = IO.get_line ctx
    in let num = int_of_string (s)
    in match num with
    | x -> x, ctx

  let get_nums (n : int) (ctx : IO.ctx) : int list * IO.ctx =
    let rec helper (numb: int) (nums: int list) (ctx: IO.ctx) : int list * IO.ctx =
      let ctx = IO.put_line ("Please enter a number (" ^ (Int.to_string numb) ^ "/" ^ (Int.to_string n) ^ ")") ctx
      in match numb with
         | x when x == n -> let n, ctx = get_num ctx in List.append nums [n], ctx
         | _ -> let n, ctx = get_num ctx in helper (numb + 1) (List.append nums [n]) ctx
    in helper 1 [] ctx

  let rec put_nums (nums : int list) (ctx : IO.ctx) : IO.ctx =
    match nums with
    | [] -> ctx
    | x::xs -> let ctx = IO.put_line (Int.to_string x) ctx
               in put_nums xs ctx

  let run (ctx : IO.ctx) =
    let ctx = IO.put_line "How many numbers do you want to square?" ctx
    in let numb_nums, ctx = get_num ctx;
    in let lst, ctx = get_nums numb_nums ctx
    in let ctx = IO.put_line "Your squared numbers are:" ctx
    in put_nums (List.map (fun x -> x * x) lst) ctx

end
