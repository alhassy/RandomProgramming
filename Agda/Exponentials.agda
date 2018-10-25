-- Looking at exponents law aᵇˣᶜ ≈ (aᵇ)ᶜ constructively: A categorical point of view.
--
-- Companion code for reply to
-- https://mathoverflow.net/questions/313733/constructive-proof-of-exponential-law-in-a-category

open import Relation.Binary.PropositionalEquality
open import Agda.Builtin.String

record _×_ (X Y : Set) : Set where
  constructor _,_
  field
    fst : X
    snd : Y

open _×_

-- Your “intro”
⟨_,_⟩ : ∀{A B C : Set} → (C → A) → (C → B) → (C → A × B)
⟨ f , g ⟩ x = (f x , g x)

record _^_ (Z X : Set) : Set where
  field apply : X → Z

apply : ∀{Z X}  →  (Z ^ X) × X → Z
apply (f , x) = _^_.apply f x

curry : ∀{X Y Z}  →  (X × Y → Z)  →  (X → Z ^ Y)
curry f = λ x → record { apply = λ z → f (x , z) }

swap : ∀{X Y} → X × Y → Y × X
swap = ⟨ snd , fst ⟩

Id : ∀{X : Set} → X → X
Id x = x 

infixr 5 _∘_
_∘_ : ∀{A B C : Set} (f : B → C) (g : A → B) → (A → C)
(f ∘ g) x = f (g x)

_×₁_ : ∀{A B C D} → (A → B) → (C → D) → (A × C → B × D)
f ×₁ g = ⟨ f ∘ fst , g ∘ snd ⟩

assocr : ∀{A B C} → (A × B) × C → A × (B × C)
assocr = ⟨ fst ∘ fst , ⟨ snd ∘ fst , snd ⟩ ⟩
-- Naturality: f × (g × h)  ∘  assocr   =   assocr  ∘  (f × g) × h

assocl : ∀{A B C} → A × (B × C) → (A × B) × C
assocl = ⟨ ⟨ fst , fst ∘ snd ⟩ , snd ∘ snd ⟩ 

expCurry : ∀ {X Y Z}  →  Z ^ (X × Y)  →  (Z ^ Y) ^ X
expCurry = curry (curry (apply ∘ assocr))

expUncurry : ∀ {X Y Z}  →  (Z ^ Y) ^ X  →  Z ^ (X × Y)
expUncurry = curry ((apply ∘ ⟨ apply ∘ fst , snd ⟩) ∘ assocl)

defn-chasing : ∀ {A : Set} (x {y} : A) → String → x ≡ y → x ≡ y
defn-chasing x reason x≡y = x≡y

syntax defn-chasing x reason x≡y = x ≡[ reason ] x≡y

infixr 2 defn-chasing

exploration : ∀{X Y Z} →  expUncurry {X} {Y} {Z} ≡ _
exploration = let open ≡-Reasoning in begin
    expUncurry
  ≡[ "Definition" ]
    curry (apply ∘ ⟨ apply ∘ fst , snd ⟩ ∘ assocl)
  ≡[ "Definition of ×-functor and identities" ]
    curry (apply ∘ (apply ×₁ Id) ∘ assocl)
  ≡[ "Definition of assocl" ]
    curry (apply ∘ (apply ×₁ Id) ∘ ⟨ ⟨ fst , fst ∘ snd ⟩ , snd ∘ snd ⟩)
  ≡[ "×-Fusion: (f × g) ∘ ⟨x, y⟩ = ⟨f ∘ x, g ∘ y⟩" ]
    curry (apply ∘ ⟨ apply ∘ ⟨ fst , fst ∘ snd ⟩ , Id ∘ snd ∘ snd ⟩)
  ≡[ "Definition of ×-functor and identities" ]
    curry (apply ∘ ⟨ apply ∘ (Id ×₁ fst) , snd ∘ snd ⟩)
  ≡[ "Reflection: Id = curry apply" ]
    curry (apply ∘ ⟨ apply ∘ (curry apply ×₁ fst) , snd ∘ snd ⟩)
  ∎

-- Note X and Y swapped  in product.
yourExpCurry : ∀ {X 𝒴 Z}  →  Z ^ (𝒴 × X)  →  (Z ^ 𝒴) ^ X
yourExpCurry = curry (curry (apply ∘ ⟨ fst , swap ∘ snd ⟩ ∘ assocr))

inverse₁ : ∀{X Y Z} →  expCurry {X} {Y} {Z} ∘ expUncurry ≡ Id
inverse₁ = let open ≡-Reasoning in begin
    expCurry ∘ expUncurry
  ≡[ "Definitions" ]
       curry (curry (apply ∘ assocr))
     ∘ curry (apply ∘ ⟨ apply ∘ fst , snd ⟩ ∘ assocl)
  ≡[ "Fusion : curry g ∘ f  ≡  curry (g ∘ (f ×₁ Id))" ]
     curry (curry (apply ∘ assocr)
            ∘ (curry (apply ∘ ⟨ apply ∘ fst , snd ⟩ ∘ assocl) ×₁ Id))
  ≡[ "Fusion : curry g ∘ f  ≡  curry (g ∘ (f ×₁ Id))" ]
     curry (curry (apply ∘ assocr
               ∘ (curry (apply ∘ ⟨ apply ∘ fst , snd ⟩ ∘ assocl) ×₁ Id) ×₁ Id))
  ≡[ "Definition of ×" ]
     curry (curry (apply ∘ assocr
               ∘ (curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id))
  ≡[ "Definition of assocr" ]
     curry (curry (apply ∘ ⟨ fst ∘ fst , ⟨ snd ∘ fst , snd ⟩ ⟩
               ∘ (curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id))
  ≡[ "Fusion: ⟨f, g⟩ ∘ x = ⟨f ∘ x, g ∘ x⟩" ]
     curry (curry (apply ∘
        ⟨ fst ∘ fst ∘ ((curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id) ,
          ⟨ snd ∘ fst , snd ⟩ ∘ ((curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id) ⟩))
  ≡[ "Projection naturality: fst ∘ (f × g) = f ∘ fst; applied twice" ]
     curry (curry (apply ∘
        ⟨ curry (apply ∘ (apply ×₁ Id) ∘ assocl) ∘ fst ∘ fst ,
          ⟨ snd ∘ fst , snd ⟩ ∘ (curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id ⟩))
  ≡[ "Fusion: ⟨f, g⟩ ∘ x = ⟨f ∘ x, g ∘ x⟩" ]
     curry (curry (apply ∘
        ⟨ curry (apply ∘ (apply ×₁ Id) ∘ assocl) ∘ fst ∘ fst ,
          ⟨ snd ∘ fst ∘ ((curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id)
          , snd ∘ ((curry (apply ∘ (apply ×₁ Id) ∘ assocl) ×₁ Id) ×₁ Id) ⟩ ⟩))
  ≡[ "Projection naturality; applied thrice" ]
     curry (curry (apply ∘
        ⟨ curry (apply ∘ (apply ×₁ Id) ∘ assocl) ∘ fst ∘ fst ,
          ⟨ Id ∘ snd ∘ fst , Id ∘ snd ⟩ ⟩))
  ≡[ "Identities" ]
     curry (curry (apply ∘
        ⟨ curry (apply ∘ (apply ×₁ Id) ∘ assocl) ∘ fst ∘ fst ,
          ⟨ snd ∘ fst , snd ⟩ ⟩))
  ≡[ "Exercise!
         ⋮
      Really: Agda is normalising the definitions."
   ]
    curry (apply ∘ (curry (apply ∘ (Id ×₁ Id)) ×₁ Id))
  ≡[ "Cancellation: k = curry (apply ∘ (k × Id))" ]  
    curry (apply ∘ (Id ×₁ Id))
  ≡[ "Cancellation: k = curry (apply ∘ (k × Id))" ]
    Id
  ∎

--  Exponential Characterisation: k = curry f  ≡  f = apply ∘ (k × Id)
--
-- Immediate Consequences Include, proven by making [choices],
--
-- Cancellation: k = curry (apply ∘ (k × Id))                              [f ≔ apply ∘ (k × Id)]
--               f = apply ∘ (curry f × Id)                                [k ≔ curry f]
-- Reflection  : Id = curry apply                                          [k,f ≔ id, apply]
-- Fusion      : curry g ∘ f  ≡  curry (g ∘ (f ×₁ Id))                     [thought required here]
-- Apply Naturality: f ∘ apply_A = apply_B ∘ (curry(f ∘ apply_A) × Id_B)    [k, f ≔ curry(f ∘ apply), f ∘ apply]
-- Curry over Composition: curry(f ∘ g) = curry (f ∘ apply) ∘ curry g      [Fusion then Cancellation]
-- Curry-Fusion: curry(f ∘ g ∘ (h × Id)) = curry(f ∘ apply) ∘ curry g ∘ h   [Fusion; curry-over-∘]
-- Apply-Fusion: apply ∘ ((curry (f ∘ apply) ∘ g ∘ h) × Id) = f ∘ (apply ∘ (g × Id)) ∘ (h × Id) [See below]
{-
Proof of Apply-Fusion:

   apply ∘ ((curry(f ∘ apply) ∘ g ∘ h) × Id)
=  apply ∘ (curry(f ∘ apply ∘ ((g ∘ h) × Id)) × Id)
=  f ∘ apply ∘ ((g ∘ h) × Id)
=  f ∘ apply ∘ ((g ∘ h) × (Id ∘ Id))
=  f ∘ apply ∘ (g × Id) ∘ (h × Id)

Remark: This is just “rad-Fusion” where L(X) = X×Y and R(Z) = Zʸ  = curry(f ∘ apply).
-}
