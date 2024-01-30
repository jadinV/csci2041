let is_square (num: int) : bool =
  let rec checker i = if i > num
                      then false
                      else if i * i == num
                            then true
                            else checker (i + 1)
  in checker 0

let rec square_all (nums: int list) : int list =
  match nums with
  | [] -> []
  | x::xs -> (x * x) :: square_all xs

let rec all_squares (nums: int list) : int list =
  match nums with
  | [] -> []
  | x::xs -> if is_square x
              then x :: all_squares xs
              else all_squares xs

let rec product_of_squares (nums: int list) : int =
  match nums with
  | [] -> 1
  | x::xs -> (x * x) * product_of_squares xs

let _ =
  assert(is_square 0 = true);
  assert(is_square 4 = true);
  assert(is_square 15 = false);
  assert(square_all [1; 2; 3; 4] = [1; 4; 9; 16]);
  assert(square_all [1; 3; 5; 7; 9] = [1; 9; 25; 49; 81]);
  assert(square_all [0; 10; 20; 30; 40] = [0; 100; 400; 900; 1600]);
  assert(all_squares [1; 2; 3; 4] = [1; 4]);
  assert(all_squares [0; 3; 9; 25] = [0; 9; 25]);
  assert(all_squares [10; 20; 30; 40] = []);
  assert(product_of_squares [1; 2; 3; 4] = 576);
  assert(product_of_squares [0; 3; 9; 25] = 0);
  assert(product_of_squares [5; 10; 15; 20] = 225000000)