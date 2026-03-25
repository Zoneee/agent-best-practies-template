# 脚本设计说明：propose-skill-upstream-pr.sh

> 状态：设计草案  
> 目的：为未来实现提供明确的输入输出规范，确保实现时行为可预期、可审计。

---

## 背景

本脚本的设计目标是辅助下游项目整理并生成一份面向模板主仓的 Skill 回流 PR 提案。

**重要约束**：脚本不会自动向上游仓库发起 PR，不会执行任何跨仓库写操作。它仅在本地生成候选文件、提案说明和 PR 正文草稿，由人工审阅后手动发起。

---

## 输入参数设计

```bash
propose-skill-upstream-pr.sh [OPTIONS]
```

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `--template-repo` | string | 是 | — | 模板主仓地址（如 `Zoneee/agent-best-practies-template`） |
| `--template-ref` | string | 否 | `main` | 模板主仓的 Git ref（branch / tag / commit） |
| `--project-type` | string | 否 | `generic` | 下游项目类型（`backend-service` / `frontend-app` / `library` / `generic`） |
| `--skill-file` | string | 是 | — | 需要回流的 Skill 文件路径（相对于项目根目录） |
| `--target-layer` | string | 否 | `base` | 回流目标层（`base` / overlay 名称） |
| `--output-dir` | string | 否 | `./output/upstream-pr` | 产物输出目录 |
| `--dry-run` | flag | 否 | false | 仅预览将要执行的操作，不生成实际文件 |
| `--strip-config` | string | 否 | — | 指定一个剥离规则配置文件（JSON），定义哪些内容需要替换或删除 |

### 参数使用示例

```bash
# 基本用法：生成回流提案
./tools/scripts/propose-skill-upstream-pr.sh \
  --template-repo Zoneee/agent-best-practies-template \
  --template-ref v0.3.0 \
  --project-type backend-service \
  --skill-file skills/my-skill.md \
  --target-layer base

# 预览模式（不写文件）
./tools/scripts/propose-skill-upstream-pr.sh \
  --template-repo Zoneee/agent-best-practies-template \
  --skill-file skills/my-skill.md \
  --dry-run

# 指定输出目录
./tools/scripts/propose-skill-upstream-pr.sh \
  --template-repo Zoneee/agent-best-practies-template \
  --skill-file skills/my-skill.md \
  --output-dir /tmp/upstream-proposals/my-skill
```

---

## 处理流程

```text
1. 参数验证
   ├── 检查必填参数是否提供
   ├── 检查 --skill-file 文件是否存在
   └── 检查 --target-layer 是否合法

2. 拉取模板主仓快照（只读）
   ├── git clone --depth=1 <template-repo> /tmp/template-snapshot
   ├── git checkout <template-ref>
   └── 提取模板主仓当前版本号（从 manifest/template-manifest.json）

3. 对比分析
   ├── 检查目标 Skill 文件在模板主仓中是否已存在
   ├── 若存在：生成 diff（下游版本 vs 模板主仓版本）
   └── 若不存在：标记为"新增 Skill"

4. 候选文件预处理
   ├── 读取 --strip-config（若提供）
   ├── 对候选文件执行内容剥离（替换项目专属词汇为占位符）
   └── 输出剥离报告

5. 生成产物（非 dry-run 模式）
   ├── 生成 metadata.json
   ├── 生成 proposal.md（基于 templates/upstream-skill-pr-template.md）
   ├── 生成 pr-body.md
   └── 复制预处理后的候选文件到 patches/

6. 输出摘要
   ├── 显示生成的文件列表
   ├── 显示关键差异摘要
   └── 提示下一步人工操作
```

---

## 输出目录结构

```text
<output-dir>/
├── metadata.json              # 元信息
├── proposal.md                # 回流提案说明（已填充基础信息的模板）
├── pr-body.md                 # 可直接粘贴到 GitHub PR 的正文草稿
├── diff-summary.md            # 候选文件与模板主仓当前版本的差异摘要
└── patches/
    └── skills/
        └── <skill-name>.md    # 候选回流文件（已执行内容剥离）
```

### metadata.json 结构示例

```json
{
  "generated_at": "2026-03-25T13:00:00Z",
  "template_repo": "Zoneee/agent-best-practies-template",
  "template_ref": "v0.3.0",
  "template_version": "0.3.0",
  "project_type": "backend-service",
  "skill_file": "skills/my-skill.md",
  "target_layer": "base",
  "is_new_skill": false,
  "strip_applied": true
}
```

---

## 允许与不允许参与比较和候选回流的文件

### 允许参与回流的文件类型

| 文件路径模式 | 说明 |
|--------------|------|
| `skills/*.md` | Skills 文件（本脚本的主要目标） |
| `skills/**/*.md` | 子目录下的 Skills 文件（若启用子目录结构） |

### 明确不允许参与回流的文件类型

| 文件路径模式 | 原因 |
|--------------|------|
| `AGENTS.md` | 包含项目特定入口和约束 |
| `README.md` | 项目介绍，非通用 Skill |
| `ARCHITECTURE.md` | 项目架构文档 |
| `DESIGN.md`, `PRODUCT_SENSE.md` | 项目产品和设计文档 |
| `docs/architecture/**` | 项目架构细节 |
| `docs/runbooks/**` | 项目运行手册 |
| `docs/exec-plans/**` | 项目执行计划 |
| `docs/product-specs/**` | 项目产品规格 |
| `templates/**` | 模板文件（暂不支持，需单独评估） |
| `tools/**` | 工具脚本（暂不支持，需单独评估） |
| `.github/**` | CI/CD 配置（项目专属） |
| 任何包含 `.env`, `secret`, `credential` 的文件 | 安全原因 |

---

## 为什么不直接做自动反向同步

本脚本刻意不实现自动向上游仓库创建 PR 的功能，原因如下：

1. **质量控制**：下游改动可能包含项目专属内容，需要人工确认已完全剥离，才能安全进入模板主仓。自动同步无法保证这一点。

2. **语义判断**：并非所有下游改动都适合回流。判断一个改动是否具有通用价值，以及应进入 `base` 还是某个 `overlay`，需要人工语义理解，无法自动化。

3. **历史可审计性**：回流 PR 应该是一个有明确意图和来源说明的人工决策，而不是由脚本悄悄执行的自动操作。这确保了模板主仓的变更历史可读、可追溯。

4. **避免权限滥用**：自动跨仓库写操作需要持久化的仓库写权限，这在安全性和权限管理上引入了不必要的风险。

5. **与现有工作流兼容**：模板主仓本身有自己的 PR 评审和 CI 流程，所有变更都应通过这个流程进入，而不是被绕过。

---

## 剥离规则配置文件格式

若需要自动化内容剥离，可以提供一个 `--strip-config` JSON 文件：

```json
{
  "replace_patterns": [
    {
      "pattern": "my-internal-system",
      "replacement": "<internal-system>",
      "reason": "内部系统名称"
    },
    {
      "pattern": "project-specific-term",
      "replacement": "<project-term>",
      "reason": "项目专属术语"
    }
  ],
  "remove_sections": [
    {
      "start_marker": "<!-- project-specific:begin -->",
      "end_marker": "<!-- project-specific:end -->",
      "reason": "项目专属内容块"
    }
  ]
}
```

---

## 相关文档
- `skills/skill-upstream-pr.md`：受控回流 PR 工作流 Skill
- `templates/upstream-skill-pr-template.md`：上游回流 PR 正文模板
- `docs/design-docs/upstream-pr-workflow.md`：工作流设计背景与决策说明
