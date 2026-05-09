# Workspace Hooks 基线

状态：有效
负责人：工程团队
最后评审：2026-05-09

## 用途
- 把 handoff contract 中已定义的可机械化 stop condition 压缩为可复用的 workspace hooks 默认落点。
- 为 repo-local Agent / Autopilot 执行提供第一版 `PreToolUse`、`PostToolUse`、`Stop` 基线，并明确 `chat-light` / `plan-light` / `full-governance` 之间的 gate 差异。
- 作为 [templates/plan-execute-handoff-contract-template.md](../../templates/plan-execute-handoff-contract-template.md) 与 [/handoff](../../.github/prompts/handoff.prompt.md) 的默认 hooks 映射来源。

## 适用边界
- 仅用于已经进入执行阶段的 `full-governance` 任务；单轮 `plan-light` 或 chat-only 输出默认不要求独立 handoff contract。
- 只承接“当前工具输入或输出可直接判断”的门禁。
- 需要产品取舍、优先级变更、环境权衡或人工授权的条件，继续保留在 handoff contract 的人工停止条件中，不下沉到 hooks。
- 当前 VS Code hooks payload 尚未稳定提供 `plan | ask | agent` 模式字段；若 runtime 或上层 wrapper 显式提供该字段，hooks 应按模式分流。字段缺省时，当前基线只把仓库工作树内的写入视为执行态改动，不把 `/memories/` 等会话/外部路径写入纳入 validation gate。

## 模式化门禁基线

| 模式    | 默认 gate 期望                                                                                                                                                       |
| ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ask`   | 对应 `chat-light`：仅保留 `PreToolUse` 的安全防线；默认不要求执行态 validation、计划产物落盘或文档治理 gate。                                                       |
| `plan`  | 对应 `plan-light`：仅保留安全防线，以及用户显式要求落盘时对实际仓库文件写入的最小必要检查；会话计划、`/memories/` 写入或 chat-only 计划输出不应触发执行态 `PostToolUse` / `Stop` 门禁。 |
| `agent` | 对应 `full-governance`：应用完整执行态门禁；仓库文件写入触发 pending validation，失败验证阻止推进，未完成 required validation / evidence 时阻止结束。                 |

## 默认落点原则
- `PreToolUse`：优先拦截“执行前就能判断，且一旦放行就可能产生越界副作用”的规则。
- `PostToolUse`：优先检查“必须看到工具结果后才能确认”的规则。
- `Stop`：保留“依赖跨步骤状态、重试历史或任务完成态判断”的规则。

## 第一批建议实现顺序
1. `PreToolUse`：先实现范围、禁止项与 destructive 防线，因为风险最高且最容易机械判断。
2. `PostToolUse`：再实现验证失败、诊断错误、产物缺失与回写缺失等结果检查。
3. `Stop`：最后实现提前宣告完成、同一关键验证反复失败等依赖执行状态的门禁。

## 默认规则映射

| 合同中的可机械化条件                                                        | 默认 hook     | 默认动作                                                        | 说明                                                                          |
| --------------------------------------------------------------------------- | ------------- | --------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| 超出 `## 范围` 或命中 `## 约束与禁止` 的文件改动、命令或工具调用            | `PreToolUse`  | 直接阻止并要求先更新 contract                                   | 这是最高优先级的越界防线，不能等副作用发生后再补救。                          |
| 未授权的 destructive 命令或高风险写操作                                     | `PreToolUse`  | 直接阻止并回报                                                  | 目标是把不可逆操作拦在执行前，而不是依赖事后回滚。                            |
| 当前 slice 之外的不必要工具调用或路径写入                                   | `PreToolUse`  | 直接阻止；若确有需要，先更新 contract                           | 这类规则来自当前 slice 的已知范围，适合在工具执行前检查。                     |
| 当前 required slice 的关键验证失败                                          | `PostToolUse` | 阻止进入下一步；允许在当前 slice 内做一次局部修复并重跑同一验证 | 只有在看到验证结果后才能判断，因此默认挂在 `PostToolUse`。                    |
| 相关文件出现新的诊断错误                                                    | `PostToolUse` | 阻止进入下一步，直到错误清除或已按 contract 记录例外            | 需要依据编辑后的诊断结果判断。                                                |
| 预期产物未生成、未更新，或计划 / 契约 / 证据回写痕迹缺失                    | `PostToolUse` | 阻止进入下一步；若到 slice 边界仍未补齐，再升级到 `Stop`        | 先在结果面检查，避免遗漏产物或证据。                                          |
| 同一关键验证在一次局部修复后仍失败                                          | `Stop`        | 停止执行并回报当前 slice 已超出局部修复边界                     | 该条件依赖“已修复并重跑过一次”的执行历史，不适合只靠单次 `PostToolUse` 判断。 |
| Agent 试图在 required slices、required 验证或 required 证据未完成时结束执行 | `Stop`        | 阻止完成并回报缺口                                              | 这是任务生命周期层面的门禁，默认保留到 `Stop`。                               |

## 暂不下沉到 hooks 的条件
- 执行目标、范围或优先级与用户最新明确指令冲突。
- 缺少关键环境、依赖、权限、凭证或外部事实源，且是否继续需要人工权衡。
- 相关文件被外部修改，已经影响当前执行判断或证据有效性。
- 当前出现的新风险超出源执行计划允许的权衡边界。

## 回填 handoff contract 的默认方式
- 若当前任务只需要 `plan-light`，不回填 handoff contract；直接在源计划或当前输出中记录范围、验证和下一步。
- `PreToolUse`：默认填写范围越界、命中禁止项、未授权 destructive 命令、当前 slice 之外的不必要工具或路径写入。
- `PostToolUse`：默认填写关键验证失败、新诊断错误、预期产物缺失、计划 / 契约 / 证据回写缺失。
- `Stop`：默认填写“同一关键验证在一次局部修复后仍失败”与“试图在 required work 未完成时提前结束执行”。
- 若某个 slice 需要更严格的门禁，应在 handoff contract 中在默认基线之上追加，而不是重写整套映射逻辑。

## 最小实现草案
- 当前仓库已提供一版 workspace hooks 草案：`.github/hooks/workspace-baseline.json`。
- `PreToolUse` 当前由 `.github/hooks/scripts/pre_tool_use_baseline.py` 承接，先覆盖 destructive terminal 命令与 `.git/` 元数据路径写入这两类高风险规则。
- `PostToolUse` 当前由 `.github/hooks/scripts/post_tool_use_baseline.py` 承接，先用最小状态跟踪覆盖“编辑后待验证”“验证失败阻止继续”这两类门禁。
- `Stop` 当前由 `.github/hooks/scripts/stop_baseline.py` 承接，先覆盖“仍有待验证改动时阻止结束”与“同一验证重复失败时阻止静默结束”。
- 运行时状态默认写入 `.git/copilot-hooks-state/`，避免在工作树内制造新的跟踪文件。

## 当前草案已覆盖的部分
- 危险 terminal 命令在工具执行前阻止。
- `.git/` 元数据路径写入在工具执行前阻止。
- 仅仓库工作树内的文件改动会触发待验证状态；`/memories/` 等会话内存写入不会被误记为待验证改动。
- 验证失败会在 `PostToolUse` 阶段阻止继续推进。
- 仍有待验证改动，或同一验证重复失败时，会在 `Stop` 阶段阻止直接结束。

## 当前草案未覆盖的部分
- 基于 handoff contract 的精确范围 / slice 级路径边界检查。
- `plan-light` 与 `full-governance` 在同一 runtime mode 下的更细粒度自动识别；当前仍主要依赖显式 mode 或“是否为仓库工作树写入”的保守代理。
- “预期产物、计划回写、证据回写是否齐全”的精确存在性验证；当前仅保留为文档基线和后续增强点。
- 外部文件变更、优先级冲突、环境权衡等仍需人工判断的停止条件。
- `get_errors` 在当前 VS Code hooks runtime 中会提供 `tool_name=get_errors` 与 `tool_input.filePaths`，但 `tool_response` 为空；因此它当前只适合作为补充诊断，不作为 `PostToolUse` 的强制 validation gate。
- 其他 VS Code agent logs 中更精确的 tool schema 适配；若首次运行发现 tool 名称或字段与当前脚本假设不同，应先按日志修正脚本，再扩大 enforcement 范围。

## 已验证的 runtime 适配结论
- 当前 hooks 已在仓库中真实生效。
- `get_errors` 的 runtime schema 已被实际观察并回写到 hooks 草案：由于缺少可用的 `tool_response`，它不再参与 `PostToolUse` 的 blocking validation 判定。
- 当前 payload 仅稳定提供 `tool_name`、`tool_input`、`cwd`、`session_id`、`transcript_path` 等字段，尚未观察到可直接依赖的 chat mode 字段；因此 hooks `v1` 先支持可选显式 mode，并以“是否为仓库工作树写入”作为执行态 gate 的保守代理。
- 当前 hooks 草案的强制 validation 应优先依赖可执行命令型验证，例如 `bash tools/scripts/check-doc-links.sh`、测试命令或显式 lint / check 命令；编辑器诊断继续作为补充信号使用。

## 推荐的当前仓库内验证方式
1. 对 hooks 草案本身，优先用可执行命令验证：脚本编译、JSON 解析、文档链接检查、测试 / lint / check 命令。
2. 对编辑器诊断工具，当前只把 `get_errors` 作为补充观察，不把它作为 clearing pending-validation 的唯一依据。
3. 若后续需要让诊断类工具参与强制门禁，应先取得包含结果正文的稳定 hook payload，再单独扩展脚本。
