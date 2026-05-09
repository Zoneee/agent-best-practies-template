# 功能规格

## 标题
文档治理门禁增强规格：让 workspace hooks 能识别并强制最小可机械化的文档治理验证

## 来源澄清契约
`docs/exec-plans/active/2026-05-09_feature_doc-governance-hook-enforcement.md`

## 相关计划 / 代码锚点
- `docs/standards/workspace-hooks.md`
- `.github/hooks/workspace-baseline.json`
- `.github/hooks/scripts/hook_common.py`
- `.github/hooks/scripts/post_tool_use_baseline.py`
- `.github/hooks/scripts/stop_baseline.py`
- `tools/scripts/check-doc-freshness.sh`
- `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`
- `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 用户问题
当前 feature 执行结束后，hooks 最多只能确认“是否跑过某种验证”，却无法确认“文档治理检查是否已完成”。这使得 feature 工作即便通过了测试或链接检查，也可能仍然遗留文档噪音、过时说明或未回写的计划 / 契约 / 证据。

## 期望结果
新增一条可机读、可失败退出的文档治理验证路径，并让 hooks 在相关 slice 完成前要求这条验证通过；对暂时无法机械判断的语义噪音问题，明确保留人工审计或单独立项，而不是伪装成已经自动覆盖。短期交付只面向本地 hooks 与手动命令验证，不以 CI 集成为目标。

## 范围
- 设计文档治理验证的 `v1` 目标、触发条件和成功 / 失败语义。
- 明确是否升级现有 `check-doc-freshness.sh`，或新增更适合本地 hooks / 手动验证复用的命令入口。
- 扩展 hooks 基线，使其能在相关 slice 中识别“文档治理验证必需 / 已完成 / 未完成”。
- 同步更新 `docs/standards/workspace-hooks.md`、相关执行计划与验证记录方式。

## 非范围
- 直接实现全仓库语义级重复检测或 token 成本评分。
- 替代 workflow audit 计划中关于职责边界与重复文档的长期审计工作。
- 为短期方案引入或重构 CI 工作流。

## 约束与禁止
- hooks 的 clearing signal 必须优先使用命令型验证，不依赖编辑器诊断工具。
- `v1` 必须先保证低误报和可解释性，不能因为追求覆盖面而牺牲执行稳定性。
- 必须保留当前三类文档新鲜度分流的已知业务语义，除非计划中显式决定调整。
- 不得把“人工审计仍必需”的问题静默并入“自动已覆盖”的结论。

## 用户流程
1. Agent / 维护者完成一个相关 feature slice 的实现或文档改动。
2. hooks 将当前 slice 标记为“除了通用验证外，还需要文档治理验证”。
3. Agent / 维护者运行专用文档治理检查命令。
4. 若命令通过，hooks 允许结束当前 slice；若失败或未运行，hooks 在 `PostToolUse` 或 `Stop` 阶段阻止继续或结束。
5. 若本次发现的问题属于人工语义审计范围，则需要在计划 / handoff / PR 说明中记录，而不是依赖 hooks 自动放行。

## 边界情况
- 仅修改 `docs/exec-plans/active/` 时，现有新鲜度三类分流会把这些文件排除自动检查，需要单独定义 `v1` 的处理策略。
- 仅修复文档拼写或链接时，不应要求完整的高成本审计。
- 代码功能变更但没有直接修改文档文件时，是否强制文档治理验证需要单独定义触发矩阵。
- `get_errors` 仍不能作为强制 validation gate 的 clearing signal。

## 风险
- 若把“应更新文档”推断范围扩得过大，hooks 会频繁误拦截。
- 若命令输出语义不稳定，hook 侧可能再次出现误判。
- 若把未来可能存在的 CI 预留需求提前混入 `v1`，会无谓扩大当前实现范围。

## 验收标准
- 有一条对 hooks 友好的文档治理命令，具备明确的 pass/fail 语义。
- hooks 能在相关 slice 中识别该命令是否已成功运行，并在缺失时阻止结束。
- 标准文档明确写出 `v1` 自动覆盖范围与仍需人工判断的范围。
- 相关计划与证据回写路径清晰，不依赖对话口头约定。

## 成功指标
- 相关 feature slice 在未完成文档治理验证时不能静默结束。
- 文档治理检查不再仅靠人工记忆，而成为 hooks 可观察的执行门禁之一。
- 新能力不会把现有 hooks 噪音放大到不可接受程度。

## 相关架构文档
- `docs/standards/workspace-hooks.md`
- `docs/exec-plans/index.md`

## 相关开发规范
- `AGENTS.md`
- `skills/docs-update-required.md`