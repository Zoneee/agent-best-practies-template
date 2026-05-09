# 澄清契约

## 标题
增强 workspace hooks 的文档治理门禁，避免“只跑通用验证、不处理文档治理缺口”

## 摘要
- 当前 workspace hooks 只能强制“编辑后有验证”，不能强制“文档治理检查已完成”。
- `tools/scripts/check-doc-freshness.sh` 目前仍是分类报告脚本，既不失败退出，也明确把“重复 / 噪音控制、过时内容清理”留给人工检查。
- 需要新增一份独立 feature 计划，定义可机械化的文档治理门禁、脚本语义和 hooks 集成方式，而不是把实施直接混入现有 workflow audit 计划。

## 任务类型
feature

## 目标结果
产出一份独立执行计划，定义如何让 hooks 在相关 feature slice 完成前，要求运行并通过一条可机读的文档治理验证命令；同时明确哪些文档噪音问题仍保留人工审计。

## 问题 / 缺口
当前 `.github/hooks` 草案只会跟踪通用 `pendingValidation`，并在识别到测试 / lint / check 类命令通过后清状态；它不会判断文档治理脚本是否已运行，也不会判断计划 / 契约 / 证据回写是否齐全。现有 `check-doc-freshness.sh` 还保留“只报告、不失败”的语义，因此无法直接作为强制 hook gate。

## 当前证据 / 信号
- `docs/standards/workspace-hooks.md` 明确把“预期产物、计划回写、证据回写是否齐全”的精确存在性验证列为当前草案未覆盖部分。
- `.github/hooks/scripts/post_tool_use_baseline.py` 与 `.github/hooks/scripts/stop_baseline.py` 当前只覆盖“编辑后待验证 / 验证失败 / 提前结束阻止”。
- `tools/scripts/check-doc-freshness.sh` 明确写出“重复 / 噪音控制、过时内容清理”仍需人工检查，且默认不因发现问题失败退出。
- 仓库内虽然存在 `.github/workflows/docs-check.yml`，但用户已明确短期内所有项目都不会引入 CI；因此该文件当前只作为历史上下文参考，不构成 `v1` 的交付前提或门禁来源。
- 设计决策切片的当前比较结论是：`v1` 优先新增专用 gate 命令，而不是直接升级 `check-doc-freshness.sh`；保留后者继续承担分类报告，避免同时改变现有报告语义与 hooks clearing signal。

## 相关文档 / 计划 / 代码锚点
- `docs/standards/workspace-hooks.md`
- `.github/hooks/workspace-baseline.json`
- `.github/hooks/scripts/hook_common.py`
- `.github/hooks/scripts/post_tool_use_baseline.py`
- `.github/hooks/scripts/stop_baseline.py`
- `tools/scripts/check-doc-freshness.sh`
- `docs/exec-plans/active/2026-05-09-workflow-audit-plan.md`
- `docs/exec-plans/active/2026-05-07-template-governance-upgrade.md`

## 下游专用产物（如适用）
- feature-spec：`docs/exec-plans/active/2026-05-09_feature-spec_doc-governance-hook-enforcement.md`
- bug-report：不适用

## 范围
- 定义 workspace hooks 下“文档治理验证”的最小可机械化目标与触发矩阵。
- 明确是升级 `check-doc-freshness.sh` 还是新增独立脚本 / wrapper 来承接可机读 pass/fail 语义。
- 设计 hooks 如何识别“文档治理验证必需”“验证已通过”“验证失败或未运行”。
- 规划相关标准文档、执行计划和验证证据的回写方式。

## 非范围
- 不承诺一次性自动识别全仓库所有语义重复、低收益段落或职责边界问题。
- 不在本任务中直接开展大规模文档重写。
- 不重新打开已稳定的 Phase 4 hooks 基线或 `get_errors` runtime 适配结论。

## 约束与禁止
- 新门禁必须优先依赖命令型验证，而不是编辑器诊断工具。
- 必须区分“可机械化检查”与“仍需人工判断”的文档治理问题，不能把两者混写成单一自动化承诺。
- 不得因为补门禁而无差别阻塞所有无关 slice；必须定义最小必要的触发范围。
- 短期设计目标只面向本地 hooks 与手动命令验证，不把 CI 集成作为当前方案成立的前提。

## 验收标准
- 已生成独立执行计划文件，覆盖脚本语义、hook 集成、文档回写与 runtime 验证四类工作。
- 计划明确区分 `v1` 可机械化覆盖的文档治理检查与仍保留人工审计的噪音问题。
- 计划给出验证路径与证据记录方式，而不是只给概念性建议。

## 验证计划
- 测试：不适用。
- 手动步骤：核对澄清契约、feature spec 与执行计划之间的边界是否一致，且未把审计计划与实施计划混写。
- 日志 / 截图 / 指标：记录新建计划文件路径，并对相关文档执行链接检查与编辑器错误检查。

## 风险
- 若把“语义噪音治理”直接机械化，容易设计出大量误报或无意义阻塞。
- 若触发范围定义过宽，会把当前 hooks 门禁变成高噪音系统。
- 若脚本改为失败退出但成功 / 失败语义不稳定，可能同时破坏 hooks 与本地手动验证链路的可解释性。

## 假设
- 当前 hooks runtime 继续适合以命令型验证作为 clearing signal。
- 文档治理门禁的 `v1` 应先覆盖最小可机械化集合，再决定是否单独立项研究更强的语义检查。

## 未决问题
- `v1` 的触发范围是只覆盖文档 / 模板 / prompt / plan 改动，还是进一步覆盖“代码改动但行为变更需要文档同步”的 slice。
- 新增专用 gate 命令后，是否需要在标准文档中明确 `.github/workflows/docs-check.yml` 目前不属于短期交付边界。

## 就绪判定
Ready for planning

## 下一步动作
create plan