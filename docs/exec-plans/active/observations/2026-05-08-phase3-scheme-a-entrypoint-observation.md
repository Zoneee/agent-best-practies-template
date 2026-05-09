# 观察记录

## 标题
Phase 3 观察卡 001：默认工作入口问答命中方案 A 主路径

## 关联信息
- 关联计划：`docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`
- 观察对象 / 方案：Phase 3 / 方案 A / `AGENTS.md` 主入口 + `.github/copilot-instructions.md` 薄桥接 + 单个 `.github/skills/` 试点
- 记录日期：2026-05-08
- 记录人：GitHub Copilot

## 场景
- 任务类型：仓库默认入口问答验证
- 触发背景：验证在当前方案 A 试点下，仓库默认工作入口相关规则是否能在对话中被命中并正确复述。
- 预期命中面：`AGENTS.md`、`docs/exec-plans/index.md`，以及可能的 `.github/copilot-instructions.md` 薄桥接层。

## 实际结果
- 实际命中面：`AGENTS.md`、`docs/exec-plans/index.md`
- 结果判定：歧义
- 观察事实：
  - 基于“先按这个仓库的默认工作入口回答我”这一验证提示，运行时结果显式读取了 `AGENTS.md` 与 `docs/exec-plans/index.md`。
  - 返回内容正确复述了默认入口、默认阅读顺序与 active 执行计划更新纪律。
  - 当前结果仍未暴露 `.github/copilot-instructions.md`、applied instructions 或 native skill discovery 的直接命中证据。

## 证据
- 日志 / 截图 / 输出：VS Code Chat 对上述验证提示的响应摘要；结果已压缩记录到 active 计划的 `进展日志`。
- 相关文件 / PR / 对话入口：
  - `AGENTS.md`
  - `docs/exec-plans/index.md`
  - `.github/copilot-instructions.md`
  - `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 成本与噪音
- 上下文 / token 影响：本次观察未显示薄桥接带来额外重复说明；当前回答仍主要依赖 `AGENTS.md` 与执行计划索引。
- 是否出现重复说明、额外手工补充或错误命中：需要通过定向验证提示触发观察；尚不能仅凭自然命中证明桥接层已自动生效。
- 维护触点：若后续要调整仓库默认入口相关规则，至少需同步检查 `AGENTS.md`、`.github/copilot-instructions.md` 以及与执行计划更新纪律相关的说明文档。

## 影响评估
- 对现有使用者的影响：现有使用者仍可沿用 `AGENTS.md` 作为唯一默认入口，未观察到因方案 A 试点导致的入口混乱。
- 对当前方案判断的影响：支持继续观察方案 A，但不足以据此宣布 repo-wide instructions 层已经稳定命中。
- 是否触发回滚、降级或后续验证：触发后续验证，继续收集 `.github/copilot-instructions.md` 与 `.github/skills/` 的直接命中证据；当前不触发回滚。

## 回写建议
- 适合回写到：进展日志 | 后续事项
- 建议回写摘要：当前默认入口相关规则能够通过 `AGENTS.md` 与执行计划索引被稳定检索；但桥接层与原生 skill 的直接命中证据仍不足，继续保持方案 A 观察状态。
- 后续待验证事项：
  - 是否能在非定向提示下看到 `.github/copilot-instructions.md` 的直接命中证据。
  - 是否能获取 `.github/skills/plan-before-code/SKILL.md` 被原生发现的正向证据。