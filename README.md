# 5xRuby Marp Theme

基於 5xRuby 企業網站設計風格的 Marp 簡報主題。

## 設計特色

- **品牌色彩**：使用 5xRuby 標誌性的紅色 (#D32C25)
- **專業字體**：Barlow Semi Condensed
- **灰階調色盤**：從深灰到淺灰的完整色階
- **現代設計**：簡潔、專業、易讀

## 安裝與使用

### 1. 安裝 Marp CLI

```bash
npm install -g @marp-team/marp-cli
```

### 2. 使用主題

在你的 Markdown 檔案開頭加入：

```yaml
---
marp: true
theme: 5xruby
paginate: true
header: 'Your Header Text'
---
```

### 3. 產生簡報

```bash
# 產生 HTML
marp --theme themes/5xruby.css your-slides.md

# 產生 PDF
marp --theme themes/5xruby.css --pdf your-slides.md

# 產生 PPTX
marp --theme themes/5xruby.css --pptx your-slides.md
```

## 版面類別

### `lead` - 首頁/封面頁

置中顯示，適合標題頁。

```markdown
<!-- _class: lead -->

# 簡報標題
副標題或說明文字
```

### `invert` - 深色版面

深色背景，淺色文字。

```markdown
<!-- _class: invert -->

## 深色版面
內容...
```

### `highlight` - 強調版面

紅色漸層背景，適合重點訊息。

```markdown
<!-- _class: highlight -->

## 重要訊息
內容...
```

### `center` - 垂直置中

內容垂直置中對齊。

```markdown
<!-- _class: center -->

## 置中內容
```

### `columns` - 兩欄版面

左右兩欄排版。

```markdown
<!-- _class: columns -->

## 兩欄標題

### 左欄
內容...

### 右欄
內容...
```

## 顏色變數

主題使用以下 CSS 變數：

```css
--color-primary: #d32c25      /* 5xRuby 紅色 */
--color-gray-850: #272727     /* 深灰 */
--color-gray-500: #8b8b8b     /* 中灰 */
--color-gray-250: #dedede     /* 淺灰 */
--color-gray-150: #efefef     /* 極淺灰 */
```

## 文字格式

- **粗體文字** → 紅色強調
- *斜體文字* → 灰色
- [連結](url) → 紅色底線
- `程式碼` → 灰色背景

## 語法高亮

主題內建完整的語法高亮支援，支援多種程式語言：

````markdown
```ruby
class Developer
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello from #{@name}!"
  end
end
```

```javascript
const greeting = (name) => {
  console.log(`Hello from ${name}!`);
};
```

```python
def greet(name):
    print(f"Hello from {name}!")
```
````

### 語法高亮色彩

- **關鍵字** (def, class, function) → 紅色 (#d32c25)
- **字串** → 綠色 (#50a14f)
- **數字** → 橘色 (#c18401)
- **函式** → 藍色 (#4078f2)
- **類別/型別** → 紫色 (#a626a4)
- **註解** → 灰色斜體 (#8b8b8b)

### 注意事項

Marp 使用 **Shiki/Highlight.js** 進行語法高亮（不是 PrismJS），但本主題已針對常見語法元素設計完整的顏色配置，確保程式碼清晰易讀。

## 範例

查看 `5xruby-demo.md` 以了解完整功能展示。

## 授權

MIT License

## RomanParserPure - 教學用純 Parser 實作

本專案包含用於 **RubyWorld Conference 2025** 演講的實驗性 POJ (台羅拼音) Parser 實作。

### 目的

展示如何將 Compiler 理論（Lexical Analysis → Syntax Analysis → Semantic Analysis）應用於自然語言處理。

### 實作特色

- **Phase 1: Lexical Analysis** - 使用 Parslet 定義 token 規則
- **Phase 2: Syntax Analysis** - 建立 AST（Abstract Syntax Tree）
- **Phase 3: Semantic Analysis** - 驗證與轉換

### 測試結果

| 版本 | 實作方式 | 測試結果 (64,554 筆) | 成功率 |
|------|----------|---------------------|--------|
| V1 | 基礎實作 | 63,481/64,554 | 98.34% |
| V2 | 加入 Latin Extended Additional | 63,516/64,554 | 98.39% |
| V3 | 修正 Curly Quotes (Unicode escapes) | 64,191/64,554 | 99.44% |
| V4 | str() → match[] 優化 | 64,191/64,554 | 99.44% |
| V5 | 加入 prefix_hyphen_word 規則 | 64,208/64,554 | 99.46% |
| V6 | 完整 Unicode 範圍支援 | 64,476/64,554 | 99.88% |
| V7 | 邊緣案例處理（double-hyphen, underscore, angle brackets） | 64,548/64,554 | 99.99% |
| **V8** | **完美解析（zero-width space, combining U+0358, isolated hyphen, plus sign）** | **64,554/64,554** | **100.00%** |

### V4 重點優化 (2025-10-20)

將標點符號規則從 `str()` 串聯改為 `match[]` 字元集合：

```ruby
# 修改前 - 使用 str() 串聯 (14 行)
rule(:punctuation) do
  str('...') | str('⋯⋯') | str('……') |
  str(',') | str('.') | str('!') | str('?') |
  str('？') | str('！') |
  # ... 等等
end

# 修改後 - 使用 match[] 分類 (6 行)
rule(:punctuation) do
  str('...') | str('⋯⋯') | str('……') |  # Multi-char first
  match[',.:;()!?？！/~、─…⋯'] |  # Single-char punctuation
  match["\"'\u201C\u201D\u2018\u2019"] |  # Quotes (ASCII and curly)
  match['「」『』']  # CJK quotes
end
```

**優勢**：
- ✅ 更符合 Parslet 慣例
- ✅ 程式碼更簡潔（14 行 → 6 行）
- ✅ 語意更清楚（按功能分類）
- ✅ 維持 99.44% 成功率
- ✅ 更適合教學展示

### V5 重點優化 (2025-10-20)

新增 `prefix_hyphen_word` 規則處理括號內前置連字符：

```ruby
# 新增規則 - 前置連字符詞
rule(:prefix_hyphen_word) do
  single_hyphen >> syllable
end

# Token 優先順序調整
rule(:token) do
  prefix_hyphen_word.as(:word) |  # 🆕 優先匹配（更具體）
  hyphenated_word.as(:word) |
  number.as(:num) |
  punctuation.as(:punct)
end
```

**解決的問題**：
- ✅ 成功 parse `(-pha)` → `["(", "-pha", ")"]`
- ✅ 保持 `-pha` 為單一 token（符合 CorporaArraySettable 邏輯）
- ✅ 不破壞漢字對齊關係

**優勢**：
- ✅ 成功率提升至 99.46%（64,208/64,554）
- ✅ Parse 錯誤減少至 0.32%（205 個）
- ✅ 新增 17 個成功案例
- ✅ 符合台羅拼音語意結構
- ✅ 與原始系統行為一致

### V6 重點優化 (2025-10-20)

大幅擴展 Unicode 範圍支援，處理所有語料庫中出現的特殊字元：

```ruby
# 擴展 letter 定義
rule(:letter) do
  unicode_letter |
  (ascii_letter >> combining_mark.repeat) |
  ascii_letter |
  modifier_letter |  # 🆕 ˇ ˋ (U+02C0-02FF)
  superscript        # 🆕 ⁿ (U+2070-209F)
end

# 擴展 punctuation 定義
rule(:punctuation) do
  str('...') | str('⋯⋯') | str('……') |
  match[',.:;()!?？！/~、─…⋯\u2027%'] |  # 🆕 添加 % 和 ‧
  match["\"'\u201C\u201D\u2018\u2019"] |
  match['\u3000-\u303F'] |  # 🆕 完整 CJK 符號範圍（含。【】等）
  match['\uFF01-\uFF5E'] |  # 🆕 全形 ASCII 變體（％（）－等）
  match['\u2014'] |          # Em dash
  match['\u2600-\u26FF']     # 🆕 雜項符號（☐ 等）
end

# 新增特殊 token 類型
rule(:bopomofo) { match['\u3105-\u312F'].repeat(1) }  # 🆕 ㄅㄆㄇㄈ
rule(:cjk_char) { match['\u4E00-\u9FFF'] }            # 🆕 漢字
```

**新增支援的字元類型**：

1. **注音符號相關**
   - Bopomofo (ㄅㄆㄇㄈ) - 作為獨立 token
   - 聲調符號 (ˇ ˋ) - Spacing Modifier Letters

2. **CJK 標點符號**
   - 句號（。）、頓號（、）、空格（　）
   - 括號（【】）完整範圍

3. **全形符號**
   - 全形標點（！％（）－／等）
   - 涵蓋 U+FF01-FF5E 範圍

4. **特殊符號**
   - 方框（☐）- Ballot box
   - 上標（ⁿ）- Superscript n
   - 間隔點（‧）- Hyphenation point

5. **混合文本**
   - 漢字 token 處理（當 POJ 中混入漢字時）

**優勢**：
- ✅ 成功率大幅提升至 **99.88%**（64,476/64,554）
- ✅ Parse 錯誤大幅減少至 **0.12%**（78 個）
- ✅ 比 V5 新增 **268** 個成功案例
- ✅ 涵蓋所有常見 Unicode 字元範圍
- ✅ 支援完整台羅拼音語料庫字元集

**改進幅度**：
- V5 → V6: +0.42% 成功率
- Parse errors: 205 → 78（減少 62%）

### V7 重點優化 (2025-10-20)

針對 V6 剩餘的 78 個錯誤進行深入分析，發現主要集中在三種模式：

#### 問題分析

1. **Double-hyphen after quotes (59 cases - 76%)**
   - Pattern: `"phrase"--word`
   - Example: `"tsia̍h-kín lòng-phuà uánn"--ooh!`
   - 引號後直接接 `--` 再接詞，無空格

2. **Underscore placeholders (9 cases - 11.5%)**
   - Pattern: `lán_`
   - Meaning: `咱__`（佔位符）
   - 表示文本中的空白位置

3. **Other special characters**
   - Angle brackets: `< lâng kah sai >`
   - Leading spaces in quotes: `" tāi it kok-bûn "`

#### 解決方案

新增三種特殊 token 規則：

```ruby
# Double-hyphen word: starts with double hyphen
rule(:double_hyphen_word) do
  double_hyphen >> syllable >>
  (single_hyphen >> syllable | single_hyphen).repeat
end

# Underscore placeholder: word with trailing underscore
rule(:underscore_word) do
  syllable >> underscore
end

# Angle brackets support
rule(:punctuation) do
  # ... existing patterns ...
  match[',.:;()!?？！/~、─…⋯\u2027%<>'] |  # Added <>
  # ...
end

# Token priority (most specific first)
rule(:token) do
  double_hyphen_word.as(:word) |  # Try double-hyphen first
  prefix_hyphen_word.as(:word) |
  underscore_word.as(:word) |
  hyphenated_word.as(:word) |
  # ...
end
```

**優勢**：
- ✅ 成功率突破至 **99.99%**（64,548/64,554）
- ✅ Parse 錯誤降至 **0.01%**（6 個）
- ✅ 比 V6 新增 **72** 個成功案例
- ✅ 錯誤減少 **92.3%**（78 → 6）
- ✅ 接近完美的解析準確度

**改進幅度**：
- V6 → V7: +0.11% 成功率
- Parse errors: 78 → 6（減少 92.3%）

**剩餘 6 個極端邊緣案例**：
1. ASCII hyphen vs Em dash (—) 混用 - ID 96824
2. Zero-width space (U+200B) 開頭 - ID 101361
3. Combining character U+0358（特殊聲調符號）- ID 101568, 101572
4. Plus sign (+) 未支援 - ID 106448
5. 特殊表情符號 `^Q^` - ID 116361

這些案例占比僅 **0.01%**，V7 認為屬於資料品質問題。但經過分析後發現全部都是技術上可行且合理的語言現象。

### V8 重點優化 (2025-10-20)

用戶提出挑戰：「剩下這6筆還有可能處理嗎？」

經過詳細可行性分析，發現所有 6 個案例都是技術上可行的：

#### 問題與解決方案

1. **Zero-width space (U+200B) - ID 101361**
   - 問題：不可見字元在句首
   - 解決：將 U+200B 加入 `space?` 定義
   ```ruby
   rule(:zero_width_space) { match['\u200B'] }
   rule(:space?) { (zero_width_space | match['\s']).repeat }
   ```

2. **Combining character U+0358 - ID 101568, 101572**
   - 問題：`khò͘` 使用的 Combining Dot Above Right 不在 U+0300-036F 範圍
   - 解決：擴展 combining_mark 並修正 letter 定義順序
   ```ruby
   rule(:combining_mark) { match['\u0300-\u036F'] | match['\u0358'] }

   rule(:letter) do
     (unicode_letter >> combining_mark.repeat) |  # 允許 precomposed letter 附加 combining
     (ascii_letter >> combining_mark.repeat) |
     unicode_letter |
     ascii_letter |
     # ...
   end
   ```

3. **Caret (^) 表情符號 - ID 116361**
   - 問題：`^Q^` 笑臉表情中的 `^` 未定義
   - 解決：將 `^` 加入 punctuation

4. **Plus sign (+) - ID 106448**
   - 問題：`"Kong-sī + tshit"` 中的 `+` 未支援
   - 解決：將 `+` 加入 punctuation

5. **Isolated hyphen (em dash intent) - ID 96824**
   - 問題：`bó-gú - Tâi-uân-uē` 中單獨的 `-` 無法匹配
   - 解決：將 `-` 加入 punctuation（作為 token 之間的獨立符號）
   ```ruby
   match[',.:;()!?？！/~、─…⋯\u2027%<>^+-']  # 加入 + 和 -
   ```

**優勢**：
- ✅ 達成 **100.00% 完美解析**（64,554/64,554）
- ✅ **零錯誤率**（0 errors）
- ✅ 所有「資料品質問題」實為合理的語言現象
- ✅ Parser 具備完整的 POJ 語料庫處理能力

**改進幅度**：
- V7 → V8: +0.01% 成功率（但更重要的是：6 → 0 errors）
- Parse errors: 6 → 0（減少 100%）

**技術洞察**：
- 原本認為是「資料品質問題」的案例，實際上都是合理且可解決的
- Zero-width space 在文本編輯中常見（複製貼上產生）
- U+0358 是合法的 Unicode combining character
- 單獨 hyphen 作為 em dash 的替代在打字輸入中很常見
- `+` 在數學表達式中是必要的標點

**結論**：V8 證明了透過細緻的 Unicode 字元分析和優先順序設計，可以達到 100% 的完美解析準確度。

### 檔案位置

- `experimental/roman_parser_pure.rb` - 主要實作
- `test_pure_with_stats.rb` - 測試腳本
- `test_data/corpora_data_new.json` - 完整測試資料 (64,554 筆)

### 執行測試

```bash
# 測試範例資料（預設，約 3,000 筆）
ruby test_parser.rb

# 或指定測試檔案
ruby test_parser.rb test_data/sample_data.json

# 測試完整 64,554 筆資料
ruby test_parser.rb test_data/corpora_data_new.json
```

**測試腳本特色**：
- 進度條顯示（█ 和 ░ 視覺效果）
- 即時百分比更新
- 最終統計結果
- 錯誤案例顯示（如有）
- 100% 成功時顯示慶祝訊息

### 相關文件

詳細開發歷程請參考 `CLAUDE.md` 中的「Parser 開發歷程記錄」段落。

---

## 關於 5xRuby

5xRuby 是台灣專業的 Ruby on Rails 開發團隊。

- 網站：https://5xruby.com
- GitHub：https://github.com/5xRuby
