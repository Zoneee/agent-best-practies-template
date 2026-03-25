# overlays/

本目录存放面向特定项目类型的 **可选追加内容（overlays）**。

## 设计原则

- Overlay 是对 `base/` 共性内容的 **补充**，不是替换。
- 下游项目可以按需选择一个或多个 overlay。
- Overlay 内容通过 `manifest/template-manifest.json` 中的 `overlay` 分组定义。

## 目录结构

```text
overlays/
├── python-project/     # Python 项目专用追加内容
├── node-project/       # Node.js 项目专用追加内容
└── <project-type>/     # 其他项目类型（按需添加）
```

## 如何使用

在下游项目的 `tools/agent-template/sync-template.config.json` 中指定要启用的 overlay：

```json
{
  "overlays": ["python-project"]
}
```

然后运行同步脚本：

```bash
./tools/agent-template/sync-template.sh --group overlay-python
```

## 适合放在 overlay 的内容

- 项目类型专属的 skills（如 Python 特有的测试规范 skill）
- 项目类型专属的标准文档（如 Node.js 包管理规范）
- 项目类型专属的模板（如 Python wheel 发布模板）

## 不适合放在 overlay 的内容

- 业务逻辑相关的决策（应放在项目本地）
- 项目架构文档（应放在项目的 `docs/architecture/`）
- 项目专属的 `AGENTS.md`（必须由项目本地维护）
