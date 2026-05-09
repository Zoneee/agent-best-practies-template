# 观察记录

## 标题
Phase 4 本地高度自治执行：原生能力闭环与插件引入门槛

## 关联信息
- 关联计划：`docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`
- 观察对象 / 方案：Phase 4 / 本地高度自治执行 / built-in-first 路径 vs 插件补洞路径
- 记录日期：2026-05-08
- 记录人：GitHub Copilot

## 场景
- 任务类型：research
- 触发背景：在 repo-local 的澄清工作流落地后，需要继续判断“Copilot 像自主员工一样工作”在本地高度自治执行阶段究竟依赖哪些原生能力，以及哪些插件或扩展只有在原生能力出现明确缺口时才值得引入。该仓库同时是会向其他项目分发的最佳实践模板，因此除了本仓库可用性，还要考虑后续跨仓库复用时如何尽量保持一致体验、减少重复纠偏。
- 预期命中面：
  - 当前 Phase 4 built-in-first 路径
  - 本地 agent / Autopilot / hooks / MCP / Copilot CLI 等原生能力
  - 可能的插件、扩展或 MCP 引入门槛

## 实际结果
- 实际命中面：VS Code Copilot 本地 agent、Autopilot、工具审批、terminal auto-approve、sandboxing、hooks、MCP servers、Copilot CLI background sessions、agent plugins 预览能力
- 结果判定：正向
- 观察事实：
  - 当前“本地高度自治执行”的最小原生闭环已经基本存在，不需要先引入插件才能跑通。
  - 对这个仓库来说，立即可用的原生能力组合是：本地 Agent、Autopilot、工具审批与 URL 审批、terminal auto-approve、sandboxing、workspace hooks、必要时 handoff 到 Copilot CLI。
  - 当前真正的缺口不在“没有插件”，而在“缺少确定性的安全门、外部系统事实源、角色级工具边界以及长期可复用的封装”。
  - 由于该仓库本身就是模板仓库，长期可复用的封装不是可有可无的远期目标，而是显式约束；但若在 repo-local 契约、handoff 和安全门尚未稳定时就先打包分发，只会把当前的不稳定一起扩散到其他仓库。

### 原生能力闭环

| 原生能力                 | 当前价值 | 对本地高度自治执行的作用                                                                    | 当前判定                         |
| ------------------------ | -------- | ------------------------------------------------------------------------------------------- | -------------------------------- |
| 本地 Agent + `Autopilot` | 高       | 连续迭代、自动批准工具、自动回复澄清问题，适合作为本地自治执行引擎                          | 立即需要                         |
| 工具审批与 URL 审批      | 高       | 在不完全放开权限时控制 fetch、外部工具与敏感动作                                            | 立即需要                         |
| terminal auto-approve    | 中高     | 对白名单命令降低摩擦，减少每步审批成本                                                      | 立即需要，但需谨慎配置           |
| agent sandboxing         | 高       | 通过文件系统和网络边界把高自治执行限制在可控范围内                                          | 强烈建议尽快验证                 |
| workspace hooks          | 高       | 提供确定性的 PreToolUse / PostToolUse / Stop 门禁，可拦截危险操作、自动跑验证、阻止过早结束 | 强烈建议尽快验证                 |
| MCP servers              | 中高     | 为 agent 提供结构化外部事实与工具，避免把一切都塞进 shell 脚本                              | 仅在事实源不足时引入             |
| Copilot CLI sessions     | 中高     | 本地后台自治执行、可 worktree 隔离、适合定义清楚的实现任务                                  | 当本地 chat 会话不够后台化时启用 |
| custom agents            | 中       | 固化角色、tool list、handoff 与 hooks 组合                                                  | 在 prompt-first 不够稳时引入     |
| agent plugins            | 低到中   | 打包 slash commands、skills、agents、hooks、MCP，适合跨 repo 复用                           | 作为后续分发层候选               |

### 当前原生缺口

| 缺口                   | 影响                                                    | 更接近的原生补法                              | 何时需要插件                                                        |
| ---------------------- | ------------------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------------- |
| 缺少确定性的安全门     | agent 可能在验证不足时继续推进                          | workspace hooks + sandboxing + tool approvals | 当这些原生控制仍不足或需要复用到多仓库时                            |
| 缺少结构化外部事实源   | agent 可能因为看不到 CI、数据库、服务状态而做出风险判断 | workspace MCP server                          | 当需要跨团队复用或统一分发时                                        |
| 缺少角色级工具边界     | 澄清阶段和实现阶段容易共享过多工具                      | custom agent + tool list + agent-scoped hooks | 当团队需要强制岗位边界时                                            |
| 缺少长期后台执行与隔离 | 本地 chat 会话不适合长时实现                            | Copilot CLI worktree isolation                | 通常不需要插件，CLI 已覆盖                                          |
| 缺少跨仓库可安装封装   | 需要在多个仓库复制 prompt / skill / hook                | repo-local 自定义先行                         | 该需求已明确存在，但应在 repo-local 契约稳定后再进入 packaging 设计 |

### 值得考虑的插件 / 扩展类型

| 类别                                                               | 当前价值 | 适用前提                                | 主要风险                                               | 当前建议                       |
| ------------------------------------------------------------------ | -------- | --------------------------------------- | ------------------------------------------------------ | ------------------------------ |
| Workspace MCP server（repo metadata / CI status / issue data）     | 高       | agent 需要读取本地以外的结构化事实      | 服务脆弱性、凭证管理、信任面扩大                       | 首选的“插件级”增强方向         |
| 轻量验证扩展（基于 diagnostics / lint / type errors 阻断继续执行） | 中高     | 发现 agent 经常在仓库已坏状态下继续推进 | 维护额外 VS Code 扩展逻辑                              | 作为次优先增强项               |
| Tool allowlister / auditor 扩展                                    | 中       | 发现不同阶段经常越权使用工具            | 规则过严会拖慢执行；规则过松无收益                     | 仅在真实越权信号出现后考虑     |
| Agent plugin（打包 skill / agent / hook / MCP）                    | 中       | 需要跨多个仓库复用同一自治执行模型      | 预览特性、发行与维护成本高、容易和 repo-local 配置双轨 | 列入后续分发层，但不先于稳定化 |
| 一般性的生产力扩展                                                 | 低       | 仅改善编辑体验，不直接增强自治执行      | 引入噪音和双重真相来源                                 | 不应作为本阶段重点             |

### 具体建议的 adoption order

1. 继续保持 built-in-first：本地 Agent / Autopilot / prompt / template / repo instructions。
2. 优先验证 hooks 与 sandboxing，而不是先找 plugin，因为它们直接决定本地高度自治执行是否安全可控。
3. 仅在 agent 缺少结构化外部事实时，新增 workspace MCP server；优先只读、可 sandbox 的服务器。
4. 仅在出现明确的越权或 broken-state 推进信号时，再考虑 validator extension 或 tool allowlister extension。
5. 由于跨多个仓库分发是该模板仓库的既有目标，当前应先把 repo-local 契约、handoff 与安全门做稳；在这些能力稳定后，再设计跨仓库分发层，优先选择复制友好的 repo-local 结构，只有当复制与维护成本持续过高时才打包成 agent plugin。

## 证据
- 日志 / 截图 / 输出：
  - VS Code Copilot 官方文档：agents overview、agent tools、hooks、MCP servers、agent plugins、Copilot CLI、cloud agents
  - 当前仓库已落地的 `.github/prompts/clarify.prompt.md` 与 `templates/clarification-contract-template.md`
- 相关文件 / PR / 对话入口：
  - `.github/prompts/clarify.prompt.md`
  - `templates/clarification-contract-template.md`
  - `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 成本与噪音
- 上下文 / token 影响：
  - built-in-first 路径的成本主要来自 prompt、template、instructions 与少量 settings。
  - plugin / extension 路径会增加安装、信任、更新、市场可用性与兼容性成本。
- 是否出现重复说明、额外手工补充或错误命中：
  - 当前最大噪音不是缺少插件，而是自治执行的边界和 stop condition 还没有被机械化。
  - 由于本仓库承担模板分发职责，后续确实需要考虑可移植封装；但若过早引入 plugin，容易在 repo-local 配置之外再增加一层“第二真相来源”，把未稳定的行为一起扩散出去。
- 维护触点：
  - 近期若推进原生增强，维护触点会集中在 `.vscode/settings.json`、`.github/hooks/`、`.vscode/mcp.json`、`.github/agents/`。
  - 若推进插件封装，额外维护触点会扩展到 plugin manifest、marketplace 源与插件版本管理。

## 影响评估
- 对现有使用者的影响：
  - 保持 built-in-first 对现有使用者最温和，不强制安装额外扩展或切换到 preview plugin 流程。
  - 若后续引入 hooks / sandboxing，需要使用者理解更严格的执行边界，但这是安全收益而非纯负担。
- 对当前方案判断的影响：
  - 支持继续把本地高度自治执行的近期重点放在原生能力加固，而不是插件引入。
  - 支持把 plugin 的角色明确为“分发和打包层”，而不是当前自治执行能力的首要来源；对模板仓库而言，这意味着 plugin 不再是“是否需要”的问题，而是“何时进入打包”的顺序问题。
- 是否触发回滚、降级或后续验证：
  - 当前不触发回滚。
  - 触发后续验证：优先验证 hooks、sandboxing 与 Copilot CLI worktree 路径，再根据缺口决定是否需要 MCP 或扩展。

## 回写建议
- 适合回写到：进展日志 | 决策日志 | 后续事项
- 建议回写摘要：已完成 Phase 4 对“本地高度自治执行”的原生能力与插件引入门槛研究；当前结论为先用原生能力与 repo-local 契约加固执行闭环，再把稳定工作流作为模板产物分发到其他仓库；plugin / extension 当前仍属于后续分发层而非第一步。
- 后续待验证事项：
  - hooks 是否足以提供需要的 stop condition 与 post-edit 验证门禁。
  - sandboxing 在本仓库下的可用性与对开发体验的影响。
  - Copilot CLI worktree isolation 是否能作为“本地后台高度自治执行”的默认实现路径。
  - 是否确实存在需要 workspace MCP server 才能补齐的外部事实源缺口。
  - 是否需要补充一份可移植的 plan -> execute handoff contract，避免目标仓库重复依赖聊天上下文纠偏。