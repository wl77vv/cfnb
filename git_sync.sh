#!/bin/bash
# git_sync.sh

cd "$(dirname "$0")" || exit 1

github_username="wl77vv"
repo_name="cfnb"
branch="main"

# 使用远程 URL 中的 token 进行认证（从 git remote 获取）
remote_url=$(git remote get-url origin 2>/dev/null)
if [[ "$remote_url" != *"@"* ]]; then
    echo "⚠️ 请先配置带 token 的远程地址:"
    echo "git remote set-url origin https://<TOKEN>@github.com/${github_username}/${repo_name}.git"
    exit 1
fi

git pull origin "$branch" 2>/dev/null

git add ip.txt .github/workflows/tg_notify.yml git_sync.sh
git commit -m "Update ip.txt on $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null

git push origin "$branch" 2>&1

echo "✅ 已推送到 GitHub"
