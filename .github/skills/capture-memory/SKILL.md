---
name: capture-memory
description: Capture durable lessons into GitHub Copilot Memory with the correct scope. Use when a task produces reusable experience, stable repo practices, or personal working preferences that should outlive the current chat.
argument-hint: Describe the lesson, who benefits from it, whether it changes shared repo facts, and which memory scope seems appropriate.
---

# Capture Memory

Use this skill when the work produced an insight that is worth keeping.

The goal is to store durable experience in GitHub Copilot Memory instead of scattering it across ad hoc local notes.

## Apply this skill when

- you found a repeated pitfall, workaround, or validation pattern worth reusing
- you confirmed a repo-specific operating rule that future agents will likely need again
- you want to preserve a personal preference or cross-repo working habit
- you are closing work and there is a stable lesson that should survive the current conversation

## Do not use this skill for

- temporary status updates or task progress logs
- raw command output, long narratives, or ticket-specific timelines
- shared repo rules that belong only in versioned documentation and nowhere else

## Memory decision tree

1. If the knowledge changes a team-shared rule, interface contract, architecture boundary, or formal workflow, update repository docs first.
2. If the knowledge is mainly a reusable repo-scoped lesson for future work in this repository, store it under `/memories/repo/`.
3. If the knowledge is mainly a personal preference, cross-repo habit, or general technique, store it under `/memories/`.
4. If the knowledge is only needed for the current conversation, keep it in `/memories/session/` or in the execution plan instead of promoting it to long-term memory.

## Workflow

1. Check existing memory files before creating new ones to avoid duplicates.
2. Compress the lesson into short durable bullets rather than long prose.
3. Prefer updating an existing memory file over creating a new fragmented note.
4. Include the trigger, the durable lesson, and any important boundary or caveat.
5. If the lesson also changes shared repo facts, write the doc update as well; Memory does not replace reviewed documentation.

## Quality bar

- Stable: likely still useful after the current task is forgotten.
- Reusable: likely to save time or prevent the same mistake again.
- Scoped: clearly belongs to user memory, repo memory, or session memory.
- Concise: short enough to be scanned and applied later.

## Repository notes

- Start from [AGENTS.md](../../../AGENTS.md).
- Use GitHub Copilot Memory as the long-term experience layer, not as a substitute for shared repository documentation.
- In this repository, `/memories/` is for user-wide preferences, `/memories/repo/` is for repo-scoped reusable experience, and `docs/` remains the source of truth for shared standards, design, and plans.