---
name: repo-as-source-of-truth
description: Prefer repository facts over chat memory or private assumptions. Use when gathering authoritative context, reconciling code and docs, or deciding where durable knowledge should be written back.
argument-hint: Describe the question, code area, and which docs, plans, or files may contain the authoritative answer.
---

# Repo As Source Of Truth

Use this skill when the task depends on durable project knowledge and you need to avoid treating recent chat context as the only truth source.

## Apply this skill when

- code and documentation may have drifted
- a workflow or rule is being inferred from memory instead of repository artifacts
- a change creates new durable knowledge that future contributors will need
- you need to choose which file should become the long-term source of truth

## Rules

1. Do not rely on chat history or private notes as the only source of project knowledge.
2. Prefer versioned repository artifacts: plans, docs, schemas, prompts, and checked-in references.
3. If code and docs conflict, investigate and reconcile them instead of guessing.
4. When a change creates durable knowledge, write it back into the repository.

## Repository notes

- Start from [AGENTS.md](../../../AGENTS.md).
- Use [docs/index.md](../../../docs/index.md) and [docs/exec-plans/index.md](../../../docs/exec-plans/index.md) to find the current surviving documentation surface.
- In the current reduced repo shape, durable updates usually belong in surviving standards docs, design logs, or active execution plans.