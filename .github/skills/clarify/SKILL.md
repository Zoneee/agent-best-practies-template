---
name: clarify
description: Clarify an incoming request into a structured contract before planning or implementation. Use when requirements are underspecified, risky, or missing scope, constraints, acceptance criteria, or validation details.
argument-hint: Describe the request, current evidence, missing facts, and whether you want a chat-only clarification result or a persisted handoff into execution planning.
---

# Clarify

Use this skill when the first problem is not implementation but ambiguity.

The goal is to turn an incoming request into a contract that is precise enough to plan, validate, or explicitly block.

## Apply this skill when

- the request is missing scope, acceptance criteria, or validation detail
- facts, assumptions, and unknowns are mixed together
- a feature or bug request still needs a bounded definition before implementation
- the next action is unclear because the task may still be blocked on user input or repo research

## Default contract

- State the target outcome and why it matters now.
- Separate current facts, assumptions, and unknowns explicitly.
- Define scope and non-goals before discussing implementation.
- Make acceptance criteria and validation expectations explicit.
- End in exactly one routed next action: `ask user`, `research repo`, `create plan`, or `implement`.

## Required sections

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

Add optional sections only when they reduce ambiguity: `## 相关文档 / 计划 / 代码锚点`、`## 下游专用产物（如适用）`、`## 假设`、`## 未决问题`、`## Refactor / Chore 补充`.

## Workflow

1. Classify the task as `feature`, `bug`, `refactor`, `chore`, `research`, or `unknown`.
2. Prefer repository facts, plans, issues, tests, and nearby code anchors before asking the user.
3. Fill every required section; if a field is unknown, write `待补充` and list the blocker under `## 未决问题`.
4. Set `## 就绪判定` to exactly one of: `Ready for planning`, `Ready for implementation`, `Blocked on user input`, `Blocked on repo research`, `Not in scope`.
5. Set `## 下一步动作` to exactly one of: `ask user`, `research repo`, `create plan`, `implement`.
6. If the clarification result is plan-ready and the user did not ask for a clarify-only artifact, create or refresh the execution plan in the same turn instead of stopping at a recommendation.

## Blocking rules

- Missing `## 目标与理由` or `## 问题 / 缺口` blocks all downstream stages.
- Missing `## 范围` or `## 非范围` blocks implementation.
- Missing `## 验收标准` or `## 验证计划` blocks implementation.
- For bugs, missing a reproducible signal blocks autonomous fixing.
- For features, missing enough user outcome and scope detail blocks autonomous implementation.
- For refactors, missing protected behavior or validation notes blocks autonomous implementation.

## Output behavior

- By default, persist the clarification artifact under [docs/exec-plans/plans](../../../docs/exec-plans/plans/) using the file naming contract `YYYY-MM-DD_{task-type}_{topic}.md`.
- If the user explicitly asks for a chat-only result, return the clarification contract in chat without creating a file.
- When the clarification result is already plan-ready, create or refresh the execution plan in the same turn and treat that plan as the downstream output of the clarify workflow.

## Repository notes

- Start from [AGENTS.md](../../../AGENTS.md).
- Use [docs/index.md](../../../docs/index.md) and [docs/exec-plans/index.md](../../../docs/exec-plans/index.md) to find the current surviving repo context.
- This skill is the only requirement-clarification entrypoint in the reduced three-skill model.