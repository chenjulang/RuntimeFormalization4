import Lake
open Lake DSL

def moreServerArgs := #[
  "-Dpp.unicode.fun=true", -- pretty-prints `fun a ↦ b`
  "-DautoImplicit=false",
  "-DrelaxedAutoImplicit=false"
]

-- These settings only apply during `lake build`, but not in VSCode editor.
def moreLeanArgs := moreServerArgs

-- moreServerArgs

package «leanCourse» where
  moreServerArgs := moreServerArgs

require mathlib from git "https://github.com/leanprover-community/mathlib4.git"

-- require IMOSLLean4 from git "https://github.com/mortarsanjaya/IMOSLLean4"@"main"
-- require Paperproof from git "https://github.com/Paper-Proof/paperproof.git"@"main"/"lean"
-- require proofwidgets from git "https://github.com/leanprover-community/ProofWidgets4"@"v0.0.3"
-- require alp from git "https://github.com/dwrensha/animate-lean-proofs.git"



-- require MATH681CourseProject from git "https://github.com/davidowe/MATH681CourseProject.git"


-- require MIL from git "https://github.com/avigad/mathematics_in_lean_source.git"
-- require LADR3 from git "https://github.com/martincmartin/linear_algebra_done_right.git"

-- require FM2024 from git "https://github.com/ImperialCollegeLondon/formalising-mathematics-2024.git"



-- require Duper from git "https://github.com/leanprover-community/duper.git" @ "v0.0.5"



@[default_target]
lean_lib «LeanCourse» where
  moreLeanArgs := moreLeanArgs
