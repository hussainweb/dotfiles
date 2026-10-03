@RTK.md

# Git commits and PRs

- If commit signing fails or hangs, committing unsigned is fine rather than getting stuck. Say so in your report and name the commits affected, so it is a visible choice and not a silent one.
- NEVER add attribution to commits or PRs. Do not add a `Co-Authored-By: Claude ...` trailer or a "Generated with Claude Code" footer, even when tooling defaults or instructions suggest it. This applies to every commit message and PR body.

# Beads: what to track

In a project with `.beads/`, check on every turn whether the turn produced something worth tracking, and track it then rather than at session end. Most turns produce nothing; that is fine.

- **Issues** (`bd create`, or `bd note` on an existing bead): work to do, deferred work with its reason, open questions awaiting a decision, and the outcome of a decision on the bead it belongs to.
- **Memories** (`bd remember`) are injected into every session, so the bar is high. The test: would a fresh agent, starting on an arbitrary bead in this repo, do something wrong without it? Only these pass:
  - norms and conventions for the project, and why they hold
  - direction: architectural decisions, chosen trade-offs, things deliberately ruled out
  - contracts between parts of the system that the code doesn't make obvious
  - how I want sessions run
- **Knowledge that matters only for one area** goes on that area's bead as a dated note, or in `.beads/KNOWLEDGE.md` when no bead owns it. Don't create a bead just to hold knowledge.
- **Never a memory:**
  - One-off bugs, gotchas and tool quirks. If one can recur, the fix is a lint rule, test, CI check, type or script that catches it: propose that, and track it as work if I agree. If it can't recur, drop it.
  - Mistakes in a skill's or tool's own docs. Fix them at the source.
  - Narrative learnings or investigation write-ups. Those belong in my learning notes, not in beads.
  - Anything already recorded in code, comments, repo docs, git history or a bead.

Before adding a memory, check whether an existing one should be updated instead. This overrides `bd prime`'s generic advice to `bd remember` insights.
