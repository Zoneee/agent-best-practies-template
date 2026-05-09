---
name: evidence-driven-delivery
description: Define completion with concrete evidence instead of intuition. Use when planning validation, summarizing a fix, deciding whether work is done, or reviewing risks after a change.
argument-hint: Describe the change, the intended validation method, and what evidence is available or still missing.
---

# Evidence Driven Delivery

Use this skill when you need to turn a plausible change into a defensible result.

## Required questions

1. What was broken or missing?
2. How can it be reproduced or observed?
3. What changed?
4. How was the result validated?
5. What risks remain?
6. What should be monitored or rechecked later?

## Valid evidence examples

- unit, integration, or end-to-end tests
- logs, traces, metrics, or screenshots
- before/after repro steps
- focused manual verification
- validation recorded in an execution plan or companion note

## Repository notes

- Do not mark work as done without recorded evidence.
- In this repo, evidence often belongs in the active execution plan, a linked note under `docs/exec-plans/active/`, or a focused validation summary in chat.