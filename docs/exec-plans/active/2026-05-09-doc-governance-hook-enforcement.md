# 执行计划

> 先写交付质量控制，再写问题修复内容。若"质量控制相关章节（交付目标与成功标准/范围/非范围/质量门禁/验证计划/证据记录方式/风险/回滚与止损等）"的填写明显少于"实现步骤"，则该计划不合格。

## 标题
workspace hooks 文档治理门禁增强

## 状态
执行中

## 阶段完成度概览
- Phase 1：执行中，已完成路线比较、专用 gate 命令命名、最小检查集合、文本 / 退出码契约、计划产物关键标题清单、无 path 默认取样方式，以及 mode-aware 触发边界收敛；待决定是否覆盖“代码变更但应同步文档”的 slice，并收敛当前 slice 触发条件。
- Phase 2：待开始，实现或拆分文档治理命令，使其具备稳定的 pass/fail 语义。
- Phase 3：待开始，把文档治理命令接入 workspace hooks 状态机与阻止逻辑。
- Phase 4：待开始，完成标准文档回写、真实 runtime 验证与后续边界记录。

## 交付目标与成功标准
- 为当前 workspace hooks 基线补齐一条“文档治理验证”能力：当相关 slice 完成前，Agent 不能只靠通用验证通过就结束，而必须补齐可机读的文档治理检查。
- 让文档治理检查具备明确的命令入口、稳定的成功 / 失败语义，以及 hooks 可识别的 clearing signal。
- 明确记录 `v1` 自动覆盖的内容与仍保留人工审计的问题，避免把暂不可机械化的噪音问题伪装成已自动解决。

## 范围
- `tools/scripts/check-doc-freshness.sh` 的语义评估与必要改造，或新增更适合本地 hooks / 手动验证复用的文档治理命令。
- `.github/hooks/scripts/hook_common.py`、`.github/hooks/scripts/post_tool_use_baseline.py`、`.github/hooks/scripts/stop_baseline.py` 的状态与判定逻辑增强。
- `.github/hooks/workspace-baseline.json`、`docs/standards/workspace-hooks.md` 与相关执行计划 / 规格文档的同步更新。
- 当前本地执行边界、手动验证路径与文档说明的一致性确认。

## 非范围
- 不在本计划中实现全仓库语义级重复检测、token 成本分析或职责边界自动判定。
- 不直接开展大规模文档清理或重写。
- 不重开已经稳定的 Phase 4 hooks runtime 适配结论。

## 质量门禁
- 必须先明确 `v1` 的机械化边界，再写实现步骤；不能把人工审计问题直接塞进自动化承诺。
- 新命令必须具备 hooks 与本地手动验证都可依赖的 pass/fail 语义，不能继续维持“只输出统计、不失败退出”的模糊状态。
- hooks 增强必须可解释、低误报，并且明确哪些路径或 slice 需要该门禁。
- 每一项自动化结论都要有对应的标准文档或计划回写，避免对话知识漂移。

## 验证计划
1. 命令语义验证：确认文档治理命令在“无问题”和“存在问题”两种场景下都能稳定给出预期退出状态与可识别输出。
2. hook 状态验证：对相关 slice 进行一次真实运行，确认未跑文档治理命令时会被阻止，跑通后可清除相应状态。
3. 基线兼容验证：执行 hook 脚本编译、hooks JSON 解析、文档链接检查与受影响文档错误检查。
4. 文档边界验证：核对 `docs/standards/workspace-hooks.md` 与计划文档，确认自动覆盖范围与人工保留范围一致。

## 证据记录方式
- 在本计划 `进展日志` 中记录触发矩阵决策、命令契约、hooks runtime 验证结果与剩余边界。
- 若命令契约或 runtime 行为需要多轮观察，使用 observation card 记录原始现象，再把稳定结论回写本计划。
- 若需执行阶段交接，再基于本计划补充 handoff contract；handoff 只压缩执行规则，不替代本计划。

## 文档更新与治理
- 受影响文档：`docs/standards/workspace-hooks.md`、`docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`、本计划关联的澄清契约与 feature spec、可能新增或修改的脚本说明。
- 是否需要同步修订或移除过时内容：需要；若 `check-doc-freshness.sh` 的职责发生变化，必须同步清理现有“仅报告、不失败”类描述。
- 本计划的验证证据将记录在：本计划 `进展日志`、必要 observation card、相关命令输出摘要。

## 风险
- 路径或 slice 触发策略定义不当，会导致 hooks 误拦截或漏拦截。
- 若直接升级现有 `check-doc-freshness.sh`，可能改变既有“分类报告”语义，并让当前仓库中的历史 workflow 文件说明与真实交付边界脱节。
- 计划 / 契约 / 证据回写是否齐全这类要求，若实现得过于激进，容易把 hooks 变成高噪音系统。

## 回滚与止损
- 若发现把现有 `check-doc-freshness.sh` 直接升级为失败退出会破坏既有流程，则改为新增专用命令，保留原脚本作为报告入口。
- 若 hooks 的触发范围在试运行中产生高误报，先回退到更窄的 path matrix，再决定是否扩大覆盖。
- 若某类文档噪音问题无法形成稳定机器判断，降级回 audit plan 或 observation card，不强行纳入 `v1` 自动门禁。
- 若后续项目真的重新引入 CI，再单独评估是否需要为 gate 命令增加 CI 集成；该决定不阻塞当前计划。

## 背景
Phase 4 已经把 workspace hooks 的最小基线、真实 runtime 适配与 feature / bug 路由验证稳定下来。当前缺口不是 hooks 是否生效，而是 hooks 尚不能强制“文档治理检查已完成”：它只会要求通用验证，而 `check-doc-freshness.sh` 也仍停留在分类报告脚本阶段。

## 问题摘要
- 当前 hooks 只知道“最近是否有写操作、是否跑过某种验证”，不知道“文档治理验证是否已完成”。
- 当前文档新鲜度脚本仍把“重复 / 噪音控制、过时内容清理”保留为人工检查，且不失败退出。
- 仓库虽存在文档检查 workflow 文件，但用户已明确短期内不将 CI 作为项目交付基线，因此当前设计不应继续围绕 CI job 组织。

## 受影响区域
- `.github/hooks/workspace-baseline.json`
- `.github/hooks/scripts/hook_common.py`
- `.github/hooks/scripts/post_tool_use_baseline.py`
- `.github/hooks/scripts/stop_baseline.py`
- `tools/scripts/check-doc-freshness.sh`
- `docs/standards/workspace-hooks.md`
- `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`

## 约束与禁止
- 不得把“完整语义噪音治理”伪装成 `v1` 自动化范围。
- 不得依赖 `get_errors` 或其他缺少稳定结果正文的诊断工具清除文档治理门禁。
- 不得在未定义触发矩阵前就直接扩大 hooks enforcement 范围。
- 不得让实现混入无关文档清理或其他治理主题。

## 实现步骤

### Phase 1：定义门禁契约与触发矩阵
1. 收敛 `v1` 的自动化目标：明确哪些检查属于“可机械化文档治理”，哪些仍属于人工审计。
2. 定义触发矩阵：哪些文件类型、哪些 slice 或哪些命令结果会要求额外文档治理验证。
3. 在“升级现有脚本”与“新增专用命令”之间做出实现决策，并定义统一的成功 / 失败输出契约。

### Phase 2：实现命令语义
1. 让文档治理命令在存在可机械化问题时能失败退出，在通过时输出 hooks 可识别的稳定成功信号。
2. 明确哪些现有检查项继续保留为报告 / 提示，哪些升级为强制 gate。
3. 如需保留原有分类报告语义，拆分出专用 gate 命令，避免混淆报告脚本与 hooks clearing signal 的用途。

### Phase 3：接入 hooks 状态机
1. 扩展 hooks 公共逻辑，使其能识别“本次 slice 需要文档治理验证”以及对应的 clearing command。
2. 更新 `PostToolUse` 与 `Stop` 逻辑，在相关 slice 中阻止“只跑通用验证、不跑文档治理验证”就结束。
3. 保持现有 `get_errors` 退回补充诊断的结论不变，避免重新引入 schema 误判。

### Phase 4：回写标准并做真实验证
1. 更新 `docs/standards/workspace-hooks.md`、相关计划和必要脚本说明，写清自动与人工边界。
2. 进行一次真实 hooks runtime 验证，记录“未跑 gate 被阻止、跑通 gate 后放行”的证据。
3. 若仍发现无法自动化的噪音问题，决定是回写 audit plan、创建 observation card，还是另立后续计划。

## 决策日志
- 2026-05-09：本能力不并入 `2026-05-09-workflow-audit-plan.md`，因为后者的非范围已明确“不直接实施大规模修复或 hooks 能力增强”；本项改以独立 feature 计划承接，避免重新混合“审计”和“实施”。
- 2026-05-09：`v1` 目标先定义为“最小可机械化的文档治理门禁”，而不是“全自动语义噪音清理”。
- 2026-05-09：执行态 hook gate 必须按模式分层：`ask` 与 `plan` 默认只保留安全防线，不因 chat-only 输出、会话计划或 `/memories/` 写入触发“必须完成验证 / 必须落盘计划产物”的执行态阻断；`agent` 才应用完整 validation / stop gate。
- 2026-05-09：当前 VS Code hooks payload 尚未稳定提供可直接依赖的 mode 字段，因此基线实现先采用“双层判定”：若 runtime 或 wrapper 显式提供 `plan | ask | agent`，按模式分流；否则以“是否为仓库工作树写入”作为执行态 gate 代理，明确排除 `/memories/` 等会话内存写入。
- 2026-05-09：Phase 1 设计决策切片结论：`v1` 优先新增专用 gate 命令，而不是直接升级 `tools/scripts/check-doc-freshness.sh`。
- 2026-05-09：比较理由一：`check-doc-freshness.sh` 与现有文档都把它定义为“分类报告 / 不失败退出 / 人工承接重复噪音问题”；若直接升级为 gate，会把既有报告职责与 hooks clearing signal 混在一起。
- 2026-05-09：比较理由二：hooks 侧当前已经把 `bash tools/scripts/check-*.sh` 视为 validation 命令；因此新增专用 gate 命令可以复用现有命令识别面，只需单独定义更稳定的成功 / 失败文本契约，而不必先改造现有报告脚本的职责边界。
- 2026-05-09：用户已明确短期内所有项目都不会引入 CI；因此本计划不再把“是否新增 CI job”视为待决策项，`v1` 仅面向本地 hooks 与手动命令验证设计。
- 2026-05-09：Phase 1 第二个设计决策切片结论：专用 gate 命令暂定命名为 `bash tools/scripts/check-doc-governance.sh`；`check-doc-freshness.sh` 继续保留为分类报告入口，不承担 hooks clearing signal。
- 2026-05-09：`check-doc-governance.sh` 的 `v1` 最小检查集合收敛为 3 类 deterministic checks：`REVIEW_FIELD_PRESENT`，对当前 slice 触达且落在治理范围内的 Markdown 文档校验 `最后评审` 字段存在；`STRICT_REVIEW_NOT_PLACEHOLDER`，对 strict-scope 文档校验 `最后评审` 不是占位值或空值；`PLANNING_ARTIFACT_SHAPE`，对当前 slice 触达的 `docs/exec-plans/active/` 计划产物校验文件命名契约与模板要求的关键顶层标题存在。`v1` 明确不做语义重复检测、职责边界推断或 token 成本推断。
- 2026-05-09：`PLANNING_ARTIFACT_SHAPE` 在 `v1` 只覆盖当前已稳定使用的澄清契约、feature spec 与执行计划三类产物；检查目标是模板结构完整，而不是判断内容是否“写得好”。
- 2026-05-09：专用 gate 命令的文本契约收敛为 3 个稳定首行 token：成功时输出 `DOC_GOVERNANCE_GATE PASSED`；存在治理发现但命令正常完成时输出 `DOC_GOVERNANCE_GATE FAILED`；命令因参数、路径、仓库状态或运行时异常无法完成判断时输出 `DOC_GOVERNANCE_GATE ERROR`。该契约故意复用当前 hooks 已识别的 `passed` / `failed` / `error` 关键词，降低 Phase 2 对额外解析器改造的需求。
- 2026-05-09：专用 gate 命令的退出码契约收敛为：`0` 表示无 findings 且 gate 通过；`1` 表示存在可机械化治理 findings、当前 slice 不可清 gate；`2` 表示命令调用或运行环境异常，当前应视为 blocker 而不是普通治理发现。
- 2026-05-09：专用 gate 命令的详细输出行统一使用稳定前缀，失败时追加 `DOC_GOVERNANCE_FINDING <RULE_ID> <PATH> <DETAIL>`，运行错误时追加 `DOC_GOVERNANCE_ERROR <DETAIL>`，成功时追加摘要行 `checked_files=<N>` 与 `findings=0`，为后续 hooks 日志与人工排查提供最小一致格式。
- 2026-05-09：`PLANNING_ARTIFACT_SHAPE` 的 `v1` 结构契约进一步收敛为“artifact type 对应的固定文档主标题 + 必需 `##` 标题存在性”检查，不校验段落顺序、字数、列表条数或内容质量，以降低误报。澄清契约要求 `# 澄清契约`，且至少包含 `## 标题`、`## 摘要`、`## 任务类型`、`## 目标结果`、`## 问题 / 缺口`、`## 当前证据 / 信号`、`## 相关文档 / 计划 / 代码锚点`、`## 下游专用产物（如适用）`、`## 范围`、`## 非范围`、`## 约束与禁止`、`## 验收标准`、`## 验证计划`、`## 风险`、`## 假设`、`## 未决问题`、`## 就绪判定`、`## 下一步动作`；当 `## 任务类型` 为 `refactor` 或 `chore` 时，再额外要求 `## Refactor / Chore 补充` 与其模板内子标题。feature spec 要求 `# 功能规格`，且至少包含 `## 标题`、`## 来源澄清契约`、`## 相关计划 / 代码锚点`、`## 用户问题`、`## 期望结果`、`## 范围`、`## 非范围`、`## 约束与禁止`、`## 用户流程`、`## 边界情况`、`## 风险`、`## 验收标准`、`## 成功指标`、`## 相关架构文档`、`## 相关开发规范`。执行计划要求 `# 执行计划`，且至少包含 `## 标题`、`## 状态`、`## 阶段完成度概览`、`## 交付目标与成功标准`、`## 范围`、`## 非范围`、`## 质量门禁`、`## 验证计划`、`## 证据记录方式`、`## 文档更新与治理`、`## 风险`、`## 回滚与止损`、`## 背景`、`## 问题摘要`、`## 受影响区域`、`## 约束与禁止`、`## 实现步骤`、`## 决策日志`、`## 进展日志`、`## 后续事项`。
- 2026-05-09：随着 `2026-05-09-workflow-output-reset.md` 进入实施，澄清契约的 shape 契约从“长表单默认必填”收敛为“核心锚点 + 追加区块按需”。新的核心锚点为 `## 标题`、`## 任务类型`、`## 目标与理由`、`## 问题 / 缺口`、`## 当前证据 / 信号`、`## 范围`、`## 非范围`、`## 约束与禁止`、`## 验收标准`、`## 验证计划`、`## 风险`、`## 就绪判定`、`## 下一步动作`；`## 相关文档 / 计划 / 代码锚点`、`## 下游专用产物（如适用）`、`## 假设`、`## 未决问题` 以及 `Refactor / Chore 补充` 改为按需区块，不再默认要求所有任务保留。
- 2026-05-09：独立 handoff contract 的触发条件收敛为“跨轮执行、Autopilot、或需要显式 slice gate”；普通 `plan-light` 不应被文档治理或 hooks 语义默认推向 handoff artifact。
- 2026-05-09：`check-doc-governance.sh` 在无显式 path 输入时，默认检查工作树中受影响且落在当前 gate 覆盖面的文档路径，而不是依赖 hooks session state 中记录的“当前 slice 路径”。`v1` 先把该默认面收敛为 `docs/` 下 staged、unstaged 与 untracked 的 Markdown 文件；其中 `PLANNING_ARTIFACT_SHAPE` 只对命中 `docs/exec-plans/active/` 且文件名符合三类产物命名契约的文件生效。若 hooks 后续需要更窄的 slice 级精确检查，应由 hooks 显式传入路径，而不是让命令默认依赖隐式 session state。

## 进展日志
- 2026-05-09：已完成首轮仓库现状收集：确认当前 hooks 只强制通用验证，`check-doc-freshness.sh` 仍为分类报告脚本；仓库内虽然存在 `docs-check.yml`，但在用户已明确“短期无 CI”的约束下，该文件当前只作为历史上下文参考。据此立项本计划。
- 2026-05-09：已完成 Phase 1 首个设计决策切片，对比“升级 `check-doc-freshness.sh`”与“新增专用 gate 命令”两条路线；当前采纳“保留分类报告脚本 + 新增专用 gate 命令”的方向。比较中进一步确认：`hook_common.py` 已把 `bash tools/scripts/check-*.sh` 纳入 validation 命令识别，但现有 `check-doc-freshness.sh` 的输出与退出语义并不适合作为直接 clearing signal。
- 2026-05-09：已完成 Phase 1 第二个设计决策切片：当前将专用 gate 命令收敛为 `check-doc-governance.sh`，并把 `v1` 最小检查集合限定为“`最后评审` 字段存在性”“strict-scope 非占位 review 字段”“计划产物模板结构完整性”三类低误报检查；同时定义了 `PASSED / FAILED / ERROR` 首行文本契约、finding 前缀与 `0 / 1 / 2` 退出码契约。
- 2026-05-09：已完成 Phase 1 第三个设计决策切片：对照 `templates/clarification-contract-template.md`、`templates/feature-spec-template.md`、`templates/plan-template.md` 与当前已落盘样例，已把 `PLANNING_ARTIFACT_SHAPE` 的 `v1` 检查目标收敛为“固定文档主标题 + artifact-specific 必需 `##` 标题集合存在”；同时决定 `check-doc-governance.sh` 在无显式 path 输入时默认从工作树受影响的 `docs/**/*.md` 取样，以保持手动命令与 hooks 集成之间的可复现性，并把 slice 级精确路径留给 hooks 显式传参解决。
- 2026-05-09：已完成一轮 mode-aware 基线修正：真实 hooks state 观测显示，`pendingValidation` 曾仅因 `memory` 工具写入 `/memories/session/plan.md` 而被置为 `true`，从而在 plan 会话结束时触发误阻断。现已把 hooks 基线调整为“只对仓库工作树写入设置执行态 pending validation；若 payload 或 wrapper 显式提供 `plan | ask | agent`，再按模式进一步分流”，并补齐 `Stop` 阶段对旧的非执行态 pending state 的清理。
- 2026-05-09：已用脚本级 focused validation 验证上述修正：3 个 hooks Python 脚本编译通过；模拟 `memory -> /memories/session/plan.md` 写入不再产生 `pendingValidation`，且旧 state 会在 `Stop` 被清理；模拟仓库内 `create_file` 写入仍会保留 `pendingValidation` 并在 `Stop` 阶段被阻止结束。
- 2026-05-09：进一步确认旧 Plan 会话仍可能携带 pre-fix 污染 state：早先的 `extract_paths` bug 曾把整段 plan 文本错误写入 `lastWriteTool.paths`。现已补充自愈逻辑，令 `recorded_write_requires_validation` 对 `memory` 工具的历史 state 一律视为非执行态写入；脚本级复核表明两个已污染的 Plan session 当前都会返回 `False`，因此同一窗口中的旧 Plan 会话在下一次 `Stop` 判定时即可按新逻辑恢复，不需要依赖新开窗口加载。 
- 2026-05-09：`workflow-output-reset` 已完成首轮规则和计划模板改写，并通过 focused doc validation；当前同步把澄清契约与 handoff contract 的模板语义收敛到“核心锚点 + 按需展开”，避免未来 doc governance gate 继续鼓励默认长表单。

## 后续事项
- 决定 `v1` 的触发范围是否需要覆盖“代码变更但行为变化要求文档同步”的 slice。
- 决定是否需要在标准文档中显式声明 `.github/workflows/docs-check.yml` 当前不属于短期交付边界。
- 若后续 runtime 能稳定提供 chat mode 字段，改为直接按 `plan | ask | agent` 驱动 gate，而不是继续依赖“仓库工作树写入”代理判定。
- 若 runtime 验证需要多轮观测，准备对应 observation card。