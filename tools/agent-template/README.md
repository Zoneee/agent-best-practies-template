# tools/agent-template/

本目录包含模板同步工具，用于将 `agent-best-practies-template` 的共享内容同步到下游项目。

## 文件说明

| 文件 | 说明 |
|------|------|
| `sync-template.sh` | 主同步脚本 |
| `sync-template.config.json` | 下游项目的本地配置（需复制并定制） |
| `template-version.json` | 当前已同步的版本信息（由脚本自动维护） |

## 快速开始

### 在下游项目中使用

1. 将本目录复制到目标项目：

```bash
cp -r tools/agent-template your-project/tools/
cd your-project
```

2. 编辑本地配置：

```bash
vi tools/agent-template/sync-template.config.json
# 修改 projectName 等字段
```

3. 预览同步内容：

```bash
./tools/agent-template/sync-template.sh --dry-run
```

4. 执行同步：

```bash
./tools/agent-template/sync-template.sh
```

## 常用命令

```bash
# 同步全部 enabled group（默认行为）
./tools/agent-template/sync-template.sh

# 预览不写入
./tools/agent-template/sync-template.sh --dry-run

# 同步到特定版本（tag 或 branch）
./tools/agent-template/sync-template.sh --ref v1.0.0

# 只同步特定 group
./tools/agent-template/sync-template.sh --group core-skills
./tools/agent-template/sync-template.sh --group core-skills --group templates

# 查看帮助
./tools/agent-template/sync-template.sh --help
```

## 同步模式说明

| 模式 | 行为 |
|------|------|
| `hard-sync` | 目标目录与源保持完全一致（会删除目标中多余的文件），适合 `skills/`、`templates/` |
| `soft-sync` | 只追加/更新同名文件，不删除目标中的本地新增文件，适合 `docs/standards/`、`docs/references/` |

## 依赖

- `git`：用于克隆模板仓库
- `python3`：用于解析 JSON manifest（大多数系统内置）
- `rsync`（可选）：如未安装则回退到 `cp`，但 hard-sync 的删除功能将不可用

## manifest 与 config 协作方式

```text
manifest/template-manifest.json  ←  模板仓库维护（定义所有可同步 group）
        +
tools/agent-template/sync-template.config.json  ←  下游项目本地维护（定制启用哪些 group）
        ↓
sync-template.sh  →  实际同步操作
        ↓
tools/agent-template/template-version.json  ←  自动记录本次同步的 ref 和时间戳
```

## AGENTS.md 说明

`AGENTS.md` 属于项目私有内容，**不由本工具同步**。  
模板仓库提供一个参考版本，下游项目在初始化时可以参考，但之后由项目自行维护。  
`AGENTS.md` 的规则变更将通过单独 PR 提出 diff，由各项目决定是否采纳。
