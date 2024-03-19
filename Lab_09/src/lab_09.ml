include Io

module MakeApp (IO : Io.S) : sig
  val run : IO.ctx -> IO.ctx
end = struct

  let rec get_num (ctx : IO.ctx) : int * IO.ctx =
    let s, ctx = get_line ctx
    in let num = int_of_string (s)
    in match num with
    | None -> let ctx = put_line "Please enter only digits. Try again." ctx
              in get_num ctx
    | Some x -> x * ctx

  let get_nums (n : int) (ctx : IO.ctx) : int list * IO.ctx =
    let rec helper (numb: int) (nums: int list) : int list =
      let ctx = put_line ("Please enter a number (" ^ (Int.to_string numb) ^ "/" ^ (Int.to_string n) ^ ")") ctx
      in match numb with
         | x when x == n -> List.append nums [get_num ctx]
         | _ -> helper (numb + 1) (List.append nums [get_num ctx])
    in helper 1 []

  let rec put_nums (nums : int list) (ctx : IO.ctx) : IO.ctx =
    match nums with
    | [] -> ()
    | x::xs -> let ctx = put_line (Int.to_string x) ctx
               in put_nums xs ctx

  let run (ctx : IO.ctx) =
    let ctx = put_line "How many numbers do oyu want to square?" ctx
    in let numb_nums, ctx = get_num ctx;
    in let lst, ctx = get_nums numb_nums ctx
    in let ctx = put_line "Your squared numbers are:" ctx
    in put_nums (List.map (fun x -> x * x) lst) ctx

end
