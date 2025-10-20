# WASHING_PATTERNS 轉換成 Parslet 規則可行性分析

## 執行摘要

**結論：不建議將所有 WASHING_PATTERNS 轉換為 Parslet 規則**

原因：
1. 54 個模式中，約 40% 是**語意層正規化**，必須在 Transform 階段處理
2. PEG 文法無法表達**否定前瞻/後顧** (negative lookahead/lookbehind)
3. 目前架構（Parser + Transform）已經是正確的分工方式
4. 強行轉換會讓 Parser 過度複雜，失去可讀性

## 分類統計

```
總計: 54 個模式

【punctuation_spacing】: 29 個 (53.7%)
  - 標點符號前後加空格
  - 例：/(.)(",)(.)/ => '\1 \2 \3'

【quote_handling】: 9 個 (16.7%)
  - 引號處理
  - 例：/''/ => "'"

【period_spacing】: 9 個 (16.7%)
  - 句點處理
  - 例：/(\.)([^\.])/ => '\1 \2'

【space_normalization】: 3 個 (5.6%)
  - 空格正規化
  - 例：/\s{2,}/ => ' '

【other】: 4 個 (7.4%)
  - 其他特殊處理
```

## 可轉換性分析

### 🔴 無法轉換為 Parslet 規則 (Semantic Level - 必須保留在 Transform)

#### 1. Space Normalization (3 patterns)
```ruby
/\s{2,}/ => ' '           # 多個空格壓縮為一個
/─\s+?─/ => '──'          # 連字符之間的空格移除
/\(\s([a-zA-Z0-9]+)\s\)/ => '(\1)'  # 括號內空格移除
```

**原因**: 這些是**正規化處理**，屬於語意層操作。Parser 應該保留原始結構，normalization 在 Transform 階段進行。

#### 2. Negative Lookahead/Lookbehind (約 15+ patterns)
```ruby
/(\.)([^\.])/ => '\1 \2'      # 句點後面「不是」句點時加空格
/([^\.])(\.)/ => '\1 \2'      # 句點前面「不是」句點時加空格
/([^\.])(\.\.\.)\s/ => '\1 \2 '  # 前面「不是」句點的刪節號
/(\"")([^\""])/ => '\1 \2'    # 引號後面「不是」引號時加空格
```

**原因**: PEG 文法無法表達「不是 X」的條件（negative lookahead/lookbehind）。這是正則表達式的優勢。

#### 3. Position-dependent Patterns (約 10+ patterns)
```ruby
/^"/ => '" '              # 開頭的引號
/'$/ => ' ''              # 結尾的引號
/^([\(_+=\:;"'~`""\\」「\?!])/ => '\1 '  # 開頭的標點
/([\)_+=\:;"'~`""\\」「\?!])$/ => ' \1'  # 結尾的標點
```

**原因**: 雖然 Parslet 可以用 `str()` 在句首/句尾匹配，但這些模式是在**已經 tokenize 之後**才套用的正規化規則，不是解析階段的規則。

### 🟡 部分可轉換 (Lexical/Syntax Level - 可考慮)

#### 1. Punctuation Spacing (約 20 patterns)
```ruby
/(.)(,)(.)/ => '\1 \2 \3'  # 逗號前後加空格
/(.)(:)(.)/ => '\1 \2 \3'  # 冒號前後加空格
/(.)(~)(.)/ => '\1 \2 \3'  # 波浪號前後加空格
```

**可能做法**: 在 Parser 階段就把這些標點視為獨立 token
```ruby
rule(:comma) { str(',').as(:punct) >> spaces? }
rule(:colon) { str(':').as(:punct) >> spaces? }
```

**但是**: 這會讓 Parser 規則爆炸（需要為每個標點寫規則），而且這些「加空格」本質上是**格式化**，不是**解析**。

#### 2. Quote Normalization (部分)
```ruby
/''/ => "'"  # 兩個單引號變一個
```

**可能做法**: 在 Lexer 階段就識別並合併
```ruby
rule(:double_quote) { str("''").as(:single_quote) }
```

**但是**: 這是**正規化**而非**解析**，應該在 Transform 處理。

### 🟢 已經在 Parser 中處理 (Current Implementation)

```ruby
# 目前 Parser 已經處理的：
rule(:punctuation) do
  str(',') | str('.') | str('!') | str('?') |
  str(';') | str(':') | str('"') | str("'") |
  str("\u201C") | str("\u201D") | str("\u2018") | str("\u2019")  # Smart quotes
end

rule(:sentence) do
  spaces? >>
  token >>
  (spaces? >> token).repeat >>  # 空格分隔
  spaces?
end
```

這些已經在做：
- 識別標點符號為獨立 token
- 處理 token 之間的空格
- 支援智慧引號

## 建議方案

### ✅ 推薦：保持目前的 3-Phase 架構

```ruby
# Phase 1: Lexical Analysis (Parser 負責)
# - 識別 words, numbers, punctuation
# - 處理連字符、tone marks
# - Tokenization

# Phase 2: Syntax Analysis (Parser 負責)
# - 建立 AST
# - 確認 token 順序

# Phase 3: Semantic Analysis (Transform 負責)
# - 套用 WASHING_PATTERNS
# - 正規化空格、標點
# - 格式化輸出
```

**目前實作**:
```ruby
rule(sentence: sequence(:tokens)) do
  WASHING_PATTERNS.reduce(tokens.join(' ')) do |result, (pattern, replacement)|
    result.gsub(pattern, replacement)
  end.split(/\s/).compact
end
```

這個架構是**正確的**！Parser 專注於**結構化**（tokenization），Transform 專注於**正規化**（washing）。

### ❌ 不推薦：強行轉換所有 Patterns 為 Parslet 規則

如果要這樣做，你會需要：

```ruby
# 為每個標點寫規則
rule(:comma_with_space) { str(',') >> spaces? }
rule(:period_with_space) { str('.').absent?(str('..')) >> spaces? }  # 但這個做不到！
rule(:ellipsis) { str('...') >> spaces? }

# 為每個引號組合寫規則
rule(:open_quote) { str('"') >> spaces? }
rule(:close_quote) { spaces? >> str('"') }

# 處理所有邊界情況
rule(:sentence) do
  start_punct.maybe >>
  word_or_number >>
  (
    comma_with_space | period_with_space | colon_with_space |
    # ... 需要列舉所有可能的組合
  ).repeat >>
  end_punct.maybe
end
```

問題：
1. **複雜度爆炸**：需要數百行規則
2. **無法表達否定條件**：PEG 做不到「前面不是句點」
3. **失去彈性**：新增一個標點就要改 Parser
4. **違反關注點分離**：Parser 不應該負責格式化

## 目前問題的真正原因

目前 99.85% fallback 的原因**不是** WASHING_PATTERNS 的問題，而是：

### 問題：Combining Diacriticals 在字母之間

```
文字: "tsi̍t"
實際編碼: t-s-i-̍-t (combining mark 在 i 和 t 之間)

目前 Parser 假設: letter+ diacriticals*
實際需要: (letter diacriticals?)+
```

**解決方案**：修改 `roman_word` 規則

```ruby
# 目前（錯誤）
rule(:roman_word) do
  (
    letter.repeat(1) >>
    (hyphen.absent? >> match['\u0300-\u036F']).repeat >>  # 假設 tone marks 在最後
    (hyphen >> ...).repeat
  ).as(:word)
end

# 應該改為
rule(:roman_word) do
  (
    (letter >> match['\u0300-\u036F'].repeat).repeat(1) >>  # 每個字母後都可能有 tone mark
    (hyphen >> (letter >> match['\u0300-\u036F'].repeat).repeat(1)).repeat
  ).as(:word)
end
```

## 結論與建議

### 1. ✅ 保持 WASHING_PATTERNS 在 Transform 階段
- 這是正確的架構設計
- 符合編譯器理論的 3-phase 分離
- 正則表達式比 PEG 更適合表達這些 normalization 規則

### 2. ✅ 修正 Parser 的 Combining Diacriticals 處理
```ruby
rule(:letter_with_tone) do
  letter >> match['\u0300-\u036F'].repeat
end

rule(:roman_word) do
  (
    letter_with_tone.repeat(1) >>
    (hyphen >> letter_with_tone.repeat(1)).repeat
  ).as(:word)
end
```

### 3. ✅ 簡化 WASHING_PATTERNS（可選）
如果覺得 54 個 patterns 太多，可以分類整理：

```ruby
SPACE_AROUND_PUNCT = [
  [/(.)(,)(.)/, '\1 \2 \3'],
  [/(.)(;)(.)/, '\1 \2 \3'],
  # ...
].freeze

NORMALIZE_QUOTES = [
  [/''/, "'"],
  [/""/, '"'],
  # ...
].freeze

WASHING_PATTERNS = [
  *SPACE_AROUND_PUNCT,
  *NORMALIZE_QUOTES,
  # ...
].freeze
```

### 4. ✅ RubyWorld Conference 2025 簡報重點

**正確的訊息**：
> "Parser 專注於結構化（Tokenization），Transform 專注於正規化（Washing）。
> 這是編譯器理論的 3-phase 分離原則，也是 Ruby Parser 的做法。
> 不是所有問題都該用 Parser 解決 — 選擇合適的工具才是關鍵。"

**展示重點**：
1. Lexical Analysis: 識別 words, numbers, punctuation
2. Syntax Analysis: 建立 token sequence (AST)
3. Semantic Analysis: 套用 WASHING_PATTERNS 正規化

**不要強調**：
- 不要說「Parser 可以處理所有 WASHING_PATTERNS」（這是錯的）
- 不要過度複雜化 Parser（違反設計原則）

## 附錄：Pattern 詳細分類

### Punctuation Spacing (29 個)
```ruby
/(.)([_+=\:;"'~`""\\」「\?!])(.)/ => '\1 \2 \3'
/(.)(,)(.)/ => '\1 \2 \3'
/(.)(~)(.)/ => '\1 \2 \3'
/(.)(')(.)/  => '\1 \2 \3'
/(.)(")(.)/ => '\1 \2 \3'
/(.)(」)(.)/ => '\1 \2 \3'
/(.)(「)(.)/ => '\1 \2 \3'
/(.)(⋯⋯)/ => '\1 \2'
/(⋯⋯)(.)/ => '\1 \2'
/(.)(……)/ => '\1 \2'
/(……)(.)/ => '\1 \2'
/(.)(！)/ => '\1 \2'
/(！)(.)/ => '\1 \2'
/(.)(？)/ => '\1 \2'
/(？)(.)/ => '\1 \2'
/(.)(－)/ => '\1 \2'
/(－)(.)/ => '\1 \2'
# ... 等
```

### Quote Handling (9 個)
```ruby
/''/ => "'"
/(.)([_+=\:;"'~`""\\」「\?!])(.)/ => '\1 \2 \3'
/^([\(_+=\:;"'~`""\\」「\?!])/ => '\1 '
/([\)_+=\:;"'~`""\\」「\?!])$/ => ' \1'
/(")([^"])/ => '\1 \2'
/^"/ => '" '
/^'/ => '' '
/'$/ => ' ''
/"$/ => ' "'
```

### Period Spacing (9 個)
```ruby
/(\.)([^\.])/ => '\1 \2'
/([^\.])(\.)/ => '\1 \2'
/\s\.\s\.\s\.$/ => ' ...'
'. ..' => '...'
'.. .' => '...'
/([^\.])(\.\.\.)\s/ => '\1 \2 '
/([^\.])(\.)([^\.])/ => '\1 \2 \3'
/([^\.])(\.\.\.)/ => '\1 \2'
/(\.\.\.)([^\.])/ => '\1 \2'
```

### Space Normalization (3 個)
```ruby
/─\s+?─/ => '──'
/\(\s([a-zA-Z0-9]+)\s\)/ => '(\1)'
/\s{2,}/ => ' '
```
