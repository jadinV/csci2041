## Prove that sum is equivalently defined with folds and recursion

### 1. Principle of Induction

This proof uses induction on the `list` type, so the principle of induction is:
for all `xs : 'a list`, `P(xs)` if
- `P([])`
- for all `hd : 'a` and `tl : 'a list`, `P(tl) => P(hd :: tl)`

### 2. Base Case to Prove

`sum [] = sum_fold []`

### 3. Proof of Base Case

`sum []`

- by def of sum

`= 0`

- by def of foldr

`= foldr (+) 0 []`

- by def of sum_fold

`= sum_fold []`

### 4. Inductive Case to Prove

`sum xs = sum_fold xs`

### 5. Inductive Hypothesis

`sum tl = sum_fold tl`

### 6. Proof of Inductive Case

`sum xs`

 - by properties of lists

 `= sum (hd::tl)`

 - by def of sum

 `= hd + sum tl`

 - by def of (+)

 `= (+) hd (sum tl)`

 - by inductive hypothesis

 `= (+) hd (sum_fold tl)`

 - by def of sum_fold

`= (+) hd (foldr (+) 0 tl)`

 - by def of foldr

`= foldr (+) 0 (hd::tl)`

 - by properties of lists

`= foldr (+) 0 lst`

 - by def of sum_fold

 `= sum_fold xs`

## Prove the map fusion law

### 1. Principle of Induction

This proof uses induction on the `list` type, so the principle of induction is:
for all `xs : 'a list`, `P(xs)` if
- `P([])`
- for all `hd : 'a` and `tl : 'a list`, `P(tl) => P(hd :: tl)`

### 2. Base Case to Prove

`map f (map g []) = map (fun x -> f (g x)) []`

### 3. Proof of Base Case

`map f (map g [])`
 
 - by def of map

 `= map f ([])`

 - by def of map

 `= []`

 - by def of map

`= map (fun x -> f (g x)) []`

### 4. Inductive Case to Prove

`map f (map g xs) = map (fun x -> f (g x)) xs`

### 5. Inductive Hypothesis

`sum tl = sum_fold tl`

### 6. Proof of Inductive Case

`map f (map g xs)`

 - by properties of lists

 `= map f (map g (hd::tl))`

 - by def of map

 `= map f (g hd :: map g tl)`

 - by def of map

 `= f (g hd) :: map f (map g tl)`

 - by inductive hypothesis

 `= f (g hd) :: map (fun x -> f (g x)) tl`

 - by def of map

`= map (fun x -> f (g x)) hd::tl`

- by properties of lists

`= map (fun x -> f (g x)) xs`

## Prove that the product of a list commutes with append

### 1. Principle of Induction

This proof uses induction on the `list` type, so the principle of induction is:
for all `xs : int list`, `ys : int list`, `P(xs, ys)` if
- `P([], ys)`
- for all `hd : int` and `tl : int list`, `P    (tl) => P(hd :: tl, ys)`

### 2. Base Case to Prove

`prod (app [] l2) = prod [] * prod l2`

### 3. Proof  of Base Case

`prod (app [] l2)`

- by def of app

`= prod l2`

- by arithmetic

`= 1 * prod l2`

- by def of prod

`= prod [] * prod l2`

### 4. Inductive Case to Prove

`prod (app l1 l2) = prod l1 * prod l2`

### 5. Inductive Hypothesis

`prod (app tl l2) = prod tl * prod l2`

### 6. Proof of Inductive Case

`prod (app l1 l2)`

- by properties of lists

`= prod (app hd::tl l2)`

- by def of app

`= prod (hd :: app tl l2)`

- by def of prod

`= hd * prod (app tl l2)`

- by def of inductive hypothesis

`= hd * prod tl * prod l2`

- by def of prod

`=  prod l1 * prod l2`