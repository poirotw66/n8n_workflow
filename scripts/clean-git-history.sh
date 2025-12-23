#!/bin/bash

# 從 Git 歷史記錄中移除敏感信息（Bearer tokens）
# ⚠️ 警告：此操作會重寫 Git 歷史，需要強制推送

set -e

echo "⚠️  ⚠️  ⚠️  重要警告 ⚠️  ⚠️  ⚠️"
echo ""
echo "此腳本將從 Git 歷史記錄中移除所有硬編碼的 Bearer tokens"
echo "這是一個破壞性操作，會："
echo "  1. 重寫所有提交歷史"
echo "  2. 需要強制推送到遠程倉庫"
echo "  3. 所有協作者需要重新克隆倉庫"
echo ""
echo "請確保："
echo "  ✓ 已備份所有重要數據"
echo "  ✓ 已通知所有協作者"
echo "  ✓ 已撤銷所有暴露的 tokens"
echo ""

read -p "是否繼續？(輸入 'YES' 確認): " confirm

if [ "$confirm" != "YES" ]; then
    echo "❌ 操作已取消"
    exit 1
fi

echo ""
echo "📦 創建完整倉庫備份..."
BACKUP_DIR="../n8n_workflow-1_backup_$(date +%Y%m%d_%H%M%S)"
cp -r . "$BACKUP_DIR"
echo "✅ 備份完成: $BACKUP_DIR"
echo ""

echo "🔍 檢查 Git 歷史中的敏感信息..."
TOKEN_COUNT=$(git log --all -p -S "Bearer" -- LINEBOT/*.json 2>/dev/null | grep -c "Bearer" || echo "0")
echo "   發現 $TOKEN_COUNT 個可能的 token 引用"
echo ""

echo "🧹 開始清理 Git 歷史..."
echo "   這可能需要幾分鐘時間..."
echo ""

# 使用 git filter-branch 移除敏感信息
# 替換所有包含 Bearer token 的行
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch LINEBOT/*.json || true' \
  --prune-empty --tag-name-filter cat -- --all

# 重新添加文件（使用當前已清理的版本）
git checkout HEAD -- LINEBOT/*.json 2>/dev/null || true

# 再次過濾，替換文件內容中的 tokens
git filter-branch --force --tree-filter \
  'if [ -f "LINEBOT/[MAIN]LINE CHATBOT.json" ]; then
     sed -i "" "s/Bearer [A-Za-z0-9+/=]\{50,\}/Bearer {{ \$env.LINE_CHANNEL_ACCESS_TOKEN }}/g" LINEBOT/*.json 2>/dev/null || true
   fi' \
  --prune-empty --tag-name-filter cat -- --all

echo ""
echo "🧹 清理引用..."
git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo ""
echo "✅ Git 歷史清理完成！"
echo ""
echo "📋 下一步操作："
echo "   1. 檢查清理結果："
echo "      git log --all -p -S 'Bearer' -- LINEBOT/"
echo ""
echo "   2. 如果結果正確，強制推送到遠程："
echo "      git push origin --force --all"
echo "      git push origin --force --tags"
echo ""
echo "   3. 通知所有協作者重新克隆倉庫"
echo ""
echo "💾 完整備份保存在: $BACKUP_DIR"

