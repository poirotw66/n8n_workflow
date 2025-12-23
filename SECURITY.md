# 🔒 安全指南

## ⚠️ 重要安全警告

**本倉庫中的 n8n 工作流 JSON 文件包含硬編碼的 LINE API Bearer tokens。這些 tokens 是敏感信息，不應該被提交到公開的 GitHub 倉庫。**

## 🚨 立即行動

### 1. 撤銷已暴露的 Token

如果這些 token 已經被推送到 GitHub（特別是公開倉庫），您需要：

1. **立即撤銷所有已暴露的 LINE API tokens**：
   - 前往 [LINE Developers Console](https://developers.line.biz/console/)
   - 登入您的帳號
   - 找到對應的 Channel
   - 重新生成新的 Channel Access Token
   - 舊的 token 將立即失效

2. **從 Git 歷史記錄中移除敏感信息**（如果已推送）：
   ```bash
   # 使用 git filter-branch（需要謹慎操作）
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch LINEBOT/*.json" \
     --prune-empty --tag-name-filter cat -- --all
   
   # 或者使用 BFG Repo-Cleaner（推薦）
   # 下載 BFG: https://rtyley.github.io/bfg-repo-cleaner/
   java -jar bfg.jar --replace-text tokens.txt
   
   # 強制推送（警告：這會重寫歷史）
   git push origin --force --all
   ```

### 2. 使用安全的 Token 管理方式

在 n8n 中，應該使用以下方式管理敏感信息：

#### 方法一：使用 n8n Credentials（推薦）

1. 在 n8n 中創建 Credential：
   - 前往 **Settings** > **Credentials**
   - 創建新的 HTTP Header Auth credential
   - 將 Bearer token 存儲在 credential 中

2. 在工作流中使用 credential：
   - 在 HTTP Request 節點中選擇使用 credential
   - 而不是直接輸入 token

#### 方法二：使用環境變數

1. 在 n8n 環境變數中設置：
   ```bash
   LINE_CHANNEL_ACCESS_TOKEN=your_token_here
   ```

2. 在工作流中使用：
   ```
   =Bearer {{ $env.LINE_CHANNEL_ACCESS_TOKEN }}
   ```

#### 方法三：使用 n8n 的 Secret 功能

在 n8n 1.0+ 中，可以使用 Secrets 來存儲敏感信息。

### 3. 清理工作流文件

在導出 n8n 工作流時：

1. **使用 n8n 的 "Export without credentials" 選項**（如果可用）
2. **手動移除敏感信息**：
   - 將所有 `"value": "=Bearer ..."` 替換為 `"value": "={{ $env.LINE_TOKEN }}"`
   - 或使用 placeholder：`"value": "=Bearer YOUR_TOKEN_HERE"`

### 4. 創建模板文件

建議創建一個模板版本的工作流文件，其中敏感信息被替換為 placeholder：

```json
{
  "value": "=Bearer {{ $env.LINE_CHANNEL_ACCESS_TOKEN }}"
}
```

## 📋 檢查清單

在提交代碼到 GitHub 之前，請確認：

- [ ] 所有 API tokens 已從 JSON 文件中移除
- [ ] 使用環境變數或 credentials 替代硬編碼的 token
- [ ] 已檢查所有文件，確保沒有其他敏感信息（API keys、密碼等）
- [ ] 已添加 `.gitignore` 文件
- [ ] 如果 token 已暴露，已在 LINE Developers Console 中撤銷並重新生成

## 🔍 如何檢查是否包含敏感信息

使用以下命令搜索可能包含敏感信息的文件：

```bash
# 搜索 Bearer tokens
grep -r "Bearer" LINEBOT/

# 搜索可能的 API keys
grep -r "api.*key\|apikey\|secret" LINEBOT/ -i

# 搜索可能的密碼
grep -r "password\|passwd\|pwd" LINEBOT/ -i
```

## 📚 相關資源

- [LINE Developers Documentation](https://developers.line.biz/en/docs/)
- [n8n Security Best Practices](https://docs.n8n.io/security/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

## ⚡ 快速修復腳本

如果您需要批量替換 token，可以使用以下腳本：

```bash
#!/bin/bash
# 替換所有 JSON 文件中的 Bearer token 為環境變數引用

find LINEBOT/ -name "*.json" -type f -exec sed -i '' \
  's/"value": "=Bearer [^"]*"/"value": "={{ $env.LINE_CHANNEL_ACCESS_TOKEN }}"/g' {} \;
```

**注意**：執行前請備份文件！

