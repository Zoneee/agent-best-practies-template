# 示例项目：simple-project

本示例展示一个接入 agent-best-practies-template 后的最简项目结构。

## 目录结构（同步后）

```text
my-project/
├── AGENTS.md                      # 【项目本地维护】Agent 总入口，基于模板定制
├── ARCHITECTURE.md                # 【项目本地维护】架构速查
├── README.md                      # 【项目本地维护】项目说明
│
├── skills/                        # 【强同步】来自 base/skills/
│   ├── index.md
│   ├── delivery-quality-first.md
│   ├── plan-before-code.md
│   └── ...
│
├── templates/                     # 【强同步】来自 base/templates/
│   ├── plan-template.md
│   ├── pr-template.md
│   └── ...
│
├── docs/
│   ├── standards/                 # 【弱同步】来自 base/docs/standards/
│   │   ├── index.md
│   │   ├── coding-rules.md
│   │   └── ...（可本地追加）
│   ├── references/                # 【弱同步】来自 base/docs/references/
│   │   └── ...（可本地追加）
│   ├── architecture/              # 【项目本地维护】
│   ├── exec-plans/                # 【项目本地维护】
│   └── runbooks/                  # 【项目本地维护】
│
└── tools/
    └── agent-template/            # 同步工具（可选引入）
        ├── sync-template.sh
        ├── sync-template.config.json   # 本地配置（项目定制）
        └── template-version.json       # 当前同步版本记录
```

## 内容维护分类

| 内容类型 | 维护方式 | 说明 |
|---------|---------|------|
| `skills/` | 强同步 | 行为规范保持一致，不应本地覆盖 |
| `templates/` | 强同步 | 模板格式保持统一，不应本地覆盖 |
| `docs/standards/` | 弱同步 | 可本地追加，同名文件会被覆盖 |
| `docs/references/` | 弱同步 | 可本地追加，同名文件会被覆盖 |
| `AGENTS.md` | 项目本地 | 模板提供初始版本，之后由项目维护 |
| `ARCHITECTURE.md` | 项目本地 | 完全由项目维护 |
| `docs/architecture/` | 项目本地 | 完全由项目维护 |
| `docs/exec-plans/` | 项目本地 | 完全由项目维护 |

## 初始化流程

```bash
# 1. 克隆模板仓库（或使用 GitHub "Use this template"）
git clone https://github.com/Zoneee/agent-best-practies-template.git

# 2. 在目标项目中初始化同步工具
cp -r agent-best-practies-template/tools/agent-template your-project/tools/

# 3. 编辑本地配置
cd your-project
vi tools/agent-template/sync-template.config.json

# 4. 执行首次同步（--dry-run 先预览）
./tools/agent-template/sync-template.sh --dry-run

# 5. 确认无误后执行实际同步
./tools/agent-template/sync-template.sh
```

## 更新模板

```bash
# 查看可用版本
./tools/agent-template/sync-template.sh --ref v1.1.0 --dry-run

# 同步到指定版本
./tools/agent-template/sync-template.sh --ref v1.1.0
```
