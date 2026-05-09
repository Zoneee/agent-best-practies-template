---
name: plan-before-code
description: Create or refine an execution plan before coding. Use when asked to break down a task, plan multi-file or high-risk work, define acceptance criteria or validation steps, record risks or rollback notes, or prepare an execution plan for work expected to take more than 15 minutes.
argument-hint: Describe the task, affected area, and any known risks or constraints.
---

# Plan Before Code

Use this skill when the task is large enough that implementation without a written plan would increase scope drift or validation risk.

Typical prompts that should trigger this skill include:

- "Help me create an execution plan before coding"
- "Break down this multi-file change"
- "Plan the implementation and validation steps first"
- "List risks, rollback, and acceptance criteria before we edit code"

## Inputs to gather

- Task description or bug report
- User flow or failure being changed
- Relevant product, architecture, and standards documents
- Existing execution plan under [docs/exec-plans/active/](../../../docs/exec-plans/active/)

## Workflow

1. Summarize the problem in 3-5 bullets.
2. Identify the affected modules, files, and constraints.
3. Define acceptance criteria and the focused validation path.
4. Record risks, rollback notes, and unknowns.
5. If a clarification artifact is already plan-ready, continue directly into plan creation instead of leaving `create plan` as an unexecuted recommendation.
6. For larger work, create or update an execution plan instead of keeping the plan only in chat.

## Output shape

- Delivery goals and success criteria
- Scope and non-goals
- Affected areas
- Validation and evidence plan
- Risks and rollback notes
- Follow-up items

## Notes for this repository

- Keep [AGENTS.md](../../../AGENTS.md) as the default workflow entrypoint.
- When an active execution plan exists, update only the allowed tracking sections described in [docs/exec-plans/index.md](../../../docs/exec-plans/index.md).
- This is the repository-native planning skill for the current GitHub skills layout.
