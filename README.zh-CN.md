[English](./README.md) | 中文

# Claude Code 执行策略

解决 Claude Code 「直接执行，不先给方案」的问题。

## 问题

Claude Code 默认行为是收到任务后直接改代码、跑命令，而不是先展示方案等用户确认。方向错了浪费 token，产出不符合预期。

## 解决方案

五类任务分类 + 三层判定逻辑 + 行为约束。

| 类型 | 判定 | 行为 |
|------|------|------|
| ① 知识型 | 问原理/原因/用法 | 直接回答，不动主机 |
| ② 实操型 | 帮我改/帮我加 | 先方案，后执行 |
| ③ 任务型 | 设计/重构/架构 | 方案+利弊，用户选择 |
| ④ 修复型 | 报错/环境/故障 | 直接干，边做边说 |
| ⑤ 其他型 | 拿不准 | 给选项，用户选 |

判定逻辑：显式意图词 → 关键词匹配 → 上下文推断，详见 `execution.md`。

## 快速导入

### Windows

双击 `import.bat`，或终端执行：

```powershell
.\import.ps1
```

### Linux / macOS

```bash
chmod +x ./import.sh && ./import.sh
```

导入完成，新会话自动生效。

## 工作原理

规则文件复制到 `~/.claude/strategies/` 目录，通过 CLAUDE.md 的 `@` 语法引用，避免 CLAUDE.md 文件过大。

## 文件说明

- `execution.md` — 核心规则
- `import.bat` / `import.ps1` / `import.sh` — 导入脚本
