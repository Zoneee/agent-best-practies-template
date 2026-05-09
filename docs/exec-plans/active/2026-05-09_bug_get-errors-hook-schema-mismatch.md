# 澄清契约

## 标题
`get_errors` 在 hooks runtime 中缺少结果正文，导致 PostToolUse 误判验证失败

## 摘要
- 当前 hooks 已真实生效，但 `get_errors` 的 runtime payload 不包含可用的结果正文。
- `PostToolUse` 曾把该工具误判为失败验证，阻塞结束流程。
- 需要把这类诊断工具退回补充信号，而不是强制 validation gate。

## 任务类型
bug

## 目标结果
确认 `get_errors` 的真实 hook schema，并将 hooks 草案适配到该事实，避免误判验证失败。

## 问题 / 缺口
最初的 hooks 草案把 `get_errors` 视为普通验证工具，但 runtime 实际只提供 `tool_name` 与 `tool_input.filePaths`，`tool_response` 为空，导致 `PostToolUse` 无法判断成功结果。

## 当前证据 / 信号
- hooks 已真实生效。
- `get_errors` 工具结果在聊天面显示 `No errors found`，但 hook 侧仍出现 `Validation failed for the current slice`。
- runtime 观测表明 `get_errors` payload 的 `tool_response` 为空。

## 相关文档 / 计划 / 代码锚点
- `docs/standards/workspace-hooks.md`
- `.github/hooks/scripts/hook_common.py`
- `.github/hooks/scripts/post_tool_use_baseline.py`
- `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 下游专用产物（如适用）
- feature-spec：不适用
- bug-report：`docs/exec-plans/active/2026-05-09_bug-report_get-errors-hook-schema-mismatch.md`

## 范围
- 识别 `get_errors` 在 hooks runtime 下的真实输入 / 输出结构。
- 调整 hooks 草案对诊断类工具的判断策略。
- 回写当前已知限制和推荐验证方式。

## 非范围
- 不为所有诊断工具一次性建立完整 schema 适配。
- 不把编辑器诊断完全替代为命令行验证。
- 不重写整个 hooks 架构。

## 约束与禁止
- 必须基于真实 runtime 证据调整，而不是继续凭空猜测。
- 不得把没有稳定结果正文的工具继续作为强制 validation clearing 信号。

## 验收标准
- 已确认 `get_errors` 的 runtime schema。
- hooks 草案不再因 `get_errors` 成功结果而误判失败。
- 文档已记录该工具在当前 runtime 下的使用边界。

## 验证计划
- 测试：不适用。
- 手动步骤：触发 `get_errors`，确认 hooks 不再误拦截；复核文档已回写限制。
- 日志 / 截图 / 指标：保留 runtime 观测结论和后续计划记录。

## 风险
- 若后续 runtime schema 变化，当前适配可能需要再次修正。
- 若误把更多诊断工具排除出 validation gate，可能削弱门禁强度。

## 假设
- 当前 `get_errors` 的 hook payload 在短期内保持空 `tool_response`。

## 未决问题
- 未来是否存在稳定、可机读的诊断结果字段可重新纳入 validation gate。

## 就绪判定
Ready for implementation

## 下一步动作
implement