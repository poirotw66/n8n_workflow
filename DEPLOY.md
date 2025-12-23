# GitHub Pages 部署指南

如果遇到部署錯誤，請按照以下步驟操作：

## 方法一：使用 GitHub Actions 自動部署（推薦）

### 步驟 1：啟用 GitHub Pages

1. 前往您的 GitHub 倉庫
2. 點擊 **Settings**（設置）
3. 在左側選單中找到 **Pages**
4. 在 **Source** 部分：
   - 選擇 **GitHub Actions** 作為來源
   - 或者選擇 **Deploy from a branch**，然後選擇 `gh-pages` 分支和 `/ (root)` 目錄
5. 點擊 **Save**（保存）

### 步驟 2：推送代碼

```bash
git add .
git commit -m "Add GitHub Pages"
git push origin main
```

### 步驟 3：檢查部署狀態

1. 前往倉庫的 **Actions** 標籤
2. 查看工作流執行狀態
3. 如果成功，幾分鐘後即可訪問您的網站

## 方法二：使用簡單部署工作流

如果方法一遇到問題，可以使用 `deploy-simple.yml` 工作流：

1. 確保 `.github/workflows/deploy.yml` 被禁用或刪除
2. 使用 `deploy-simple.yml`（會自動部署到 `gh-pages` 分支）
3. 在 GitHub 設置中選擇 `gh-pages` 分支作為來源

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

### 錯誤：HttpError: Not Found

**原因**：GitHub Pages 尚未在倉庫設置中啟用

**解決方法**：
1. 前往 **Settings** > **Pages**
2. 選擇一個部署來源（GitHub Actions 或分支）
3. 保存設置

### 錯誤：Get Pages site failed

**原因**：Pages 環境尚未配置

**解決方法**：
1. 確保在 **Settings** > **Pages** 中選擇了 **GitHub Actions** 作為來源
2. 或者使用 `deploy-simple.yml` 工作流，它會自動創建 `gh-pages` 分支

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

