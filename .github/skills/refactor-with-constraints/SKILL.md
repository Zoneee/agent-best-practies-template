---
name: refactor-with-constraints
description: Refactor without behavior drift or illegal dependency changes. Use when restructuring code, extracting modules, or cleaning internals while preserving observable behavior and validation confidence.
argument-hint: Describe the code area, protected behavior, constraints, and how you plan to validate the refactor.
---

# Refactor With Constraints

Use this skill when cleanup or restructuring is justified, but the repository still needs explicit constraints to avoid architecture drift.

## Rules

1. Preserve observable behavior unless the scope explicitly allows behavior changes.
2. Preserve or improve tests.
3. Keep dependency direction legal.
4. Prefer staged refactors over one-shot rewrites.
5. When a reusable pattern emerges, record its structural intent in surviving docs or plans.

## Evidence expected

- tests are unchanged or improved
- no silent scope expansion
- structural constraints are still respected

## Repository notes

- Use an active execution plan for larger refactors.
- Pair this skill with `delivery-quality-first` and `evidence-driven-delivery` when the refactor spans multiple files.