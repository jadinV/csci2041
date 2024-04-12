## Induction on `expr`

### Principle of induction

This proof uses induction on the `expr` type, so the principle of induction is:
for all `ex : expr`, `P(ex)` if
- `P(Num x)` holds for all x
- `P(Neg e)` holds for all e
- `P(e1) => P(Add e1 e2)`

## Appending instruction lists

### 1. Principle of induction

This proof uses induction on the `instr list` type, so the principle of induction is:
for all `lst: instr list`, `P(lst)` if

- `P([])`
- for all `hd : 'a` and `tl : 'a list`, `P(tl) => P(hd :: tl)`

### 2. Base case to Prove

