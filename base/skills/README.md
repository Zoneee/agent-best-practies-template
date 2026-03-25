# base/skills/

本目录是 Agent 行为手册（Skills）的 **权威来源（source of truth）**，作为同步脚本的源路径。

下游项目通过 `tools/agent-template/sync-template.sh` 同步后，这些文件会出现在项目根目录的 `skills/` 下，供 Agent 直接读取。

## 当前状态

**已完成内容迁移。** `base/skills/` 包含全部 Skills 文件，`manifest/template-manifest.json` 中的 `source` 路径指向此目录（`base/skills/`）。

根目录 `skills/` 保持原有路径有效，以确保向后兼容。

## 包含的 Skills

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

**强同步（hard-sync）**：下游项目不应覆盖这些文件。若需要项目级定制，应通过 `overlays/` 中的追加文件实现。
