---
name: clarify
description: Clarify an incoming request into a structured contract before planning or implementation. Use when the task is underspecified, risky, or lacks clear acceptance criteria.
argument-hint: Describe the request, current evidence, and whether you want the default persisted artifact or a chat-only result.
agent: plan
---

# Clarify Task

Use this prompt to normalize an incoming request into a clarification contract before any implementation starts.

## Repository anchors

- Start from [AGENTS.md](../../AGENTS.md).
- Treat repository documents as the source of truth.
- When an active execution plan exists, follow the update discipline in [docs/exec-plans/index.md](../../docs/exec-plans/index.md).
- Use the structure in [templates/clarification-contract-template.md](../../templates/clarification-contract-template.md).

## Workflow

1. Classify the task as `feature`, `bug`, `refactor`, `chore`, `research`, or `unknown`.
2. Prefer repository facts, linked issues, specs, tests, and code anchors before asking the user.
3. Separate facts, assumptions, and unknowns explicitly.
4. Produce the clarification result using the template structure as a generic intake artifact.
5. Keep all universal sections.
6. For `refactor` and `chore`, keep the dedicated supplement block in the clarification contract.
7. For `feature` and `bug`, do not recreate a full feature spec or full bug report inside the clarification artifact; if a dedicated downstream artifact is needed, link it under `## 下游专用产物（如适用）`.
8. If a required field is unknown, write `待补充` and list the blocker under `## 未决问题`.
9. Set `## 就绪判定` to exactly one of:
   - `Ready for planning`
   - `Ready for implementation`
   - `Blocked on user input`
   - `Blocked on repo research`
   - `Not in scope`
10. Set `## 下一步动作` to exactly one of:
   - `ask user`
   - `research repo`
   - `create plan`
   - `implement`
11. Do not create an implementation plan or code changes in this stage.

## Routing rules

- If the clarification result still lacks enough detail to describe feature behavior, create or refresh a separate feature spec with [templates/feature-spec-template.md](../../templates/feature-spec-template.md) in the next stage, and link it under `## 下游专用产物（如适用）`.
- If the clarification result still lacks enough detail to reproduce or scope a bug, create or refresh a separate bug report with [templates/bug-report-template.md](../../templates/bug-report-template.md) in the next stage, and link it under `## 下游专用产物（如适用）`.
- If `## 下一步动作` is `create plan`, the next artifact is an execution plan using [templates/plan-template.md](../../templates/plan-template.md).
- If `## 下一步动作` is `implement` and the work will span multiple turns, use Autopilot, or need explicit stop conditions, prepare a handoff contract with [/handoff](../../.github/prompts/handoff.prompt.md) before execution starts.
- In this clarify stage, route to the next artifact but do not create plans, handoff contracts, or code changes unless the user explicitly asks for that follow-up step.

## Blocking rules

- Missing `目标结果` or missing `问题 / 缺口` blocks all downstream stages.
- Missing `范围` or `非范围` blocks implementation.
- Missing `验收标准` or `验证计划` blocks implementation.
- For bugs, missing a reproducible signal in the clarification artifact or a linked detailed bug report blocks autonomous fixing.
- For features, missing enough user outcome and scope detail in the clarification artifact or a linked feature spec blocks autonomous implementation.
- For refactors, missing `受保护行为` or `验证范围` blocks autonomous implementation.

## Output behavior

- By default, persist the clarification artifact under [docs/exec-plans/active/](../../docs/exec-plans/active/) using the file naming contract `YYYY-MM-DD_{task-type}_{topic}.md`.
- If the user explicitly asks for a chat-only result, return the clarification contract in chat without creating a file.
- When persisting the artifact, keep it separate from existing active execution plans unless the user explicitly asks to merge the content into a plan.
- When a dedicated feature spec or bug report is needed, keep it as a separate artifact and link it from `## 下游专用产物（如适用）`.
- The file naming contract applies only to the file name; the document title remains free-form.