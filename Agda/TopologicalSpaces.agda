-- A possible representation of topological spaces by using is-an-open-set predicate.
--
-- Companion code for reply to ─notation from OP is used─
-- https://cs.stackexchange.com/questions/99243/curry-howard-isomorphism-in-object-oriented-programming-languages

open import Data.Bool renaming (Bool to Boolean)
open import Relation.Binary.PropositionalEquality
open import Data.Product renaming (_×_ to _AND_)

{-
For brevity we use propositional equality; it would be better
to use a use-provided notion of equality on 

`BaseSet` is the underlying set of the topological space;
`Topology S` tells us whether a set `S`, represented as a predicate,
is an open set or not.
-}

record R : Set₁ where

  field     
     BaseSet  : Set
     Topology : (BaseSet → Boolean) → Boolean

  Empty    = λ (x : BaseSet) → false
  Universe = λ (x : BaseSet) → true

  field
    axiom1   :       Topology Empty    ≡ true
                AND  Topology Universe ≡ true
