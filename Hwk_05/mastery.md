## Induction on `expr`

### Principle of induction

This proof uses induction on the `expr` type, so the principle of induction is:
for all `ex : expr`, `P(ex)` if
- `P(Num x)` holds for all x
- `P(Neg e)` holds for all e
- `P(e1) && P(e2) => P(Add e1 e2)`

## Appending instruction lists

### 1. Principle of induction

This proof uses induction on the `instr list` type, so the principle of induction is:
for all `lst: instr list`, `P(lst)` if

- `P([])`
- for all `hd : 'a` and `tl : 'a list`, `P(tl) => P(hd :: tl)`

### 2. Base case to Prove

`exec (app [] code2) stack = exec code2 (exec [] stack)`

### 3. Proof of base Case

`exec (app [] code2) stack`

- by def of app

`= exec code2 stack`

- by def of exec

`= exec code2 (exec [] stack)`

### 4. Inductive Case to Prove

`exec (app inst1::insts1 inst2::insts2) stack = exec inst2::insts2 (exec inst1::insts1 stack)`

### 5. Inductive Hypothesis

`exec (app insts1 inst2::insts2) stack = exec inst2::insts2 (exec insts1 stack)`

### 6. Proof of Inductive Case

`exec (app inst1::insts1 inst2::insts2) stack`

- by def of app

`= exec (inst1 :: (app insts1 inst2::insts2)) stack`

- by def of exec

`= exec (app insts1 inst2::insts2) (step inst1 stack)`

- by inductive hypothesis

`= exec inst2::insts2 (exec insts1 (step inst1 stack))`

- by def of exec

`= exec inst2::insts2 (exec inst1::insts1 stack)`

## Compile is correct with respect to exec

### 1. Principle of Induction

This proof uses induction on the `expr` type, so the principle of induction is:
for all `ex : expr`, `P(ex)` if
- `P(Num x)` holds for all x
- `P(Neg e)` holds for all e
- `P(e1) && P(e2) => P(Add e1 e2)`

### 2. Base Case to Prove

`exec (compile Num x) stack = eval Num x :: stack`

### 3. Proof of base Case

`exec (compile Num x) stack`

- by def of compile 

`= exec ([Push x]) stack`

- by def of exec

`= exec [] (step [Push x] stack)`

= by def of step

`= exec [] (x :: stack)`

- by def of exec

`= x :: stack`

- by def of eval

`= eval Num x :: stack`

### 4. Inductive Cases to Prove

#1 `exec (compile Neg e) stack = eval Neg e :: stack`

#2 `exec (compile Add (e1, e2)) stack = eval Add (e1, e2) :: stack`

### 5. Inductive Hypothesis

`exec (compile e) stack = eval e :: stack`

### 6. Proof of Inductive Case

`exec (compile Neg e) stack`

- by def of compile

`= exec (app (compile e) [Unop negate]) stack`

- by Appending instruction lists

`= exec [Unop negate] (exec (compile e) stack)`

- by inductive hypothesis

`= exec [Unop negate] (eval e :: stack)`

- by def of exec

`= step Unop negate (eval e :: stack)`

- by def of step

`= do_unop negate (eval e :: stack)`

- by def of do_unop

`= negate (eval e) :: stack`

- by def of negate

`= -(eval e) :: stack`

- by def of eval

`= eval Neg e :: stack`


### 6b. Proof of Inductive Case #2

`exec (compile Add (e1, e2)) stack`

- by def of compile

`= exec (app (compile e1) (app (compile e2) [Binop (+)])) stack`

- by Prove the associativity of append for nonempty lists

`= exec (app (app (compile e1) (compile e2)) [Binop (+)]) stack`

- by Appending instruction lists

`= exec [Binop (+)] (exec (app (compile e1) (compile e2)) stack)`

- by def of exec

`= exec [] (step Binop (+) (exec (app (compile e1) (compile e2)) stack))`

- by def of exec

`= step Binop (+) (exec (app (compile e1) (compile e2)) stack)`

- by def of step

`= do_binop (+) (exec (app (compile e1) (compile e2)) stack)`

- Appending instruction lists

`= do_binop (+) (exec compile e2 (exec compile e1 stack))`

- by inductive hypothesis

`= do_binop (+) (exec compile e2 (eval e1 :: stack))`

- by inductive hypothesis

`= do_binop (+) (eval e2 :: eval e1 :: stack)`

- by def of do_binop

`= (+) (eval e2) (eval e1) :: stack`

- by def of (+)

`= eval e2 + eval e1 :: stack`

- by associativity of +

`= eval e1 + eval e2 :: stack`

- by def of eval

`= eval Add (e1, e2) :: stack`

## Compile is correct with respect to run

### 1. Principle of Induction

This proof uses induction on the `expr` type, so the principle of induction is:
for all `ex : expr`, `P(ex)` if
- `P(Num x)` holds for all x
- `P(Neg e)` holds for all e
- `P(e1) && P(e2) => P(Add e1 e2)`

### 2. Base Case to Prove

`run (compile Num x) = eval Num x`

### 3. Proof of Base Case

`run (compile Num x)`

- by some bullshit

`= eval Num x`

### 4. Inductive Cases to Prove

#1 `run (compile Neg e) = eval Neg e`

#2 `run (compile Add (e1, e2)) = eval Add (e1, e2)`

### 5. Inductive Hypothesis

`run (compile e) = eval e`

### 6a. Proof of Inductive Case #1

`run (compile Neg e)`

- by some bullshit

`= eval Neg e`

### 6b. Proof of Inductive Case #2

`run (compile Add (e1, e2))`

- by some bullshit

`= eval Add (e1, e2)`