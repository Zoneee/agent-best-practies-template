# base/skills/

本目录用于承载基础 Skills 内容，作为同步脚本的 **源路径（source）**。

下游项目同步后，`skills/` 会出现在项目根目录下，供 Agent 直接读取。

## 当前状态

**Phase 1：占位结构与说明。** 当前 `base/skills/` 仅包含本 README，用于约定目录用途和未来结构。

**Phase 2：迁移内容并作为 source。** 后续会将根目录 `skills/` 中的实际文件迁移/复制到 `base/skills/`，届时以 `manifest/template-manifest.json` 中的 `source` 路径为准，实现“镜像 `skills/` 的内容 / 保持内容一致”。

## 计划包含的 Skills

下表是本目录在 Phase 2 之后**计划**承载的基础 Skills 文件清单，当前仓库中这些文件可能仅存在于根目录 `skills/`（或尚未创建），而不会自动出现在 `base/skills/`：
| 文件 | 用途 |
|------|------|
| `delivery-quality-first.md` | 交付质量优先（所有模式默认起点） |
| `plan-before-code.md` | 先计划，后编码 |
| `repo-as-source-of-truth.md` | 仓库即唯一事实来源 |
| `small-safe-prs.md` | 小而安全的 PR |
| `evidence-driven-delivery.md` | 以证据驱动交付 |
| `boundary-validation.md` | 边界校验 |
| `codebase-navigation.md` | 代码库导航 |
| `refactor-with-constraints.md` | 约束性重构 |
| `docs-update-required.md` | 文档必须同步更新 |
| `self-review-loop.md` | 提交前自查循环 |
| `failure-recovery.md` | 失败恢复 |
| `fix-the-system-not-just-the-ticket.md` | 修系统而非只修工单 |
| `observability-first-debugging.md` | 可观测性优先调试 |
| `entropy-cleanup.md` | 熵值清理 |
| `index.md` | Skills 索引（导航入口） |

## 同步模式

**强同步（hard-sync）**：下游项目不应覆盖这些文件。若需要项目级定制，应通过 `overlays/` 中的追加文件实现，而不是修改同步来的基础内容。
