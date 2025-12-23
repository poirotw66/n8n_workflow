# LINE Chatbot 專案

這是一個基於 n8n 平台建構的 LINE Chatbot 專案，旨在提供智能化的自動回覆功能。它利用 AI 語言模型（如 Google Gemini）來分析用戶輸入，並根據內容類型智能路由到對應的子流程進行處理，提供多樣化的 AI 服務。

## 🌐 線上展示

**GitHub Pages 網站**：https://poirotw66.github.io/n8n_workflow/

網站展示了所有工作流的詳細資訊和視覺化流程圖，支援圖片燈箱查看功能。

## ⚠️ 安全說明

**重要**：本專案已移除所有硬編碼的 API tokens，使用環境變數管理敏感信息。

- ✅ 所有 Bearer tokens 已從代碼中移除
- ✅ 使用 `{{ $env.LINE_CHANNEL_ACCESS_TOKEN }}` 環境變數引用
- ✅ Git 歷史記錄已清理，敏感信息已從歷史中移除

詳細的安全指南請參考 [SECURITY.md](./SECURITY.md)

## 📁 專案結構

```
n8n_workflow-1/
├── LINEBOT/                          # n8n 工作流 JSON 檔案
│   ├── [MAIN]LINE CHATBOT.json      # 主要控制流程
│   ├── [SUB] *.json                  # 各種子流程模組（19個）
│   └── FACT linebot.json             # FACT 工作流
├── image/                            # 工作流流程圖
│   ├── [MAIN]LINE CHATBOT.png       # 主流程圖
│   └── [SUB] *.png                   # 子流程圖（18個）
├── index.html                        # GitHub Pages 展示頁面
├── styles.css                        # 頁面樣式文件
├── LINE_CHATBOT.txt                  # AI 模型提示詞和輸出規範
├── scripts/                          # 工具腳本
│   ├── remove-tokens.sh             # 移除 tokens 腳本
│   └── clean-git-history.sh          # 清理 Git 歷史腳本
├── .github/workflows/                # GitHub Actions 工作流
│   └── deploy.yml                   # GitHub Pages 自動部署
└── 文檔/
    ├── README.md                     # 本文件
    ├── SECURITY.md                   # 安全指南
    ├── DEPLOY.md                     # 部署指南
    └── GITHUB_PAGES_SETUP.md         # GitHub Pages 設置指南
```

## 🎯 主要流程

### [MAIN] LINE CHATBOT

核心控制流程，負責：
- 📥 接收 LINE Webhook 訊息
- 🤖 整合 AI 語言模型（Google Gemini）進行內容分析
- 🎯 根據訊息類型智能路由到對應子流程
- 📤 處理 AI 回應並格式化輸出
- ✂️ 自動分段處理超長訊息（支援最多 5 則訊息）
- 📱 發送回應回 LINE 用戶

**技術內容處理能力**：
- 自動識別技術文件、會議記錄、專業討論等內容
- 支援網址內容爬取（HTTP Request / Jina AI）
- 支援 YouTube 影片逐字稿提取
- 提供標準輸出和詳細報告兩種模式
- 優化 LINE 平台顯示格式（繁體中文，500 字以內）

## 🔧 子流程模組

本專案包含 **19 個子流程模組**，涵蓋多種功能：

### 🤖 AI 代理模組
- **1399 RAG Agent** - 檢索增強生成代理，結合知識庫檢索和 AI 生成
- **MCP RAG Agent** - 基於 MCP 協議的 RAG 代理
- **RAG Pipeline** - RAG 處理管道，整合檢索和生成的完整流程
- **ITR Agent** - ITR 專業代理，處理特定領域的專業查詢
- **FACT Agent** - 事實查證代理，驗證資訊的真實性和準確性
- **CB Agent** - CB 對話代理，提供個性化的對話和互動服務
- **DR Agent** - DR 專業代理，處理特定領域的專業任務

### 📰 資訊處理模組
- **NEWS Agent** - 新聞資訊代理，提供最新新聞資訊和新聞摘要
- **News Agent Scrape** - 新聞爬蟲代理，自動抓取和整理網路新聞
- **STOCK Agent** - 股票資訊代理，提供股票價格、市場資訊等金融數據查詢

### 🖼️ 圖像處理模組
- **IMAGE Generator** - 使用 AI 模型進行文字轉圖像生成
- **Food Image** - 食物圖像生成模組，專門生成美食相關的圖像
- **Image Editing** - 圖像編輯模組，提供圖像處理和編輯功能
- **Image Module** - 圖像處理模組，整合多種圖像相關功能

### 🌐 網頁處理模組
- **WEB** - 網頁內容處理模組，處理網頁爬取和內容提取
- **LINE CHATBOT Crawl** - 網頁爬取工具，專門用於 LINE Chatbot 的內容爬取

### 🛠️ 工具模組
- **SUBS Module** - 子模組整合，管理多個子流程的協調和調用
- **Database Query Tool** - 資料庫查詢工具，提供資料庫查詢和數據檢索功能

### 📋 其他模組
- **FACT linebot** - FACT 相關的 LINE Bot 工作流

## 🚀 GitHub Pages 展示網站

本專案包含一個功能完整的 GitHub Pages 展示網站，展示所有工作流的功能和架構。

### 網站功能

- 📊 **視覺化展示** - 所有工作流都有對應的流程圖
- 🔍 **圖片燈箱** - 點擊圖片可在全屏模式下查看詳細流程
- 📱 **響應式設計** - 適配手機、平板、桌面各種設備
- 🎨 **現代化 UI** - 美觀的卡片式佈局和漸層配色

### 快速開始

1. **啟用 GitHub Pages**：
   - 前往 GitHub 倉庫的 **Settings** > **Pages**
   - 在 **Source** 部分選擇 **GitHub Actions**
   - 點擊 **Save**

2. **自動部署**：
   - 推送代碼到 `main` 分支會自動觸發部署
   - 或前往 **Actions** 標籤手動觸發工作流

3. **訪問網站**：
   ```
   https://poirotw66.github.io/n8n_workflow/
   ```

詳細設置指南請參考 [GITHUB_PAGES_SETUP.md](./GITHUB_PAGES_SETUP.md)

### 本地預覽

```bash
# 使用 Python 簡單 HTTP 服務器
python3 -m http.server 8000

# 或使用 Node.js http-server
npx http-server
```

然後在瀏覽器中訪問 `http://localhost:8000`

## 💻 技術架構

### 核心技術

- **n8n** - 工作流自動化平台
- **Google Gemini** - AI 語言模型
- **LINE Messaging API** - LINE 通訊整合
- **RAG 技術** - 檢索增強生成
- **GitHub Pages** - 靜態網站託管

### 技術特點

- 🔌 **可視化工作流** - 使用 n8n 的拖拽式界面設計流程
- 🤖 **AI 驅動** - 整合多種 AI 模型和服務
- 🔍 **智能路由** - 根據內容自動選擇最適合的處理流程
- 📊 **模組化設計** - 每個功能獨立為子流程，易於維護和擴展
- 🔒 **安全優先** - 使用環境變數管理敏感信息

## 📋 功能概述

### 1. Webhook 入口

- 監聽來自 LINE 的訊息，觸發自動回應流程
- **注意事項**：
  - 確保 Webhook 設定正確，確保 LINE 可發送請求
  - 需要在 LINE Developers Console 設定 Webhook URL

### 2. AI 語言模型處理

- 呼叫 AI 模型（如 Google Gemini）來產生適當回應
- **主要任務**：分析用戶輸入內容，並根據以下邏輯處理：

  **技術相關內容處理**：
  - 判斷標準：包含技術文件、會議記錄、專業討論等內容
  - 處理方式：
    - 如內容包含網址，使用 "HTTP Request" 或 "Jina AI" 工具讀取完整內容
    - 如內容包含 YouTube 網址，使用 "Youtube Transcript" 工具讀取影片逐字稿
    - 一般情況依照「標準輸出模板」格式化回覆
    - 若使用者要求詳細報告，則依照「詳細輸出模板」輸出
    - 內容與技術內容不相關，依照「非技術內容處理」輸出

  **非技術內容處理**：
  - 展現個性化的對話風格

- **注意事項**：
  - 確保 API Key 正確填寫，避免請求失敗
  - 使用環境變數管理 API Keys，不要硬編碼

### 3. 處理 AI 回應

- 解析 AI 產生的回應，取得 `replyToken` 和 `text`
- 自動分段處理超長訊息
- **注意事項**：
  - 確保 AI Agent 輸出的格式正確
  - 若 AI 輸出錯誤，應該在這裡處理錯誤邏輯

### 4. 發送回應給 LINE

- 將處理後的訊息發送回 LINE 用戶
- 支援多則訊息自動分段發送

## 📝 技術內容輸出規範

### 基本要求

- **語言**：繁體中文
- **平台**：LINE 通訊軟體適配
- **字數**：控制在 500 字以內
- **格式**：純文字，避免 Markdown 和 HTML 語法

### 輸出模板

詳細的輸出模板和格式規範請參考 [LINE_CHATBOT.txt](./LINE_CHATBOT.txt)

## 🔒 安全最佳實踐

1. **使用環境變數**：
   ```bash
   # 在 n8n 中設置環境變數
   LINE_CHANNEL_ACCESS_TOKEN=your_token_here
   ```

2. **使用 n8n Credentials**：
   - 在 n8n 中創建 HTTP Header Auth credential
   - 將 Bearer token 存儲在 credential 中

3. **定期更新 Tokens**：
   - 定期在 LINE Developers Console 中重新生成 tokens
   - 撤銷不再使用的舊 tokens

詳細的安全指南請參考 [SECURITY.md](./SECURITY.md)

## 📚 相關文檔

- [SECURITY.md](./SECURITY.md) - 安全指南和最佳實踐
- [DEPLOY.md](./DEPLOY.md) - 部署指南和故障排除
- [GITHUB_PAGES_SETUP.md](./GITHUB_PAGES_SETUP.md) - GitHub Pages 設置指南
- [LINE_CHATBOT.txt](./LINE_CHATBOT.txt) - AI 模型提示詞和輸出規範

## 🛠️ 開發工具

### 腳本工具

- `scripts/remove-tokens.sh` - 批量移除硬編碼的 tokens
- `scripts/clean-git-history.sh` - 清理 Git 歷史中的敏感信息

### 使用方式

```bash
# 移除硬編碼的 tokens
./scripts/remove-tokens.sh

# 清理 Git 歷史（需謹慎操作）
./scripts/clean-git-history.sh
```

## 📄 授權

本專案僅供學習和參考使用。

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

---

**專案網站**：https://poirotw66.github.io/n8n_workflow/  
**GitHub 倉庫**：https://github.com/poirotw66/n8n_workflow
