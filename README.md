[中文](./README.zh-CN.md) | English

# Claude Code Execution Strategy

Solve the problem of Claude Code executing directly instead of presenting a solution first.

## Problem

Claude Code's default behavior is to edit files and run commands immediately, rather than showing a plan and waiting for confirmation. This wastes tokens and produces results that don't match user expectations.

## Solution

Six task categories + three-layer classification logic + behavior constraints + execution rate optimization.

| Type | Condition | Behavior |
|------|-----------|----------|
| ① Knowledge | Asking why/how/what | Answer directly, don't touch the machine |
| ② Practical | "Help me fix/add" | Present plan → wait → execute |
| ③ Task | Design/refactor/architect | Plan + tradeoffs → user chooses → execute |
| ④ Fix | Errors/env/debugging | Fix directly, report progress |
| ⑤ Chat | Casual chat/greetings/non-tech topics | Normal chat, skip task flow |
| ⑥ Other | Uncertain | Think → provide options → user chooses |

Classification: explicit intent keywords → pattern matching → context inference. See `execution.md`.

### Execution Rate Optimization

To address "strategy becoming ineffective after long conversations", the following optimizations are applied:

- **Core rules first**: Key requirements highlighted at the top in quote format
- **Simplified output**: `[①]` instead of verbose classification lines, reducing execution cost
- **Strong wording**: "Forbidden", "must", "invalid if violated" to reinforce constraints
- **Repeated emphasis**: Core rules reiterated at the beginning, middle, and end
- **Self-check mechanism**: Type judgment before each answer, with a self-check checklist
- **Consequence reinforcement**: "Violating rules = invalid answer"

## Quick Import

### Windows

Double-click `import.bat`, or run in terminal:

```powershell
.\import.ps1
```

### Linux / macOS

```bash
chmod +x ./import.sh && ./import.sh
```

Import complete. Takes effect in new sessions.

## How It Works

Rules are copied to `~/.claude/strategies/` directory, then referenced via CLAUDE.md's `@` syntax to avoid bloating the CLAUDE.md file.

## Files

- `execution.md` — Core rules
- `import.bat` / `import.ps1` / `import.sh` — Import scripts
