# CHANGELOG

本文件记录模板仓库的版本化发布说明，遵循 [Semantic Versioning](https://semver.org/)。

下游项目通过 `tools/agent-template/template-version.json` 追踪当前同步的版本。

---

## [Unreleased]

> 以下变更尚未正式发布，待两个阶段 PR 合并后统一打 tag。

### Added（新增）
- `base/` 目录：共享内容权威来源，含 `skills/`、`templates/`、`docs/standards/`、`docs/references/` 的结构说明
- `overlays/` 目录：面向特定项目类型的可选追加内容（Python、Node.js 示例占位）
- `examples/` 目录：示例项目结构，说明同步后的推荐目录布局
- `manifest/template-manifest.json`：同步清单，定义同步 group、源路径、目标路径和同步模式
- `tools/agent-template/sync-template.sh`：主同步脚本，支持 `--dry-run`、`--ref`、`--group`
- `tools/agent-template/sync-template.config.json`：下游项目本地配置示例
- `tools/agent-template/template-version.json`：同步版本追踪文件
- `CHANGELOG.md`：本文件，用于记录版本化发布说明
- `skills/delivery-quality-first.md`：交付质量优先 Skill（所有模式默认起点）
- `templates/plan-template.md`：质量前置结构的执行计划模板

### Changed（变更）
- `README.md`：补充 `base/overlays/examples` 结构说明、manifest/sync script/project config 协作方式、三类内容维护说明

### Notes（备注）
- `AGENTS.md` 正文未作修改；如有规则调整建议，将通过单独 PR 提出 diff。
- 根目录下的 `skills/`、`templates/`、`docs/standards/`、`docs/references/` 保持原有路径有效（向后兼容）。
- 本次 PR 聚焦模板多项目复用的基础设施重构，不包含 `AGENTS.md` 规则内容变更。

---

## [v0.1.0] - 2026-03-25（历史基线）

### Added
- 初始模板仓库结构
- `AGENTS.md`：Agent 总入口，含工作规则、核心工作流、Skills 使用与加载规则
- `skills/`：Agent 行为手册（delivery-quality-first、plan-before-code、repo-as-source-of-truth 等）
- `templates/`：可复用执行表单（plan-template、pr-template、bug-report-template 等）
- `docs/`：结构化知识源（architecture、standards、runbooks、exec-plans 等）
- `.github/`：CI workflows、PR 模板、Issue 模板

---

## 版本说明

| 版本号 | 含义 |
|-------|------|
| `MAJOR`（主版本）| manifest 结构或同步机制不向后兼容的变更 |
| `MINOR`（次版本）| 新增 group、新增 overlay、新增 skill 等向后兼容的功能增强 |
| `PATCH`（补丁）  | 文档修正、小幅内容更新、bug 修复 |

tag 将在 PR 合并后由人工统一执行，不在本次 PR 中打 tag。
