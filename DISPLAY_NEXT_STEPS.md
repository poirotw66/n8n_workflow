# n8n 專案展示 – 下一步建議

此文件列出可進一步提升 **n8n 專案展示頁** 的具體做法，依優先順序與難度整理。

---

## 已完成的調整（本次）

- **主流程圖**：主流程（LINE Chatbot System）已加上圖片 `image/[MAIN]LINE CHATBOT.png`，並支援點擊放大。
- **頂部導覽**：新增簡潔 header（標題「n8n Workflow Portfolio」+ 語系切換按鈕 EN/繁中）。
- **SEO / 分享**：在 `<head>` 加入 `description`、Open Graph、Twitter Card 等 meta，方便搜尋與社群分享。

---

## 建議下一步（由你決定順序）

### 1. 確認主流程圖檔案存在

- 若尚未匯出主流程圖，請在 n8n 編輯器中開啟 **[MAIN] LINE CHATBOT**，截圖或匯出為 PNG。
- 將檔案命名為 `[MAIN]LINE CHATBOT.png`，放在專案根目錄的 `image/` 資料夾。
- 若檔名或路徑不同，請同步修改 `index.html` 中主流程區塊的 `src` 與 `onclick` 路徑。

### 2. 設定分享預覽圖（og:image）

- 在 `index.html` 的 `<head>` 中可加入（請改為你的實際網址）：

```html
<meta property="og:image" content="https://poirotw66.github.io/n8n_workflow/image/[MAIN]LINE%20CHATBOT.png">
<meta name="twitter:image" content="https://poirotw66.github.io/n8n_workflow/image/[MAIN]LINE%20CHATBOT.png">
```

- 這樣在 LINE、Facebook、Twitter、LinkedIn 等分享連結時，會顯示該流程圖為預覽圖。
- 若倉庫網址是 `n8n_workflow-1`，請將上述 URL 改成對應的 GitHub Pages 網址。

### 3. 每個專案卡片加上「匯入工作流」連結

- 在 `LINEBOT/` 與 `n8n_courses/` 已有對應的 JSON，可在每張卡片下方加一個小按鈕或連結：
  - 文案例如：「匯入至 n8n」或「Download workflow (JSON)」
  - 連結到該工作流的 JSON 檔（例如 GitHub raw 或相對路徑）。
- 範例（需依實際路徑與檔名調整）：

```html
<a href="LINEBOT/[MAIN]LINE%20CHATBOT.json" download class="text-accent text-sm hover:underline">Download workflow (JSON)</a>
```

- 若部署在 GitHub Pages，可改用 raw 連結讓別人一鍵複製或下載。

### 4. 在 README 強調展示頁

- 在 README 最上方或「專案結構」前，保留或加一段「線上展示」：
  - 例如：**GitHub Pages**：`https://poirotw66.github.io/n8n_workflow/`
- 方便面試、履歷或對外分享時直接點開。

### 5. 響應式與無障礙檢查

- 用手機、平板實際打開展示頁，確認：
  - 標題、卡片、圖片不會跑版。
  - 語系按鈕、燈箱關閉按鈕容易點擊。
- 若需要，可為重要圖片補上清楚的 `alt` 文字（部分已具備，可整體檢查一遍）。

### 6. 可選：加上簡單數據或情境說明

- 在精選專案或課程區塊的副標題旁，可加一兩句情境說明，例如：
  - 「適用情境：客服機器人、內部知識庫問答、報價單自動化」等。
- 若有實際上線數據（例如每日處理訊息量、節省工時），可簡短寫在該專案描述中，提升說服力。

### 7. 部署與持續更新

- 確認 GitHub Actions 的 `deploy.yml` 已啟用，且 **Settings > Pages** 來源為 **GitHub Actions**。
- 之後每次更新 `index.html`、`image/` 或 `LINEBOT/` 後 push 到 main，就會自動更新展示站。

---

## 小結

| 項目               | 狀態／建議 |
|--------------------|------------|
| 主流程圖           | 已接上 HTML，請確認 `image/[MAIN]LINE CHATBOT.png` 存在 |
| 頂部標題與語系     | 已完成     |
| SEO / 分享 meta   | 已完成，可補上 og:image 與 twitter:image |
| 匯入工作流連結     | 建議在卡片上加上 JSON 下載或 raw 連結 |
| README 展示連結   | 建議保留並置頂 |
| 響應式／無障礙     | 建議手動測一次 |
| 部署               | 確認 Pages 與 Actions 設定即可 |

依上述步驟逐項完成，展示頁的完整度與專業度會明顯提升；若要再進階，可考慮為每個工作流寫一頁簡短說明（例如用 GitHub Wiki 或 repo 內 `docs/`）。
