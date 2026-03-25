# Node.js 测试规范

> 本文件由 `overlay-node` 追加到项目的 `docs/standards/` 目录。

## 框架

- 使用 `jest` 或 `vitest` 作为测试框架
- 使用 `@testing-library/` 系列处理 UI 组件测试

## 覆盖率要求

- 最低行覆盖率：80%
- 核心业务逻辑最低行覆盖率：90%

## 测试组织

```text
src/
└── __tests__/     # 与源码同级的测试目录
    ├── unit/
    └── integration/
```

## 命名规范

- 测试文件：`<module>.test.ts` 或 `<module>.spec.ts`
- 测试套件：`describe('<功能模块>', () => { ... })`
- 测试用例：`it('<行为描述>', () => { ... })`

## CI 命令

```bash
pnpm test --coverage
```
