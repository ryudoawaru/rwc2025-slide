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

# Parsing Taiwanese Like Code
## 3-Phase Analysis of POJ Romanization with Ruby

**Mu-Fan Teng (鄧慕凡)**

### RubyJam 2025

<!--
Speaker Note:
Hello everyone!
Today I'd like to share about "Parsing Taiwanese Like Code."
I'll demonstrate how to use Ruby to analyze Taiwanese POJ romanization through a 3-phase approach.
-->

---

<!-- _class: center scale-95 -->
<!-- _header: "" -->

# About Me

**Mu-Fan Teng (鄧慕凡)**
- Founder, 5xRuby CO., LTD
- Ruby Evangelist in Taiwan
- RubyConf Taiwan Chief Organizer
- Rubyist from 2007

![bg right:40% fit](images/2024_AVATAR_RYUDOAWARU.jpg)

<!--
Speaker Note:
Let me introduce myself.

I'm Mu-Fan Teng, founder of 5xRuby.
I've been active in the Ruby community since 2008,
and I'm the chief organizer of RubyConf Taiwan.

Last November, I also gave the Japanese version of this talk at RubyWorld Conference 2025.
-->

---

<!-- _class: scale-90 -->

# Agenda

<div class="two-columns">

<div>

## Today's Topics

1. **Why Did Nobody Bid on This Project?**
   - Revealing the truth

2. **What is POJ (Taiwanese Romanization)?**
   - The romanization system for Taiwanese

3. **Word Segmentation Alignment: The GSUB Approach**
   - 3-phase processing flow + Edge Cases

4. **From GSUB to Parser**
   - Parslet implementation and comparison

5. **Key Insights and Results**
   - Test verification + System demo

6. **Conclusion**

</div>

<div style="text-align: center;">

### Slide Materials

#### https://rwc2025.ryudo.tw/rubyjam-en.md
#### https://rwc2025.ryudo.tw/rubyjam.md (zh-TW)

![w:320](images/qrcode-slide-rubyjam-en.png)

</div>

</div>

<!--
Speaker Note:
Today's content is divided into six parts.

First, why nobody dared to bid on this project.
Then an introduction to POJ Taiwanese romanization.
Next, the word segmentation alignment implementation using GSUB, including a deep dive into Edge Cases.
After that, the transition from GSUB to Parser.
And finally, key insights, test verification, and a system demo.

The QR code on the right links to the slides.
-->

---

<!-- _class: center highlight -->
<!-- _header: "" -->

# Why Did Nobody Bid on This Project?

**Lost 8 consecutive bids**
**9th attempt: Competitors = 0**

**"Word segmentation alignment is too complex — nobody dared to take it on"**

<!--
Speaker Note:
Let's get into the topic.

5xRuby started bidding on government projects in 2023 and lost 8 times in a row.
The main reason was that Taiwan's government projects favor the Microsoft tech stack, making it very hard for Ruby to win.

But on the 9th bid, there were zero competitors.
After winning, we found out why: the word segmentation alignment for Taiwanese was too complex, and other companies already knew about this pitfall, so nobody dared to take it on.

But we solved it successfully with Ruby.
-->

---

<!-- _class: lead -->
<!-- _header: "" -->

# What is POJ (Taiwanese Romanization)?

**Understanding through analogy with Japanese**

<!--
Speaker Note:
So what exactly is word segmentation alignment? And why is it so difficult?
Let's first understand the Taiwanese writing system.
-->

---

<!-- _class: scale-85 -->

# What is POJ (Taiwanese Romanization)?

| Context (Kanji) | Context (POJ) |
|------------------|------------------|
| 去**日本**食壽司 | khì **Ji̍t-pún** tsia̍h sú-sih |
| 香港、澳門...、臺灣佮**日本** | Hiong-káng, Ò-mn̂g...Tâi-uân kah **Ji̍t-pún** |
| 的時，**日本**義工共臺灣人 | ê sî, **Ji̍t-pún** gī-kang kā Tâi-uân-lâng |

<div class="two-columns">

<div>

## Taiwanese Romanization
- **Official name**: Taiwanese Romanization System
- **Abbreviation**: Tâi-lô (台羅)
- **Published**: October 2006, by the Ministry of Education
- **Status**: Official romanization system for Taiwanese

</div>

<div>

## Not Mandarin Chinese
- **Taiwanese**: A language in the Southern Min family
- **Features**:
  - 9 tones
  - Its own consonant and vowel system
  - Nasalization markers
- **History**: Developed based on Pe̍h-ōe-jī (POJ) with IPA elements

</div>

</div>

<!--
Speaker Note:
POJ is the official Taiwanese romanization published by the Ministry of Education in 2006.

Taiwanese is not Mandarin Chinese — it has 9 tones and its own consonant and vowel system.

Look at the examples in the table: "日本" in Taiwanese is always "Ji̍t-pún."
It's like the correspondence between kanji and hiragana in Japanese.
-->

---

<!-- _class: scale-80 -->

# Correspondence Between Kanji and Phonetic Notation

<div class="two-columns">

<div>

## The Japanese System

**Kanji → Hiragana**

**Correspondence**:
- One word group → One hiragana group

**Examples**:
```
生活    → せいかつ
新幹線  → しんかんせん
東京駅  → とうきょうえき
```

</div>

<div>

## The Taiwanese System

**Kanji → POJ**

**Correspondence**:
- One word group → One POJ group

**Examples**:
```
紲落      → suà-lo̍h
新竹市    → Sin-tik-tshī
明仔載    → bîn-á-tsài
```

</div>

</div>

<div style="text-align: center; margin-top: 1.5em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**Common point**: One kanji group ↔ One phonetic group

**→ This is why we need "Word Segmentation Alignment"!**

</div>

<!--
Speaker Note:
In Japanese, kanji corresponds to hiragana. In Taiwanese, kanji corresponds to POJ.

Both hiragana and POJ are phonetic notations.
So we need to correctly match each kanji group to its phonetic counterpart —
that's what "word segmentation alignment" is.
-->

---

<!-- _class: scale-80 -->

# Actual Word Segmentation Alignment Example

<div style="background: #f5f5f5; padding: 1.5em; border-radius: 8px; margin: 1em 0;">

**Input data (before segmentation):**
- Kanji: `紲落來看新竹市明仔載二十六號的天氣`
- POJ: `suà-lo̍h lâi-khuànn Sin-tik-tshī bîn-á-tsài gī-tsap-lak hō ê thinn-khì`

**Expected output (after segmentation alignment):**

| Kanji | POJ |
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
Let's look at a real example.

Above is the data before segmentation — a single string of kanji and a single string of POJ.
Below is the expected output, with each kanji group correctly matched to its POJ.

"紲落" maps to "suà-lo̍h",
"新竹市" maps to "Sin-tik-tshī."

Every row must be correctly aligned — that's the core task of word segmentation alignment.
-->

---

<!-- _class: scale-75 -->

# Comparing Raw Data and Processed Data

<div class="two-columns">

<div>

## Raw Data from the Client (xlsx)

**107,294 corpus entries**

| # | Card ID | Kanji | POJ |
|---|-----------|------|------|
| 1 | A002 | 認真無私心、閣會用心分享的人... | Jīn-tsin bô su-sim, koh ē iōng-sim... |
| 2 | A002 | 有課就罔上、罔代課， | Ū khò tiō bóng siōng, bóng tāi-khò, |
| 3 | A002 | 我看，著留予讀者沓沓仔去研究， | guá khuànn, tio̍h lâu hōo tho̍k-tsiá... |
| 4 | A002 | 對這點就看會出來。 | tuì tsit tiám tiō khuànn ē tshut--lâi. |
| 5 | A002 | 精彩的齣頭佇後壁， | tsing-tshái ê tshut-thâu tī āu-piah, |

**Each entry = one kanji sentence + one POJ sentence**
**→ Must be split into aligned pairs**

</div>

<div>

## Processed Results (csv)

**Each sentence split into kanji / roman rows**

| naer_id | balanced | text | 1 | 2 | 3 | ... |
|---------|----------|------|---|---|---|-----|
| TA23_43969 | true | 紲落來看... | 紲落 | 來看 | 新竹市 | ... |
| TA23_43969 | true | suà-lo̍h... | suà-lo̍h | lâi-khuànn | Sin-tik-tshī | ... |
| TA23_43970 | true | 溫度二十九... | 溫度 | 二十九 | 至 | ... |
| TA23_43970 | true | un-tōo... | un-tōo | lī-tsa̍p-káu | tsì | ... |

**`balanced` = whether segmentation succeeded**
- `true`: All three validation checks passed
- `false`: Requires manual correction

**→ Provided to the client for accuracy verification**

</div>

</div>

<!--
Speaker Note:
At the start of the project, we received over 100,000 corpus entries from the client.
Each entry contains one kanji sentence and its corresponding POJ.

Our task was to split each sentence into aligned pairs.
After processing, we provided the results to the client for verification.

In the output CSV, the "balanced" field indicates whether the system successfully completed the alignment.
"true" means all three validation checks passed, "false" means manual correction is needed.

Over 100,000 entries, more than 60,000 unique sentences — all needing to be correctly split.
That was the biggest challenge of this project.
-->

---

<!-- _class: lead -->
<!-- _header: "" -->

# Word Segmentation Alignment Implementation

**A 3-Phase Processing Flow**

<!--
Speaker Note:
Now let's look at the implementation.
We process this in 3 phases.
-->

---

<!-- _class: center -->
<!-- _header: "" -->

# Implementation Overview: 3 Phases

<div style="text-align: center;">

![w:860](images/rwc2025-setarr.drawio.svg)

</div>

<!--
Speaker Note:
The implementation is divided into 3 phases.

Phase 1 is WASH — symbol normalization.
Phase 2 is SPLIT — splitting into arrays.
Phase 3 is ALIGN — alignment and validation.

Next, I'll demonstrate with an edge case example:
the situation where POJ text is embedded within kanji.
-->

---

<!-- _class: scale-65 -->

# Phase 1: Normalization (WASH)

<div class="two-columns">

<div>

## washed_kanji - Kanji Side

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

**Processing:**
- Insert spaces around symbols
- Separate periods, commas, parentheses, etc.
- Properly handle POJ text (Lín--sàng) as well

**Execution example:**
```
Input:  做工課的Lín--sàng。
Output: 做工課的Lín --sàng。
```

</div>

<div>

## washed_roman - POJ Side

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

**Processing:**
- 65+ patterns for symbol normalization
- **Hyphens preserved** — syllable boundaries
- **Double hyphens (--) also preserved** — inter-word pauses

**Execution example:**
```
Input:  tsò-khang-khuè ê Lín--sàng.
Output: tsò-khang-khuè ê Lín--sàng .
```

</div>

</div>

<!--
Speaker Note:
Phase 1 normalizes both the kanji and POJ sides.

Each side uses dozens of regular expressions to process the strings.

The important thing is that POJ hyphens are preserved —
they'll be used to count syllables in the later phases.
-->

---

<!-- _class: scale-80 -->

# Phase 2-1: splitted_kanji - Splitting Kanji

<div class="two-columns">

<div>

## Implementation Code

```ruby
# RXP_SPK - Identify CJK vs non-CJK characters
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
# combine_one_word - Special combination handling
def combine_one_word(text)
  ONE_KANJI_WORDS.reduce(text) do |ks, (mt, kp)|
    ks.gsub(mt, kp)
  end
end
```

</div>

<div>

## Processing Details

1. **RXP_SPK scans characters**
   - CJK characters (Kanji, Hiragana, etc.)
   - Non-CJK characters (POJ, numbers, etc.)
   - Character-by-character or contiguous non-CJK as a whole token

2. **combine_one_word special handling**
   - Applies ONE_KANJI_WORDS patterns
   - Combines specific symbol sequences

3. **Split by whitespace**

4. **Edge Case handling:**
   - `Lín--sàng` is recognized as a single token

## Execution Example

**Input:** `做工課的Lín--sàng 。`
**Output:**
`["做", "工", "課", "的", "Lín--sàng", "。"]`

</div>

</div>

<!--
Speaker Note:
Phase 2-1 splits Kanji text into an array.

splitted_kanji processes in three steps:
First, it scans with a regex to distinguish CJK and non-CJK characters.
Then it uses combine_one_word to handle special combinations.
Finally, it splits by whitespace.

In this example, the POJ text portion is recognized as a single token.
-->

---

<!-- _class: scale-85 -->

# Phase 2-2: splitted_roman - Splitting POJ

<div class="two-columns">

<div>

## Implementation Code

```ruby
def splitted_roman
  washed_roman
    .split(/\s/)
    .compact_blank
end
```

**Super simple! Only 3 lines**

</div>

<div>

## Processing Details

1. **Simple: split by whitespace**
   - Phase 1 already separated the symbols
   - Just need to split by whitespace

2. **Important design decisions:**
   - **Does NOT split by hyphens**
   - **Double hyphens (--) are also preserved**
   - Maintains intra-word syllable structure

3. **compact_blank removes empty elements**

## Execution Example

**Input:** `tsò-khang-khuè ê Lín--sàng .`
**Output:**
`["tsò-khang-khuè", "ê", "Lín--sàng", "."]`

**Syllable counts:**
- `tsò-khang-khuè` = 3 syllables
- `Lín--sàng` = 2 syllables (-- is not counted in syllable count)

</div>

</div>

<!--
Speaker Note:
Phase 2-2 is very simple.
Phase 1 already separated the symbols, so just splitting by whitespace is enough.

The important design decision is not splitting by hyphens.
Hyphens are syllable boundary markers.

The first word in the example has 2 hyphens, so it has 3 syllables.
-->

---

<!-- _class: scale-75 -->

# Phase 3: Alignment and Validation

<div class="two-columns">

<div>

```ruby
def roman_kanji_array
  spk = splitted_kanji.dup
  splitted_roman.map do |rword|
    if rword == '--' || (SP_MIRRORS.key?(rword) &&
        #... Edge Case handling
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

## Processing Details

1. **Pair by syllable count**
   - Hyphen = syllable boundary
   - `tsò-khang-khuè` (3 syllables) → 3 Kanji characters
   - `Lín--sàng` (2 syllables) → Direct Roman mapping

2. **Edge Case handling:**
   - When Roman text appears on the kanji side, it maps directly
   - Double hyphens (--) are not counted in syllable count

3. **Array combination**: `transpose` separates roman/kanji

4. **Balance validation (3 conditions)**
   - Arrays are not empty
   - roman and kanji element counts match
   - kanji total character count equals original character count

|                           |                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------- |
| **kanji_array:**      | `["做工課", "的", "Lín--sàng", "。"]`                                                  |
| **roman_array:**      | `["tsò-khang-khuè", "ê", "Lín--sàng", "."]`                                       |
| **roman_kanji_array** | `[["tsò-khang-khuè", "做工課"], ["ê", "的"], ["Lín--sàng", "Lín--sàng"], [".", "。"]]` |


</div>

</div>

<!--
Speaker Note:
Phase 3 is alignment and validation.

Kanji and POJ are paired by syllable count.
3 syllables correspond to 3 Kanji characters.

The edge case is when Roman text appears on the kanji side — it maps directly.

Finally, transpose separates the arrays,
and 3 conditions are used to validate balance.
-->

---

<!-- _class: scale-75 -->

# Deep Dive into Edge Cases

<div class="two-columns">

<div>

## Number Handling
```
漢字: 二十六
POJ:  gī-tsa̍p-la̍k
```
- 3 Kanji characters ↔ 3 syllables
- Syllable count = character count ✅

## POJ Text Within Kanji
```
漢字: 做工課的Lín--sàng。
POJ:  tsò-khang-khuè ê Lín--sàng.
```
- `Lín--sàng` also appears on the kanji side
- Double hyphen `--` is an inter-word pause marker
- Treated as a single token

</div>

<div>

## Punctuation Sequences
```
漢字: ...好食」。
POJ:  ...hó-tsia̍h」.
```
- `」。` is consecutive punctuation
- Must be correctly separated and individually mapped

## Prefix Hyphen (Inter-word Pause)
```
漢字: 日時
POJ:  ji̍t--sî
```
- `--` indicates an inter-word pause (not a syllable boundary)
- `--` is not counted when calculating syllable count
- `ji̍t--sî` = 2 syllables (not 3)

## Key Takeaways
- Each edge case requires a **dedicated pattern**
- This is how the 65+ GSUB patterns accumulated

</div>

</div>

<!--
Speaker Note:
Let's take a deeper look at some edge cases.

Number handling is relatively straightforward — 二十六 maps to 3 syllables.

The trickiest case is when POJ text appears within Kanji,
like "Lín--sàng" which also exists on the kanji side and needs to be handled as a whole.

Punctuation sequences must be correctly separated.

The prefix double hyphen "--" indicates an inter-word pause, not a syllable boundary,
so it must not be counted when calculating syllable count.

Each edge case requires a dedicated pattern,
which is why the GSUB patterns accumulated to 65+.
-->

---

<!-- _class: scale-85 -->

# The Problem with GSUB Patterns

<div class="two-columns">

<div>

## The Problem

### Maintaining 65+ Patterns is Difficult
```ruby
ROMAN_GSUB_PATTERNS = {
  /''/ => "'",
  /(.)([_+=\:;"'~`""\\」「\?!])(.)/ =>
    '\1 \2 \3',
  /^([\(_+=\:;"'~`""\\」「\?!])/ =>
    '\1 ',
  # ... 60+ more
}
```

### Order Dependency
- The execution order of patterns affects results
- Adjusting one pattern may break other cases
- **Debugging is hard**: The issue could be in the 23rd pattern

### New Edge Case = New Pattern
- Every new case discovered requires a new pattern, while maintaining correct order
- Continuous growth, increasingly fragile

</div>

<div>

## A Concrete Order Dependency Problem

```ruby
# Suppose we have these two patterns:
{ /\./ => ' . ' }     # Pattern A
{ /\.\.\./ => ' ... ' } # Pattern B

# If A executes before B:
"..." → " .  .  . "  # ❌ Wrong!

# If B executes before A:
"..." → " ... "      # ✅ Correct!
```

**→ Pattern order is a form of implicit coupling**

<div style="margin-top: 1em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**The GSUB approach works**, but as patterns grow:
- Maintenance cost keeps rising
- Hard for newcomers to grasp the full picture
- A more systematic approach is needed

</div>

</div>

</div>

<!--
Speaker Note:
What challenges does the GSUB approach have?

First, maintaining 65+ patterns is difficult.
Each pattern is a regular expression and replacement rule.

The most troublesome issue is order dependency.
The execution order of patterns affects results.
For example, with ellipsis "..." handling,
if the single-dot pattern executes first, the ellipsis gets broken apart.

Every new edge case discovered requires a new pattern,
making the system increasingly fragile.

This is what motivated us to explore the Parser approach.
-->

---

<!-- _class: scale-90 -->

# Inspiration from Kaneko-san's Talk

<div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 2em; align-items: center;">

<div>

<img src="images/rubyconftw2025-kaneko.jpg" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

</div>

<div>

**"Understanding Ruby Grammar Through Conflicts"**

<div style="margin: 1.5em 0; padding: 1em; background: #f5f5f5; border-left: 4px solid #CC342D; border-radius: 4px;">

**The Three Stages of Parser Processing**

1. **Lexical Analysis**
2. **Syntax Analysis**
3. **Semantic Analysis**

</div>

<div style="margin-top: 2em; padding: 1em; background: linear-gradient(135deg, #fff3cd 0%, #fff 100%); border-radius: 8px;">

<div style="text-align: center; font-size: 1.1em; margin-bottom: 0.8em;">

**"What I've been doing... is actually a Parser!"**

</div>

<div style="text-align: center; font-size: 1.05em; margin-top: 1em; padding-top: 1em; border-top: 2px dashed #CC342D;">

→ **"Let me try reimplementing it the Parser way"**

</div>

</div>

</div>

</div>

<!--
Speaker Note:
Recent developments in Ruby Parser have brought many talks about Syntax Parsers.

After attending Kaneko-san's talk at RubyConf Taiwan last year,
I realized that the word segmentation processing I had been doing
was actually a form of the three-stage Parser processing.

So I decided to reimplement it using the Parser approach,
and share my insights through this process.
-->

---

<!-- _class: center highlight -->
<!-- _header: "" -->

# Conference Driven Development

**Reimplementing word segmentation alignment using the Parser approach**

<!--
Speaker Note:
This is also a form of Conference Driven Development.

I originally had no intention of rewriting it.
But inspired by someone else's talk, I discovered this possibility,
which led to this presentation and research.
-->

---

<!-- _class: scale-85 -->

# Introduction to the Parslet Gem

**A DSL library for writing Parsers in Ruby**

<div class="two-columns">

<div>

## Why Parslet?

- **PEG Parser**: Parsing Expression Grammar
- **Ruby DSL**: Define Parsers using Ruby syntax
- **Clear structure**: Naturally implements 3-phase design

```ruby
# Basic form of Parslet
class MyParser < Parslet::Parser
  # Phase 1 & 2: Rule definitions
  rule(:word) { match['a-z'].repeat(1) }
  rule(:sentence) { word >> space }

  root(:sentence)
end
```

</div>

<div>

## Parslet's Design Philosophy

Parslet naturally guides developers to be aware of **3 Phases**:

**Phase 1: Lexical Analysis**
- `rule()` defines Token types
- `match[]`, `str()` define character patterns

**Phase 2: Syntax Analysis**
- `>>`, `|` combine rules
- Automatically constructs AST

**Phase 3: Semantic Analysis**
- `Transform` class performs conversions
- AST → Final data structure

</div>

</div>

<!--
Speaker Note:
When searching for Ruby Parser Gems, I discovered Parslet.

Parslet is a library for writing PEG (Parsing Expression Grammar) Parsers using Ruby DSL.

What's important is its design philosophy:
It naturally guides developers to be aware of three Phases.
Lexical Analysis, Syntax Analysis, and Semantic Analysis.
-->

---

<!-- _class: scale-75 -->

# Parslet DSL Basic Syntax

<div class="three-columns">

<div>

## Basic Syntax

### `rule()` - Define Rules

```ruby
rule(:letter) { match['a-zA-Z'] }
rule(:digit) { match['0-9'] }
```

**Purpose**: Define reusable Parser rules

### `match[]` - Character Classes

```ruby
match['a-z']           # a-z
match['a-zA-Z0-9']     # alphanumeric
match['\u0300-\u036F'] # tone marks
```

**Purpose**: Equivalent to regex `[...]`

### `str()` - String Matching

```ruby
str('-')      # hyphen
str('--')     # double hyphen
str(' - ')    # space-hyphen-space
```

**Purpose**: Exact string matching

</div>

<div>

## Combining Rules

### `>>` - Sequence

```ruby
# A followed by B
rule(:word) { letter >> letter }
```

**Purpose**: Ordered concatenation (AND)

### `|` - Choice

```ruby
# A or B (order matters!)
rule(:token) do
  double_hyphen_word |  # try first
  hyphenated_word       # try second
end
```

**Important**: PEG uses the first matching option

### `.repeat` - Repetition

```ruby
match['a-z'].repeat      # 0 or more
match['a-z'].repeat(1)   # 1 or more
```

</div>

<div>

## AST Construction

### `.as(:symbol)` - Naming

```ruby
# Add a type label to a Token
rule(:word) {
  letter.repeat(1).as(:word)
}

# Output AST
{ word: "hello" }
```

**Purpose**: Identifier name used in the AST

### `root()` - Start Rule

```ruby
# Specify the Parser entry point
rule(:sentence) {
  token >> space?
}
root(:sentence)
```

**Purpose**: Specify which rule to start parsing from

</div>

</div>

<!--
Speaker Note:
Let's look at the basic syntax of Parslet.

On the left is the basic syntax: rule defines rules, match matches characters, str matches strings.
In the middle are combination methods: sequence, choice, and repetition. Note that order matters in PEG.
On the right is AST construction: use as for naming, use root to specify the entry point.

By combining these, you can implement complex language Parsers.
-->

---

<!-- _class: scale-60 -->

# Regexp → Parslet Conversion: Punctuation Handling

<div class="two-columns">

<div>

## GSUB Approach

```ruby
# Part of 65+ patterns
ROMAN_GSUB_PATTERNS = {
  /,/ => ' , ',      # Add spaces around commas
  /\./ => ' . ',     # Add spaces around periods
  /!/ => ' ! ',      # Add spaces around exclamation marks
  /\?/ => ' ? ',     # Add spaces around question marks
  # ... 60+ other patterns
}

# Apply
text = "suà-lo̍h,lâi-khuànn"
ROMAN_GSUB_PATTERNS.each do |pattern, replacement|
  text = text.gsub(pattern, replacement)
end
# => "suà-lo̍h , lâi-khuànn"
```

**Approach**: Surround symbols with spaces → then split

</div>

<div>

## Parslet Approach

```ruby
# Directly recognize punctuation as Tokens
rule(:punctuation) do
  str('...') | str('⋯⋯') | str('……') |  # Multi-char first
  match[',.:;()!?？！/~、─…⋯'] |         # Single char
  match["\"'\u201C\u201D\u2018\u2019"] |  # Quotes
  match['\u3000-\u303F']                  # CJK symbols
end

# Token rule
rule(:token) do
  hyphenated_word.as(:word) |
  punctuation.as(:punct)
end
```

**Input**: `"suà-lo̍h,lâi-khuànn"`

**Output (AST)**:
```ruby
[
  { word: "suà-lo̍h" },
  { punct: "," },
  { word: "lâi-khuànn" }
]
```

**Approach**: Structured into Tokens → no split needed

</div>

</div>

<!--
Speaker Note:
Comparing the GSUB approach with the Parslet approach.

The GSUB approach adds spaces around symbols, then splits later.
The Parslet approach directly recognizes symbols as Tokens.

The result is a structured AST, no split needed.
-->

---

<!-- _class: scale-65 -->

# Regexp → Parslet Conversion: Hyphen and Syllable Mapping

<div class="two-columns">

<div>

## Preserving Hyphens

### GSUB Approach

```ruby
# Step 1: Symbol normalization
text = "suà-lo̍h lâi-khuànn"
# Hyphens preserved (important!)

# Step 2: Split by whitespace
tokens = text.split(/\s/)
# => ["suà-lo̍h", "lâi-khuànn"]

# Step 3: Count syllables
syllables = "suà-lo̍h".split('-').size
# => 2

# Step 4: Take corresponding number of Kanji
kanji_chars = ["紲", "落", "來", "看"]
combined = kanji_chars.shift(syllables).join
# => "紲落"
```

**Principle**: Hyphen = syllable boundary

</div>

<div>

### Parslet Approach

```ruby
# Recognize hyphenated word as a single Token
rule(:hyphenated_word) do
  syllable >>
  (single_hyphen >> syllable).repeat
end

# "suà-lo̍h" → { word: "suà-lo̍h" }
```

**Syllable counting**:
```ruby
# Phase 3: Transform
rule(word: simple(:w)) do
  syllables = w.to_s.split('-').size
  # => 2
end
```

**Kanji mapping**:
```ruby
# Number of syllables = number of Kanji characters
"suà-lo̍h".split('-').size  # => 2
"紲落".chars.size            # => 2
# ✅ Match!
```

**Principle**: Parser preserves syllable structure → automatic mapping

</div>

</div>

<!--
Speaker Note:
Comparing hyphen handling and syllable counting.

The GSUB approach preserves hyphens, uses split to count syllables,
then takes the corresponding number of Kanji characters.

The Parslet approach lets the Parser automatically preserve syllable structure,
and in Phase 3, counting syllables automatically maps to Kanji.

This is the structural advantage of the Parser approach.
-->

---

<!-- _class: scale-75 -->

# The Actual RomanParserPure: 8 Token Types

<div class="two-columns">

<div>

## Token Assembly (Order = PEG Priority)

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

**Most specific rules go first; PEG tries the longest match first**

</div>

<div>

## Real-World Scenarios for Each Type

| # | Type | Example | Scenario |
|---|------|---------|----------|
| 1 | Double hyphen prefix | `--kóng` | Word after quotation mark |
| 2 | Prefix hyphen | `-pha` | Alternative reading `(-pha)` |
| 3 | Underscore placeholder | `lán_` | Missing character placeholder |
| 4 | Regular hyphenated word | `suà-lo̍h` | Most common |
| 5 | Number | `100` | Mixed numbers |
| 6 | Bopomofo | `ㄅㄆㄇ` | Mixed text |
| 7 | Kanji | `台灣` | Kanji within POJ |
| 8 | Punctuation | `，。「」` | Full-width/half-width/CJK |

</div>

</div>

<div style="text-align: center; margin-top: 0.5em; padding: 0.5em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**With 100,000+ corpus entries, every possible case exists → See GitHub for full source code**

</div>

<!--
Speaker Note:
The actual Parser needs to recognize 8 Token types.

The order matters — PEG uses the first match.
The most specific, double_hyphen_word, goes first; the most general, punctuation, goes last.

Each type was discovered from real-world scenarios across 100,000+ corpus entries.
For example, words following quotation marks, alternative readings with prefix hyphens,
missing character placeholders with underscores, and even Kanji and Bopomofo mixed into POJ text.

The full source code is available on GitHub.
-->

---

<!-- _class: scale-80 -->

# GSUB vs Parser Comparative Analysis

<div class="two-columns">

<div>

## Comparison by Aspect

| Aspect | GSUB | Parser |
|--------|------|--------|
| **Maintainability** | 65+ patterns, hard to debug | Declarative rules, self-documenting |
| **Readability** | Sequential gsub chain | Grammar-like DSL |
| **Performance** | Multiple string scans | Single-pass parsing |
| **Extensibility** | Add more patterns | Add/modify rules |
| **Testing** | Can only test entire pipeline | Can test individual rules |
| **Error handling** | Silent failures | Structured parse errors |

</div>

<div>

## When to Use Each Approach

### GSUB approach works well for...
- Rapid prototyping
- Cases with few patterns
- Existing systems the team is familiar with
- **Still used in production for this project**

### Parser approach works well for...
- Systems requiring long-term maintenance
- Complex grammatical structures
- Structured error messages needed
- Education and research purposes

<div style="margin-top: 1em; padding: 1em; background: #fff3cd; border-radius: 8px; border: 2px solid #ffc107;">

**Conclusion**: Not a replacement, but **complementary**
The Parser approach serves as theoretical validation of the GSUB approach

</div>

</div>

</div>

<!--
Speaker Note:
Comparing the two approaches across various aspects.

GSUB is weaker in maintainability and readability,
but has advantages in rapid prototyping.

The Parser approach is better in maintainability, readability, and test-friendliness,
but requires more prerequisite knowledge.

The key takeaway: production for this project still uses the GSUB approach.
The Parser approach serves as theoretical validation and for educational purposes.
The two are complementary, not a replacement for one another.
-->

---

<!-- _class: scale-80 -->

# Comparison with Ruby Parser

<div class="two-columns">

<div>

## Ruby Parser (Prism)

```ruby
# Input
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

## Taiwanese POJ Parser (RomanParserPure)

```
# Input
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

**Note**: Experimental implementation (educational purpose)

</div>

</div>

<!--
Speaker Note:
Here we compare Ruby's Prism Parser with our RomanParserPure.

Both share the same three-phase structure:
Lexical Analysis, Syntax Analysis, and Semantic Analysis.

Of course, the Ruby Parser is far more complex—
this is just an experimental implementation.

But the key takeaway is: the Parser mindset isn't only applicable to programming languages;
it can also be applied to natural language processing.
-->

---

<!-- _class: scale-80 -->

# Kanji Processing Depends on the POJ Parser

**A one-way dependency: parse the complex structure first**

<div class="two-columns">

<div>

## POJ Parser (Complex)

```ruby
# RomanParserPure - implemented with Parslet
roman_array = [
  "suà-lo̍h",      # 2 syllables
  "lâi-khuànn",    # 2 syllables
  "Sin-tik-tshī"   # 3 syllables
]

# Count syllables
"suà-lo̍h".split('-').size  # => 2
"Sin-tik-tshī".split('-').size  # => 3
```

**Complex processing:**
- Semantic analysis of hyphens (syllable vs. inter-word)
- Tone mark recognition (Unicode combining characters)
- Special handling of double hyphens (--)
- Grammar rule definition and AST construction

</div>

<div>

## Kanji Processing (Simple)

```ruby
# Just follow the POJ syllable count
kanji = "紲落來看新竹市"

# 1. "suà-lo̍h" = 2 syllables
#    → Take 2 Kanji characters: "紲落"
# 2. "lâi-khuànn" = 2 syllables
#    → Take 2 Kanji characters: "來看"
# 3. "Sin-tik-tshī" = 3 syllables
#    → Take 3 Kanji characters: "新竹市"

kanji_array = ["紲落", "來看", "新竹市"]
```

**Simple processing:**
- Syllable count = character count correspondence
- Pattern matching (for edge cases)
- No independent syntax analysis needed

</div>

</div>

<!--
Speaker Note:
The important observation here is the one-way dependency.

The POJ Parser handles the complex processing:
semantic analysis of hyphens, tone mark recognition, and grammar rule definition.

Kanji processing is simple—just take characters according to the POJ syllable count.

This is a key principle from compiler theory:
parse the complex structure first, and the simple structure naturally follows.
-->

---

<!-- _class: scale-80 -->

# Testing and Quality Assurance

<div class="two-columns">

<div>

## Test Results

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

- **3,000 real corpus records**
- **100% parse success rate**

</div>

<div>

## Balance Validation (arrays_balanced)

### Triple Check
```ruby
self.arrays_balanced = [
  # 1. Arrays are not empty
  roman_array.size.positive?,
  # 2. Both sides have equal element count
  roman_array.size == kanji_array.size,
  # 3. Total Kanji characters = original text length
  kanji_array.join.size ==
    washed_kanji.delete(' ').size
].all?
```

### Why a Triple Check?
1. **Non-empty check**: Prevent empty data from passing
2. **Count consistency**: Every Kanji group has a corresponding POJ
3. **Character count conservation**: Ensure nothing is missing or duplicated

### Significance of Validation
- Not just successful parsing, but ensuring **correctness**
- Character count conservation is the strongest validation condition
- Any segmentation error is caught by the 3rd condition

</div>

</div>

<!--
Speaker Note:
The test results show all 3,000 real corpus records parsed successfully.

But successful parsing alone isn't enough—
we use a triple check to ensure correctness.

First, the arrays must not be empty.
Second, the roman and kanji element counts must match.
Third, and most importantly: the total Kanji character count must equal the original text length.

This character count conservation check catches any segmentation error.
-->

---

<!-- _class: scale-80 -->

# More Real-World Examples

<div class="two-columns">

<div>

## Mixed Punctuation

**Input:** `「好食」，真好食！`

| Kanji | Roman |
|-------|-------|
| 「 | 「 |
| 好食 | hó-tsia̍h |
| 」， | 」, |
| 真 | tsin |
| 好食 | hó-tsia̍h |
| ！ | ! |

**Both full-width and half-width punctuation correctly aligned** ✅

</div>

<div>

## Inter-word Pause (--) and Passport Numbers

**Input:** `日時斷斷仔`

| Kanji | Roman |
|-------|-------|
| 日時 | ji̍t--sî |
| 斷斷仔 | tuān-tuān-á |

`--` doesn't count as a syllable → `ji̍t--sî` = **2** syllables ✅

## Other Common Scenarios

- **Passport numbers**: `五二三九五一七空` → 8 single characters each mapped to 1 syllable
- **Temperature numbers**: `二十九` → `lī-tsa̍p-káu` (3 characters = 3 syllables)
- **Consecutive punctuation**: `...。` → separated into two tokens

</div>

</div>

<!--
Speaker Note:
Let's look at some interesting real-world examples.

On the left is a mixed punctuation example.
Full-width quotation marks and half-width commas and exclamation marks are all correctly aligned.

Top right shows the inter-word pause.
The double hyphen doesn't affect syllable counting—ji̍t--sî is 2 syllables corresponding to 2 Kanji characters.

Below on the right are other common scenarios,
like passport numbers with 8 single-character Kanji mapped one-to-one, temperature numbers, and so on.

These are all real data from over 100,000 corpus entries.
-->

---

<!-- _class: scale-80 -->

# Taiwanese Corpus System

- **Official Name**: Taiwan Taiwanese Corpus Application Search System
- **Public URL**: https://tggl.naer.edu.tw
- **Commissioned by**: Ministry of Education / National Academy for Educational Research

<div style="text-align: center; margin: 1.5em 0;">

![w:720](images/naer-homepage.png)

</div>

<!--
Speaker Note:
This technology is used in the Taiwanese Corpus System.
The system is publicly available at https://tggl.naer.edu.tw.

It has three main features: corpus search, textbook vocabulary, and grammar point search.
Word segmentation alignment processing is the foundational technology behind all three features.
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

# Conclusion

**The Universality of Compiler Theory**
- Programming language Parsers → Natural language processing
- Ruby's 3-phase analysis → Taiwanese word segmentation alignment

**Choose the right tools, understand the principles, and even complex problems become solvable**

**Learn from conferences, take on new domains**
- Apply existing knowledge to new problems
- A path of growth as an engineer

<!--
Speaker Note:
And now the conclusion.

The universality of compiler theory:
the Parser mindset from programming languages can be applied to natural language processing.
Ruby's three-phase analysis can be used for Taiwanese word segmentation alignment.

What matters is choosing the right tools and understanding the principles.
Ruby's regular expressions, method chaining, and the Rails ecosystem—
when combined correctly, they can solve seemingly complex problems.

Also, by learning from conference talks
and applying existing knowledge to new problem domains,
that is the path of growth as an engineer.
-->

---

<!-- _class: scale-95 -->

# Thank You!

<div class="two-columns">

<div style="text-align: center;">

## Slides & Source Code

![w:200](images/github-qr-code.jpg)

**https://github.com/ryudoawaru/rwc2025-slide**

**Includes:**
- Full RomanParserPure implementation
- 3,000 real corpus test data

</div>

<div>

## Quick Start

```bash
# Clone
git clone https://github.com/
  ryudoawaru/rwc2025-slide
cd rwc2025-slide

# Install dependencies
bundle install

# Test with sample data (~3,000 records)
ruby test_parser.rb

# Full 64,554 records test
ruby test_parser.rb \
  test_data/corpora_data_new.json
```

</div>

</div>

<!--
Speaker Note:
The QR code on the left links to the GitHub repo,
which contains the full RomanParserPure implementation and 3,000 test data records.

On the right is the Quick Start—clone the repo, run bundle install,
then run ruby test_parser.rb to test.
By default it uses 3,000 sample records, but you can also specify the full 64,554 corpus records for testing.

Feel free to download and try it out. Thank you all!
-->

<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
