import Mathlib.Data.List.Sort
import Mathlib.Tactic.Linarith

section timedSort

universe u

variable {α : Type u} (s : α → α → Bool)
local infixl:50 " ≼ " => s

@[simp] def merge (l r : List α) : (List α × Nat) :=
  loop l r []
where
  loop : List α → List α → List α → (List α × Nat)
  | [], r, t => (List.reverseAux t r, 0)
  | l, [], t => (List.reverseAux t l, 0)
  | a::l, b::r, t =>
    bif s a b then
      let (l', n) := loop l (b::r) (a::t)
      (l', n + 1)
    else
      let (l', n) := loop (a::l) r (b::t)
      (l', n + 1)

theorem merge_loop_complexity : ∀ l₁ l₂ l₃ : List α,
  (merge.loop s l₁ l₂ l₃).snd ≤ l₁.length + l₂.length
  | [],   r,  t => by simp [merge.loop]
  | _::_, [], t => by simp [merge.loop]
  | a::l, b::r, t => by
    simp [merge.loop]
    cases s a b
    { simp; have ih := merge_loop_complexity (a :: l) r (b :: t); simp at ih; linarith }
    { simp; have ih := merge_loop_complexity l (b :: r) (a :: t); simp at ih; linarith }

theorem merge_complexity : ∀ l₁ l₂ : List α,
  (merge s l₁ l₂).snd ≤ l₁.length + l₂.length
  | [], l₂ => by simp [merge.loop]
  | (h₁ :: t₁), [] => by simp [merge.loop]
  | (h₁ :: t₁), (h₂ :: t₂) => by
    unfold merge
    unfold merge.loop
    cases s h₁ h₂
    { have ih := merge_loop_complexity s (h₁ :: t₁) t₂ [h₂]
      simp at ih
      simp
      linarith
    }
    { have ih := merge_loop_complexity s t₁ (h₂ :: t₂) [h₁]
      simp at ih
      simp
      linarith
    }

theorem merge_loop_equivalence : ∀ l₁ l₂ l₃ : List α,
  (merge.loop s l₁ l₂ l₃).fst = List.merge.loop s l₁ l₂ l₃
  | [], r, t => by simp [merge.loop, List.merge.loop]
  | _::_, [], t => by simp [merge.loop, List.merge.loop]
  | a::l, b::r, t => by
    simp [merge.loop, List.merge.loop]
    cases s a b
    { simp; exact merge_loop_equivalence (a :: l) r (b :: t) }
    { simp; exact merge_loop_equivalence l (b :: r) (a :: t) }

theorem merge_equivalence : ∀ l₁ l₂ : List α,
  (merge s l₁ l₂).fst = List.merge s l₁ l₂
  | [],       []           => by simp [merge.loop]
  | [],       (h₂ :: t₂)   => by simp [merge.loop]
  | (h₁ :: t₁), []         => by simp [merge.loop]
  | (h₁ :: t₁), (h₂ :: t₂) => by
    unfold merge
    unfold List.merge
    rw [merge_loop_equivalence s (h₁ :: t₁) (h₂ :: t₂) []]

end timedSort
