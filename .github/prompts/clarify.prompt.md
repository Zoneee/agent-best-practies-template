---
name: clarify
description: Clarify an incoming request into a structured contract before planning or implementation. Use when the task is underspecified, risky, or lacks clear acceptance criteria.
argument-hint: Describe the request, current evidence, and whether you want the default persisted artifact or a chat-only result.
agent: plan
---

# Clarify Task

Use this prompt to normalize an incoming request into a clarification contract before any implementation starts.

Clarification is a convergence stage, not a terminal output format. Once the request has enough scope, constraints, acceptance criteria, and validation detail to plan safely, the workflow should end in a complete execution plan or an explicit blocker, not in repeated next-step recommendations.

## Repository anchors

- Start from [AGENTS.md](../../AGENTS.md).
- Treat repository documents as the source of truth.
- When an active execution plan exists, follow the update discipline in [docs/exec-plans/index.md](../../docs/exec-plans/index.md).

## Required sections

- Always include these sections in the clarification artifact:
   - `## 标题`
   - `## 任务类型`
   - `## 目标与理由`
   - `## 问题 / 缺口`
   - `## 当前证据 / 信号`
   - `## 范围`
   - `## 非范围`
   - `## 约束与禁止`
   - `## 验收标准`
   - `## 验证计划`
   - `## 风险`
   - `## 就绪判定`
   - `## 下一步动作`
- Add these sections only when they reduce ambiguity:
   - `## 相关文档 / 计划 / 代码锚点`
   - `## 下游专用产物（如适用）`
   - `## 假设`
   - `## 未决问题`
   - `## Refactor / Chore 补充`

## Workflow

1. Classify the task as `feature`, `bug`, `refactor`, `chore`, `research`, or `unknown`.
2. Prefer repository facts, linked issues, specs, tests, and code anchors before asking the user.
3. Separate facts, assumptions, and unknowns explicitly.
4. Produce the clarification result using the required sections above as a generic intake artifact.
5. Keep all required sections.
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
11. Do not create code changes in this stage.
12. If the clarification result is plan-ready, create or refresh the execution plan in the same turn instead of stopping at `create plan` as a recommendation.

## Routing rules

- If the clarification result still lacks enough detail to describe feature behavior, keep the missing facts in the clarification artifact or add a short companion note under `docs/exec-plans/active/`, then link it under `## 下游专用产物（如适用）`.
- If the clarification result still lacks enough detail to reproduce or scope a bug, keep the missing facts in the clarification artifact or add a short companion note under `docs/exec-plans/active/`, then link it under `## 下游专用产物（如适用）`.
- If `## 下一步动作` is `create plan`, immediately create or update the execution plan using [templates/plan-template.md](../../templates/plan-template.md), unless the user explicitly asked for a clarify-only artifact.
- If `## 下一步动作` is `implement` and the work will span multiple turns, use Autopilot, or need explicit stop conditions, prepare a handoff contract with [/handoff](../../.github/prompts/handoff.prompt.md) before execution starts.
- Do not leave the workflow parked on repeated `create plan` recommendations once the required planning inputs are already present.

## Blocking rules

- Missing `## 目标与理由` or missing `## 问题 / 缺口` blocks all downstream stages.
- Missing `范围` or `非范围` blocks implementation.
- Missing `验收标准` or `验证计划` blocks implementation.
- For bugs, missing a reproducible signal in the clarification artifact or a linked companion note blocks autonomous fixing.
- For features, missing enough user outcome and scope detail in the clarification artifact or a linked companion note blocks autonomous implementation.
- For refactors, missing `## Refactor / Chore 补充` or a clear protected-behavior / validation note blocks autonomous implementation.

## Output behavior

- By default, persist the clarification artifact under [docs/exec-plans/active/](../../docs/exec-plans/active/) using the file naming contract `YYYY-MM-DD_{task-type}_{topic}.md`.
- If the clarification result is plan-ready and the user did not ask for a clarify-only result, create or refresh the execution plan in the same turn and treat that plan as the final output of the clarify workflow.
- If the user explicitly asks for a chat-only result, return the clarification contract in chat without creating a file.
- When persisting the artifact, keep it separate from existing active execution plans unless the user explicitly asks to merge the content into a plan.
- When a dedicated downstream note is needed, keep it as a separate artifact and link it from `## 下游专用产物（如适用）`.
- The file naming contract applies only to the file name; the document title remains free-form.