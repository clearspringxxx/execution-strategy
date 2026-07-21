#!/bin/bash
# Claude Code 执行策略 - Linux/Mac 导入脚本
# 将 execution.md 复制到 ~/.claude/strategies/，通过 @ 引用加载

set -e

CLAUDE_DIR="$HOME/.claude"
STRATEGIES_DIR="$CLAUDE_DIR/strategies"
RULES_FILE="$(dirname "$0")/execution.md"

# 检查规则文件
if [ ! -f "$RULES_FILE" ]; then
    echo "错误: 找不到 execution.md"
    exit 1
fi

# 确保目录存在
mkdir -p "$STRATEGIES_DIR"

# 复制文件
cp "$RULES_FILE" "$STRATEGIES_DIR/"

# 自动添加引用到 CLAUDE.md
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
REF_LINE="@~/.claude/strategies/execution.md"

if [ -f "$CLAUDE_MD" ]; then
    if ! grep -qF "$REF_LINE" "$CLAUDE_MD"; then
        echo "" >> "$CLAUDE_MD"
        echo "$REF_LINE" >> "$CLAUDE_MD"
        echo "已添加引用到: $CLAUDE_MD"
    else
        echo "引用已存在，无需重复添加。"
    fi
else
    echo "$REF_LINE" > "$CLAUDE_MD"
    echo "已创建并添加引用: $CLAUDE_MD"
fi

echo "导入完成！新会话生效。"
