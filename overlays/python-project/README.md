# overlays/python-project/

Python 项目类型的追加内容。

## 包含的内容

本 overlay 为 Python 项目提供以下追加文件：

- `skills/python-conventions.md`（示例，待补充）：Python 编码约定与工具链规范
- `docs/standards/python-testing.md`（示例，待补充）：pytest 与 coverage 规范

## 适用范围

- Python 后端服务
- Python CLI 工具
- Python 数据处理脚本

## 启用方式

在 `tools/agent-template/sync-template.config.json` 中：

```json
{
  "overlays": ["python-project"]
}
```

## 状态

📋 **待填充**：当前为占位结构，实际 overlay 内容将在后续 PR 中按项目需求补充。
