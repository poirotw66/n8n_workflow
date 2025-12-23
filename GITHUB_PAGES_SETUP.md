# GitHub Pages 設置指南

## ⚠️ 重要：啟用 GitHub Pages

要使用新的 GitHub Pages Actions 部署，您需要先在 GitHub 倉庫設置中啟用 Pages。

## 📋 設置步驟

### 步驟 1：前往倉庫設置

1. 前往您的 GitHub 倉庫：https://github.com/poirotw66/n8n_workflow
2. 點擊 **Settings**（設置）標籤
3. 在左側選單中找到 **Pages**

### 步驟 2：配置 Pages 源

在 **Source** 部分：

1. 選擇 **GitHub Actions**（不是 "Deploy from a branch"）
2. 點擊 **Save**（保存）

### 步驟 3：等待部署

1. 前往 **Actions** 標籤
2. 查看 "Deploy to GitHub Pages" 工作流
3. 等待部署完成（通常需要 1-2 分鐘）

### 步驟 4：訪問網站

部署成功後，您的網站將在以下網址可用：
```
https://poirotw66.github.io/n8n_workflow/
```

## 🔍 如果遇到錯誤

### 錯誤：HttpError: Not Found 或 Failed to create deployment

**原因**：GitHub Pages 尚未在設置中啟用

**解決方法**：
1. 前往 **Settings** > **Pages**
2. 選擇 **GitHub Actions** 作為源
3. 保存設置
4. 重新運行工作流

### 錯誤：Permission denied

**原因**：工作流權限不足

**解決方法**：
1. 前往 **Settings** > **Actions** > **General**
2. 在 "Workflow permissions" 部分
3. 選擇 "Read and write permissions"
4. 勾選 "Allow GitHub Actions to create and approve pull requests"
5. 保存設置

## 📝 當前部署配置

- **部署方式**：GitHub Actions
- **工作流文件**：`.github/workflows/deploy.yml`
- **部署文件**：
  - `index.html`
  - `styles.css`
  - `.nojekyll`
  - `image/` 文件夾
  - `README.md`

**排除的文件**：
- `LINEBOT/` 文件夾（工作流 JSON 文件）
- 其他 JSON 和 TXT 文件
- 備份文件夾
- 腳本文件

## ✅ 驗證部署

部署成功後，您應該能夠：

1. 訪問網站並看到完整的頁面
2. 查看工作流圖片（如果已添加）
3. 所有樣式和功能正常運作

## 🔄 更新網站

每次推送到 `main` 分支時，網站會自動更新。您也可以：

1. 前往 **Actions** 標籤
2. 選擇 "Deploy to GitHub Pages" 工作流
3. 點擊 **Run workflow** 手動觸發部署

