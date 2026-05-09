# 执行计划

> 先写交付质量控制，再写问题修复内容。若"质量控制相关章节（交付目标与成功标准/范围/非范围/质量门禁/验证计划/证据记录方式/风险/回滚与止损等）"的填写明显少于"实现步骤"，则该计划不合格。

## 标题
工作流输出重置：更短、更能解释目标、步骤可直接执行

## 状态
执行中

## 阶段完成度概览
- Phase 1：已完成，新的输出分层与质量判断标准已落到仓库级规则中。
- Phase 2：已完成，`AGENTS.md` 与默认 Skills 已改为“解释充分 + 步骤可执行优先”。
- Phase 3：已完成，计划模板、澄清契约与 handoff 模板已收敛到“核心锚点 + 按需展开”。
- Phase 4：已完成，执行计划索引、doc governance 假设与 workspace hooks 基线已完成首轮对齐。
- Phase 5：待开始，用样本任务验证“更短但更清楚、更可执行”。

## 交付目标与成功标准
- 把当前“模板完整但信息不够”的输出模式改成“默认更短，但目标解释充分、步骤可执行”。
- 让普通问答、单任务规划和高风险执行分别落到不同重量级的输出层，而不是共享一套重型结构。
- 降低用户阅读模板噪音的成本，使读者在前几行就能看懂目标、理由和下一步。
- 把计划步骤从 Phase 口号改成可直接接手执行的切片，避免“知道方向但不知道先做哪一步”。
- 保留高风险执行需要的验证、证据和回滚门禁，不以“瘦身”为理由削弱执行安全性。

## 范围
- `AGENTS.md`、核心 Skills、计划模板、交接模板、执行计划索引、workspace hooks 基线与相关文档治理约束。
- 与输出结构直接相关的解释标准、步骤粒度标准和轻重分层触发条件。
- 影响默认对话、单任务计划和多阶段执行任务的文档与模板链路。

## 非范围
- 本计划不实现自动语义重复检测或精确 token 计量系统。
- 本计划不削弱 agent 执行态的必要验证、证据记录或 stop condition。
- 本计划不顺手重写与输出契约无关的文档风格或目录结构。
- 本计划不把现有 doc governance hook bug 修复重新并入同一实施面。

## 质量门禁
- 每项新规则都必须同时提升至少一项核心质量：更早解释目标、更清楚说明理由、或把步骤拆到可执行粒度。
- 轻量模式必须保留最小必要的质量信息，不能只靠删段落来缩短输出。
- `full-governance` 只在跨文件、多阶段、Autopilot 或高风险执行时触发，不能让普通任务默认落入重型结构。
- 任何 shape check 或 gate 不得再把“标题数量多”误当成“信息质量高”。
- 改动必须拆成小范围切片；每个切片都要有独立验证，避免再次形成大杂烩治理 PR。

## 验证计划
1. 规则验证：检查新的分层规则是否同时覆盖 `chat-light`、`plan-light`、`full-governance` 三种场景。
2. 文档验证：核对 `AGENTS.md`、核心 Skills、模板与索引之间是否仍存在双重真相来源。
3. 模板验证：用同类任务分别套用旧模板和新模板，确认目标解释更早出现、步骤更细、默认篇幅更短。
4. Gate 验证：检查 workspace hooks 基线和 planning artifact 相关治理规则，确认轻量计划不会被误判为缺失产物。
5. 样本验证：至少用三类样本任务验证“目标更清楚、理由更充分、步骤能接手执行”。

## 证据记录方式
- 在本计划的 `进展日志` 中记录每个切片的规则变化、验证结果和未解决问题。
- 需要对比新旧输出效果时，使用 observation card 记录样本任务的前后对照，再把稳定结论回写本计划。
- 对会影响 hooks 或 doc governance gate 的结论，回写到对应标准文档或相关执行计划，避免仅留在聊天上下文中。

## 文档更新与治理
- 受影响文档：`AGENTS.md`、`skills/delivery-quality-first.md`、`skills/plan-before-code.md`、`templates/clarification-contract-template.md`、`templates/plan-template.md`、`templates/plan-execute-handoff-contract-template.md`、`docs/exec-plans/index.md`、`docs/standards/workspace-hooks.md` 及相关 active plans。
- 是否需要同步修订或移除过时内容：需要。旧的“章节数量平衡”或“重型标题集合”若与新分层冲突，必须同步收敛。
- 本计划的验证证据将记录在：本计划 `进展日志`、必要 observation card、相关标准文档与脚本验证输出。

## 风险
- 只做篇幅压缩而不补足解释，导致输出更短但更难懂。
- 步骤拆分不够细，计划仍然停留在概念层，无法直接执行。
- 规则改轻后若未同步 gate 和 hooks，轻量计划可能被误报为不合格。
- 改动面涉及 `AGENTS.md`、Skills、模板与 hooks 基线，若不分阶段推进，容易再次混合目标。

## 回滚与止损
- 若某项轻量规则降低了可验证性，立即恢复该项到上一版表达，并把问题记录为 observation，而不是继续扩张改动面。
- 若模板改动与现有 gate 冲突，优先回滚模板触发面或同步收窄 gate，不带着冲突继续推进后续切片。
- 若样本验证显示输出虽然更短但仍解释不足，则停止继续收敛篇幅，先补解释标准再继续实施。

## 背景
当前仓库已经明确识别出默认上下文负担、重复说明和 token 成本问题，但用户进一步反馈显示，真正的痛点不只是“说得太多”，而是“说得多但目标没解释透、步骤又不够细”。现有规则在防止漏写方面有效，但也鼓励代理优先把章节写满，导致读者需要先过滤大量模板骨架，才能找到真正有用的信息。本计划的目标是在不削弱高风险执行门禁的前提下，重置输出契约，让默认输出更短、更能解释目标，并让步骤能直接执行。

## 问题摘要
- 当前输出常由模板骨架主导，信息密度低，读者很难快速定位目标和判断结论。
- 目标、方案与取舍常只有结论，没有说明“为什么这样做”和“为什么值得这样做”。
- 执行步骤经常停留在 Phase 标题或抽象动词层，缺少可直接接手的输入、动作和验证。
- planning artifact 与 gate 更关注标题存在性，容易把“结构齐全”误判为“内容质量足够”。

## 受影响区域
- `AGENTS.md`
- `skills/delivery-quality-first.md`
- `skills/plan-before-code.md`
- `templates/clarification-contract-template.md`
- `templates/plan-template.md`
- `templates/plan-execute-handoff-contract-template.md`
- `docs/exec-plans/index.md`
- `docs/standards/workspace-hooks.md`
- `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`
- `docs/exec-plans/active/2026-05-09-doc-governance-hook-enforcement.md`

## 约束与禁止
- 本计划中的每个步骤必须只承载一个明确产出，不能把规则设计、文件改动和验证混成一个动作块。
- 不得只以“更短”为理由删除质量信息；必须同时说明如何保留解释、验证或边界控制。
- 不得在未同步相关 gate / hooks 假设前，单独改轻模板或规则。
- 不得把本计划再次写成审计清单；这里只记录要实施的规则、模板和对齐动作。

## 实现步骤

### Phase 1：建立新的输出分层与质量判断标准
1. 在 `AGENTS.md`、`skills/delivery-quality-first.md`、`skills/plan-before-code.md` 中提炼当前共同问题，形成 3 个稳定失败模式：模板噪音、目标解释缺失、步骤粒度过粗。
2. 定义 3 条新的默认判断标准：每份输出都要说明目标、理由和下一步；每个计划步骤都要有单一产出、依赖和验证；只有高风险执行才展开完整治理结构。
3. 设计三层输出模型：`chat-light`、`plan-light`、`full-governance`，并为每层明确触发条件、最小必含信息和不该出现的冗余结构。
4. 产出一份“任务类型 -> 输出层级 -> 必含信息”的映射，并用它作为后续 Skills、模板和 gate 对齐的基线。

### Phase 2：重写仓库级输出原则与核心 Skills
1. 更新 `AGENTS.md` 的工作规则第 8 条及相关桥接规则，把“章节数量平衡”改成“解释充分且步骤可执行优先”。
2. 更新 `skills/delivery-quality-first.md`，保留“先交付质量、后修复内容”的原则，但允许在低风险场景短写，并强制补足“为什么这样做”的解释。
3. 更新 `skills/plan-before-code.md`，增加细步骤标准，要求计划步骤至少包含本步目标、依赖、动作和验证。
4. 验证三份规则文档之间不存在互相矛盾的输出要求，也不再默认把所有模式拉成同样重量。

### Phase 3：重构计划与交接模板
1. 收敛 `templates/clarification-contract-template.md`，保留少量必填字段，并为每个字段增加“它解决什么不确定性”的说明。
2. 重构 `templates/plan-template.md`，将其压缩为核心块：目标与理由、范围边界、执行步骤、验证、风险；把其余内容改成按需展开块。
3. 重构 `templates/plan-execute-handoff-contract-template.md`，明确只有跨轮执行、Autopilot 或显式 slice 门禁时才需要独立 handoff contract。
4. 为计划步骤补充统一结构：本步目标、输入依赖、涉及文件、具体动作、完成证据、进入下一步前的检查。
5. 对照现有 active plan 样例检查新模板是否仍能承载必要信息，同时显著降低默认产物体积。

### Phase 4：对齐执行计划索引、文档治理 gate 与 workspace hooks
1. 更新 `docs/exec-plans/index.md`，明确何时只需 `plan-light`，何时必须进入完整执行计划或 handoff。
2. 更新 `docs/standards/workspace-hooks.md`，确保 ask / plan 的轻量模式不会被误记为缺失验证或缺失计划产物。
3. 回查 `docs/exec-plans/active/2026-05-09-doc-governance-hook-enforcement.md` 中的 planning artifact shape 假设，确认它不再以重型标题集合作为主要质量代理。
4. 若现有 gate 仍与新模板冲突，先缩减强制锚点到“目标、范围、验证、风险、步骤”这类最小必要结构，再决定是否需要后续脚本改动。

### Phase 5：用样本任务验证新输出契约
1. 选取 3 类样本：简单反馈对话、单文件小任务、多阶段治理任务。
2. 对每类样本检查四个问题：前几行能否看懂目标；是否解释了为什么这样做；步骤是否能直接交给下一个执行者；整体篇幅是否低于旧路径。
3. 若样本显示“更短但仍解释不足”或“步骤仍需大量追问”，视为未通过，先回到相应规则或模板补强，再继续扩展实施面。
4. 将稳定结论回写到 `2026-05-09-workflow-audit-plan.md`，并根据实际改动范围决定是否补 observation card。

## 决策日志
- 2026-05-09：本实施不挂在 `2026-05-09-workflow-audit-plan.md` 下继续推进，因为后者明确只做审计与排序；实际规则和模板修改由本计划单独承接，避免再把“发现问题”和“实施修复”混写。
- 2026-05-09：本实施的成功标准从“缩短输出”升级为“更短，但目标解释更强、步骤更细且可执行”。
- 2026-05-09：普通 `plan-light` 不默认生成 handoff contract；只有跨轮执行、Autopilot 或需要显式 slice gate 时，才展开独立执行投影。
- 2026-05-09：planning artifact 与 hooks 文档对齐时，不再把“标题数量多”作为主要质量代理；核心锚点与 focused validation 才是默认基线。

## 进展日志
- 2026-05-09：已创建独立实施计划，明确本轮改动的目标、范围、风险和分阶段执行顺序；当前下一步切片为 Phase 2 中的 `AGENTS.md` 与核心 Skills 规则重写。
- 2026-05-09：已完成首轮规则重写：`AGENTS.md` 将工作规则第 8 条从“章节数量平衡”改为“目标 / 理由 / 下一步 + 按层级压缩质量信息”；`skills/delivery-quality-first.md` 与 `skills/plan-before-code.md` 同步补齐“解释为什么这样做”和“步骤必须可直接执行”的标准。针对这 3 个文件运行 focused doc validation，链接检查与 freshness 检查均通过。
- 2026-05-09：已完成模板链路首轮收敛：`templates/plan-template.md` 增加 `plan-light | full-governance` 适用层级、目标理由提示与步骤结构约束；`templates/clarification-contract-template.md` 与 `templates/plan-execute-handoff-contract-template.md` 收敛为“核心锚点 + 按需展开”。对应 focused doc validation 已通过。
- 2026-05-09：已完成治理对齐：`docs/exec-plans/index.md` 明确 `plan-light` 默认不生成 handoff contract，`docs/exec-plans/active/2026-05-09-doc-governance-hook-enforcement.md` 回写新的澄清契约核心锚点，`docs/standards/workspace-hooks.md` 明确 `ask=chat-light`、`plan=plan-light`、`agent=full-governance` 的 gate 差异。相关文档 focused validation 已通过。
- 2026-05-09：已对当前实施面再次执行 focused validation，覆盖 `AGENTS.md`、核心 Skills、3 个模板、`docs/exec-plans/index.md`、`docs/standards/workspace-hooks.md`、`docs/exec-plans/active/2026-05-09-doc-governance-hook-enforcement.md`、`docs/exec-plans/active/2026-05-09-workflow-output-reset.md` 与 `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`。`check-doc-links.sh` 全部通过，`check-doc-freshness.sh` 结果为“严格检查文档 4、保留占位文档 29、排除自动检查文档 14、需立即修复 0”。

## 后续事项
- 选择 3 类样本任务，进入 Phase 5 的前后对照验证。
- 决定是否为“输出更短但解释更强”的对比结果补 observation card。
- 若后续需要把新的核心锚点真正落到 `check-doc-governance.sh` 脚本，实现时另立切片，不在当前文档收敛中顺手扩张。