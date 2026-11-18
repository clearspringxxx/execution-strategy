[中文](./README.zh-CN.md) | English

# Claude Code Execution Strategy

Solve the problem of Claude Code executing directly instead of presenting a solution first.

## Problem

Claude Code's default behavior is to edit files and run commands immediately, rather than showing a plan and waiting for confirmation. This wastes tokens and produces results that don't match user expectations.

## Solution

Four core rules, ~25 lines total:

1. **Plan before acting** — tasks that touch files, commands, or config get a plan first (one line for small changes, a breakdown with risks for large ones), then wait for confirmation.
2. **Answer-only for questions** — explanations, how-tos, and principles are answered directly; nothing is touched.
3. **Fix directly by default** — errors, environment, and debugging are handled immediately with progress reports; deletions, overwrites, refactors, and dependency swaps require a heads-up first.
4. **User overrides everything** — "just do it", "skip the process", "I'm in a hurry" suspends all of the above.

Scope boundaries cover new features, design work, ambiguous requests, mid-task stops, and scope creep. A single self-check anchors the whole thing: *did the user agree? if not, present a plan first.*

## Design Notes

- No classification markers, no multi-layer decision tables. The rules are short enough to stay effective in long conversations.
- An explicit override clause so the strategy never fights the user's own instructions.
- Rules live in a file referenced from CLAUDE.md via `@` syntax to avoid bloating it.

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
