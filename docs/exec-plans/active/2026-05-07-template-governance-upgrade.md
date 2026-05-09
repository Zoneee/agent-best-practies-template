# 执行计划

> 先写交付质量控制，再写问题修复内容。若"质量控制相关章节（交付目标与成功标准/范围/非范围/质量门禁/验证计划/证据记录方式/风险/回滚与止损等）"的填写明显少于"实现步骤"，则该计划不合格。

## 标题
最佳实践模板仓库治理升级与 Copilot 结构对齐预案

## 状态
执行中（Phase 3 观察中，Phase 4 已完成）

## 阶段完成度概览
- Phase 1：已完成首轮实现与入口收敛验证；当前未发现因入口调整导致的断链或职责冲突。
- Phase 2：已完成核心交付并取得显著成功；当前仅保留“是否将现有文档治理脚本升级为 CI 门禁”的开放决策。
- Phase 3：已确认采用方案 A 进入观察期，并保留薄桥接的 `.github/copilot-instructions.md` 与 `plan-before-code` skill 样例作为当前兼容性基线；是否进入迁移立项仍待一段时间的实际使用证据。
- Phase 4：已完成 repo-local 澄清 / 交接工作流、模板职责收敛、hooks 语义对齐、workspace hooks 基线、`.github/hooks` 最小实现草案，以及真实 feature / bug 路由验证与 hooks runtime schema 适配；当前已满足本阶段收口门禁。

## 交付目标与成功标准
- 降低任务启动时的默认上下文负担，减少重复入口和不必要的常驻说明。
- 建立更明确的文档治理约束，减少不更新文档、重复追加噪音、保留过时内容的问题。
- 为执行计划建立日期前缀命名规范，使计划能仅通过文件名表达时间顺序。
- 产出一份可执行的 Copilot 原生结构对齐方案，并明确是否迁移、迁移范围和迁移顺序。
- 明确一组推荐或要求安装的 skills / agent 相关扩展基线，并说明其适用边界。
- 将后续执行拆成 4 个可独立交付的阶段，避免混合目标的大改动。

## 范围
- 梳理并收敛仓库的默认阅读链路，包括入口文档、索引文档、技能导航和模板之间的职责边界。
- 调整或补充执行计划、PR 模板、文档治理规范和脚本，使其支持更强的质量约束。
- 评估当前 `skills/` 组织方式与 Copilot 官方推荐的 `.github/instructions/`、`.github/skills/` 结构的关系。
- 评估是否需要为仓库提供 VS Code 扩展推荐或必装基线，例如 `.vscode/extensions.json` 与配套说明文档。
- 输出阶段拆分、交付边界、验证计划、风险与回滚方式。

## 非范围
- 本计划不直接重写所有技能内容为新的官方格式实现。
- 本计划不补齐仓库中所有示例文档的真实业务内容。
- 本计划不一次性引入大规模 Hook、CI 工作流或额外平台依赖，除非在阶段验证中证明为最小必要变更。
- 本计划不处理与本次治理目标无关的模板美化或目录重构。

## 质量门禁
- 默认起始阅读链路必须缩短或至少不增长，且职责边界更清晰。
- 所有新增治理规则都要说明其 token 成本和使用收益，避免新增长期上下文噪音。
- 文档治理方案必须同时覆盖新增内容质量与过时内容淘汰，不能只做占位字段检查。
- 执行计划命名规范必须同时落在索引、模板和至少一个入口说明中，避免单点规则。
- Copilot 对齐方案必须给出至少两个候选路径及其适用边界、风险和回滚策略。
- 扩展推荐方案必须区分“必需基线”和“可选增强”，避免把个人偏好伪装成团队强制要求。
- 若引入扩展安装建议，必须同时说明为什么它能降低维护成本或提升 Agent/Skills 体验，而不是单纯罗列工具。
- 后续执行必须可拆为小范围 PR，不混合四类目标。

## 验证计划
1. 入口一致性验证：核对 `AGENTS.md`、`README.md`、`docs/index.md`、`skills/index.md`、根目录速查文件与 `QUALITY_SCORE.md` 对默认阅读顺序和按需加载边界的描述是否一致。
2. 文档脚本验证：运行文档链接检查和升级后的文档治理检查脚本，确认至少能捕获日期缺失、失效链接或约定中的治理问题。
3. 命名样例验证：用一个 `YYYY-MM-DD-topic.md` 计划文件名样例验证排序、归档和引用是否自洽。
4. 原生结构对照验证：对照 Copilot 官方推荐的 instructions/skills 目录结构和 frontmatter 规则，确认候选方案的可实现性。
5. 扩展基线验证：确认推荐清单中的扩展在 VS Code 市场可获取，且仓库内的推荐方式与实际安装入口一致。
6. 阶段拆分验证：核对四阶段是否能各自独立提交和回滚。

## 证据记录方式
- 在本计划的进展日志中记录每个阶段的关键决策、验证输出和是否满足门禁。
- 在后续 PR 描述中记录入口链路变化、脚本输出、示例文件名和迁移对比结论。
- 对关键规则调整保留改前问题与改后约束的对照说明，避免只有结论没有依据。

## 风险
- 精简入口过度可能削弱新使用者的发现路径，导致仓库可导航性下降。
- 文档治理约束过强可能对模板仓库示例内容产生大量噪声告警。
- 同时讨论默认入口、文档治理和 Copilot 迁移容易导致范围扩张。
- 官方推荐结构可能无法完整承载当前以 `AGENTS.md` 为中心的工作流。
- 扩展推荐若缺少分层，可能把团队基线与个人偏好混在一起，增加不必要的环境负担。

## 回滚与止损
- 若入口收敛影响可导航性，则保留短入口文件，只撤回激进的合并或删除动作。
- 若新的文档治理规则产生过多误报，则先保留弱检查并把强约束降为文档规范或手动检查项。
- 若 Copilot 原生结构桥接方案验证不足，则保持 `AGENTS.md` + `skills/` 现状，仅补映射说明，不进入迁移执行。
- 若扩展基线争议较大，则先保留“推荐安装”而不是“强制安装”，并把必需项缩减到最小集合。
- 任一阶段若出现目标混杂或变更面失控，应拆出新的执行计划或技术债项，而不是继续扩张当前计划。

## 采用的 Skills
- `delivery-quality-first`：先定义交付质量控制、验证与风险，再写实施步骤。
- `plan-before-code`：本任务跨入口文档、模板、脚本和目录结构，需要分阶段推进。
- `repo-as-source-of-truth`：结论基于仓库现有文档、模板和脚本，而不是对话记忆。
- `evidence-driven-delivery`：阶段结论要由脚本输出、样例和结构对照支撑。
- `small-safe-prs`：执行时按四阶段拆成独立 PR。
- `docs-update-required`：文档同步更新质量是本次治理目标之一。
- `fix-the-system-not-just-the-ticket`：当前问题是重复出现的系统性失效，需要机械化改进。
- `entropy-cleanup`：计划明确包含入口冗余和文档噪音治理。
- `refactor-with-constraints`：若涉及结构对齐，需分阶段、可回滚地重构。

## 背景
近期在使用该模板仓库时暴露出三类持续性问题：
- 默认必读链路偏长，部分说明在多个入口间重复出现，增加了 token 消耗。
- 文档更新主要依靠提示性约束，缺少足够强的质量门禁，导致出现不更新、重复追加、过时内容不移除等问题。
- 执行计划缺少日期前缀命名规范，无法通过文件名快速识别任务发生时间。

同时，当前 `skills/` 目录作为仓库内自定义工作流说明存在价值，但与 Copilot 官方推荐的 instructions/skills 结构并未对齐，需要先形成迁移判断依据，再决定是否桥接或迁移。

## 问题摘要
- 默认上下文过重：起始入口、技能导航和速查文档之间存在重复导航和重复约束。
- 文档治理过弱：当前脚本只做占位级检查，不能有效约束文档的新鲜度和噪音控制。
- 计划体系不完整：`docs/exec-plans/` 缺少明确的文件命名规则和日期约定。
- 技能体系定位不清：当前自定义技能与官方推荐方式之间缺少桥接说明和迁移边界。

## 受影响区域
- `AGENTS.md`
- `README.md`
- `ARCHITECTURE.md`
- `DESIGN.md`
- `PRODUCT_SENSE.md`
- `RELIABILITY.md`
- `SECURITY.md`
- `QUALITY_SCORE.md`
- `docs/index.md`
- `docs/exec-plans/index.md`
- `docs/exec-plans/active/`
- `skills/index.md`
- `skills/repo-as-source-of-truth.md`
- `skills/docs-update-required.md`
- `skills/plan-before-code.md`
- `templates/plan-template.md`
- `.github/pull_request_template.md`
- `tools/scripts/check-doc-freshness.sh`
- `tools/scripts/check-doc-links.sh`
- 视阶段四结论而定的 `.vscode/extensions.json`
- 视阶段三结论而定的 `.github/instructions/` 与 `.github/skills/`

## 约束
- 本计划只定义治理升级路线与阶段边界，不在本次文档中直接执行大规模结构迁移。
- 每个阶段都应能独立交付、独立验证、独立回滚。
- 若新增 Copilot 原生结构，必须遵循官方推荐的目录结构与 frontmatter 约束。
- 若新增扩展推荐或要求安装机制，应优先采用 VS Code 原生推荐入口，而不是散落在多处的文字说明。
- 不得为了追求“官方化”而牺牲当前仓库中有效的知识组织方式。

## 实现步骤

### Phase 1：上下文瘦身与入口收敛

#### 目标
- 将 `AGENTS.md` 固化为唯一默认起始入口，避免多个文件同时声明默认阅读顺序。
- 将 `README.md`、`docs/index.md`、`skills/index.md` 与根目录速查文件收敛到清晰分层职责，减少重复导航。
- 明确默认常驻上下文、按需速查和全局状态参考的边界，为阶段二和阶段三提供统一基线。

#### 主要工作
1. 盘点 `AGENTS.md`、`README.md`、`docs/index.md`、`skills/index.md`、根目录速查文件与 `QUALITY_SCORE.md` 的职责，区分“强制规则”“导航索引”“可选速查”“状态参考”“重复表述”。
2. 固化新的入口层次：
   - 默认总入口：`AGENTS.md`
   - 仓库概览层：`README.md`
   - 主题索引层：`docs/index.md`、`skills/index.md`
   - 按需速查层：`ARCHITECTURE.md`、`DESIGN.md`、`PRODUCT_SENSE.md`、`RELIABILITY.md`、`SECURITY.md`
   - 状态参考层：`QUALITY_SCORE.md`
3. 输出默认阅读顺序：
   - 先读 `AGENTS.md`
   - 若已有当前任务计划，进入对应执行计划；否则从 `docs/index.md` 深入相关主题
   - 仅在任务明确需要时加载具体 Skills、根目录速查文件或 `QUALITY_SCORE.md`
4. 形成文件级实施映射，明确哪些重复规则要从 `README.md`、`docs/index.md`、`skills/index.md` 移除，哪些入口说明只保留在 `AGENTS.md`。
5. 产出 Phase 1 的入口职责图或职责表、默认阅读顺序清单和按需加载清单，作为后续阶段引用基线。

#### 交付物
- 一版入口职责图或职责表，明确每个入口文件的唯一职责。
- 一份默认阅读顺序清单，说明哪些内容属于默认常驻上下文。
- 一份按需加载清单，说明技能、速查文件和状态参考的触发条件。
- 一份文件级实施映射，供后续执行和 PR 拆分直接使用。

#### 验收标准
- 只有 `AGENTS.md` 声明默认启动顺序。
- `README.md` 不再重复流程规则，只保留仓库概览、目录结构和主入口指引。
- `docs/index.md` 与 `skills/index.md` 不再与 `AGENTS.md` 竞争默认入口职责。
- 根目录速查文件仍可作为 map 使用，但不会被误读为默认必读。
- `QUALITY_SCORE.md` 被定位为按需查看的全局状态参考，而不是默认阅读链路的一部分。
- 精简后的信息仍能在单一、明确的来源中找到，不产生知识丢失。

#### 验证与证据
1. 输出一份前后对照表，比较改前改后哪些文件承担默认入口职责。
2. 人工走查从 `AGENTS.md` 和 `README.md` 出发的两条冷启动路径，确认都能无冲突地到达深层文档。
3. 在实施阶段运行 `tools/scripts/check-doc-links.sh`，确认入口收敛没有引入断链。
4. 对每个根目录速查文件做保留性复核，确认没有独有规则被误删。

#### 依赖与注意事项
- 本阶段只定义入口职责边界和默认阅读顺序，不处理计划命名规范、文档治理脚本升级或 Copilot 原生结构迁移。
- 若某个速查文件中存在深层文档尚未承载的独有规范，先迁入对应 canonical 文档，再继续瘦身。
- 若实际改动超出小 PR 边界，应拆成“核心入口收敛”和“速查文件降级”两个 docs-only PR，而不是混入后续阶段目标。

### Phase 2：文档治理约束与计划命名规范

#### 目标
- 将文档更新要求从提示性原则提升为更可验证的约束。
- 建立执行计划文件命名规范，使计划按日期可排序、可追踪。

#### 当前完成度评估
- 当前状态：已完成核心交付并取得显著成功，阶段目标已满足。
- 当前开放项：是否将现有 `tools/scripts/check-doc-freshness.sh` 从“模板仓库分类报告”升级为真正的 CI 门禁；该决策不阻塞本阶段验收。
- 当前补充结论：Phase 2 中“重复/噪音控制”应解释为“执行计划更新纪律”，目标是减少计划推进时的重复状态表述，而不是靠脚本重写原计划正文。

#### 主要工作与完成情况
1. 已完成：重新定义文档治理检查目标，当前区分为：
   - 新鲜度检查
   - 重复/噪音控制：已具体化为执行计划更新纪律，要求只在 `状态 / 阶段完成度概览 / 进展日志 / 决策日志 / 后续事项` 这些固定位置更新推进信息，不改写原始 `实现步骤`
   - 过时内容清理提示：已落在执行计划模板与 PR 模板治理清单中
   - 基础链接有效性：继续由 `tools/scripts/check-doc-links.sh` 独立负责
2. 已完成：升级 `tools/scripts/check-doc-freshness.sh`，不再只检查“最后评审”字样；当前输出模板仓库三类范围：严格检查文档 4 个、保留占位文档 28 个、排除自动检查文档 2 个，需立即修复项为 0。
3. 已完成：在 `docs/exec-plans/index.md` 和 `templates/plan-template.md` 中加入执行计划命名规范，明确采用 `YYYY-MM-DD-<topic>.md`。
4. 已完成：在 `.github/pull_request_template.md` 中加入“文档是否需要更新、是否移除过时内容、是否记录验证证据”的检查项，并删除重复 PR 模板副本，收敛为单一入口。
5. 已完成：明确 `tech-debt-tracker.md` 继续使用 `TD-001` 这类独立编号，不并入执行计划的日期前缀命名规则。

#### 交付物与当前状态
- 已交付：一版升级后的文档治理脚本与分类规则说明。
- 已交付：一版明确带日期前缀的执行计划命名规范。
- 已交付：与命名规范联动的模板和 PR 入口更新。

#### 验收标准与当前判定
- 新计划文件可通过文件名直接表达日期与主题。已满足。
- 文档治理脚本或规则至少能覆盖基础新鲜度与链接检查，并明确后续可扩展方向。已满足；当前通过 `tools/scripts/check-doc-freshness.sh` 与 `tools/scripts/check-doc-links.sh` 分别承接模板仓库分类报告和链接有效性检查。
- 文档模板和 PR 模板能提示作者处理过时内容，而不是只追加新内容。已满足；执行计划模板与单一 PR 模板入口均已补齐治理检查项。

#### 依赖与注意事项
- 阶段二不要求一次性实现复杂的文档质量静态分析；当前已将复杂规则保留为人工检查或后续扩展点。
- 若脚本误报过多，可先把部分规则降级为人工检查项。当前已采用该策略，将模板示例文档与运行性文档从严格检查中分流。

### Phase 3：Copilot 原生结构对齐与迁移决策

#### 目标
- 判断当前自定义技能体系是否应桥接到 Copilot 官方推荐结构。
- 明确保留 `AGENTS.md` 作为总入口时，原生 instructions/skills 适合承接哪些职责。

#### 主要工作
1. 将当前内容按职责拆分为三类：
   - 全局、稳定、低 token 的规则
   - 按文件或场景触发的补充说明
   - 可复用、按需加载的多步骤工作流
2. 基于官方推荐结构建立候选方案：
   - 方案 A：桥接方案。保留 `AGENTS.md` 为总入口，将高频约束下沉到 `.github/instructions/`，将按需工作流迁入 `.github/skills/`。
   - 方案 B：维持现状并纠偏。保留 `skills/` 目录作为仓库知识组织方式，仅补充与官方结构的映射说明。
3. 为每个方案补充：
   - 适用边界
   - token 成本影响
   - 维护成本
   - 对现有使用者的迁移影响
   - 回滚方式
4. 根据阶段一和阶段二的结果，决定是否需要单独立项执行迁移。

#### 交付物
- 一份方案对比表或决策矩阵。
- 明确推荐路径、非目标和后续执行前提。

#### 验收标准
- 至少形成两个可比较的候选路径，而不是单向建议。
- 推荐结论能够说明为什么不会增加长期 token 负担或维护复杂度。
- 若不迁移，也要说明如何在现有结构下补齐官方方式的映射说明。

#### 依赖与注意事项
- 阶段三以研究和设计为主，不默认直接实施全面迁移。
- 若决定进入迁移执行，应拆出新的执行计划或后续 PR，不与阶段一、阶段二混合提交。

### Phase 4：Skills / Agent 扩展基线与安装策略

#### 目标
- 为该模板仓库定义一组推荐或要求安装的 skills / agent 相关扩展基线。
- 区分团队最低可协作基线与个人增强型工具，避免把偏好型扩展强制化。

#### 主要工作
1. 识别扩展安装场景，至少区分：
   - 必需：直接关系到仓库的 Agent 工作流、Copilot 自定义结构发现、或计划/文档执行体验。
   - 推荐：显著改善 Skills、Prompt、Agent、PR 审阅或仓库导航效率，但不是协作前提。
   - 可选：更偏个人偏好的增强能力。
2. 产出扩展清单时，为每个候选扩展记录：
   - 扩展 ID
   - 用途
   - 与本仓库哪个阶段或工作流相关
   - 推荐级别（必需/推荐/可选）
   - 不安装时的影响
3. 评估是否新增 `.vscode/extensions.json` 作为工作区推荐入口，并决定是否需要在 `README.md` 或本地开发说明中补充安装说明。
4. 评估是否需要把某些扩展作为“要求安装”的团队基线；若需要，明确其生效边界、替代方案和例外条件。

#### 交付物
- 一份 skills / agent 扩展基线清单。
- 一份“必需 / 推荐 / 可选”分层说明。
- 若决定在仓库内落地，则提供 `.vscode/extensions.json` 和相应的说明文档更新方案。

#### 验收标准
- 扩展清单中每个条目都有明确用途与适用边界，而不是工具名称堆砌。
- 团队强制项数量维持在最小集合，且能说明不安装时会影响哪个关键工作流。
- 若采用 `.vscode/extensions.json`，则推荐列表与文档说明一致，不出现双重真相来源。

#### 依赖与注意事项
- 阶段四应参考阶段三对 Copilot 原生结构的判断结果，避免推荐与目标结构不兼容的扩展。
- 若仓库最终只选择“推荐安装”而非“要求安装”，仍需保留明确的优先级和理由，避免清单失去决策价值。

## 决策日志
- 2026-05-07：采用四阶段计划，将扩展基线与安装策略单独成阶段，避免与结构迁移混合讨论。
- 2026-05-07：阶段三先研究后定，不预设全面迁移到 Copilot 官方推荐结构。
- 2026-05-07：执行计划文件使用日期前缀命名，先在本计划中示范。
- 2026-05-07：阶段一确定 `AGENTS.md` 为唯一默认起始入口，`README.md` 退回仓库概览层，`docs/index.md` 与 `skills/index.md` 退回主题索引层。
- 2026-05-07：阶段一保留根目录速查文件作为按需速查层，并将 `QUALITY_SCORE.md` 降级为按需查看的全局状态参考。
- 2026-05-07：针对 `AGENTS.md` 采用原地结构压缩策略，不新增工作流说明文件，不外移规则内容。
- 2026-05-07：阶段二将 `docs/exec-plans/index.md` 限定为执行计划子域索引，只补充计划命名、生命周期和技术债边界说明，不承载默认入口或全局 Agent 约束。
- 2026-05-07：阶段二将 PR 模板收敛为单一入口，仅保留 `.github/pull_request_template.md`，删除仓库内重复副本以减少维护噪音和上下文开销。
- 2026-05-07：阶段二将 `tools/scripts/check-doc-freshness.sh` 维持为告警统计脚本，当前只自动区分“缺少最后评审字段”和“最后评审仍为占位值”，不因发现问题而失败退出。
- 2026-05-07：阶段二将文档新鲜度告警分流为三类处理：仓库自维护元文档立即补真实评审日期；模板示例文档保留占位值但仍要求存在字段；执行计划运行性文档与技术债跟踪器排除自动检查。
- 2026-05-07：阶段二将文档新鲜度脚本的输出语义调整为“模板仓库分类报告”而不是“全量文档健康报告”，必须同时显示严格检查、保留占位和排除自动检查三类范围。
- 2026-05-07：阶段二将“重复/噪音控制”明确收敛为执行计划更新纪律：计划推进时不重写原始步骤，不在多个位置重复书写状态链，只在 `状态 / 阶段完成度概览 / 进展日志 / 决策日志 / 后续事项` 中维护当前信息。
- 2026-05-07：将执行计划更新纪律以最小桥接规则接入 `AGENTS.md`，要求存在 active 执行计划时按 `docs/exec-plans/index.md` 更新计划状态与进展，而不是重写原始 `实现步骤`。
- 2026-05-07：将执行计划更新纪律的桥接规则与模板说明进一步压缩，保留最小必要表达，避免 `AGENTS.md`、执行计划索引和计划模板再次形成长篇重复说明。
- 2026-05-08：阶段三优先优化 VS Code / Copilot Agent 体验，不以 GitHub.com / code review 的最广覆盖为首要目标。
- 2026-05-08：若某类 workflow 迁入 `.github/skills/` 并验证成立，则以 `.github/skills/` 作为该类 workflow 的 canonical 承载面，`skills/` 退回索引、兼容或迁移说明层。
- 2026-05-08：`.github/instructions/**/*.instructions.md` 在阶段三中作为可选承载面，仅在存在明确路径或文件级收益时纳入，不因结构完整性而强行引入。
- 2026-05-08：阶段三先执行最小桥接试点：新增 `.github/copilot-instructions.md` 与单个 `.github/skills/plan-before-code/SKILL.md` 样例；path-specific instructions 继续后置。
- 2026-05-08：阶段三将 chat customization 相关 workspace 设置显式化，避免 `AGENTS.md` 与 applying/referenced instructions 的发现行为依赖未记录的默认值。
- 2026-05-08：阶段三对 `.github/copilot-instructions.md` 完成一次短期命中试验后，最终保留其“repo-wide Copilot bridge”定位；`AGENTS.md` 继续作为唯一默认入口，`.github/copilot-instructions.md` 仅保留最小桥接与防漂移声明。
- 2026-05-08：阶段三确认采用方案 A 进入观察期：继续保留 `AGENTS.md` 主入口、`.github/copilot-instructions.md` 薄桥接与单个 `.github/skills/` 试点作为当前路径；方案 B 暂不启用，待观察结论形成后再决定是否作为后续路径。
- 2026-05-08：阶段三长周期观察的原始记录不再直接堆入 active 计划；后续统一使用 `templates/observation-record-template.md` 记录 observation card，再将稳定结论回写到 `进展日志 / 决策日志 / 后续事项`。
- 2026-05-08：阶段四先采用 built-in-first 的实现顺序：先落 `.github/prompts/clarify.prompt.md` 与 `templates/clarification-contract-template.md`，用 repo-local prompt + 模板承接“需求澄清阶段”，暂不提前引入 custom agent、plugin 或扩展推荐清单。
- 2026-05-08：澄清契约文件名采用 `YYYY-MM-DD_{task-type}_{topic}.md`；该命名契约只约束文件名，不约束文档标题，字段之间使用 `_` 分隔，字段内部多词使用 `-`。
- 2026-05-08：澄清产物默认落盘到 `docs/exec-plans/active/`；仅在用户明确要求 chat-only 输出时，`clarify` prompt 才不创建文件。
- 2026-05-08：已形成“当前 `Plan/Agent + /clarify` vs 未来 `Clarify custom agent`”对照结论；当前默认继续采用 prompt-first 路径，将 custom agent 记录为后续增强方向而非首批必需交付。
- 2026-05-08：阶段四对“本地高度自治执行”的研究结论为：近期优先加固原生能力闭环（Autopilot、tool approvals、sandboxing、hooks、Copilot CLI、必要时 workspace MCP），暂不以 agent plugin 或一般性扩展作为首选落地路径。
- 2026-05-08：补充确认该仓库的模板定位不仅意味着“本仓库内可用”，还意味着后续要把稳定工作流迁移到其他产品与项目；因此 Phase 4 需显式追求可移植的一致 AI 开发体验，但顺序上仍坚持“先稳定 repo-local 契约与安全门，再进入分发层封装”。
- 2026-05-08：计划完成后的执行交接，采用独立的 `plan -> execute handoff contract` 产物承接；执行阶段应把该契约视为单一执行事实来源，不得因后续聊天只讨论某个局部切片，就隐式替换整份计划的范围、顺序、验证与 stop condition。
- 2026-05-08：模板职责收敛默认采用“两级 intake + 独立 handoff”边界：`clarification-contract-template.md` 作为唯一通用 intake，`feature-spec-template.md` 与 `bug-report-template.md` 作为详细专用模板，`plan-execute-handoff-contract-template.md` 继续作为 `plan-template.md` 的执行投影而非替代品。
- 2026-05-08：删除未接入当前工作流且与澄清契约职责重叠的 `templates/task-template.md`；后续不再把“通用任务 intake”作为独立模板保留。
- 2026-05-08：surviving templates 中涉及范围边界的通用字段名统一采用 `范围 / 非范围 / 约束与禁止`；`clarification-contract-template.md`、`feature-spec-template.md`、`plan-execute-handoff-contract-template.md`、`plan-template.md` 与 `design-doc-template.md` 按该约定同步收敛。
- 2026-05-08：高层工作流路由以 `AGENTS.md` 与 `.github/prompts/clarify.prompt.md` 为主入口说明：默认先进入澄清契约；feature / bug 需要详细专用产物时分别转入 `feature-spec-template.md` 与 `bug-report-template.md`；需要计划时转入 `plan-template.md`；多轮执行 / Autopilot / 显式 stop condition 时再补 `plan-execute-handoff-contract-template.md`。
- 2026-05-08：为降低多轮执行前的手工切换成本，阶段四补充 repo-local 的 `.github/prompts/handoff.prompt.md` 作为 handoff contract 入口；当前默认继续采用 prompt-first，而不是直接引入 custom agent。
- 2026-05-08：handoff contract 与 hooks 的当前对齐原则为：stop condition 必须拆分为“优先机械化的 hook 门禁”和“保留人工判断的停止条件”；对于当前 slice 可直接观察的门禁，优先记录到 `PreToolUse`、`PostToolUse`、`Stop` 映射，而不是只写抽象提醒。
- 2026-05-08：Phase 4 的当前最小基线正式收敛为 built-in-first：以 repo-local prompts、templates、handoff contract、hooks 语义与 `.vscode/settings.json` 为当前协作基线，不再把独立扩展清单或 `.vscode/extensions.json` 作为本阶段完成前提；是否进入扩展分发层，留待后续出现明确复制成本或能力缺口时再判断。
- 2026-05-09：workspace hooks 的 canonical 基线落在 `docs/standards/workspace-hooks.md`：默认由 `PreToolUse` 承接范围/禁止项/ destructive 防线，由 `PostToolUse` 承接验证失败、诊断错误、产物与回写缺失，由 `Stop` 保留重复失败与提前结束执行这类生命周期门禁；handoff contract 与 `/handoff` prompt 应从该基线裁剪，而不是重复发明映射。
- 2026-05-09：本轮复核结论为：Phase 4 仍未完成，当前只能判定为“核心文档、模板与 hooks 草案已收敛，但真实任务验证与 hooks runtime 验证仍缺”；因此暂不新建下一份工作流检查计划，待 Phase 4 两项收口门禁通过后再转入下一轮治理计划。
- 2026-05-09：Phase 4 现已完成收口：真实 feature 路由使用 `2026-05-09_feature_workflow-audit-plan.md` -> `2026-05-09_feature-spec_workflow-audit-plan.md` -> `2026-05-09-workflow-audit-plan.md` 完成验证；真实 bug 路由使用 `2026-05-09_bug_get-errors-hook-schema-mismatch.md` -> `2026-05-09_bug-report_get-errors-hook-schema-mismatch.md` 完成验证；hooks runtime 已确认 `get_errors` 的 `tool_response` 为空，因此该工具退回补充诊断而不再参与 blocking validation gate。

## 进展日志
- 2026-05-07：完成计划立项，将治理目标、门禁、验证方式和四阶段边界写入 active 计划文档。
- 2026-05-07：已识别当前主要问题为默认上下文冗余、文档治理弱、执行计划命名缺失以及技能体系对齐不清。
- 2026-05-07：补充阶段四，将 skills / agent 扩展推荐与要求安装策略纳入治理升级范围。
- 2026-05-07：完成阶段一首轮实现，已收敛核心入口文案、为根目录速查与 `QUALITY_SCORE.md` 标注按需定位，并同步调整相关 Skills 文案。
- 2026-05-07：执行 `bash tools/scripts/check-doc-links.sh`，结果为“所有文档链接有效”。
- 2026-05-07：继续收敛阶段一元说明重复，已移除速查文件与具体 Skills 中重复的入口提示，并压缩 `AGENTS.md` 内部重复表述。
- 2026-05-07：二次执行 `bash tools/scripts/check-doc-links.sh`，结果仍为“所有文档链接有效”。
- 2026-05-07：回补根目录速查与全局状态参考的短角色标签，恢复单文件自解释性；再次执行 `bash tools/scripts/check-doc-links.sh`，结果仍为“所有文档链接有效”。
- 2026-05-07：完成 `AGENTS.md` 原地结构压缩，已收敛工作规则、Skills 加载规则、核心工作流与完成定义之间的重复表述，并保留唯一默认入口语义。
- 2026-05-07：启动阶段二 docs-only 实现，已在 `docs/exec-plans/index.md` 和 `templates/plan-template.md` 中补充执行计划命名规范，并明确 `tech-debt-tracker.md` 保持 `TD-001` 式独立编号。
- 2026-05-07：已更新 `.github/pull_request_template.md`，补充“文档是否更新、是否处理过时内容、验证证据是否已记录”的治理检查项；后续删除仓库内重复 PR 模板副本，避免双重真相来源。
- 2026-05-07：阶段二 docs-only 改动后执行 `bash tools/scripts/check-doc-links.sh`，结果仍为“所有文档链接有效”。
- 2026-05-07：已升级 `tools/scripts/check-doc-freshness.sh`，当前自动检查覆盖“缺少最后评审字段”和“最后评审仍为占位值”，并明确“重复/噪音控制”“过时内容清理”仍由人工检查承接。
- 2026-05-07：执行 `bash tools/scripts/check-doc-freshness.sh`，基线结果为“缺少字段 7 个、占位值 27 个、合计告警 34 个”；当前脚本仅输出告警统计，不失败退出。
- 2026-05-07：已删除 `templates/pr-template.md`，将 PR 模板事实来源收敛为 `.github/pull_request_template.md` 单一入口。
- 2026-05-07：已完成文档新鲜度告警分流：4 个仓库自维护元文档补充真实评审日期，28 个模板示例文档保留占位值，2 个运行性文档（active 执行计划与技术债跟踪器）排除自动检查。
- 2026-05-07：按分流结果更新 `tools/scripts/check-doc-freshness.sh` 后再次执行，结果为“缺少字段 0 个、占位值 0 个、合计告警 0 个”。
- 2026-05-07：继续调整 `tools/scripts/check-doc-freshness.sh` 报告语义后再次执行，结果为“严格检查文档 4 个、保留占位文档 28 个、排除自动检查文档 2 个、需立即修复 0 个”，能够反映模板仓库上下文，而不再只输出一个无解释的 0。
- 2026-05-07：补充阶段完成度评估，当前判定为“Phase 1 已完成首轮实现、Phase 2 已完成核心交付、Phase 3/4 未开始”；阶段二仅剩是否升级为 CI 门禁的开放决策。
- 2026-05-07：补充阶段二对“重复/噪音控制”的执行定义，并同步更新执行计划索引与计划模板，明确计划推进时应追加进展事实，而不是反复改写状态或删除原始步骤。
- 2026-05-07：已更新 `AGENTS.md`，补充执行计划更新纪律的桥接规则，减少后续 Agent 推进执行计划时遗漏更新或重复写状态链的概率。
- 2026-05-07：已压缩 `AGENTS.md`、`docs/exec-plans/index.md` 与 `templates/plan-template.md` 中的执行计划更新纪律文案，保留短版桥接规则、短版更新纪律和短版模板提示。
- 2026-05-07：阶段二进展已取得显著成功；执行计划命名规范、单一 PR 模板入口、执行计划更新纪律和模板仓库语义下的文档治理报告均已落地，当前仅剩是否升级为 CI 门禁的收尾决策。
- 2026-05-08：完成阶段三基线盘点，确认当前仓库尚未采用 `.github/copilot-instructions.md`、`.github/instructions/**/*.instructions.md` 或 `.github/skills/<skill>/SKILL.md`，`.github/` 当前仅承载模板与 workflows。
- 2026-05-08：完成阶段三第一版职责映射，当前将 `AGENTS.md` 视为默认总入口，将 `skills/` 视为仓库内工作法文档，并将官方承载面拆分为 repo-wide instructions、可选 path-specific instructions 与 Agent Skills。
- 2026-05-08：已新增最小 `.github/copilot-instructions.md` 试点文件，并执行 `bash tools/scripts/check-doc-links.sh` 与编辑器错误检查，结果均通过。
- 2026-05-08：已新增 `.github/skills/plan-before-code/SKILL.md` 试点文件，并再次执行 `bash tools/scripts/check-doc-links.sh` 与编辑器错误检查，结果均通过。
- 2026-05-08：阶段三当前已完成可自动化的基础验证；原生发现与叠加行为仍待后续在 VS Code Chat References 或 Diagnostics 中确认，当前环境未提供可直接读取这些结果的安全入口。
- 2026-05-08：已增强 `plan-before-code` 原生 Skill 的 description 与 trigger phrasing，并新增 `.vscode/settings.json` 显式开启 `chat.useAgentsMdFile`、`chat.includeApplyingInstructions` 与 `chat.includeReferencedInstructions`；随后清理了自动化校验过程误生成的根目录 `SKILL.md`，再次执行文档链接检查与编辑器错误检查，结果均通过。
- 2026-05-08：已人工查看 VS Code “GitHub Copilot Chat” 诊断输出；当前可确认扩展网络连通性基本正常，且 `.vscode/settings.json` 仍保留 `chat.useAgentsMdFile`、`chat.includeApplyingInstructions` 与 `chat.includeReferencedInstructions` 三项开关，但该诊断页未暴露 Chat References、applied instructions 或 skill discovery 明细，因此仍不足以证明 `.github/copilot-instructions.md` 或 `.github/skills/plan-before-code/SKILL.md` 已在运行时被实际加载。
- 2026-05-08：基于“先按这个仓库的默认工作入口回答我”验证提示词，运行时结果显式读取了 `AGENTS.md` 与 `docs/exec-plans/index.md`，且回答内容正确复述了默认入口、默认阅读顺序与 active 执行计划更新纪律；这可作为仓库规则在对话中被成功检索和采用的间接正向证据，但由于结果未显示 `.github/copilot-instructions.md`、applied instructions 或其他自定义指令诊断信息，当前仍不能把它视为 repo-wide instructions 层已被自动加载的直接证据。
- 2026-05-08：已对 `.github/copilot-instructions.md` 完成一次“自包含摘要 -> 薄桥接”收敛试验；当前文件保留“AGENTS 为主入口”“仓库文档为事实来源”“active plan 按索引纪律更新”“避免在此重复 workflow 细节”四类最小约束，且文档链接检查与编辑器错误检查均通过。
- 2026-05-08：复核阶段三状态后确认：当前只适合将方案 A 作为观察路径继续使用，步骤 2 / 3 / 4 尚未形成可提交的方案矩阵、长期使用证据或迁移立项结论；因此阶段四后续按方案 A 的当前兼容边界推进，不等待短期内关闭阶段三。
- 2026-05-08：已新增 `templates/observation-record-template.md`，并同步更新执行计划索引与计划模板；后续关于方案 A 的适用边界、token 成本、维护成本、迁移影响与回滚信号，将先记录为 observation card，再压缩回 active 计划。
- 2026-05-08：已创建首条 Phase 3 observation card 样例 `docs/exec-plans/active/observations/2026-05-08-phase3-scheme-a-entrypoint-observation.md`，记录默认工作入口问答对方案 A 主路径的命中情况；当前结论为“支持继续观察方案 A，但桥接层与原生 skill 的直接命中证据仍不足”。
- 2026-05-08：基于“Copilot 像自主员工一样工作”的新目标，已完成 repo-local 澄清工作流最小切片设计：当前将“需求澄清”拆为独立阶段，先定义结构化契约、文件命名契约与固定输出模板，再开始实现 prompt / agent 入口。
- 2026-05-08：已启动阶段四第一实现切片，准备新增 `templates/clarification-contract-template.md` 与 `.github/prompts/clarify.prompt.md`，以最小 repo-local 方式验证“先澄清、后规划 / 实现”的工作流，不等待 plugin 或扩展基线方案先落地。
- 2026-05-08：已完成阶段四第一实现切片，新增 `templates/clarification-contract-template.md` 与 `.github/prompts/clarify.prompt.md`；当前通过 repo-local 模板与 slash prompt 承接“需求澄清阶段”，暂未引入 custom agent、plugin 或扩展推荐清单。
- 2026-05-08：对上述改动执行 `bash tools/scripts/check-doc-links.sh` 与编辑器错误检查，结果均通过；当前未发现新模板、新 prompt 或计划跟踪更新引入的断链与诊断错误。
- 2026-05-08：根据最新约束更新澄清工作流默认行为：澄清产物改为默认落盘到 `docs/exec-plans/active/`，仅在用户显式要求时才退回 chat-only 输出。
- 2026-05-08：已新增对照记录 `docs/exec-plans/active/observations/2026-05-08-phase4-clarify-prompt-vs-custom-agent-direction.md`，明确当前 prompt-first 路径与未来 custom-agent 路径的角色稳定性、handoff 能力、工具约束与维护成本差异；当前稳定结论为“先保持 prompt-first，custom agent 作为下一阶段增强项”。
- 2026-05-08：已新增研究记录 `docs/exec-plans/active/observations/2026-05-08-phase4-local-autonomy-builtins-vs-plugins.md`，明确本地高度自治执行当前更依赖原生能力闭环加固，而不是立即引入 plugin；当前值得优先验证的增强面是 hooks、sandboxing、Copilot CLI worktree 与必要时的 workspace MCP server。
- 2026-05-08：结合模板仓库的跨项目复用目标，已回写 Phase 4 研究结论：当前应先稳定 repo-local 的澄清、handoff 与执行边界，再把这些稳定产物作为模板分发；plugin 的角色从“是否需要”进一步收敛为“何时进入打包分发层”的时序问题。
- 2026-05-08：已起草 `templates/plan-execute-handoff-contract-template.md`，用于把完整计划压缩为执行阶段单一契约，明确执行范围模式、分步执行总览、验证门禁、全局停止条件与 Autopilot 启动提示，降低执行阶段对最近聊天切片的依赖。
- 2026-05-08：对 `templates/plan-execute-handoff-contract-template.md` 与本计划追踪更新执行 `bash tools/scripts/check-doc-links.sh` 和编辑器错误检查，结果均通过；当前未发现 handoff contract 模板引入的断链或诊断问题。
- 2026-05-08：已删除 `templates/task-template.md`，并执行引用搜索确认仓库内不再残留 `task-template` 入口；随后运行 `bash tools/scripts/check-doc-links.sh` 与编辑器错误检查，结果均通过。
- 2026-05-08：已收敛 intake 层模板职责：`templates/clarification-contract-template.md` 退回通用澄清与路由角色，不再内嵌 feature / bug 的详细字段；`templates/feature-spec-template.md` 与 `templates/bug-report-template.md` 分别补充来源链接字段；`.github/prompts/clarify.prompt.md` 已同步更新为“feature / bug 详细信息转入专用模板”的规则。相关链接检查与编辑器错误检查均通过。
- 2026-05-08：已收紧 plan / handoff 边界：`templates/plan-execute-handoff-contract-template.md` 现明确声明自身只是源执行计划的执行投影，不再重写完整计划目标；`templates/plan-template.md` 与 `docs/exec-plans/index.md` 已同步写入 handoff contract 的使用时机、命名与边界说明。相关链接检查与编辑器错误检查均通过。
- 2026-05-08：已完成 surviving templates 的字段统一与高层路由补齐：`clarification-contract-template.md`、`feature-spec-template.md`、`plan-execute-handoff-contract-template.md`、`plan-template.md` 与 `design-doc-template.md` 的核心范围字段已统一；`AGENTS.md`、`skills/plan-before-code.md` 与 `.github/prompts/clarify.prompt.md` 已补齐 clarify -> spec/report -> plan -> handoff 的路由规则。随后执行引用回扫，确认模板目录内不再残留旧字段名，也未发现 `task-template` 入口被继续使用；文档链接检查与编辑器错误检查均通过。
- 2026-05-08：已新增 `.github/prompts/handoff.prompt.md`，并同步把 `/handoff` 接入 `AGENTS.md`、`docs/exec-plans/index.md`、`templates/plan-template.md` 与 `.github/prompts/clarify.prompt.md` 的路由说明；当前 handoff contract 已从“模板存在但需手动记住”提升为 repo-local prompt 入口。相关链接检查与编辑器错误检查均通过。
- 2026-05-08：已将 `templates/plan-execute-handoff-contract-template.md` 与 `.github/prompts/handoff.prompt.md` 按 hooks 语义对齐：每个 slice 新增 `Hook 门禁映射`，全局 stop condition 拆分为“可机械化全局停止条件”和“需要人工判断的全局停止条件”；`docs/exec-plans/index.md` 已同步写入“优先把可观察门禁下沉到 `PreToolUse` / `PostToolUse` / `Stop`”的约定。相关链接检查与编辑器错误检查均通过。
- 2026-05-08：复核 Phase 4 当前状态后确认：本阶段的文档/模板/入口交付已经收敛，早期“扩展基线与安装策略”表述不再构成当前阻塞；但在缺少真实 feature / bug 任务端到端验证，以及未把 hook stop condition 进一步压缩成 workspace hooks 基线之前，Phase 4 仍只可判定为“核心交付完成、收口验证未完成”。
- 2026-05-09：已新增 `docs/standards/workspace-hooks.md` 作为 workspace hooks 默认门禁基线，并同步把 `templates/plan-execute-handoff-contract-template.md`、`.github/prompts/handoff.prompt.md`、`docs/standards/index.md` 与 `docs/exec-plans/index.md` 对齐到该基线；当前“把可机械化 stop condition 压缩为 workspace hooks 基线”这一收口项已完成，但 Phase 4 仍需真实任务路由验证与 hooks runtime 验证。相关链接检查与编辑器错误检查均通过。
- 2026-05-09：已新增 `.github/hooks/workspace-baseline.json` 与配套 Python 脚本草案，把 workspace hooks 基线进一步落为可执行配置：`PreToolUse` 先拦 destructive terminal 命令与 `.git/` 元数据写入，`PostToolUse` 先跟踪“编辑后待验证 / 验证失败”，`Stop` 先阻止“待验证改动未清”与“同一验证重复失败”时直接结束。脚本语法编译、hooks JSON 解析、文档链接检查与编辑器错误检查均通过；当前仍缺 VS Code hooks runtime 下的真实行为验证。
- 2026-05-09：已完成 hooks runtime 的真实 schema 适配验证：确认 `get_errors` 在当前 hooks payload 中只有 `tool_name=get_errors` 与 `tool_input.filePaths`，`tool_response` 为空；据此更新 `.github/hooks` 草案，使 `get_errors` 退回补充诊断，不再作为 `PostToolUse` 的 blocking validation gate。随后再次触发 `get_errors`，确认不再出现误判拦截。
- 2026-05-09：已完成真实 feature / bug 路由验证，并基于 feature 路由创建下一份独立执行计划 `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`，聚焦重复文档问题、职责重叠 / 模糊问题与 token 浪费问题。相关 hook 脚本编译、文档链接检查与编辑器错误检查均通过。

## 后续事项
- 若后续新增模板示例文档，需同步判断其应归入“保留占位”还是“排除自动检查”，避免新文件重新引入治理噪音。
- 阶段二核心交付已完成；下一步只需决定是否将当前文档治理脚本从模板仓库分类报告升级为 CI 门禁。
- 阶段三继续按 `templates/observation-record-template.md` 记录方案 A 观察卡；只有在 `.github/copilot-instructions.md`、`.github/skills/plan-before-code/SKILL.md` 或 path-specific instructions 出现更直接命中证据时，再考虑单独立项迁移。
- 按 `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md` 启动下一轮工作流审计，聚焦重复文档问题、职责重叠 / 模糊问题与 token 浪费问题。
- 若后续真正扩大 workspace hooks enforcement，应继续以 `docs/standards/workspace-hooks.md` 为基线；只有在 hooks / sandboxing 仍无法覆盖时，再评估 validator、workspace MCP 或其他分发层增强。