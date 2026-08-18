## Collaboration contract

- **Do not implement changes unless explicitly instructed to.**
  - By default, you are planning, brainstorming, or answering questions.
  - Feedback to a plan is not permission to implement. Update the plan only unless explicitly instructed to implement.
  - A question is not permission to implement. Answer the question only unless explicitly instructed to implement.
  - If there is ambiguity, ask.
- **Never amend commits or rewrite history unless explicitly instructed to.**
  - By default, I always squash merge. I don't care about commit churn.
  - If I want a rebase, I will explicitly instruct for it. 
  - If there is ambiguity, ask. 

## Instructions

- **Project instructions**: Please check the repository root directory for an `AGENTS.md`. If it exists, read it for project-specific instructions.
- **Project-specific dev tools**: When running tools like `python` or `pytest`, don't just assume things. If instructions are not documented, look at the project's setup to use the appropriate package managers like `uv` or command runners like `just`.
- **Document for the current state**: don't document self-references to edit history, especially edit history that was never merged into `main`.
- **Comments should be concise and only document what the code is or does if non-obvious**: don't justify design, and especially don't keep a history of how it used to work. 
- **Don't test the absence of old behavior.** When behavior changes from X to Y, write tests that assert the new behavior (output equals Y), not tests that only rule out the old one (output does not equal X). Only keep a not-X check if X is a specific _shipped_ bug or edge case the implementation could regress into — not merely "what it used to do."
- **Check the state**: I often cowork with agents in the repository interactively. Just because you haven't committed something or made a change because I said I would do it in a previous turn, doesn't mean the change hasn't happened. Check the repository or filesystem before continuing to assume I haven't done it. 
- **Commit signature**: When creating git commits, use "Assisted-by" instead of "Co-authored-by"
