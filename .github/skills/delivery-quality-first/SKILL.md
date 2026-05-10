---
name: delivery-quality-first
description: Plan, execute, validate, and summarize work with explicit goals, scope, evidence, and risk control. Use when a clear request needs to be turned into a high-quality delivery path in this repository.
argument-hint: Describe the task, current stage, scope, risks, and the validation evidence you expect to produce.
---

# Delivery Quality First

Use this skill when the request is clear enough to move, but the delivery path still needs structure.

The job of this skill is to carry work from plan to implementation to evidence-backed closeout without losing scope control.

In the reduced model, this skill also absorbs the planning, evidence, repo-grounding, and code-implementation guidance that used to live in separate helper skills.

## Apply this skill when

- a plan needs clearer goals, scope, evidence, or rollback notes
- implementation is about to start without an explicit validation path
- a multi-step task should create or update an execution plan instead of staying only in chat
- a review or summary needs to explain what changed, how it was validated, and what risk remains

## Default contract

- State the goal, the reason for the current path, and the next concrete action early.
- Define scope and non-goals before implementation expands.
- Choose the smallest testable slice that can falsify the current plan.
- Make validation and evidence explicit before editing and before claiming work is done.
- Surface major risks, rollback boundaries, and stop conditions instead of hiding uncertainty.

## Workflow

1. Restate the delivery goal, constraints, and success criteria.
2. Decide whether the task should stay chat-light or create/update an execution plan under [docs/exec-plans/](../../../docs/exec-plans/).
3. Implement the smallest slice that exercises the controlling code path or governing document.
4. Run the narrowest focused validation available before widening scope.
5. Record evidence, remaining risks, and any follow-up items before marking work complete.

## Planning and repo grounding

- Prefer repository docs, code, tests, and existing execution plans over chat history when deciding what is true.
- If the task is multi-file, high-risk, or likely to take more than one focused slice, create or update an execution plan instead of leaving planning only in chat.
- Do not stop at recommending `create plan` when the task is already plan-ready.
- If code and docs conflict, reconcile them before implementation continues.

## Implementation expectations

- Make the smallest change that solves the real problem at the controlling code path.
- Keep code readable from names and control flow; avoid commented-out code and unnecessary abstraction.
- Validate untrusted input before it enters business logic.
- Handle failures explicitly; keep user-facing errors actionable and internal diagnostics sufficiently contextual.
- Keep logs useful for operators without exposing secrets, tokens, or private data.
- Keep critical paths bounded with explicit timeouts, graceful degradation where justified, and a rollback path when the change is deployment-relevant.

## Evidence expectations

- Start from the cheapest focused check that can falsify the current approach.
- Prefer narrow tests for the touched slice.
- If no focused test exists, use the narrowest compile, lint, typecheck, or reproducible manual check available.
- Do not mark work done without explicit evidence and a short note about remaining risk.

## Mode guidance

- Ask / chat-light: give judgment, rationale, boundaries, and next step.
- Plan / plan-light: define scope, steps, validation, evidence, and risks.
- Agent / execution: state the active slice, validation path, and risk controls before editing.

## Repository notes

- Keep [AGENTS.md](../../../AGENTS.md) as the default workflow entrypoint.
- When an execution plan exists, follow the tracking discipline in [docs/exec-plans/index.md](../../../docs/exec-plans/index.md).
- Prefer the smallest structure that still makes the work auditable.
- In the three-skill model, this is the default delivery entrypoint after `clarify`.