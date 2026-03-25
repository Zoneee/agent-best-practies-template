# overlays/node-project/

Node.js 项目类型的追加内容。

## 包含的内容

本 overlay 为 Node.js 项目提供以下追加文件：

- `skills/node-conventions.md`（示例，待补充）：Node.js 编码约定与包管理规范
- `docs/standards/node-testing.md`（示例，待补充）：Jest 与 TypeScript 测试规范

## 适用范围

- Node.js 后端服务（Express、NestJS 等）
- 前端 React/Vue/Angular 项目
- Node.js CLI 工具

## 启用方式

在 `tools/agent-template/sync-template.config.json` 中：

```json
{
  "overlays": ["node-project"]
}
```

## 状态

📋 **待填充**：当前为占位结构，实际 overlay 内容将在后续 PR 中按项目需求补充。
