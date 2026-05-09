---
name: delivery-quality-first
description: Explain goals, rationale, validation, and risk before diving into implementation. Use when planning work, executing risky changes, reviewing delivery quality, or answering workflow questions in this repository.
argument-hint: Describe the task, current stage, risks, and what evidence or validation is expected.
---

# Delivery Quality First

Use this skill when the main failure mode is not code syntax but weak delivery framing: unclear goals, weak rationale, missing validation, or hand-wavy risk control.

## Apply this skill when

- a plan needs clearer goals, evidence, or rollback notes
- an implementation is about to start without an explicit validation path
- a review or summary needs to explain why the chosen path is correct
- a response is technically plausible but hard to judge quickly

## Default contract

- State the goal, the reason for the current path, and the next concrete action early.
- Keep quality information present, but compress it to the task size instead of expanding empty governance boilerplate.
- Make validation and evidence explicit before claiming work is done.
- Surface major risks, boundaries, and stop conditions instead of hiding uncertainty.

## Mode guidance

- Ask / chat-light: give judgment, rationale, boundaries, and next step.
- Plan / plan-light: define scope, steps, validation, evidence, and risks.
- Agent / execution: state the active slice, validation path, and risk controls before editing.

## Repository notes

- Keep [AGENTS.md](../../../AGENTS.md) as the default workflow entrypoint.
- When an active execution plan exists, follow the tracking discipline in [docs/exec-plans/index.md](../../../docs/exec-plans/index.md).
- Prefer the smallest structure that still makes the work auditable.