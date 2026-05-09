# 观察记录

## 标题
Phase 4 澄清工作流：当前 `Plan/Agent + /clarify` 与未来 `Clarify custom agent` 的对照

## 关联信息
- 关联计划：`docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`
- 观察对象 / 方案：Phase 4 / repo-local 澄清工作流 / 当前 prompt-first 路径 vs 未来 custom-agent 路径
- 记录日期：2026-05-08
- 记录人：GitHub Copilot

## 场景
- 任务类型：research
- 触发背景：在已落地 `templates/clarification-contract-template.md` 与 `.github/prompts/clarify.prompt.md` 之后，需要把“继续使用当前 chat 内置 `Plan/Agent + prompt`”与“后续补一个 `Clarify custom agent`”之间的差异写成可追踪文档，作为 Phase 4 后续演进参考。
- 预期命中面：
  - 当前澄清入口：`.github/prompts/clarify.prompt.md`
  - 当前结构化产物模板：`templates/clarification-contract-template.md`
  - 后续候选承载面：`.github/agents/clarify.agent.md`
  - 当前执行计划的阶段四决策与后续事项

## 实际结果
- 实际命中面：当前仓库的 repo-local prompt 方案、澄清契约模板、Phase 4 active plan 跟踪区
- 结果判定：正向
- 观察事实：
  - 当前已实现路径是“内置 `plan` agent + `/clarify` prompt + 澄清契约模板 + 默认落盘到 `docs/exec-plans/active/`”。
  - 当前路径已经能承接“先澄清、后规划 / 实现”的最小工作流，且不需要新增 custom agent、plugin 或扩展依赖。
  - 当前路径的主要优点是改动小、易试错、低迁移成本；主要不足是角色稳定性、handoff 能力和工具边界仍依赖 prompt 文案，而不是角色级配置。

### 具体对照

| 维度               | 当前：内置 `Plan/Agent + /clarify`                                                    | 未来：`Clarify custom agent`                                         |
| ------------------ | ------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| 角色来源           | 由当前 chat 选中的内置 agent，再叠加 `.github/prompts/clarify.prompt.md` 决定本次行为 | 由 `.github/agents/clarify.agent.md` 固化为长期可选角色              |
| 角色稳定性         | 中等；依赖每次进入正确的 chat 模式并触发 `/clarify`                                   | 高；选中 `Clarify` agent 后，整个会话默认按澄清职责工作              |
| 约束强度           | 主要靠 prompt 文案约束“先澄清，不实现”                                                | 可在 agent 层直接限制职责、工具、可调用子 agent 和 handoff           |
| 工具边界           | 偏软；prompt 只能提醒少用或不用某些工具                                               | 偏硬；可把默认工具限制为只读搜索、文件阅读、提问等                   |
| handoff 能力       | 主要靠输出文字提示，后续切换 `Plan` 或 `Agent` 需人工完成                             | 可配置明确的 handoff，例如 `Clarify -> Plan`、`Clarify -> Implement` |
| 工作流入口         | 通过 `/clarify` 作为一次性 slash command 进入                                         | 通过 agent picker 进入一个固定岗位                                   |
| 维护成本           | 低；当前只需维护 prompt 与模板                                                        | 中；需要维护 agent 定义、工具列表、handoff 以及可能的配套说明        |
| 适合阶段           | 工作流试点、字段模板打磨、快速迭代                                                    | 工作流稳定后固化为团队默认岗位                                       |
| 对当前仓库的匹配度 | 高；符合当前 Phase 4 的 built-in-first 策略                                           | 暂不必需；只有当 prompt-first 方案在稳定性或约束力上不足时才值得引入 |
| 当前建议           | 保持为默认方案                                                                        | 作为下一阶段演进方向保留                                             |

### 结论

- 当前仓库应继续以 `Plan/Agent + /clarify` 作为默认澄清路径，因为它已经满足最小可用需求，且不会提前引入新的结构承载面与治理成本。
- `Clarify custom agent` 不是当前必须项，而是“在工作流稳定后提高稳定性与可控性”的后续增强项。
- 若未来出现下列信号，才值得推进到 custom agent：
  - 经常忘记进入 `/clarify` 或进入错误 chat 模式，导致行为漂移。
  - 需要强制的只读阶段，避免澄清阶段直接开始实现。
  - 需要标准化 handoff 到 `Plan` 或 `Implement`，减少人工切换。
  - 需要把澄清角色作为团队固定岗位，而不是一次性 prompt。

## 证据
- 日志 / 截图 / 输出：
  - 当前已存在 `.github/prompts/clarify.prompt.md`
  - 当前已存在 `templates/clarification-contract-template.md`
  - 当前 active plan 已记录 Phase 4 built-in-first 路径与后续 custom agent 评估点
- 相关文件 / PR / 对话入口：
  - `.github/prompts/clarify.prompt.md`
  - `templates/clarification-contract-template.md`
  - `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 成本与噪音
- 上下文 / token 影响：
  - prompt-first 路径的新增上下文较小，只增加一个 slash prompt 和一个模板引用。
  - custom-agent 路径会增加新的角色说明、handoff 配置和工具列表，长期维护成本更高。
- 是否出现重复说明、额外手工补充或错误命中：
  - 当前仍需要人工记住“先用 `/clarify` 再进入后续阶段”，因此存在轻度手工切换成本。
  - 当前未发现因 prompt-first 路径导致的明显断链或配置冲突。
- 维护触点：
  - `.github/prompts/clarify.prompt.md`
  - `templates/clarification-contract-template.md`
  - 若后续升级，还将新增 `.github/agents/clarify.agent.md`

## 影响评估
- 对现有使用者的影响：
  - 当前保持 prompt-first 路径，对现有使用者最温和，不要求改变 chat 使用习惯以外的额外配置。
  - 若未来切到 custom agent，需要团队开始理解 agent picker、handoff 和工具边界。
- 对当前方案判断的影响：
  - 支持继续把 prompt-first 作为当前默认路径。
  - 支持把 custom agent 明确记录为下一阶段的可选演进方向，而不是当前必须交付项。
- 是否触发回滚、降级或后续验证：
  - 当前不触发回滚。
  - 触发后续验证：继续观察 `.github/prompts/clarify.prompt.md` 在真实任务中的稳定性；若出现角色漂移、工具越权或交接成本明显偏高，再立项 `Clarify custom agent`。

## 回写建议
- 适合回写到：进展日志 | 决策日志 | 后续事项
- 建议回写摘要：阶段四当前继续采用 prompt-first 的澄清路径；已形成与未来 `Clarify custom agent` 的对照结论，当前判定 custom agent 属于后续增强而非首批必需交付。
- 后续待验证事项：
  - 当前 `.github/prompts/clarify.prompt.md` 在真实任务中的执行稳定性。
  - 是否频繁出现“澄清阶段直接进入实现”或“需要强制只读阶段”的信号。
  - 是否确实需要标准化 handoff 到 `Plan` / `Agent` 才能降低使用成本。