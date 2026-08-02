# AGENTS instructions

## Collaboration contract

- Do not implement changes unless explicitly instructed to.
  - By default, you are planning, brainstorming, or answering questions.
  - Feedback to a plan is not permission to implement. Update the plan only unless explicitly instructed to implement.
  - A question is not permission to implement. Answer the question only unless explicitly instructed to implement.
  - If there is ambiguity, ask.
- Do not overindex on intermediate commits or intermediate states when working on non-default branches (i.e., not main or master).
  - When asked to review code, focus on the final code state. Intermediate commits are historical context but otherwise not important.
  - If there was intermediate state that was changed, a regression test is not necessary. Regression tests are only relevant for changes relative to shipped code.

## Project-specific dev tools

When running tools like `python` or `pytest`, don't just assume things. If instructions are not documented, look at the project's setup to use the appropriate package managers like `uv` or command runners like `just`.
