# LINE Chatbot 專案

這是一個基於 n8n 平台建構的 LINE Chatbot 專案，旨在提供智能化的自動回覆功能。它利用 AI 語言模型（如 Google Gemini）來分析用戶輸入，並根據內容類型（技術相關或非技術相關）生成適當的回應。

## 專案結構

- `LINEBOT/`: 包含所有 n8n 工作流 JSON 檔案
  - `[MAIN]LINE CHATBOT.json`: 主要控制流程
  - `[SUB] *.json`: 各種子流程模組
- `LINE_CHATBOT.txt`: 描述了 AI 語言模型的主要任務、內容判斷與處理邏輯、技術內容輸出規範等
- `index.html`: GitHub Pages 展示頁面
- `styles.css`: 頁面樣式文件

## 🌐 GitHub Pages 展示

本專案包含一個 GitHub Pages 展示網站，用於展示 LINE Chatbot 的功能和架構。

### 啟用 GitHub Pages

1. 前往 GitHub 倉庫的 **Settings** > **Pages**
2. 在 **Source** 部分選擇：
   - **Deploy from a branch**: 選擇 `main` 或 `master` 分支，並選擇 `/ (root)` 目錄
   - 或者使用 **GitHub Actions** 自動部署（已配置工作流）
3. 點擊 **Save**，等待幾分鐘後即可訪問您的 GitHub Pages 網站

### 訪問網站

啟用後，您的網站將在以下網址可用：
```
https://[您的用戶名].github.io/n8n_workflow-1/
```

### 本地預覽

您也可以在本地預覽網站：
```bash
# 使用 Python 簡單 HTTP 服務器
python3 -m http.server 8000

# 或使用 Node.js http-server
npx http-server
```

然後在瀏覽器中訪問 `http://localhost:8000`

## 功能概述

### 1. Webhook 入口

- 監聽來自 LINE 的訊息，觸發自動回應流程。
- **注意事項**：
  - 確保 Webhook 設定正確，確保 LINE 可發送請求。
  - 需要在 LINE Developers Console 設定 Webhook URL。

### 2. AI 語言模型處理

- 呼叫 AI 模型（如 Google Gemini）來產生適當回應。
- **主要任務**：分析用戶輸入內容，並根據以下邏輯處理：
  - **技術相關內容處理**：
    - 判斷標準：包含技術文件、會議記錄、專業討論等內容。
    - 處理方式：
      - 如內容包含網址，使用 "HTTP Request"或是"Jina AI" 工具讀取完整內容。若沒有正確爬取內容請回覆錯誤訊息。
      - 如內容包含youtube網址，使用"Youtube Transcript"工具讀取影片逐字稿。若沒有正確爬取內容請回覆錯誤訊息。
      - 一般情況依照「標準輸出模板」格式化回覆,
      - 若使用者要求詳細報告,則依照「詳細輸出模板」輸出
      - 內容與技術內容不相關，依照「非技術內容處理」輸出
  - **非技術內容處理**：展現個性化的對話風格。
- **注意事項**：
  - 確保 API Key 正確填寫，避免請求失敗。
  - 設定 `prompt` 要求輸出 JSON，避免格式錯誤。

### 3. 處理 AI 回應

- 解析 AI 產生的回應，取得 `replyToken` 和 `text`。
- **注意事項**：
  - 確保 AI Agent 輸出的格式正確。
  - 若 AI 輸出錯誤，應該在這裡處理錯誤邏輯。

### 4. 發送回應給 LINE

- 將處理後的訊息發送回 LINE 用戶。

## 技術內容輸出規範

### 基本要求
- **語言**：繁體中文
- **平台**：LINE 通訊軟體適配
- **字數**：控制在 500 字以內。
- **格式**：純文字，避免 Markdown 和 HTML 語法。

### 輸出模板

- **標準輸出模板**：