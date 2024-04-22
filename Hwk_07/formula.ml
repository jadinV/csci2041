
type formula = And  of formula * formula
	     | Implies of formula * formula
             | Or of formula * formula
	     | Not of formula 
	     | Prop of string
	     | True
             | False	

type subst = (string * bool) list


(* Some tautologies *)

(* P or (not P) *)
let t1 = Or (Prop "P", Not (Prop "P"))

(* P -> P *)
let t2 = Implies (Prop "P", Prop "P")

(* P -> Q or Q -> P *)
let t3 = Or (Implies (Prop "P", Prop "Q"), Implies (Prop "Q", Prop "P"))

(* (not P or Q) or (not Q or P) 
   - logically the same as t3 *)
let t4 = Or (Or ( Not (Prop "P"), Prop "Q"), Or ( Not (Prop "Q"), Prop "P"))



(* Some formulas that are not tautologies *)

(* P or Q *)
let nt1 = Or (Prop "P", Prop "Q")

(* P and Q *)
let nt2 = And (Prop "P", Prop "Q")

(* (P && Q) || (R -> Q) *)
let nt3 = Or (And ( Prop "P", Prop "Q"), Implies (Prop "R", Prop "Q"))



