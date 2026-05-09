# AGENTS.md

## 定位
本仓库面向 Agent 优先的软件开发方式。  
人类负责舵，Agent 负责执行。  
目标是可靠、可验证、小范围的持续交付。

## 工作规则
1. 不以对话历史作为唯一信息来源。
2. 以仓库文档作为首要知识来源。
3. 优先做小步、可逆、可测试的改动。
4. 尽可能用机械手段强制执行约束。
5. 没有验证证据，不得标记工作已完成。
6. 若任务反复失败，应改善系统，而非只修改实现。
7. 改动代码时，同步更新受影响的文档、测试与计划。若任务已有 `docs/exec-plans/active/` 中的执行计划，按 `docs/exec-plans/index.md` 的计划更新纪律追加状态、进展、决策与后续事项，不重写原始 `实现步骤`。
8. 输出必须先帮助读者快速建立判断，再补充交付控制。默认情况下，每份输出至少回答 3 件事：目标是什么、为什么这样安排、下一步具体做什么。质量信息必须存在，但按任务层级压缩表达：
	- `Ask` / 普通反馈：默认使用轻量结构，说明判断、理由、适用边界与下一步；只在必要时展开完整验证与风险。
	- `Plan` / 单任务规划：默认使用轻量计划，说明目标与理由、范围、细步骤、验证；只有多阶段、高风险或跨轮执行时才展开完整治理结构。
	- `Agent` / 高风险执行：保留完整范围、验证、证据、风险与回滚要求。
	若前几行仍不能让读者看懂目标和理由，或步骤仍停留在 Phase 标题、抽象动词或不可直接接手的粒度，视为输出不合格；章节齐全不能替代解释质量和可执行性。

## 默认阅读顺序
1. 先读取根目录 `AGENTS.md`，建立通用规则、完成定义与 Skills 加载规则。
2. 若任务已有执行计划，进入 `docs/exec-plans/active/` 中对应计划；否则从 `docs/index.md` 进入相关主题文档。
3. 按任务主题继续阅读相关架构、产品规格、开发规范和运行手册索引。
4. 仅在任务需要时进入 `skills/`，具体加载规则见下文。
5. 开始实现前确认范围、验证方式与证据来源已经明确。

## 按需参考
- `skills/index.md`：按场景查找 Skills 目录，不替代默认阅读顺序。
- `ARCHITECTURE.md`、`DESIGN.md`、`PRODUCT_SENSE.md`、`RELIABILITY.md`、`SECURITY.md`：根目录主题速查，不属于默认起始阅读链路。
- `QUALITY_SCORE.md`：仓库健康度与治理状态参考，仅在需要评估全局状态或后续治理优先级时查看。

## Skills 使用与加载规则
1. 完成默认阅读顺序后，Agent 必须按本节规则确定 Skills 装载范围，并将所采用的 Skills 视为默认执行上下文的一部分。
2. 若任务与某个场景明显相关，Agent 必须主动读取对应的 Skills 文件；不能把是否读取 Skills 的责任完全留给用户在对话中额外提醒。
3. `AGENTS.md` 中列出的“必读 Skills”默认应被视为任务启动前的基础上下文；“按场景选读 Skills”应根据任务类型自动补充读取。
4. 用户不必通过 `/skills` 命令手动指定 Skills，除非用户希望强制指定某个 Skills 文件、覆盖默认选择，或显式测试某个 Skills 是否被采用。
5. 若用户显式指定某个 Skills 文件，Agent 必须优先采用该 Skills，并在不冲突时继续遵守 `AGENTS.md` 中的其余通用约束。
6. 若用户请求与当前自动选择的 Skills 不一致，Agent 必须明确说明最终采用了哪些 Skills，以及哪些是因为用户显式指定而被优先采用。
7. 在输出计划、开始实现或给出结论前，Agent 应先自检本次任务所需读取的 Skills 是否已经覆盖；不得在未读取相关 Skills 的情况下直接开始高风险或高歧义工作。
8. `skills/delivery-quality-first.md` 是所有模式（Plan / Agent / Ask）的默认优先 Skill，每次任务开始时应首先参考。

## 核心工作流
1. 仔细阅读任务。
2. 按“默认阅读顺序”完成必要的上下文构建与计划准备。
3. 按“Skills 使用与加载规则”确定当前任务所需 Skills，并在输出计划前列出已采用的 Skills 清单及其适用原因。
4. 实现最小可用改动。
5. 执行必要的检查。
6. 收集验证证据。
7. 使用清晰的摘要、风险说明和证据开启或更新 PR。
8. 若被阻塞，先改善文档、工具或约束。

## 模板与阶段路由
1. 进入实现前，先用澄清契约收敛需求；通用 intake 统一使用 `templates/clarification-contract-template.md`，不再使用独立的任务模板。
2. 若任务类型是 `feature` 且仍需要补齐产品级细节，下一阶段转入 `templates/feature-spec-template.md`；若任务类型是 `bug` 且仍需要补齐复现、环境或影响信息，下一阶段转入 `templates/bug-report-template.md`。
3. 当澄清结果的 `下一步动作` 为 `create plan`，或任务本身属于多步骤、高风险、跨多个区域的工作时，使用 `templates/plan-template.md` 创建或更新执行计划。
4. 当执行将跨多轮对话、启用 Autopilot、或需要显式的 stop condition 与验证门禁时，在稳定计划之后通过 `.github/prompts/handoff.prompt.md` 或 `templates/plan-execute-handoff-contract-template.md` 补充执行交接契约。
5. `plan-execute-handoff-contract` 只是执行投影，不替代完整计划；若目标、边界或风险发生变化，先更新源执行计划，再同步更新 handoff contract。

## 必读 Skills
- `skills/delivery-quality-first.md`
- `skills/plan-before-code.md`
- `skills/repo-as-source-of-truth.md`
- `skills/evidence-driven-delivery.md`
- `skills/small-safe-prs.md`

## 按场景选读 Skills
- API / 解析 / 外部输入：`skills/boundary-validation.md`
- 任务反复失败：`skills/fix-the-system-not-just-the-ticket.md`
- 调试类生产问题：`skills/observability-first-debugging.md`
- 大范围重构：`skills/refactor-with-constraints.md`
- 质量漂移：`skills/entropy-cleanup.md`

## 完成定义
满足以下全部条件，工作才算完成：
- 任务范围已满足
- 必要检查通过，且验证证据已记录
- 受影响文档、测试与计划已按工作规则更新
- 风险与后续事项已备注
- 输出符合工作规则第 8 条：质量信息存在、目标与理由清楚、步骤可直接执行

## 禁止行为
- 大范围混合目的的 PR
- 未在仓库文档中记录的隐性假设
- 未经验证的外部输入直接进入业务逻辑
- 沉默的架构漂移
- 无测试、无检查、无证据的"完成"