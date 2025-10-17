# CLAUDE.md

## RubyWorld Conference 2025 發表簡報

這個專案主要目的是產生 marp 格式的簡報用於在 11/6 的 RubyWorld Conference 2025 發表，但也會製作中文版在 10.28 的 RubyJam 發表

## 簡報檔案

- **主檔案**: `rubyworld-2025-taigi-parser.md`
- **主題**: `5xruby.css`
- **發表時間**: 15 分鐘（純演講，無 Q&A）

## 專案目標

- 產生 RubyWorld Conference 2025 的 Marp 格式日文簡報（15 分鐘發表）附講稿
- 目標檔案為：rubyworld-2025-taigi-parser.md
- 圖檔都放在 images

## 簡報結構概要

### 主要分段

這是原本從 Claude 專案討論的分段，並非不可修改

1. **開場段落** (Pages 1-4)
   - Page 1: 標題頁
   - Page 2: 自我介紹與 5xRuby 簡介
   - Page 3: 松江市 MOU 締結
   - Page 4: 今日のテーマ

2. **第一幕：無人入札の物語** (Pages 5-7)
   - Page 5: 台湾政府案件の特殊性
   - Page 6: 8連敗の経験
   - Page 7: 競合なしの真相

3. **第二幕：台羅拼音（POJ）とは？** (Pages 8-11)
   - Page 8: 日本語との類比
   - Page 9: 一対一対応の必要性
   - Page 10: 視覚化展示
   - Page 11: 実際の拆字範例

4. **第三幕：技術挑戰詳細** (Pages 12a-12d) ⭐核心技術段落
   - **Page 12a**: 課題1: 連字符（ハイフン）の複雑性
     - 3種類のハイフン處理
     - 実例：`ji̍t--sî`（語間停頓）
     - Scale class: `scale-75`
   - **Page 12b**: 課題2: 聲調標記（Unicode結合文字）
     - Unicode combining characters
     - 正規化処理
     - Scale class: `scale-75`
   - **Page 12c**: 課題3: 日文混雜處理
     - 固有名詞識別
     - 特殊鏡像處理
     - Scale class: `scale-75`
   - **Page 12d**: 課題4: 特殊符號と境界
     - 多様な引用符
     - 句読点処理
     - Scale class: `scale-75`

5. **第四幕：解決策の進化** (Pages 13-17)
   - Page 13: 初版の苦労（PR #30）
   - Page 14: 規則の発見（PR #68）
   - Page 15: ROMAN_GSUB_PATTERNS 展示
   - Page 16: 実際の処理フロー
   - Page 17: バランス検証

6. **第五幕：コンパイラとの出会い** (Pages 18-21)
   - Page 18: 並列比較表
   - Page 19: Lexical Analysis
   - Page 20: Syntax Analysis
   - Page 21: Semantic Analysis

7. **第六幕：Ruby の優位性** (Pages 22-24)
   - Page 22: 正規表現の表現力
   - Page 23: Method chaining の可読性
   - Page 24: 実績データ

8. **結語** (Pages 25-28)
   - Page 25: まとめ
   - Page 26: 今後の展望
   - Page 27: 謝辞
   - Page 28: QR Code & 聯絡資訊

## 重要修正記錄

### 2025-10-12: 術語統一
- **變更**: `拆字（分詞）` → `分詞アライメント処理`
- **位置**: Line 295
- **原因**: 使用更精確的技術術語

### 2025-10-12: Page 12a 重大修正
- **問題**: 原本列出 4 種連字符處理，但第 4 種（`文脈依存の分離`）在實際程式碼中並未實作
- **修正**: 改為 3 種處理類型
  1. 單詞內連字符（保持）
  2. 二重ハイフン（境界標記）
  3. 前置ハイフン（語間停頓）
- **新增實例**: `ji̍t--sî`（日時）
  ```
  漢字: "日時斷斷仔"
  POJ:  "ji̍t--sî tuān-tuān-á"
  ```
- **關鍵發現**:
  - 最終 split 是用空格 (`split(/\s/)`)，不是用連字符
  - `--` 在 KANJI 側有處理（line 68），但在 ROMAN 側被註解掉（line 48-49）
  - 前置連字符在 `roman_kanji_array` 方法中特殊處理（lines 146-149）

## Scale Classes 使用說明

為了防止內容溢出到 footer 區域，本簡報使用了自定義的 scale utility classes：

```css
section.scale-95 { font-size: 95%; }
section.scale-90 { font-size: 90%; }
section.scale-85 { font-size: 85%; }
section.scale-80 { font-size: 80%; }
section.scale-75 { font-size: 75%; }
section.scale-70 { font-size: 70%; }
section.scale-65 { font-size: 65%; }
```

### 目前使用情況
- **Pages 12a-12d**: 使用 `scale-75` (75%)
  - 原因：技術細節頁面，內容密集
  - 包含：程式碼範例、實例展示、說明文字

### 何時使用 Scale Classes
1. 技術細節豐富的頁面
2. 包含多段程式碼的頁面
3. 需要同時展示輸入/輸出範例的頁面
4. 內容接近或超出 footer 區域時

## 程式碼來源對照

本簡報中的程式碼範例均來自實際專案，專案在上一層目錄

### 關鍵常數
- **ROMAN_GSUB_PATTERNS**: 65+ 個模式替換規則（lines 9-66）
- **KANJI_GSUB_PATTERNS**: 漢字側的模式規則（lines 67-79）
- **ONE_KANJI_WORDS**: 單字漢字特殊處理（lines 81-85）
- **SP_MIRRORS**: 特殊鏡像處理（lines 87-89）

### 核心方法
1. **`roman_kanji_array`** (lines 146-176)
   - 主要的對齊邏輯
   - 處理前置連字符
   - 處理二重連字符

2. **`splitted_roman`** (lines 115-117)
   - 使用空格分割 POJ
   - **關鍵**: `split(/\s/)`，不是用連字符分割

3. **`splitted_kanji`** (lines 119-123)
   - 使用 RXP_SPK regex 分割漢字
   - 結合 `ONE_KANJI_WORDS` 處理

4. **`washed_roman`** (lines 101-106)
   - 套用所有 ROMAN_GSUB_PATTERNS
   - 正規化處理

5. **`set_arrays`** (lines 134-144)
   - 設定陣列並驗證平衡性
   - 錯誤處理

## 技術術語對照（簡報用）

| 中文 | 日語 | 英文 | 備註 |
|------|------|------|------|
| 分詞 | 分詞 | Word Segmentation | 現統一用「分詞アライメント処理」 |
| 白話字 | 白話字 | Pe̍h-ōe-jī (POJ) | 台灣語羅馬字系統 |
| 聲調標記 | 声調記号 | Tone Marks | Unicode combining characters |
| 連字符 | ハイフン | Hyphen | - |
| 語間停頓 | 語間停頓 | Inter-word Pause | `--` 符號，類似日語「っ」 |
| 對齊 | アライメント | Alignment | - |
| 平衡性檢查 | バランス検証 | Balance Check | `arrays_balanced` |
| 字句解析 | 字句解析 | Lexical Analysis | Tokenization |
| 構文解析 | 構文解析 | Syntax Analysis | Pattern Matching |
| 意味解析 | 意味解析 | Semantic Analysis | Validation |

## Speaker Notes 使用指南

每個頁面都包含詳細的 Speaker Notes，位於 `<!--` 和 `-->` 之間。

### Speaker Notes 結構
```markdown
<!--
Speaker Notes 內容：
- 這一頁要講的重點
- 預計講述時間
- 需要強調的技術細節
- 與聽眾的互動點
-->
```

### Page 12a Speaker Notes 範例
```markdown
さて、ここからが本発表の核心部分です。
まず最初の課題は、連字符、つまりハイフンの複雑性です。

台湾語のPOJには、3種類のハイフン処理が必要です。

1つ目は、単語内の連字符です。
これは保持すべきものです。
...

3つ目は、前置ハイフンの処理です。
実際の例を見てみましょう。
「日時斷斷仔」という文章があります。
POJでは「ji̍t--sî tuān-tuān-á」と書きます。

この「--」は語間停頓を表す特殊なマーカーです。
日本語の促音「っ」に似ています。
```

## 維護注意事項

### 1. 保持程式碼準確性
- 所有程式碼範例必須與實際專案一致
- 更新程式碼前先查看最新的 Git commit
- 不應該展示不存在的功能

### 2. Scale Classes 調整
- 如果內容溢出，先嘗試調整 scale percentage
- 避免低於 `scale-65` (65%)，會影響可讀性
- 考慮分成多張投影片

### 3. 術語一致性
- 使用 `分詞アライメント処理` 而非 `拆字（分詞）`
- 保持中文、日語、英文術語對照表更新
- 新術語加入前先確認日語正確性

### 4. 實例更新
- 實例必須來自真實語料庫資料
- 提供完整的輸入/輸出範例
- 說明實例的代表性

## 預覽與匯出

### 本地預覽
```bash
npx @marp-team/marp-cli@latest -s ./
```

打開 http://localhost:8080/rubyworld-2025-taigi-parser.md 檢查
### 檢查清單
- [ ] 所有頁面內容未溢出到 footer
- [ ] 程式碼 syntax highlighting 正確
- [ ] 日語文法與術語正確
- [ ] Speaker Notes 完整且清晰
- [ ] 實例資料正確
- [ ] 時間控制在 15 分鐘內
- [ ] 圖片與 logo 正確顯示

## 相關資源

### 專案連結
- **GitLab**: https://git.5xruby.com/naer/naer/
- **Redmine**: https://redmine.5xruby.com/issues/5432
- **GitHub（公開版）**: https://github.com/5xruby/naer

### 參考文件
- Corpus Model: `app/models/corpus.rb`
- CorporaArraySettable: `app/models/concerns/corpora_array_settable.rb`
- 後台資料庫檔案範例: `後台資料庫檔案範例.xlsx`
- 拆字前範例: `拆字前的表格範例.xlsx`
- 拆字校正結果: `拆字校正結果的範例.xlsx`

### 會議資訊
- **會議**: RubyWorld Conference 2025
- **日期**: 2025年11月6-7日
- **地點**: 島根県松江市
- **演講時間**: 15分鐘（純演講，無Q&A）
- **語言**: 日語

## 基本資訊
- **發表題目**: コードのように台湾語を解析：Rubyによる白話字ローマ字の3段階解析
- **發表者**: 鄧慕凡 (Mu-Fan Teng)
- **所屬**: 5xRuby CO., LTD
- **發表時間**: 15分鐘（純演講，無Q&A）
- **發表語言**: 日語
- **日期**: 2025年11月6-7日
- **地點**: 島根県松江市

## 專案背景資料

### GitLab 專案
- **專案URL**: https://git.5xruby.com/naer/naer/
- 請使用 mcp 參考
- **關鍵PR**:
  - PR #30: 初版實作（基礎規則）
  - PR #68: 引入ROMAN_GSUB_PATTERNS（40+規則）  
  - PR #73: 處理特殊case的修正

### Redmine Issue
- **Issue #5432**: https://redmine.5xruby.com/issues/5432
- 請使用 mcp 參考
- **內容**: 拆字需求與範例

### 系統概述
- **名稱**: 臺灣台語語料庫應用檢索系統 (NAER)
- **委託方**: 教育部/國家教育研究院
- **規模**: 208小時語音資料
- **服務對象**: 全台國中小學台語教育

### 原始資料範例

- 後台資料庫檔案範例.xlsx

## 拆字範例（核心問題）

- 拆字前的表格範例.xlsx
- 拆字校正結果的範例.xlsx

### 輸入資料
```
TA23_43969	紲落來看新竹市明仔載二十六號的天氣	suà-lo̍h lâi-khuànn Sin-tik-tshī bîn-á-tsài gī-tsa̍p-la̍k hō ê thinn-khì
```

### 期待輸出

#### 漢字陣列
```
紲落｜來看｜新竹市｜明仔載｜二十六｜號｜的｜天氣
```

#### 台羅陣列
```
suà-lo̍h｜lâi-khuànn｜Sin-tik-tshī｜bîn-á-tsài｜gī-tsa̍p-la̍k｜hō｜ê｜thinn-khì
```

### 技術挑戰
1. 連字符處理（hyphen）
2. 聲調標記（tone marks）
3. 日文混雜處理
4. 數字音韻變化
5. 特殊符號處理

## 日語技術術語對照表

| 中文/英文 | 日語 | 讀音 |
|---------|------|------|
| 拆字/分詞 | 分詞 | ぶんし |
| 白話字(POJ) | 白話字 | ペーオージー |
| 聲調標記 | 声調記号 | せいちょうきごう |
| 連字符 | ハイフン | - |
| 對齊 | アライメント | - |
| 煩雜 | 煩雑 | はんざつ |
| Parser | パーサー | - |
| 字句解析 | 字句解析 | じくかいせき |
| 構文解析 | 構文解析 | こうぶんかいせき |
| 意味解析 | 意味解析 | いみかいせき |
| 正規表現 | 正規表現 | せいきひょうげん |
| Ruby傳教士 | Ruby伝道師 | Ruby でんどうし |

### 簡化版 Demo Code
```ruby
# demo.rb
class TaigiParser
  def initialize
    @patterns = load_patterns
  end
  
  def parse(input)
    puts "=" * 50
    puts "Input: #{input}"
    puts "=" * 50
    
    # Step 1: Tokenize
    puts "\n[Step 1] Tokenizing..."
    tokens = tokenize(input)
    puts "Tokens: #{tokens.inspect}"
    
    # Step 2: Align
    puts "\n[Step 2] Aligning..."
    aligned = align(tokens)
    puts "Aligned: #{aligned.inspect}"
    
    # Step 3: Validate
    puts "\n[Step 3] Validating..."
    result = validate(aligned)
    puts "Result: #{result ? '✓ Success' : '✗ Failed'}"
    
    aligned
  end
end

# 執行範例
parser = TaigiParser.new
parser.parse("suà-lo̍h lâi-khuànn Sin-tik-tshī")
```

## Marp 格式注意事項

### 基本設定
```yaml
---
marp: true
theme: default
paginate: true
header: 'RubyWorld Conference 2025'
footer: '© 2025 5xRuby'
---
```

### 建議樣式
```css
/* 自定義樣式 */
section.center {
  text-align: center;
}

.columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1em;
}

pre {
  font-size: 0.8em;
}

table {
  font-size: 0.9em;
}
```

## 視覺化素材建議

1. **開場頁**: 5xRuby Logo + 松江市MOU照片
2. **故事線圖表**: 8次落選 → 無人競標 → 得標
3. **POJ對照表**: 動畫展示漢字與台羅的對應
4. **程式碼演進**: Before/After 對比
5. **Parser類比圖**: 左右對照的流程圖
6. **成果數據**: 資訊圖表展示208小時、全台學校
7. **QR Code**: GitHub連結

## 時間掌控提醒

- 每張投影片平均30-45秒
- Demo部分預留buffer時間
- 準備15-20張投影片
- 關鍵程式碼使用syntax highlighting
- 避免過多文字，多用圖像

## 參考資料

1. **CFP投稿內容**: RubyWorld Conference 2025 発表者募集回覆
2. **系統說明書**: 國家教育研究院臺灣台語語料庫應用檢索系統建置案
3. **教育部計畫**: 閩南語語音語料庫建置計畫（2019-2022）
4. **技術文件**: GitLab專案文件與PR記錄

## 聯絡資訊

- **Email**: ryudo@5xruby.com
- **GitHub**: https://github.com/5xruby
- **Company**: 5xRuby CO., LTD
- **Phone**: +886939090146

---

*本文件用於 Claude 產生 Marp 格式簡報，請依據上述內容產生對應的投影片內容。*

---

**Last Updated:** 2025-10-12
**Theme Version:** 1.0
**Maintainer:** 5xRuby Development Team
