# Bug 报告

## 标题
`get_errors` 在 hooks runtime 中未提供结果正文，导致 PostToolUse 误判

## 来源澄清契约
`docs/exec-plans/active/2026-05-09_bug_get-errors-hook-schema-mismatch.md`

## 用户影响
即使编辑器诊断显示 `No errors found`，hooks 仍可能把当前 slice 判为验证失败，阻止结束或继续推进。

## 预期行为
当诊断工具在 hooks runtime 中没有提供可判定的结果正文时，hooks 不应把它当作强制 validation gate 的唯一信号。

## 实际行为
`get_errors` 的 hook payload 只包含 `tool_name=get_errors` 与 `tool_input.filePaths`，`tool_response` 为空；原草案因此把它误判为失败验证。

## 复现步骤
1. 触发一次 `get_errors`。
2. 观察聊天面显示 `No errors found`。
3. 同时观察 hooks 侧出现 `Validation failed for the current slice` 的阻断。

## 环境
- 仓库：`best-practices-template`
- 运行面：VS Code hooks runtime
- 相关脚本：`.github/hooks/scripts/hook_common.py`、`.github/hooks/scripts/post_tool_use_baseline.py`

## 日志 / 截图
- 真实 runtime 观测显示：`tool_name=get_errors`，`tool_input.filePaths` 存在，`tool_response` 为空。

## 疑似区域
- `hook_common.py` 中的 validation tool 识别与成功/失败判定逻辑。
- `post_tool_use_baseline.py` 中对 validation gate 的依赖方式。

## 严重程度
中

## 相关文档 / 计划 / 代码锚点
- `docs/standards/workspace-hooks.md`
- `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`
- `.github/hooks/scripts/hook_common.py`
- `.github/hooks/scripts/post_tool_use_baseline.py`