module

public import LeanSlides
public import Lean
public import Mathlib.Tactic

#slides Intro /-!

## Trusting and understanding a formal proof in Lean

Anand Rao Tadipatri

_AI4Maths&Science Journal Club_

---

## Autoformalization in the news

- [Classification of Finite Simple Groups](https://cfsg.axiommath.ai/)
- [Stacks Project formalization](https://stacks.axiommath.ai/)
- [Fermat's Last Theorem](https://www.anthropic.com/research/formalizing-fermats-last-theorem)


## Talk outline

- An introduction to interactive theorem provers and Lean
- A closer look at the activity of formalization
- Trusting a Lean formalization
- Formalizations as explanations

## Proof assistants

> An interactive theorem prover (or proof assistant) is a kind of mathematical technology for constructing and verifying formal mathematical proofs.

## Proof assistants

- It has been known for about 100 years that it is possible to formalize all mathematical knowledge in a logical foundation in principle.
- Proof assistants are computer implementations of a foun-
dational system along with additional layers for translating between the high-level intent and the formal details.

## Modern proof assistants

- Isabelle
- PVS
- Coq
- Lean
- Agda
- Mizar
- Metamath
- HOL Light

## `Lean`

- `Lean` is an interactive theorem prover and programming language
  based on the foundation of dependent type theory.
- It is being developed primarily by
  Leonardo de Moura and Sebastian Ullrich.
- `Lean` has a large library of formal mathematics,
  known as [`mathlib`](https://leanprover-community.github.io/mathlib4_docs/).
- `Lean` is also designed to be a
  fast and general-purpose programming language.
- Lean is highly extensible and allows users to write their own notation, tooling and automation.

## Why formalize mathematics?

- To ensure proofs are correct
- To understand the mathematics more deeply
- To organize mathematical knowledge
- To play maths as a video game

## Other Lean projects
- [CSLib](https://www.cslib.io/): computer science (lambda calculus, automata, ...)
- [Physlean](https://josephtoobysmith.com/Slides/Orsay2025.html#/)
- [Hex](https://kim-em.github.io/hex-dev/): verified computer algebra
- [Aeneas](https://aeneasverif.github.io/): Rust code verified in Lean
- [Signal Shot](https://www.beneficialaifoundation.org/signal-shot)

-/

/-! ## The Lean mathematics library - `mathlib` -/
#html iframeComponent
  "https://leanprover-community.github.io/mathlib4_docs/"

-- A Lean proof
example (P : Prop) (p : P) : P := by
  assumption

-- Another proof
example (P Q : Prop) (p : P) (h : P → Q) : Q := by
  apply h at p 
  assumption

-- Yet another proof
example (P Q R : Prop) : (P → Q → R) → (P → Q) → P → R := by
  intro h₁ h₂ p
  specialize h₁ p
  apply h₁
  apply h₂ at p 
  assumption

/-! A sample proof from `Mathlib`. -/

#check Nat.exists_infinite_primes

#slides Trust /-!

## Why should we trust Lean?
- Lean's logic is based on Type Theory, a foundational system for mathematics, just like (ZFC) set theory
- The piece of code that checks whether a proof is correct is the kernel

## Trusting Lean's kernel
- The kernel is a relatively small piece of code
- There are multiple independent kernel implementations, just in case the offical kernel has a bug
- One kernel, con leche (CONsistent LEan CHEcker), has been formally verified\
(assuming consistency of ZFC set theory with an infinite chain of inaccessible cardinals)

## Trusting a theorem statement
- Lean only checks the proof. You need to check the theorem statement
- Collections of trusted Lean statements: AnnalsChallenge, Formal Conjectures
- Comparator: separation of statement and proof

## AI-generated Lean certificates

- [Classification of Finite Simple Groups](https://cfsg.axiommath.ai/)
- [Stacks Project formalization](https://stacks.axiommath.ai/)
- [Fermat's Last Theorem](https://www.anthropic.com/research/formalizing-fermats-last-theorem)
- [Navier-Stokes](https://openai.com/index/navier-stokes-solution/)

-/

namespace TrustDemo

def False := True
theorem oops₁ : False := trivial

notation "False" => True
theorem oops₂ : False := trivial

elab "theorem" ident " : " term " := " term : command => return
theorem oops₃ : False := 1 + 1

end TrustDemo

#html iframeComponent "https://comparator.live.lean-lang.org/#challengez=CYUwZgBAkgzgCgJwJYFsQQBQDsIC4IByAhgC4CUeAvBAIwQA8EOg5EQSAARBANYA0tDXEQEmEAxjmEAagYGIiJgChZJABYgA9ghApoWMEixISAV1AB5MIlQgYedk16BgIggAHCAD5b0eMjROqEAEYAnrIQEDBqCEFAA&codez=PQWhAIEFwBwJwJYFsCm4EGdwENwDsBXJAIxTnABts4BzM8AFwAts9wBGcAdwWfwHtGiAG4JsFcABMEojPzhYQwAFCSUAM3ABJDAAVEqcAAo2ALnAA5bAwCU4UwF4O4ADz5wgciJwgACJwAawAaZzc%2FcEAkwn9XdwiAGsjAYiJ8ZWVQCABRYTIAT3wiUnIqWnpmVmcWLFx4ZDR1bABjBnlwJWVmFHkUJHAUAA9MBgwAfSrUQdqGptNlcBmffCDONzYIwGAifyCdfWrIr1DEsydiLOn0PAY4QTYmdhOwcDTeJnoAAzxn9CwRlAA6X5OjwZ1bAYFBYJhfezaPQGNB4E4AdvANEQeEk4AA2lYGN9JMJJIM4BoKABdW4QX7fcBNXjgco4AR4EDnGRiCTSWRNHh8Sow8DjRpwBFU4gMbAINiAC%2FJAuBBoBL8kha2lix2kSWngS7kc4COJ1m4AwyBgg3EEnRmxhpL1%2FBFYslMCCgwd8q1vX6Qy%2BY3qAsiRiOSJRkhsuv94rRmOsOLxg3OrAwpJSdwAKk8%2BV75Kygmp1OKUGjCXUCAoZCgKFkglymOACxhGl08PxRQwEPw2C0s6mJohxJCseFLNYTgAfcAABnADgAfBwh%2FgANScSfGNizjh2ABUHYFrKS9cbzbwpnYI%2BPY7YACIAIRn8dT%2Fnp7twhMQZM1NNdiSYHAULjYLKffgGk2mTNCobQdF0d7vsMAGQr4eBBGOaoXvYhzHDM4rnJcADcpySAQDT7u4LhYVOyKhhikGsvGqTgBSOColILJqGifq8FgdQtjWvAECgZybvIiigU84FSFGlHduYcFBL4oSACZE8yjlEoQRHs7jIVqOroWcFz4Dhob4U2LZESRwZkQx4bYri%2BJIAQFAEggNBMAwQRYpG1m2YMFAaAwgz8OogxWUE4kkskqTKAA6mgGBMPwXCMCwDDcDU5HUMQvBwNQOSFHQxisGizAEFg4rZngvAlscSCsFkdgQoQJBkBgQR%2BjACB1H44o0PROBwGlMZwDkdX5OArzPMoeX6jFPB4J1JSJa8yEruw7x0jy2yQZQ1B0OQJRsCN3zKC0YGEl0Wh4CV3FqAA8uoWyoFgkkKWsMDgFO8FQrdaDPRpaGnJhSQzCwwHmMqbALc430huZwXQXGJzWqK4rgBK9q0ijcood0fQ1u6MKep2S7gGD7B2MwmAnBgBDqNmdSguAMTPfJbB%2BmZkgnBhOlGIMkIM%2FgQYA9gQPBLAGPgt8Nz84Lz37ITGNWXjW4PsLgCcBDzeCAFwExjMwGfO0gLaBaq5csU8Q4Aq%2BA0tExrZsW2rJwsxirnYJI%2BLG4CrA03ZXnqM5%2FaWVGLYoKSQA"

#slides Challenges /-!

## The large gap between informal and formal mathematics

- Informal mathematical text often omits details that can be reconstructed by other mathematicians.

> If f is linear, then f (2 · x + y) = 2 · f (x) + f (y).

> f K is a field, U and V are vector spaces over K, and f : |U | → |V | is a
> linear transformation then for all x, y ∈ |U |, f (2 K · x + U y) = 2 K · f (x) + V f (y).

## The choice of description of mathematical objects

- Mathematical objects can be studied from several viewpoints, each offering a different per-
spective.
- Moreover, each description has its strengths and weaknesses.
- One of the subtle challenges of formalisation is choosing representations of mathematical
objects that are well-suited for the proof and interact well with each other and with the defi-
nitions in the library.

## Tedious proofs for obvious theorems

- Facts which appear completely obvious to a mathematician sometimes need long and detailed
justifications.

## Expressivity of the foundations

In the process of formalising mathematics, one is encoding definitions and theorems into a
logical foundation. Modern foundations are sufficiently expressive that this process usually
goes through smoothly, but there are instances where it is substantially more difficult to
encode a statement in a theorem prover than it is to write it down on paper.

-/

/-!
## Syntax in Lean

Being a interactive theorem prover meant for mathematics, Lean supports a rich and extensible syntax framework.
-/

#check { x : Nat // x ≤ 1 }
set_option pp.all true in
#check Polynomial.degree_prod_le

-- You can even define your own syntax!
macro "The " "function " "that " "sends " x:ident " : " T:term " to" " the" " value " v:term : term =>
  `(fun $x : $T ↦ $v)

#eval (The function that sends n : Nat to the value n + 5) 2

section Tactics

/-!
## Tactics

Lean allows proof automation via tactics.
Lean's tactic framework is highly extensible, allowing users to implement their own automation.
-/

-- Powerful proof automation
example (a b c : ℝ)
    (h₁ : a + b + c = 3)
    (h₂ : a ^ 2 + b ^ 2 + c ^ 2 = 5)
    (h₃ : a ^ 3 + b ^ 3 + c ^ 3 = 7) :
    a ^ 4 + b ^ 4 + c ^ 4 = 9 := by
  grind

open Lean Elab Term Tactic in
elab "trace_goal" : tactic => do
  let mainGoal ← getMainGoal
  logInfo m!"The goal is {mainGoal}"

set_option linter.unusedTactic false in
example : 1 = 1 := by
  trace_goal
  rfl

end Tactics

section Widgets

/-!
## User Widgets
Lean supports a framework of interactive and extensible *user widgets* for visualisation.
-/

open Lean ProofWidgets
open scoped ProofWidgets.Jsx

end Widgets

#html iframeComponent
  "https://www.imo.universite-paris-saclay.fr/~patrick.massot/Examples/ContinuousFrom.html"

#html iframeComponent "https://leangame.io/"

#html iframeComponent "https://ejgallego.github.io/verso-flt/"

#html jsx% {<img src="https://raw.githubusercontent.com/PatrickMassot/verbose-lean4/master/verbose_widget_test_en.gif" width="500%" />}

#slides Conclusion /-!

- With autoformalization now at a level where large-scale formalization projects can be carried out autonomously,
  we are in a position to raise our standards for what constitutes a formal proofs.
- Formal proofs should ideally not just certify the correctness of a mathematical result,
  be a means of understanding and exploring a proof at different scales of resolution.

-/
