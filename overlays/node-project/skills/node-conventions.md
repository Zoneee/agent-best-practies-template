# node-conventions

> 本文件由 `overlay-node` 追加到项目的 `skills/` 目录。

## 目的

为 Node.js 项目补充语言特定的 Agent 行为约定，与 `base/skills/` 中的通用 Skills 配合使用。

## 编码约定

- 使用 TypeScript（严格模式：`"strict": true`）
- 模块系统：ES Modules（`.mjs` 或 `"type": "module"`）
- 格式化：`prettier`
- Lint：`eslint` + `typescript-eslint`

## 工具链

- 包管理：`pnpm`（优先）或 `npm`
- 测试：`jest` 或 `vitest`
- 构建：`tsc` 或 `esbuild`

## Agent 行为要求

- 修改 TypeScript 代码时必须确保 `tsc --noEmit` 通过
- 添加新函数时必须补充 JSDoc 注释
- 运行 `jest` / `vitest` 验证测试通过
