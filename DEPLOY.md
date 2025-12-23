# GitHub Pages 部署指南

## 自動部署（推薦方法）

本專案已配置自動部署工作流，會自動將網站部署到 `gh-pages` 分支。

### 步驟 1：推送代碼

```bash
git add .
git commit -m "Deploy GitHub Pages"
git push origin main
```

### 步驟 2：等待部署完成

1. 前往倉庫的 **Actions** 標籤
2. 查看 "Deploy to GitHub Pages" 工作流執行狀態
3. 等待工作流完成（通常需要 1-2 分鐘）

### 步驟 3：啟用 GitHub Pages

部署完成後（`gh-pages` 分支已創建），需要啟用 Pages：

1. 前往 GitHub 倉庫的 **Settings** > **Pages**
2. 在 **Source** 部分：
   - 選擇 **Deploy from a branch**
   - 分支選擇 `gh-pages`
   - 目錄選擇 `/ (root)`
3. 點擊 **Save**

### 步驟 4：訪問網站

等待 1-2 分鐘後，您的網站將在以下網址可用：
```
https://[您的用戶名].github.io/n8n_workflow-1/
```

## 手動觸發部署

如果需要手動觸發部署：

1. 前往倉庫的 **Actions** 標籤
2. 選擇 "Deploy to GitHub Pages" 工作流
3. 點擊 **Run workflow** 按鈕
4. 選擇分支（通常是 `main`）
5. 點擊 **Run workflow**

## 方法三：手動部署到 gh-pages 分支

如果自動部署仍有問題，可以手動部署：

```bash
# 安裝 gh-pages 工具
npm install -g gh-pages

# 部署到 gh-pages 分支
gh-pages -d .
```

或者使用 Git 命令：

```bash
# 創建並切換到 gh-pages 分支
git checkout --orphan gh-pages
git rm -rf .

# 添加所有文件
git add .
git commit -m "Deploy to GitHub Pages"

# 推送到遠程
git push origin gh-pages --force

# 切換回主分支
git checkout main
```

## 常見問題

### 錯誤：HttpError: Not Found 或 Get Pages site failed

**原因**：這個錯誤通常出現在使用新的 GitHub Pages Actions 時，因為需要先在設置中啟用 Pages。

**解決方法**：
1. **先推送代碼**，讓工作流創建 `gh-pages` 分支
2. 等待工作流完成（查看 Actions 標籤）
3. 然後前往 **Settings** > **Pages**
4. 選擇 **Deploy from a branch**，選擇 `gh-pages` 分支
5. 保存設置

**注意**：新的工作流使用 `gh-pages` 分支部署，不需要先在設置中啟用 Pages。先讓工作流運行完成，創建 `gh-pages` 分支後，再在設置中選擇該分支即可。

### 網站無法訪問

**檢查清單**：
- [ ] GitHub Pages 已在設置中啟用
- [ ] 工作流執行成功（查看 Actions 標籤）
- [ ] 等待 1-2 分鐘讓 DNS 更新
- [ ] 檢查網站 URL 是否正確：`https://[用戶名].github.io/[倉庫名]/`

## 訪問您的網站

部署成功後，您的網站將在以下網址可用：

```
https://[您的GitHub用戶名].github.io/n8n_workflow-1/
```

如果您的倉庫名稱不同，請替換 `n8n_workflow-1` 為實際的倉庫名稱。

