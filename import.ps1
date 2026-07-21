# Claude Code 执行策略 - Windows 导入脚本
# 将 execution.md 复制到 ~/.claude/strategies/，通过 @ 引用加载

$ErrorActionPreference = "Stop"

$claudeDir = Join-Path $env:USERPROFILE ".claude"
$strategiesDir = Join-Path $claudeDir "strategies"
$rulesFile = Join-Path $PSScriptRoot "execution.md"

# 检查规则文件是否存在
if (-not (Test-Path $rulesFile)) {
    Write-Host "错误: 找不到 execution.md" -ForegroundColor Red
    exit 1
}

# 确保 strategies 目录存在
if (-not (Test-Path $strategiesDir)) {
    New-Item -ItemType Directory -Path $strategiesDir | Out-Null
    Write-Host "已创建目录: $strategiesDir"
}

# 复制文件（覆盖更新）
Copy-Item -Path $rulesFile -Destination $strategiesDir -Force

# 自动添加引用到 CLAUDE.md
$claudeMd = Join-Path $claudeDir "CLAUDE.md"
$refLine = "@~/.claude/strategies/execution.md"

if (Test-Path $claudeMd) {
    $content = Get-Content $claudeMd -Raw -Encoding UTF8
    if ($content -notmatch [regex]::Escape($refLine)) {
        Add-Content -Path $claudeMd -Value "`n$refLine" -Encoding UTF8
        Write-Host "已添加引用到: $claudeMd" -ForegroundColor Green
    } else {
        Write-Host "引用已存在，无需重复添加。" -ForegroundColor Yellow
    }
} else {
    Set-Content -Path $claudeMd -Value $refLine -Encoding UTF8
    Write-Host "已创建并添加引用: $claudeMd" -ForegroundColor Green
}

Write-Host "导入完成！新会话生效。" -ForegroundColor Green
