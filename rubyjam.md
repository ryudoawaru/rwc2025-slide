---
marp: true
theme: 5xruby
paginate: true
header: 'RubyJam 2025'
---

<!-- _class: lead scale-95 -->
<!-- _paginate: false -->
<!-- _header: "" -->

<style scoped>
h1 { font-size: 4em; padding: 0 0; margin: 0.25em 0;}
h2 { font-size: 2.5em;  padding: 0 0; margin: 0.25em 0;}
</style>

# 像寫程式一樣解析台語
## Ruby 白話字羅馬字三階段解析

**鄧慕凡 (Mu-Fan Teng)**

### RubyJam 2025

<!--
Speaker Note:
大家好！
今天要跟大家分享「像寫程式一樣解析台語」這個主題。
我會透過 Ruby 來展示如何用三階段的方式解析台語白話字羅馬字。
-->

---

<!-- _class: center scale-95 -->
<!-- _header: "" -->

# 自我介紹

**鄧慕凡 (Mu-Fan Teng)**
- 5xRuby CO., LTD 創辦人
- 台灣 Ruby 傳教士
- RubyConf Taiwan Chief Organizer
- Rubyist from 2007

![bg right:40% fit](images/2024_AVATAR_RYUDOAWARU.jpg)

<!--
Speaker Note:
先自我介紹一下。

我是 5xRuby 的創辦人鄧慕凡。
從 2008 年開始在 Ruby 社群活動，
主要負責主辦 RubyConf Taiwan。

今年 11 月也在 RubyWorld Conference 2025 做了同主題的日文版發表。
-->

---

<!-- _class: scale-90 -->

# 議程

<div class="two-columns">

<div>

## 今天的內容

1. **這個案子為什麼沒人投標？**
   - 直接揭曉真相

2. **台羅（POJ）是什麼？**
   - 台語的羅馬字標記系統

3. **分詞對齊實作：GSUB 方式**
   - 三階段處理流程 + Edge Cases

4. **從 GSUB 到 Parser**
   - Parslet 實作與比較分析

5. **核心洞察與成果**
   - 測試驗證 + 系統展示

6. **結論**

</div>

<div style="text-align: center;">

### 投影片資料

#### https://rwc2025.ryudo.tw

![w:320](images/qrcode-slide.jpg)

</div>

</div>

<!--
Speaker Note:
今天的內容分成六個部分。

首先，這個案子為什麼沒人敢投標。
接著介紹 POJ 台羅。
然後是 GSUB 方式的分詞對齊實作，包含 Edge Cases 深入分析。
再來是從 GSUB 轉換到 Parser 的過程。
最後是核心洞察、測試驗證，以及系統展示。

右邊的 QR Code 可以連到投影片。
-->

---

<!-- _class: center highlight -->
<!-- _header: "" -->

# 這個案子為什麼沒人投標？

**連續投了 8 次都落選**
**第 9 次：競爭對手 = 0**

**「分詞對齊太煩雜，沒人敢接」**

<!--
Speaker Note:
進入正題。

5xRuby 從 2023 年開始投標政府案件，連續 8 次落選。
主要原因是台灣政府案件偏好 Microsoft 技術棧，Ruby 很難中選。

但第 9 次投標時，竟然沒有任何競爭對手。
得標之後才知道原因：台語的分詞對齊處理太複雜了，其他公司早就知道這個坑，所以沒人敢接。

但我們用 Ruby 成功解決了這個問題。
-->

---

<!-- _class: lead -->
<!-- _header: "" -->

# 台羅（POJ）是什麼？

**從日語的類比來理解**

<!--
Speaker Note:
那到底什麼是分詞對齊？為什麼這麼困難？
先來了解台語的文字系統。
-->

---

<!-- _class: scale-85 -->

# 台羅（台灣閩南語羅馬字）是什麼？

| 前後文脈（漢字） | 前後文脈（POJ） |
|------------------|------------------|
| 去**日本**食壽司 | khì **Ji̍t-pún** tsia̍h sú-sih |
| 香港、澳門...、臺灣佮**日本** | Hiong-káng, Ò-mn̂g...Tâi-uân kah **Ji̍t-pún** |
| 的時，**日本**義工共臺灣人 | ê sî, **Ji̍t-pún** gī-kang kā Tâi-uân-lâng |

<div class="two-columns">

<div>

## 台語的羅馬字標記
- **正式名稱**: 臺灣台語羅馬字拼音方案
- **簡稱**: 台羅 (Tâi-lô)
- **公布**: 2006 年 10 月，教育部公布
- **地位**: 台語的官方標記系統

</div>

<div>

## 不是中文（北京話）
- **台語**: 閩南語系的語言
- **特徵**:
  - 9 個聲調
  - 獨自的子音、母音體系
  - 鼻音化標記
- **歷史**: 以白話字 (POJ) 為基礎，加入 IPA 元素開發

</div>

</div>

<!--
Speaker Note:
台羅是 2006 年教育部公布的台語官方羅馬字。

台語不是中文，它有 9 個聲調、獨自的子音母音系統。

看表格中的例子，「日本」在台語裡永遠是「Ji̍t-pún」。
就像日語的漢字和平假名的對應關係。
-->

---

<!-- _class: scale-80 -->

# 漢字與音標的對應關係

<div class="two-columns">

<div>

## 日語的系統

**漢字 → 平假名**

**對應關係**:
- 一組詞 → 一組假名

**例**:
```
生活    → せいかつ
新幹線  → しんかんせん
東京駅  → とうきょうえき
```

</div>

<div>

## 台語的系統

**漢字 → POJ**

**對應關係**:
- 一組詞 → 一組 POJ

**例**:
```
紲落      → suà-lo̍h
新竹市    → Sin-tik-tshī
明仔載    → bîn-á-tsài
```

</div>

</div>

<div style="text-align: center; margin-top: 1.5em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**共通點**: 一組漢字 ↔ 一組音標

**→ 所以需要「分詞對齊處理」！**

</div>

<!--
Speaker Note:
日語的漢字對應平假名，台語的漢字對應 POJ。

平假名和 POJ 都是「音標」。
所以需要把漢字和音標正確對應起來，
這就是「分詞對齊處理」。
-->

---

<!-- _class: scale-80 -->

# 實際的分詞對齊處理範例

<div style="background: #f5f5f5; padding: 1.5em; border-radius: 8px; margin: 1em 0;">

**輸入資料（分詞前）:**
- 漢字：`紲落來看新竹市明仔載二十六號的天氣`
- POJ：`suà-lo̍h lâi-khuànn Sin-tik-tshī bîn-á-tsài gī-tsap-lak hō ê thinn-khì`

**期望輸出（分詞對齊後）:**

| 漢字 | POJ |
|------|--------|
| 紲落 | suà-lo̍h |
| 來看 | lâi-khuànn |
| 新竹市 | Sin-tik-tshī |
| 明仔載 | bîn-á-tsài |
| 二十六 | gī-tsap-lak |
| 號 | hō |
| 的 | ê |
| 天氣 | thinn-khì |

</div>

<!--
Speaker Note:
來看實際的例子。

上面是分詞前的資料，漢字和 POJ 各一串。
下面是期望的輸出，每組漢字都正確對應到 POJ。

「紲落」對「suà-lo̍h」、
「新竹市」對「Sin-tik-tshī」。

每一行都要正確對應，這就是分詞對齊的核心任務。
-->

---

<!-- _class: scale-75 -->

# 原始資料與拆好的資料對比

<div class="two-columns">

<div>

## 業主提供的原始資料（xlsx）

**107,294 筆語料資料**

| # | 提示卡編號 | 漢羅 | 台羅 |
|---|-----------|------|------|
| 1 | A002 | 認真無私心、閣會用心分享的人... | Jīn-tsin bô su-sim, koh ē iōng-sim... |
| 2 | A002 | 有課就罔上、罔代課， | Ū khò tiō bóng siōng, bóng tāi-khò, |
| 3 | A002 | 我看，著留予讀者沓沓仔去研究， | guá khuànn, tio̍h lâu hōo tho̍k-tsiá... |
| 4 | A002 | 對這點就看會出來。 | tuì tsit tiám tiō khuànn ē tshut--lâi. |
| 5 | A002 | 精彩的齣頭佇後壁， | tsing-tshái ê tshut-thâu tī āu-piah, |

**每筆資料 = 一句漢字 + 一句台羅**
**→ 要拆成一組一組的對應**

</div>

<div>

## 拆好後的結果（csv）

**每句拆成 kanji / roman 兩列**

| naer_id | balanced | text | 1 | 2 | 3 | ... |
|---------|----------|------|---|---|---|-----|
| TA23_43969 | true | 紲落來看... | 紲落 | 來看 | 新竹市 | ... |
| TA23_43969 | true | suà-lo̍h... | suà-lo̍h | lâi-khuànn | Sin-tik-tshī | ... |
| TA23_43970 | true | 溫度二十九... | 溫度 | 二十九 | 至 | ... |
| TA23_43970 | true | un-tōo... | un-tōo | lī-tsa̍p-káu | tsì | ... |

**`balanced` = 系統分詞是否成功**
- `true`: 三重驗證全部通過
- `false`: 需要人工校正

**→ 提供給業主驗證正確性**

</div>

</div>

<!--
Speaker Note:
在專案開始時，我們從業主那邊拿到了超過十萬筆的語料庫資料。
每筆資料包含一句漢字和對應的台羅。

我們的任務是把每一句都拆成一組一組的對應。
拆好之後要提供給業主驗證是否正確。

結果的 CSV 中，balanced 欄位就是表示系統是否成功完成分詞對齊。
true 代表三重驗證全部通過，false 代表需要人工校正。

十萬多筆資料、六萬多句不同的句子，全部要正確拆分。
這就是這個專案最大的挑戰。
-->

---

<!-- _class: lead -->
<!-- _header: "" -->

# 分詞對齊實作

**3 個 Phase 的處理流程**

<!--
Speaker Note:
接下來看看實作方式。
我們用 3 個 Phase 來處理。
-->

---

<!-- _class: center -->
<!-- _header: "" -->

# 實作全體流程：3 個 Phase

<div style="text-align: center;">

![w:860](images/rwc2025-setarr.drawio.svg)

</div>

<!--
Speaker Note:
實作分成 3 個 Phase。

Phase 1 是 WASH，符號的正規化。
Phase 2 是 SPLIT，拆分成陣列。
Phase 3 是 ALIGN，對齊與驗證。

接下來用一個 Edge Case 的例子來展示：
漢字中包含 POJ 文字的情況。
-->

---

<!-- _class: scale-65 -->

# Phase 1: 正規化 (WASH)

<div class="two-columns">

<div>

## washed_kanji - 漢字側

```ruby
KANJI_GSUB_PATTERNS = {
  /(\w+)(--)(\w+)/ => '\1 \2\3',
  ')(' => ') (',
  /([^\,]),/ => '\1 ,',
  ....
}.freeze
def washed_kanji
  KANJI_GSUB_PATTERNS.reduce(kanji) do |ks, (mt, kp)|
    ks.gsub(mt, kp)
  end
end
```

**處理內容:**
- 符號前後插入空白
- 句號、逗號、括號等分離
- POJ 文字（Lín--sàng）也適當處理

**執行範例:**
```
輸入: 做工課的Lín--sàng。
輸出: 做工課的Lín --sàng。
```

</div>

<div>

## washed_roman - POJ 側

```ruby
ROMAN_GSUB_PATTERNS = {
  /''/ => "'",
  /(.)([_+=\:;"'~`""\\」「\?!])(.)/ => '\1 \2 \3',
  /^([\(_+=\:;"'~`""\\」「\?!])/ => '\1 ',
  /([\)_+=\:;"'~`""\\」「\?!])$/ => ' \1',
  /(\.)([^\.])/ => '\1 \2',
  /([^\.])(\.)/ => '\1 \2',
}...
def washed_roman
  ROMAN_GSUB_PATTERNS.reduce(roman) do |rs, (mt, rp)|
    rs.gsub(mt, rp)
  end
end
```

**處理內容:**
- 65+ 個 pattern 正規化符號
- **連字符保留** - 音節分界
- **雙連字符（--）也保留** - 語間停頓

**執行範例:**
```
輸入: tsò-khang-khuè ê Lín--sàng.
輸出: tsò-khang-khuè ê Lín--sàng .
```

</div>

</div>

<!--
Speaker Note:
Phase 1 正規化漢字和 POJ。

兩邊各用數十種正規表達式處理字串。

重要的是 POJ 的連字符要保留，
後面的 Phase 會用來計算音節數。
-->

---

<!-- _class: scale-80 -->

# Phase 2-1: splitted_kanji - 漢字的拆分

<div class="two-columns">

<div>

## 實作程式碼

```ruby
# RXP_SPK - 辨識 CJK 與非 CJK 文字
RXP_SPK = /[\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}\u3000-\u303F\uFF00-\uFFEF]|
  [^\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}\u3000-\u303F\uFF00-\uFFEF]+/x
ONE_KANJI_WORDS = {
  /(…) (。)/ => '\1\2', /(』) (。)/ => '\1\2', /(——) ([^—])/ => '\1\2' }.freeze
def splitted_kanji
  combine_one_word(
    washed_kanji.scan(RXP_SPK).map do |spka|
      spka.split(/\s/)
    end.flatten.join(' ')
  ).split
end
# combine_one_word - 特殊組合處理
def combine_one_word(text)
  ONE_KANJI_WORDS.reduce(text) do |ks, (mt, kp)|
    ks.gsub(mt, kp)
  end
end
```

</div>

<div>

## 處理說明

1. **RXP_SPK 掃描文字**
   - CJK 文字（漢字、平假名等）
   - 非 CJK 文字（POJ、數字等）
   - 逐字或連續非 CJK 文字整體辨識

2. **combine_one_word 特殊處理**
   - ONE_KANJI_WORDS pattern 套用
   - 特定符號組合的結合

3. **用空白拆分**

4. **Edge Case 處理:**
   - `Lín--sàng` 被辨識為一個 token

## 執行範例

**輸入:** `做工課的Lín--sàng 。`
**輸出:**
`["做", "工", "課", "的", "Lín--sàng", "。"]`

</div>

</div>

<!--
Speaker Note:
Phase 2-1 把漢字文字拆分成陣列。

splitted_kanji 用三個步驟處理：
先用正規表達式掃描，區分 CJK 和非 CJK 文字。
再用 combine_one_word 處理特殊組合。
最後用空白拆分。

這個例子中，POJ 文字部分被辨識為一個 token。
-->

---

<!-- _class: scale-85 -->

# Phase 2-2: splitted_roman - POJ 的拆分

<div class="two-columns">

<div>

## 實作程式碼

```ruby
def splitted_roman
  washed_roman
    .split(/\s/)
    .compact_blank
end
```

**超簡單！只有 3 行**

</div>

<div>

## 處理說明

1. **簡單：用空白拆分**
   - Phase 1 已經把符號分離好了
   - 只需要用空白拆分

2. **重要的設計:**
   - **不用連字符拆分**
   - **雙連字符（--）也保留**
   - 保持詞內的音節結構

3. **compact_blank 刪除空白元素**

## 執行範例

**輸入:** `tsò-khang-khuè ê Lín--sàng .`
**輸出:**
`["tsò-khang-khuè", "ê", "Lín--sàng", "."]`

**音節數:**
- `tsò-khang-khuè` = 3 音節
- `Lín--sàng` = 2 音節（-- 不算在音節數內）

</div>

</div>

<!--
Speaker Note:
Phase 2-2 非常簡單。
Phase 1 已經把符號分離好了，用空白拆分就好。

重要的設計是不用連字符拆分。
連字符是音節的分界標記。

範例中第一個詞有 2 個連字符，所以是 3 音節。
-->

---

<!-- _class: scale-75 -->

# Phase 3: 對齊與驗證

<div class="two-columns">

<div>

```ruby
def roman_kanji_array
  spk = splitted_kanji.dup
  splitted_roman.map do |rword|
    if rword == '--' || (SP_MIRRORS.key?(rword) &&
        #... Edge Case 處理
        [rword, spss]
      end
    end
  end
end

def set_arrays
  rka = roman_kanji_array.transpose
  assign_attributes(
    roman_array: rka[0],
    kanji_array: rka[1]
  )
  self.arrays_balanced = [
    roman_array.size.positive?,
    roman_array.size == kanji_array.size,
    kanji_array.join.size ==
      washed_kanji.delete(' ').size
  ].all?
end
```

</div>

<div>

## 處理說明

1. **用音節數配對**
   - 連字符 = 音節分界
   - `tsò-khang-khuè` (3 音節) → 漢字 3 個字
   - `Lín--sàng` (2 音節) → Roman 直接對應

2. **Edge Case 處理:**
   - Roman 出現在 kanji 側時，直接對應
   - 雙連字符（--）不算在音節數內

3. **陣列組合**：`transpose` 分離 roman/kanji

4. **平衡性驗證（3 個條件）**
   - 陣列不為空
   - roman 和 kanji 元素數一致
   - kanji 總字數等於原始字數

|                           |                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------- |
| **kanji_array:**      | `["做工課", "的", "Lín--sàng", "。"]`                                                  |
| **roman_array:**      | `["tsò-khang-khuè", "ê", "Lín--sàng", "."]`                                       |
| **roman_kanji_array** | `[["tsò-khang-khuè", "做工課"], ["ê", "的"], ["Lín--sàng", "Lín--sàng"], [".", "。"]]` |


</div>

</div>

<!--
Speaker Note:
Phase 3 是對齊與驗證。

用音節數把漢字和 POJ 配對。
3 音節就對應漢字 3 個字。

Edge Case 是 kanji 側出現的 Roman 文字直接對應。

最後用 transpose 分離陣列，
再用 3 個條件驗證平衡性。
-->

---

<!-- _class: scale-75 -->

# Edge Cases 深入分析

<div class="two-columns">

<div>

## 數字處理
```
漢字: 二十六
POJ:  gī-tsa̍p-la̍k
```
- 3 個漢字 ↔ 3 音節
- 音節數 = 字元數 ✅

## 漢字中的 POJ 文字
```
漢字: 做工課的Lín--sàng。
POJ:  tsò-khang-khuè ê Lín--sàng.
```
- `Lín--sàng` 在漢字側也出現
- 雙連字符 `--` 是語間停頓標記
- 被當作一個 token 整體處理

</div>

<div>

## 標點符號序列
```
漢字: ...好食」。
POJ:  ...hó-tsia̍h」.
```
- `」。` 是連續標點
- 需要正確分離並各自對應

## 前綴連字符（語間停頓）
```
漢字: 日時
POJ:  ji̍t--sî
```
- `--` 表示語間停頓（不是音節分界）
- 音節數計算時 `--` 不列入
- `ji̍t--sî` = 2 音節（不是 3）

## 處理要點
- 每個 Edge Case 都需要**專門的 pattern**
- 65+ 個 GSUB patterns 就是這樣累積出來的

</div>

</div>

<!--
Speaker Note:
深入看幾個 Edge Case。

數字處理比較直觀，二十六對應 3 音節。

最棘手的是漢字中出現 POJ 文字，
像「Lín--sàng」在漢字側也有，需要整體處理。

標點符號序列要正確分離。

前綴連字符「--」表示語間停頓，不是音節分界，
計算音節數時不能算進去。

每個 Edge Case 都需要專門的 pattern，
這就是為什麼累積到 65+ 個 GSUB patterns。
-->

---

<!-- _class: scale-85 -->

# GSUB 模式的問題

<div class="two-columns">

<div>

## 問題

### 65+ 個 Patterns 的維護困難
```ruby
ROMAN_GSUB_PATTERNS = {
  /''/ => "'",
  /(.)([_+=\:;"'~`""\\」「\?!])(.)/ =>
    '\1 \2 \3',
  /^([\(_+=\:;"'~`""\\」「\?!])/ =>
    '\1 ',
  # ... 還有 60+ 個
}
```

### 順序依賴性
- Pattern 的執行順序會影響結果
- 調整一個 pattern 可能破壞其他 case
- **Debug 困難**：問題可能出在第 23 個 pattern

### 新 Edge Case = 新 Pattern
- 每發現一個新 case 就要加新 pattern，並保持順序是對的
- 持續膨脹，越來越脆弱

</div>

<div>

## 具體的順序依賴問題

```ruby
# 假設有這兩個 pattern：
{ /\./ => ' . ' }     # Pattern A
{ /\.\.\./ => ' ... ' } # Pattern B

# 如果 A 在 B 前面執行：
"..." → " .  .  . "  # ❌ 錯誤！

# 如果 B 在 A 前面執行：
"..." → " ... "      # ✅ 正確！
```

**→ Pattern 順序就是一種隱性的耦合**

<div style="margin-top: 1em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**GSUB 方式可以運作**，但隨著 pattern 增加：
- 維護成本持續上升
- 新人難以理解全貌
- 需要更系統化的方法

</div>

</div>

</div>

<!--
Speaker Note:
GSUB 方式有什麼挑戰？

首先是 65+ 個 patterns 的維護困難。
每個 pattern 都是一個正規表達式和替換規則。

最麻煩的是順序依賴性。
Pattern 的執行順序會影響結果。
像省略號「...」的處理，
如果單點的 pattern 先執行，省略號就會被拆散。

每發現新的 Edge Case 就要加新 pattern，
系統越來越脆弱。

這就是我們探索 Parser 方式的動機。
-->

---

<!-- _class: scale-90 -->

# 金子さん的演講啟發

<div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 2em; align-items: center;">

<div>

<img src="images/rubyconftw2025-kaneko.jpg" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

</div>

<div>

**"Understanding Ruby Grammar Through Conflicts"**

<div style="margin: 1.5em 0; padding: 1em; background: #f5f5f5; border-left: 4px solid #CC342D; border-radius: 4px;">

**Parser 的三階段處理**

1. **Lexical Analysis** (字句解析)
2. **Syntax Analysis** (構文解析)
3. **Semantic Analysis** (語意解析)

</div>

<div style="margin-top: 2em; padding: 1em; background: linear-gradient(135deg, #fff3cd 0%, #fff 100%); border-radius: 8px;">

<div style="text-align: center; font-size: 1.1em; margin-bottom: 0.8em;">

**「我做的事情...原來就是 Parser 啊！」**

</div>

<div style="text-align: center; font-size: 1.05em; margin-top: 1em; padding-top: 1em; border-top: 2px dashed #CC342D;">

→ **「用 Parser 的方式重新實作看看吧」**

</div>

</div>

</div>

</div>

<!--
Speaker Note:
近年 Ruby Parser 的發展帶來很多關於 Syntax Parser 的演講。

去年 RubyConf Taiwan 聽了金子さん的演講後，
我才意識到自己做的分詞處理，
其實也是一種 Parser 的三階段處理。

所以決定用 Parser 的方式重新實作，
並透過這個過程來分享心得。
-->

---

<!-- _class: center highlight -->
<!-- _header: "" -->

# Conference Driven Development

**用 Parser 的方式重新實作分詞對齊處理**

<!--
Speaker Note:
這也是一種 Conference Driven Development。

本來我沒打算重寫的。
但被別人的演講啟發，發現了這個可能性，
才有了這次的發表和研究。
-->

---

<!-- _class: scale-85 -->

# Parslet gem 介紹

**用 Ruby 寫 Parser 的 DSL 套件**

<div class="two-columns">

<div>

## 為什麼選 Parslet？

- **PEG Parser**: Parsing Expression Grammar
- **Ruby DSL**: 用 Ruby 的語法定義 Parser
- **明確的結構**: 自然實現 3-phase 設計

```ruby
# Parslet 的基本形式
class MyParser < Parslet::Parser
  # Phase 1 & 2: 規則定義
  rule(:word) { match['a-z'].repeat(1) }
  rule(:sentence) { word >> space }

  root(:sentence)
end
```

</div>

<div>

## Parslet 的設計哲學

Parslet 讓開發者自然意識到 **3 個 Phase**：

**Phase 1: Lexical Analysis**
- `rule()` 定義 Token 類型
- `match[]`, `str()` 定義字元 pattern

**Phase 2: Syntax Analysis**
- `>>`, `|` 組合規則
- 自動建構 AST

**Phase 3: Semantic Analysis**
- `Transform` class 做轉換
- AST → 最終資料結構

</div>

</div>

<!--
Speaker Note:
找 Ruby 的 Parser Gem 時發現了 Parslet。

Parslet 是用 Ruby DSL 寫 PEG (Parsing Expression Grammar) Parser 的套件。

重要的是它的設計哲學：
讓開發者自然意識到三個 Phase。
Lexical Analysis、Syntax Analysis、Semantic Analysis。
-->

---

<!-- _class: scale-75 -->

# Parslet DSL 基礎語法

<div class="three-columns">

<div>

## 基本語法

### `rule()` - 定義規則

```ruby
rule(:letter) { match['a-zA-Z'] }
rule(:digit) { match['0-9'] }
```

**意義**: 定義可重複使用的 Parser 規則

### `match[]` - 字元類別

```ruby
match['a-z']           # a-z
match['a-zA-Z0-9']     # 英數字
match['\u0300-\u036F'] # 聲調符號
```

**意義**: 等同正規表達式的 `[...]`

### `str()` - 字串匹配

```ruby
str('-')      # 連字符
str('--')     # 雙連字符
str(' - ')    # 空白-連字符-空白
```

**意義**: 字串的完全匹配

</div>

<div>

## 組合方式

### `>>` - 序列

```ruby
# A 後面接 B
rule(:word) { letter >> letter }
```

**意義**: 有順序的連接（AND）

### `|` - 選擇

```ruby
# A 或 B（順序很重要！）
rule(:token) do
  double_hyphen_word |  # 先嘗試
  hyphenated_word       # 後嘗試
end
```

**重要**: PEG 採用第一個匹配的選項

### `.repeat` - 重複

```ruby
match['a-z'].repeat      # 0 次以上
match['a-z'].repeat(1)   # 1 次以上
```

</div>

<div>

## AST 建構

### `.as(:symbol)` - 命名

```ruby
# 給 Token 加上類型標籤
rule(:word) {
  letter.repeat(1).as(:word)
}

# 輸出的 AST
{ word: "hello" }
```

**意義**: AST 中用來辨識的名稱

### `root()` - 起始規則

```ruby
# 指定 Parser 的入口
rule(:sentence) {
  token >> space?
}
root(:sentence)
```

**意義**: 指定從哪個規則開始解析

</div>

</div>

<!--
Speaker Note:
來看 Parslet 的基本語法。

左邊是基本語法：rule 定義規則、match 匹配字元、str 匹配字串。
中間是組合方式：序列、選擇、重複。注意 PEG 的順序很重要。
右邊是 AST 建構：用 as 命名、用 root 指定入口。

組合這些就能實作複雜的語言 Parser。
-->

---

<!-- _class: scale-60 -->

# Regexp → Parslet 轉換：標點符號處理

<div class="two-columns">

<div>

## GSUB 方式

```ruby
# 65+ 個 pattern 的一部分
ROMAN_GSUB_PATTERNS = {
  /,/ => ' , ',      # 逗號前後加空白
  /\./ => ' . ',     # 句號前後加空白
  /!/ => ' ! ',      # 驚嘆號前後加空白
  /\?/ => ' ? ',     # 問號前後加空白
  # ... 其他 60+ 個 pattern
}

# 套用
text = "suà-lo̍h,lâi-khuànn"
ROMAN_GSUB_PATTERNS.each do |pattern, replacement|
  text = text.gsub(pattern, replacement)
end
# => "suà-lo̍h , lâi-khuànn"
```

**特點**: 用空白包圍符號 → 之後 split

</div>

<div>

## Parslet 方式

```ruby
# 直接辨識標點為 Token
rule(:punctuation) do
  str('...') | str('⋯⋯') | str('……') |  # 多字元優先
  match[',.:;()!?？！/~、─…⋯'] |         # 單一字元
  match["\"'\u201C\u201D\u2018\u2019"] |  # 引號
  match['\u3000-\u303F']                  # CJK 符號
end

# Token 規則
rule(:token) do
  hyphenated_word.as(:word) |
  punctuation.as(:punct)
end
```

**輸入**: `"suà-lo̍h,lâi-khuànn"`

**輸出（AST）**:
```ruby
[
  { word: "suà-lo̍h" },
  { punct: "," },
  { word: "lâi-khuànn" }
]
```

**特點**: 結構化為 Token → 不需要 split

</div>

</div>

<!--
Speaker Note:
比較 GSUB 方式和 Parslet 方式。

GSUB 方式是在符號前後加空白，之後再 split。
Parslet 方式是直接把符號辨識為 Token。

結果是結構化的 AST，不需要 split。
-->

---

<!-- _class: scale-65 -->

# Regexp → Parslet 轉換：連字符與音節對應

<div class="two-columns">

<div>

## 連字符的保留

### GSUB 方式

```ruby
# Step 1: 符號正規化
text = "suà-lo̍h lâi-khuànn"
# 連字符保留（重要！）

# Step 2: 空白拆分
tokens = text.split(/\s/)
# => ["suà-lo̍h", "lâi-khuànn"]

# Step 3: 計算音節數
syllables = "suà-lo̍h".split('-').size
# => 2

# Step 4: 取對應數量的漢字
kanji_chars = ["紲", "落", "來", "看"]
combined = kanji_chars.shift(syllables).join
# => "紲落"
```

**原理**: 連字符 = 音節分界

</div>

<div>

### Parslet 方式

```ruby
# 連字符詞作為一個 Token 辨識
rule(:hyphenated_word) do
  syllable >>
  (single_hyphen >> syllable).repeat
end

# "suà-lo̍h" → { word: "suà-lo̍h" }
```

**音節數計算**:
```ruby
# Phase 3: Transform
rule(word: simple(:w)) do
  syllables = w.to_s.split('-').size
  # => 2
end
```

**漢字對應**:
```ruby
# 音節數 = 漢字字數
"suà-lo̍h".split('-').size  # => 2
"紲落".chars.size            # => 2
# ✅ 一致！
```

**原理**: Parser 保持音節結構 → 自動對應

</div>

</div>

<!--
Speaker Note:
比較連字符處理和音節計算。

GSUB 方式保留連字符，用 split 計算音節數，
再取對應數量的漢字。

Parslet 方式讓 Parser 自動保持音節結構，
在 Phase 3 計算音節數就能自動對應漢字。

這就是 Parser 結構化的優勢。
-->

---

<!-- _class: scale-75 -->

# 實際的 RomanParserPure：8 種 Token 類型

<div class="two-columns">

<div>

## Token 組裝（順序 = PEG 優先度）

```ruby
rule(:token) do
  double_hyphen_word.as(:word) | # 1
  prefix_hyphen_word.as(:word) | # 2
  underscore_word.as(:word) |    # 3
  hyphenated_word.as(:word) |    # 4
  number.as(:num) |              # 5
  bopomofo.as(:bopomofo) |      # 6
  cjk_char.as(:cjk) |           # 7
  punctuation.as(:punct)         # 8
end
```

**最特殊的放最前面，PEG 先嘗試長匹配**

</div>

<div>

## 每種類型的真實情境

| # | 類型 | 範例 | 情境 |
|---|------|------|------|
| 1 | 雙連字符開頭 | `--kóng` | 引號後接詞 |
| 2 | 前綴連字符 | `-pha` | 替代讀音 `(-pha)` |
| 3 | 底線佔位 | `lán_` | 缺字佔位 |
| 4 | 一般連字符詞 | `suà-lo̍h` | 最常見 |
| 5 | 數字 | `100` | 混合數字 |
| 6 | 注音 | `ㄅㄆㄇ` | 混合文本 |
| 7 | 漢字 | `台灣` | POJ 中夾漢字 |
| 8 | 標點 | `，。「」` | 全形/半形/CJK |

</div>

</div>

<div style="text-align: center; margin-top: 0.5em; padding: 0.5em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**十萬筆語料中什麼情況都有 → 完整程式碼請見 GitHub**

</div>

<!--
Speaker Note:
實際的 Parser 需要辨識 8 種 Token 類型。

順序很重要，PEG 會用第一個匹配的。
最特殊的 double_hyphen_word 放最前面，最一般的標點放最後面。

每一種類型都是從十萬筆真實語料中發現的情境。
像是引號後面接詞、替代讀音用前綴連字符、
缺字用底線佔位、甚至 POJ 文本中混雜漢字和注音。

完整程式碼在 GitHub 上可以看到。
-->

---

<!-- _class: scale-80 -->

# GSUB vs Parser 比較分析

<div class="two-columns">

<div>

## 各面向比較

| 面向 | GSUB | Parser |
|------|------|--------|
| **可維護性** | 65+ patterns, 難 debug | 宣告式規則，自我說明 |
| **可讀性** | 連續 gsub chain | 像語法一樣的 DSL |
| **效能** | 多次字串掃描 | 單次解析 |
| **擴展性** | 加更多 pattern | 新增/修改規則 |
| **測試** | 只能測整體 pipeline | 可測個別規則 |
| **錯誤處理** | 靜默失敗 | 結構化的解析錯誤 |

</div>

<div>

## 各自的適用場景

### GSUB 方式適合...
- 快速原型開發
- pattern 數量少的情況
- 團隊已熟悉的既有系統
- **本專案的生產環境仍在使用**

### Parser 方式適合...
- 需要長期維護的系統
- 複雜的語法結構
- 需要結構化錯誤訊息
- 教育與研究目的

<div style="margin-top: 1em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**結論**: 不是取代，而是**互補**
Parser 方式是對 GSUB 方式的理論驗證

</div>

</div>

</div>

<!--
Speaker Note:
比較兩種方式的各個面向。

GSUB 在可維護性和可讀性上比較弱，
但在快速原型開發上有優勢。

Parser 方式的可維護性、可讀性、測試友善度都比較好，
但需要更多的前置知識。

重要的是：本專案的生產環境仍然使用 GSUB 方式。
Parser 方式是理論驗證和教育目的。
兩者是互補的關係，不是取代。
-->

---

<!-- _class: scale-80 -->

# 與 Ruby Parser 的比較

<div class="two-columns">

<div>

## Ruby Parser (Prism)

```ruby
# 輸入
"def foo(x); x + 1; end"
```

**Phase 1: Lexical**
```
[DEF][IDENTIFIER][LPAREN][IDENTIFIER]
[RPAREN][SEMICOLON][IDENTIFIER][PLUS]
[INTEGER][SEMICOLON][END]
```

**Phase 2: Syntax**
```ruby
DefNode(
  name: :foo,
  parameters: ParametersNode(...),
  body: StatementsNode(...)
)
```

**Phase 3: Semantic**
- Type checking
- Scope analysis
- Code generation

</div>

<div>

## 台羅 Parser (RomanParserPure)

```
# 輸入
"suà-lo̍h lâi-khuànn"
```

**Phase 1: Lexical**
```
[suà-lo̍h][lâi-khuànn]
```

**Phase 2: Syntax**
```ruby
{
  sentence: [
    { word: "suà-lo̍h" },
    { word: "lâi-khuànn" }
  ]
}
```

**Phase 3: Semantic**
- AST transformation
- Array generation
```ruby
["suà-lo̍h", "lâi-khuànn"]
```

**註**: 實驗性實作（教育目的）

</div>

</div>

<!--
Speaker Note:
把 Ruby 的 Prism Parser 和我們的 RomanParserPure 對比。

兩者都有同樣的三階段結構：
Lexical Analysis、Syntax Analysis、Semantic Analysis。

當然 Ruby Parser 複雜得多，
這只是實驗性的實作。

但重點是：Parser 的思考方式不只適用於程式語言，
自然語言的處理也能應用。
-->

---

<!-- _class: scale-80 -->

# 漢字處理依賴 POJ Parser

**單向的依存關係：先解析複雜結構**

<div class="two-columns">

<div>

## POJ Parser（複雜）

```ruby
# RomanParserPure - 用 Parslet 實作
roman_array = [
  "suà-lo̍h",      # 2 音節
  "lâi-khuànn",    # 2 音節
  "Sin-tik-tshī"   # 3 音節
]

# 計算音節數
"suà-lo̍h".split('-').size  # => 2
"Sin-tik-tshī".split('-').size  # => 3
```

**複雜的處理:**
- 連字符的語意解析（音節 vs 語間）
- 聲調符號的辨識（Unicode 組合字元）
- 雙連字符（--）的特殊處理
- 語法規則定義與 AST 建構

</div>

<div>

## 漢字處理（簡單）

```ruby
# 只要跟著 POJ 的音節數
kanji = "紲落來看新竹市"

# 1. "suà-lo̍h" = 2 音節
#    → 漢字 2 個字: "紲落"
# 2. "lâi-khuànn" = 2 音節
#    → 漢字 2 個字: "來看"
# 3. "Sin-tik-tshī" = 3 音節
#    → 漢字 3 個字: "新竹市"

kanji_array = ["紲落", "來看", "新竹市"]
```

**簡單的處理:**
- 音節數 = 字元數的對應
- Pattern matching（Edge Case 用）
- 不需要獨立的語法解析

</div>

</div>

<!--
Speaker Note:
重要的觀察是單向的依存關係。

POJ Parser 做複雜的處理：
連字符的語意解析、聲調符號辨識、語法規則定義。

漢字處理很簡單，只要跟著 POJ 的音節數取字就好。

這是 Compiler 理論的重要原理：
先解析複雜結構，簡單結構就能自然對應。
-->

---

<!-- _class: scale-80 -->

# 測試與品質保證

<div class="two-columns">

<div>

## 測試結果

```bash
$ ruby test_parser.rb

========================================
Testing RomanParserPure with 3000 records
========================================
[██████████████████████████████] 100.0%
                           (3000/3000)

========================================
Final Results
========================================
Total records:    3000
Parse success:    3000 (100.0%)
Parse errors:     0 (0.0%)
========================================

🎉 PERFECT! 100% success rate achieved!
```

- **3000 筆真實語料資料**
- **100% 解析成功率**

</div>

<div>

## 平衡性驗證（arrays_balanced）

### 三重檢查
```ruby
self.arrays_balanced = [
  # 1. 陣列不為空
  roman_array.size.positive?,
  # 2. 兩邊元素數一致
  roman_array.size == kanji_array.size,
  # 3. 漢字總字數 = 原始文字長度
  kanji_array.join.size ==
    washed_kanji.delete(' ').size
].all?
```

### 為什麼需要三重檢查？
1. **非空檢查**: 避免空資料通過
2. **數量一致**: 每組漢字都有對應的 POJ
3. **字數守恆**: 確保沒有遺漏或重複

### 驗證的意義
- 不只是解析成功，更要確保**正確性**
- 字數守恆是最強的驗證條件
- 任何拆分錯誤都會被第 3 個條件抓到

</div>

</div>

<!--
Speaker Note:
測試結果是 3000 筆真實語料資料全部成功。

但光是解析成功還不夠，
我們用三重檢查來確保正確性。

第一是陣列不能為空。
第二是 roman 和 kanji 的元素數要一致。
第三也是最重要的：漢字總字數要等於原始文字長度。

這個字數守恆檢查能抓到任何拆分錯誤。
-->

---

<!-- _class: scale-80 -->

# 更多真實案例展示

<div class="two-columns">

<div>

## 混合標點符號

**輸入:** `「好食」，真好食！`

| kanji | roman |
|-------|-------|
| 「 | 「 |
| 好食 | hó-tsia̍h |
| 」， | 」, |
| 真 | tsin |
| 好食 | hó-tsia̍h |
| ！ | ! |

**全形/半形標點都能正確對應** ✅

</div>

<div>

## 語間停頓（--）與護照號碼

**輸入:** `日時斷斷仔`

| kanji | roman |
|-------|-------|
| 日時 | ji̍t--sî |
| 斷斷仔 | tuān-tuān-á |

`--` 不算音節 → `ji̍t--sî` = **2** 音節 ✅

## 其他常見情境

- **護照號碼**: `五二三九五一七空` → 8 個單字各自對應 1 音節
- **溫度數字**: `二十九` → `lī-tsa̍p-káu`（3 字 = 3 音節）
- **連續標點**: `...。` → 分離為兩個 token

</div>

</div>

<!--
Speaker Note:
來看幾個有趣的真實案例。

左邊是混合標點的例子。
全形引號「」和半形逗號、驚嘆號都能正確對應。

右上是語間停頓。
雙連字符不影響音節計算，ji̍t--sî 是 2 音節對應 2 個漢字。

右邊下方列出其他常見情境，
像護照號碼連續 8 個單字漢字逐字對應、溫度數字等等。

這些都是十萬筆語料中的真實資料。
-->

---

<!-- _class: scale-80 -->

# 台語語料庫系統

- **正式名稱**: 臺灣台語語料庫 應用檢索系統
- **公開 URL**: https://tggl.naer.edu.tw
- **委託單位**: 教育部 / 國家教育研究院

<div style="text-align: center; margin: 1.5em 0;">

![w:720](images/naer-homepage.png)

</div>

<!--
Speaker Note:
這個技術被用在台語語料庫系統中。
系統已經在 https://tggl.naer.edu.tw 公開上線。

主要有三個功能：語料檢索、教科書語彙、語法點檢索。
分詞對齊處理是這三個功能的基礎技術。
-->

---

<!-- _class: center highlight -->
<!-- _header: "" -->

<style scoped>
section.highlight ul,
section.highlight ol,
section.highlight li {
  color: white !important;
}
section.highlight strong {
  color: white !important;
}
section.highlight li::before {
  color: white !important;
}
section.highlight p {
  color: white !important;
  margin-top: 0.25em !important;
  margin-bottom: 0.25em !important;
}
section.highlight li {
  margin-top: 0.3em !important;
  margin-bottom: 0.3em !important;
}
</style>

# 結論

**Compiler 理論的普遍性**
- 程式語言的 Parser → 自然語言的處理
- Ruby 的 3-phase 分析 → 台語的分詞對齊

**選對工具、理解原理，複雜的問題也能解決**

**從 Conference 學習，挑戰新領域**
- 把既有的知識應用到新問題上
- 作為工程師的成長之路

<!--
Speaker Note:
最後的結論。

Compiler 理論的普遍性：
程式語言的 Parser 思維可以應用到自然語言處理。
Ruby 的三階段分析可以用在台語的分詞對齊。

重要的是選對工具、理解原理。
Ruby 的正規表達式、Method Chaining、Rails 生態系，
正確組合就能解決看起來複雜的問題。

還有，從 Conference 的演講中學習，
把既有知識應用到新問題領域，
這就是工程師的成長之路。
-->

---

<!-- _class: scale-95 -->

# 謝謝！

<div class="two-columns">

<div style="text-align: center;">

## 投影片 & 程式碼

![w:200](images/github-qr-code.jpg)

**https://github.com/ryudoawaru/rwc2025-slide**

**包含:**
- 完整 RomanParserPure 實作
- 3000 筆真實語料測試資料

</div>

<div>

## Quick Start

```bash
# Clone
git clone https://github.com/
  ryudoawaru/rwc2025-slide
cd rwc2025-slide

# 安裝相依套件
bundle install

# 範例資料測試（~3,000 筆）
ruby test_parser.rb

# 完整 64,554 筆測試
ruby test_parser.rb \
  test_data/corpora_data_new.json
```

</div>

</div>

<!--
Speaker Note:
左邊的 QR Code 是 GitHub repo，
裡面有完整的 RomanParserPure 實作和 3000 筆測試資料。

右邊是 Quick Start，clone 下來之後 bundle install，
然後跑 ruby test_parser.rb 就可以測試了。
預設用 3000 筆範例資料，也可以指定完整的 64,554 筆語料測試。

歡迎大家下載來試試看。謝謝大家！
-->

<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
