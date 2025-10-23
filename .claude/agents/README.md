# Claude Code Agents

這個目錄包含專門的 Claude Code agents，用於協助 RomanParserPure 開發。

## Available Agents

### 🧪 parser-tester
**用途**: 測試 Parser 並分析結果

**主要功能**:
- 執行 Parser 測試（sample/full data）
- 統計成功率和失敗案例
- 分析失敗模式
- 版本比較

**何時使用**:
- 修改 Parser 規則後需要測試
- 想了解失敗案例的模式
- 比較不同版本的效能
- 驗證新功能是否破壞現有行為

**使用範例**:
```
請使用 parser-tester 測試目前的 Parser
請分析為什麼還有 205 個失敗案例
請比較 V4 和 V5 的改進
```

### 🔍 unicode-analyzer
**用途**: 分析 Unicode 字元和編碼問題

**主要功能**:
- 識別文字中的所有 Unicode 字元
- 顯示 Unicode codepoints (U+XXXX)
- 檢測字元編碼問題
- 分析字元頻率分布

**何時使用**:
- Parser 遇到特殊字元無法處理
- 需要了解 POJ 使用的 Unicode 範圍
- 調查編碼相關的 bug
- 檢查 precomposed vs combining forms

**使用範例**:
```
請使用 unicode-analyzer 分析這段文字的字元
為什麼 ō 和 o̍ 看起來不同？
請檢查失敗案例中的特殊字元
```

### 📝 doc-syncer
**用途**: 維護文件一致性

**主要功能**:
- 同步 README.md 和 CLAUDE.md
- 更新版本記錄表
- 驗證統計數據一致性
- 檢查程式碼範例準確性

**何時使用**:
- 發布新 Parser 版本後
- 發現文件中的不一致
- 更新測試結果統計
- 修改實作後需要同步文件

**使用範例**:
```
請使用 doc-syncer 更新 V5 的文件
請檢查 README 和 CLAUDE 的版本表是否一致
請同步最新的測試結果
```

### 🎨 marp-slide-editor
**用途**: 編輯 Marp 簡報

**主要功能**:
- 更新投影片內容和程式碼範例
- 維護日文技術術語正確性
- 管理版面配置（scale classes）
- 更新 speaker notes

**何時使用**:
- 需要更新簡報中的統計數據
- Parser 實作改變需要同步簡報
- 調整投影片排版避免溢出
- 修改或新增投影片內容

**使用範例**:
```
請使用 marp-slide-editor 更新簡報中的成功率
請把 V5 的新規則加到簡報中
第 23 頁內容溢出到 footer，請修正
```

## 如何使用 Agents

### 方法 1: 在對話中請求
```
請使用 parser-tester 測試 Parser
```

Claude Code 會自動載入 agent 的規格並執行。

### 方法 2: 使用 Task tool
如果你看到 Claude 使用 Task tool 時，它會自動選擇適合的 agent。

## Agent 規格格式

每個 agent 都有以下結構：

- **Role**: Agent 的角色定義
- **Responsibilities**: 主要職責
- **Available Tools**: 可用的工具
- **Key Files**: 相關的檔案
- **Typical Workflows**: 常見工作流程
- **Output Format**: 輸出格式規範
- **Error Handling**: 錯誤處理指南

## 未來可能的 Agents

### ⚖️ code-comparator (規劃中)
比較 Parser 與原始系統的行為差異

**用途**: 驗證 Parser 行為與 CorporaArraySettable 一致性
**功能**: 並行測試、比較 token arrays、生成相容性報告

## 貢獻指南

如果要新增 agent：

1. 在此目錄建立 `<agent-name>.md`
2. 遵循現有的規格格式
3. 更新此 README
4. 測試 agent 是否正常運作

## 相關資源

- **Parser 實作**: `experimental/roman_parser_pure.rb`
- **測試腳本**: `test_pure_with_stats.rb`, `analyze_failures.rb`
- **開發歷程**: `CLAUDE.md` - Parser 開發歷程記錄
- **專案文件**: `README.md`
