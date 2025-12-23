#!/bin/bash

# 簡單方法：從 Git 歷史中移除敏感信息
# 使用 git filter-branch 替換所有 Bearer tokens

set -e

echo "🧹 開始清理 Git 歷史中的敏感信息..."
echo ""

# 定義要替換的 tokens（部分匹配）
TOKENS=(
  "uRqMFQ1KdVU79IOYm3svDPEctOSxF3ud1hDocb"
  "KI5+tk6wK1/Xk7XBJzqxmx5c3LwgsObttlOP"
)

# 使用 git filter-branch 替換所有 JSON 文件中的 Bearer tokens
for token in "${TOKENS[@]}"; do
  echo "   處理 token: ${token:0:20}..."
  git filter-branch --force --tree-filter \
    "find LINEBOT -name '*.json' -type f -exec sed -i '' 's/Bearer [A-Za-z0-9+/=]*${token}[A-Za-z0-9+/=]*/Bearer {{ \$env.LINE_CHANNEL_ACCESS_TOKEN }}/g' {} \; 2>/dev/null || true" \
    --prune-empty --tag-name-filter cat -- --all 2>/dev/null || true
done

# 通用替換：替換所有長 Bearer tokens
echo "   執行通用清理..."
git filter-branch --force --tree-filter \
  'find LINEBOT -name "*.json" -type f -exec sed -i "" "s/=Bearer [A-Za-z0-9+/=]\{100,\}/={{ \$env.LINE_CHANNEL_ACCESS_TOKEN }}/g" {} \; 2>/dev/null || true' \
  --prune-empty --tag-name-filter cat -- --all 2>/dev/null || true

echo ""
echo "🧹 清理引用和優化..."
git for-each-ref --format="delete %(refname)" refs/original 2>/dev/null | git update-ref --stdin 2>/dev/null || true
git reflog expire --expire=now --all 2>/dev/null || true
git gc --prune=now --aggressive 2>/dev/null || true

echo ""
echo "✅ 清理完成！"

