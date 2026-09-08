# 自动解决 cherry-pick 冲突
# 【中文注释】本脚本循环推进 git cherry-pick:
#   1. 每轮检查工作区状态,干净则认为 cherry-pick 完成;
#   2. 对所有冲突文件执行 `git checkout --ours`(保留己方版本);
#   3. 对"对方已删除"的文件执行 `git rm` 同步删除;
#   4. 暂存后用 `git cherry-pick --continue` 继续;
#   5. 遇到空提交则跳过,其他错误等待 1 秒后重试。
# 【中文注释】MaxAttempts 防止死循环,超过次数后提示人工检查。
param([int]$MaxAttempts = 100)

$attempts = 0
while ($attempts -lt $MaxAttempts) {
    $attempts++

    # Check if cherry-pick is in progress
    # 【中文注释】`git status --porcelain` 无输出说明工作区干净,cherry-pick 已完成
    $status = git status --porcelain
    if (-not $status) {
        Write-Host "Cherry-pick complete!" -ForegroundColor Green
        break
    }

    # Get conflicted files
    # 【中文注释】列出所有处于未合并(U)状态的冲突文件
    $conflicts = git diff --name-only --diff-filter=U

    if ($conflicts) {
        Write-Host "Attempt $attempts`: Resolving conflicts..." -ForegroundColor Yellow

        foreach ($file in $conflicts) {
            Write-Host "  Resolving: $file"
            # 【中文注释】冲突统一取己方(ours)版本
            git checkout --ours $file 2>$null
        }

        # Handle deleted files
        # 【中文注释】状态码 DU = 己方存在、对方删除:跟随删除该文件
        git status --short | Where-Object { $_ -match '^DU' } | ForEach-Object {
            $file = ($_ -split '\s+', 2)[1]
            Write-Host "  Removing deleted: $file"
            git rm $file 2>$null
        }

        # 【中文注释】暂存全部解决结果,准备继续 cherry-pick
        git add . 2>$null
    }

    # Try to continue
    # 【中文注释】继续当前被中断的 cherry-pick
    $result = git cherry-pick --continue 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Continued successfully" -ForegroundColor Green
    }
    elseif ($result -match 'empty') {
        # 【中文注释】补丁内容为空(改动已存在)时跳过该提交
        Write-Host "  Skipping empty commit" -ForegroundColor Cyan
        git cherry-pick --skip 2>&1 | Out-Null
    }
    else {
        # 【中文注释】其他错误:打印信息并等待 1 秒后进入下一轮重试
        Write-Host "  Error: $result" -ForegroundColor Red
        Start-Sleep -Seconds 1
    }
}

# 【中文注释】达到最大尝试次数仍未完成,提示人工介入
if ($attempts -ge $MaxAttempts) {
    Write-Host "Max attempts reached. Check status manually." -ForegroundColor Red
}
