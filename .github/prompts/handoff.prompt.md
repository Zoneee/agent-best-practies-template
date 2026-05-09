---
name: handoff
description: Compress a stable execution plan into a plan-to-execute handoff contract before multi-turn or Autopilot execution.
argument-hint: Describe the source plan, desired execution range, selected slices if any, and whether you want the default persisted artifact or a chat-only result.
agent: plan
---

# Prepare Execution Handoff

Use this prompt to turn a stable execution plan into a handoff contract before multi-turn execution or Autopilot starts.

## Repository anchors

- Start from [AGENTS.md](../../AGENTS.md).
- Treat repository documents as the source of truth.
- When an active execution plan exists, follow the update discipline in [docs/exec-plans/index.md](../../docs/exec-plans/index.md).
- Build the handoff contract directly from the source execution plan; do not depend on a separate handoff template.
- If hooks or workspace baselines are unavailable, express validation gates and stop conditions directly in the handoff result instead of pointing to missing infrastructure.

## Workflow

1. Identify the source execution plan and any linked clarification contract, spec, design doc, or observation record.
2. Confirm the source plan is already stable enough for execution; if not, route back to planning instead of producing a misleading handoff artifact.
3. Set `## 执行范围模式` to exactly one of:
   - `Full-plan autopilot`
   - `Selected slices`
   - `Verification only`
4. Produce the handoff result as a compact execution projection of the source plan.
5. Keep the source plan as the full truth source for goals, risks, rollback, and long-term decisions; use the handoff contract only for execution range, slice order, validation gates, and stop conditions.
6. For each slice, make the execution gates explicit. If hook mappings are still available in the repo, include them; otherwise write the blocking validation and stop conditions directly in the slice.
7. Split global stop conditions into two classes:
   - hook-mechanizable conditions that should be enforced by hooks when possible
   - human-judgment conditions that should stop and report back instead of guessing
8. If a required field is unknown, write `待补充` and use the readiness / next-action fields to block execution rather than guessing.
9. Set `## 就绪判定` to exactly one of:
   - `Ready for Autopilot`
   - `Ready for manual execution`
   - `Blocked on contract update`
   - `Blocked on environment`
   - `Not ready`
10. Set `## 下一步动作` to exactly one of:
   - `launch autopilot`
   - `manual execute`
   - `update contract`
   - `ask user`
   - `return to planning`
11. Do not implement code changes in this stage; only prepare or refresh the handoff contract.

## Blocking rules

- Missing source execution plan blocks all downstream execution.
- If the source plan still lacks stable scope, validation baseline, or sequencing, set `## 就绪判定` to `Blocked on contract update` or `Not ready` and route back to planning.
- Missing `## 范围`, `## 非范围`, or `## 约束与禁止` blocks autonomous execution.
- Missing per-slice validation or missing either class of global stop condition blocks Autopilot launch.
- If the repo no longer has working hooks or hook baselines, lack of hook mappings alone must not block the handoff; the validation and stop logic still has to be written explicitly.
- If the current user request conflicts with the source plan, return to planning before producing a “ready” handoff artifact.

## Output behavior

- By default, persist the handoff artifact under [docs/exec-plans/active/](../../docs/exec-plans/active/) using the file naming contract `YYYY-MM-DD_handoff_{topic}.md`.
- If the user explicitly asks for a chat-only result, return the handoff contract in chat without creating a file.
- When persisting the artifact, keep it separate from the source execution plan; do not merge the handoff contract into the plan body.
- If the source plan changes after handoff creation, update the source plan first, then refresh the handoff contract.