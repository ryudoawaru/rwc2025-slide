# Claude Code Agents - Quick Reference

Created: 2025-10-20

## 快速使用指南

### 測試 Parser
```
請使用 parser-tester 測試目前的 Parser
```

### 分析 Unicode 問題
```
請使用 unicode-analyzer 分析這段文字: "suà-lo̍h"
```

### 同步文件
```
請使用 doc-syncer 更新文件
```

### 編輯簡報
```
請使用 marp-slide-editor 更新簡報中的成功率為 99.46%
```

---

## Agents 概覽

| Agent | Icon | 用途 | 主要功能 |
|-------|------|------|---------|
| **parser-tester** | 🧪 | 測試 Parser | 執行測試、統計分析、版本比較 |
| **unicode-analyzer** | 🔍 | Unicode 分析 | 字元識別、編碼檢測、頻率分析 |
| **doc-syncer** | 📝 | 文件同步 | 維護一致性、更新版本表、驗證統計 |
| **marp-slide-editor** | 🎨 | 簡報編輯 | 更新內容、管理排版、維護術語 |

---

## 工作流程範例

### 場景 1: 發布新 Parser 版本

1. **開發並測試**
   ```
   [修改 Parser 程式碼]
   請使用 parser-tester 執行完整測試
   ```

2. **更新文件**
   ```
   請使用 doc-syncer 更新 README 和 CLAUDE 的版本記錄
   ```

3. **更新簡報**
   ```
   請使用 marp-slide-editor 更新簡報中的統計數據
   ```

### 場景 2: 調查失敗案例

1. **分析失敗**
   ```
   請使用 parser-tester 分析失敗案例
   ```

2. **檢查 Unicode**
   ```
   請使用 unicode-analyzer 檢查失敗案例中的特殊字元
   ```

3. **修正並重測**
   ```
   [修改 Parser]
   請使用 parser-tester 重新測試
   ```

### 場景 3: 準備演講

1. **驗證統計**
   ```
   請使用 parser-tester 確認最新成功率
   ```

2. **檢查文件一致性**
   ```
   請使用 doc-syncer 驗證所有文件統計一致
   ```

3. **更新簡報**
   ```
   請使用 marp-slide-editor 檢查簡報內容與文件一致
   ```

---

## Agent 能力矩陣

| 功能 | parser-tester | unicode-analyzer | doc-syncer | marp-slide-editor |
|-----|---------------|------------------|------------|-------------------|
| 執行測試 | ✅ | ❌ | ❌ | ❌ |
| 統計分析 | ✅ | ✅ | ❌ | ❌ |
| Unicode 分析 | ❌ | ✅ | ❌ | ❌ |
| 更新文件 | ❌ | ❌ | ✅ | ❌ |
| 編輯簡報 | ❌ | ❌ | ❌ | ✅ |
| 版本比較 | ✅ | ❌ | ✅ | ✅ |
| 程式碼驗證 | ✅ | ❌ | ✅ | ✅ |

---

## 依任務類型選擇 Agent

### 開發任務
- 修改 Parser → **parser-tester**
- 新增 Unicode 支援 → **unicode-analyzer**
- 調查 bug → **parser-tester** + **unicode-analyzer**

### 文件任務
- 發布版本 → **doc-syncer**
- 修正不一致 → **doc-syncer**
- 更新統計 → **doc-syncer**

### 簡報任務
- 更新內容 → **marp-slide-editor**
- 調整排版 → **marp-slide-editor**
- 同步程式碼 → **marp-slide-editor**

### 品質保證
- 回歸測試 → **parser-tester**
- 文件審查 → **doc-syncer**
- 簡報檢查 → **marp-slide-editor**

---

## Agent 特色功能

### parser-tester 🧪
- **自動分類失敗案例**：按錯誤類型分組
- **基準比較**：與 V5 (99.46%) 自動比較
- **專業報告**：結構化的測試報告

### unicode-analyzer 🔍
- **完整字元分解**：顯示每個字元的 Unicode 資訊
- **編碼診斷**：檢測 precomposed vs combining
- **覆蓋率分析**：報告使用的 Unicode 範圍

### doc-syncer 📝
- **雙向同步**：README ↔ CLAUDE
- **統計驗證**：自動檢查數字一致性
- **程式碼追蹤**：確保範例與實作一致

### marp-slide-editor 🎨
- **術語管理**：維護日文技術術語庫
- **排版優化**：自動建議 scale classes
- **時間控制**：追蹤 15 分鐘演講時間

---

## 最佳實踐

1. **修改 Parser 後**
   - ✅ 先用 sample data 快速測試
   - ✅ 成功後再跑完整測試
   - ✅ 確認沒有 regression

2. **遇到新 Unicode 字元**
   - ✅ 先用 unicode-analyzer 分析
   - ✅ 檢查是否在支援範圍
   - ✅ 更新 Parser 規則

3. **發布新版本**
   - ✅ 完整測試
   - ✅ 更新所有文件
   - ✅ 同步簡報
   - ✅ 驗證一致性

4. **準備演講**
   - ✅ 確認統計最新
   - ✅ 測試簡報預覽
   - ✅ 檢查排版
   - ✅ 驗證 speaker notes

---

## 故障排除

### Agent 沒有回應
- 確認使用正確的 agent 名稱
- 檢查請求是否清楚
- 嘗試重新表述請求

### 測試結果不符預期
- 確認測試資料未被修改
- 檢查 Parser 程式碼版本
- 重新執行測試

### 文件同步錯誤
- 手動檢查兩個檔案
- 確認版本號正確
- 驗證統計計算

### 簡報排版問題
- 檢查 scale class
- 預覽實際效果
- 考慮分割投影片

---

## 版本記錄

- **2025-10-20**: 建立 4 個基礎 agents
  - parser-tester: 測試與分析
  - unicode-analyzer: Unicode 診斷
  - doc-syncer: 文件同步
  - marp-slide-editor: 簡報編輯

---

## 相關資源

- **詳細規格**: 查看各 agent 的 `.md` 檔案
- **使用範例**: 參考 `README.md`
- **專案文件**: `../README.md`, `../CLAUDE.md`
- **簡報檔案**: `../rubyworld-2025-taigi-parser.md`
