#!/bin/bash

# 安全腳本：移除工作流文件中的硬編碼 Bearer tokens
# 使用前請先備份文件！

echo "⚠️  警告：此腳本將替換所有 JSON 文件中的 Bearer tokens"
echo "📋 請確保您已經："
echo "   1. 備份了所有文件"
echo "   2. 在 LINE Developers Console 中準備好新的 token"
echo "   3. 了解此操作不可逆"
echo ""
read -p "是否繼續？(yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "❌ 操作已取消"
    exit 1
fi

# 創建備份
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
echo "📦 創建備份到 $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"
cp -r LINEBOT/ "$BACKUP_DIR/"
echo "✅ 備份完成"

# 替換 Bearer tokens 為環境變數引用
echo "🔍 搜尋並替換 Bearer tokens..."

# macOS 使用 sed -i '', Linux 使用 sed -i
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INLINE="sed -i ''"
else
    SED_INLINE="sed -i"
fi

find LINEBOT/ -name "*.json" -type f | while read file; do
    # 替換硬編碼的 Bearer token 為環境變數
    $SED_INLINE 's/"value": "=Bearer [^"]*"/"value": "={{ $env.LINE_CHANNEL_ACCESS_TOKEN }}"/g' "$file"
    echo "  ✓ 處理: $file"
done

echo ""
echo "✅ 完成！所有 Bearer tokens 已替換為環境變數引用"
echo "📝 請在 n8n 中設置環境變數 LINE_CHANNEL_ACCESS_TOKEN"
echo "💾 備份保存在: $BACKUP_DIR"

