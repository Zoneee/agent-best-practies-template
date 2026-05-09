# 澄清契约模板

> 默认使用轻量澄清契约，先解释目标与理由，再记录范围、证据和下一步。
> 只保留能缩小当前不确定性的区块；不要为了显得完整把所有补充区块都写上。
> 默认落盘位置为 `docs/exec-plans/active/`。
> 输出文件名使用 `YYYY-MM-DD_{task-type}_{topic}.md`。
> 标题按正文需要自由撰写，不要求与文件名一致。
> 该模板只负责通用澄清、就绪判定与下一步路由；不要在这里重复 feature 规格或 bug 报告的详细字段。
> feature 细节转到 `templates/feature-spec-template.md`，bug 细节转到 `templates/bug-report-template.md`。
> 涉及范围边界时，统一使用 `## 范围`、`## 非范围`、`## 约束与禁止` 这组字段名。
> 追加区块只在真的能减少歧义时保留；其余删除，不再默认全部保留。
> 若字段未知，请写 `待补充`，不要留空。

## 标题
（填写面向人阅读的标题）

## 任务类型
feature | bug | refactor | chore | research | unknown

## 目标与理由
- 目标结果：
- 为什么现在做：
- 为什么当前缺口值得处理：

## 问题 / 缺口

## 当前证据 / 信号
- 

## 范围
- 

## 非范围
- 

## 约束与禁止
- 

## Refactor / Chore 补充（仅 `refactor` / `chore` 保留）

### 动机

### 受保护行为
- 

### 非目标
- 

## 验证计划
- 测试：
- 手动步骤：
- 日志 / 截图 / 指标：


## 追加区块（按需）

> 只有当下面信息真的能减少歧义时才保留；否则整块删除。

### 相关文档 / 计划 / 代码锚点
- 

### 下游专用产物（如适用）
- feature-spec：
- bug-report：

### 假设
- 

### 未决问题
- 
## 风险
### Refactor / Chore 补充（仅 `refactor` / `chore` 保留）

#### 动机
- 
#### 受保护行为
## 未决问题
- 
#### 非目标
## 就绪判定
Ready for planning | Ready for implementation | Blocked on user input | Blocked on repo research | Not in scope
#### 验证范围
## 下一步动作
ask user | research repo | create plan | implement