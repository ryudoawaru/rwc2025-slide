# CLAUDE.md

## RubyWorld Conference 2025 Presentation

This project aims to generate Marp format slides for presentation at RubyWorld Conference 2025 on November 6th. A Chinese version will also be prepared for RubyJam on October 28th.

## Slide Files

- **Japanese (RubyWorld Conference 2025)**: `slide-ja.md`
- **Chinese (RubyJam 2025)**: `rubyjam.md`
- **Theme**: `5xruby.css` (shared)
- **Presentation Time**: 15 minutes each (pure presentation, no Q&A)

## RubyJam 2025 Chinese Version (`rubyjam.md`)

### Overview

Traditional Chinese adaptation of the RubyWorld Conference 2025 presentation for RubyJam (Taiwan audience). Since Taiwan audience already knows 5xRuby and local government project context, intro is minimal (2 pages vs 5). Freed-up time goes to deeper technical content.

- **File**: `rubyjam.md`
- **Theme**: `5xruby` (same CSS)
- **Header**: `'RubyJam 2025'`
- **Language**: Traditional Chinese (speaker notes also in Chinese)
- **Total Pages**: 33 (32 content + frontmatter)
- **Status**: Draft - content complete, pending edit & translation refinement

### Differences from `slide-ja.md`

| Aspect | slide-ja.md (Japanese) | rubyjam.md (Chinese) |
|--------|----------------------|---------------------|
| Audience | Japanese (RubyWorld) | Taiwanese (RubyJam) |
| Intro pages | 5 (Matsue MOU, 5xRuby detail) | 2 (minimal self-intro) |
| "No bidders" story | 3 pages | 1 page (condensed) |
| Edge Cases page | - | Page 17 (new) |
| GSUB Challenges page | - | Page 18 (new) |
| Parslet Complete Rules | - | Page 25 (new, 8 token types) |
| GSUB vs Parser comparison | - | Page 26 (new) |
| Testing & QA page | - | Page 29 (new) |
| Real corpus examples | - | Page 30 (new) |
| Raw data comparison | - | Page 10 (xlsx vs csv) |
| Last page 2nd col | 5xRuby company intro | Quick Start (clone & test) |
| Speaker notes | Japanese with furigana | Chinese |

### Page Structure (33 pages)

#### Part 1: Opening (Pages 1-3) ~1 min
| Page | Title | Class |
|------|-------|-------|
| 1 | 像寫程式一樣解析台語 - Ruby 白話字羅馬字三階段解析 | `lead scale-95` |
| 2 | 自我介紹 | `center scale-95` |
| 3 | 議程 | `scale-90` |

#### Part 2: Background (Pages 4-5) ~1 min
| Page | Title | Class |
|------|-------|-------|
| 4 | 這個案子為什麼沒人投標？ | `center highlight` |
| 5 | 台羅（POJ）是什麼？ (transition) | `lead` |

#### Part 3: POJ Introduction (Pages 6-10) ~2.5 min
| Page | Title | Class |
|------|-------|-------|
| 6 | 台羅（台灣閩南語羅馬字）是什麼？ | `scale-85` |
| 7 | 漢字與音標的對應關係 | `scale-80` |
| 8 | 實際的分詞對齊處理範例 | `scale-80` |
| 9 | 原始資料與拆好的資料對比 | `scale-75` |
| 10 | 分詞對齊實作 (transition) | `lead` |

#### Part 4: Implementation - GSUB (Pages 11-17) ~3.5 min
| Page | Title | Class |
|------|-------|-------|
| 11 | 實作全體流程：3 個 Phase | `center` |
| 12 | Phase 1: 正規化 (WASH) | `scale-65` |
| 13 | Phase 2-1: splitted_kanji | `scale-80` |
| 14 | Phase 2-2: splitted_roman | `scale-85` |
| 15 | Phase 3: 對齊與驗證 | `scale-75` |
| 16 | Edge Cases 深入分析 | `scale-75` |
| 17 | GSUB 模式的問題 | `scale-85` |

#### Part 5: From GSUB to Parser (Pages 18-26) ~5 min
| Page | Title | Class |
|------|-------|-------|
| 18 | 金子さん的演講啟發 | `scale-90` |
| 19 | Conference Driven Development | `center` |
| 20 | Parslet gem 介紹 | `scale-85` |
| 21 | Parslet DSL 基礎語法 | `scale-75` |
| 22 | Regexp → Parslet 轉換：標點符號處理 | `scale-60` |
| 23 | Regexp → Parslet 轉換：連字符與音節對應 | `scale-65` |
| 24 | 實際的 RomanParserPure：8 種 Token 類型 | `scale-75` |
| 25 | GSUB vs Parser 比較分析 | `scale-80` |

#### Part 6: Insights & Results (Pages 26-31) ~2.5 min
| Page | Title | Class |
|------|-------|-------|
| 26 | 與 Ruby Parser 的比較 | `scale-80` |
| 27 | 漢字處理依賴 POJ Parser | `scale-80` |
| 28 | 測試與品質保證 | `scale-80` |
| 29 | 更多真實案例展示 | `scale-75` |
| 30 | 台語語料庫系統 | `scale-80` |

#### Part 7: Conclusion (Pages 31-33) ~0.5 min
| Page | Title | Class |
|------|-------|-------|
| 31 | 結論 | `center highlight` |
| 32 | 謝謝！ | `scale-95` |

### New Pages (not in slide-ja.md)

1. **Page 9: 原始資料與拆好的資料對比** - Shows actual xlsx source data (107,294 rows) vs processed csv output side-by-side
2. **Page 16: Edge Cases 深入分析** - 4 categories: number handling, POJ-in-kanji, punctuation sequences, prefix hyphens
3. **Page 17: GSUB 模式的問題** - 65+ patterns maintenance difficulty, order-dependency bugs
4. **Page 24: 實際的 RomanParserPure：8 種 Token 類型** - Compact token rule code + table of 8 types
5. **Page 25: GSUB vs Parser 比較分析** - Side-by-side comparison table (maintainability, readability, performance, extensibility, testing, error handling)
6. **Page 28: 測試與品質保證** - test_parser.rb output, balance validation triple check
7. **Page 29: 更多真實案例展示** - Mixed punctuation, double-hyphen, passport number examples

### Reused Assets from slide-ja.md
- All images from `images/` directory
- `rwc2025-setarr.drawio.svg` (flowchart)
- `2024_AVATAR_RYUDOAWARU.jpg` (avatar)
- `naer-homepage.png` (system screenshot)
- `rubyconftw2025-kaneko.jpg` (conference photo)
- `github-qr-code.jpg`, `qrcode-slide.jpg` (QR codes)
- `search_corpus_in_system.gif`, `textbook_search.webm`, `grammar-search.webm` (demos)

### Preview
```bash
npx @marp-team/marp-cli@latest -s ./
# Open http://localhost:8080/rubyjam.md
```

## Project Goals

- Generate Marp format slides in Japanese for RubyWorld Conference 2025 (15-minute presentation) with speaker notes
- Target file: slide-ja.md
- All images stored in `images/`

## Image Generation

Reference styles used:

Simplified ICON style:

```
Flat design icon: A simple maze from top view with a confused person holding a "RFP 要求仕様書" document in the center. Red X marks on wrong paths. Golden orange and cream color scheme. Minimalist style.
```

General style:
```
A flat design illustration showing two contrasting scenes split vertically. Left side: a developer sitting at a computer with code on
  the screen, looking stressed and looking at a clock showing limited time. Right side: the same developer in a business suit at a
  networking event, shaking hands with multiple government officials, holding a stack of business cards, with a calendar in background
  showing "営業活動: 80%" (Sales Activities: 80%) in Japanese. The developer's laptop is closed and pushed to the side. The contrast
  shows time being taken away from development work. Color scheme: warm golden orange/amber for suits and main elements, cream/beige
  background, brown outlines. Soft pastel illustration style, warm and friendly colors, clean lines. Same color palette throughout both
  scenes.
```

Overall text should be in Japanese.

## Presentation Structure Overview (Latest Version 2025-11-01)

### Main Sections

**Total Pages**: ~30+ pages (including detailed technical pages)
**Presentation Time**: 15 minutes

1. **Opening** (Pages 1-5)
   - Page 1: Title Page
   - Page 2: Self Introduction
   - Page 3: 10-Year Story with RubyCity Matsue (MOU)
   - Page 4: About 5xRuby
   - Page 5: 5xRuby's Business

2. **Act 1: The Story of No Bidders** (Pages 6-8)
   - Page 6: Peculiarities of Taiwan Government Projects
   - Page 7: Lessons from 8 Consecutive Losses
   - Page 8: Truth After Winning Bid (Word segmentation too complex, nobody dared)

3. **Act 2: What is POJ (Taiwanese Romanization)?** (Pages 9-11)
   - Page 9: What is POJ?
   - Page 10: Japanese and Taiwanese Writing Systems
   - Page 11: Real Example of Word Segmentation Alignment Processing

4. **Act 3: Word Segmentation Alignment Implementation** (Pages 12-20) ⭐ Reorganized
   - Page 12: Pattern Rule Systematization (65+ patterns)
   - Pages 13-15: Original implementation approach (old pages)
   - **Pages 16-20: 3-Phase Implementation Flow** 🆕
     - Page 16: Flow Overview Diagram (Flowchart)
     - Page 17: Phase 1 - washed_kanji & washed_roman (WASH) - **Merged** ✨
     - Page 18: Phase 2-1 - splitted_kanji (SPLIT)
     - Page 19: Phase 2-2 - splitted_roman (SPLIT)
     - Page 20: Phase 3 - roman_kanji_array & set_arrays (ALIGN)

5. **Act 4: Encounter with Parser** (Pages 21-26) ⭐ Core Section
   - Page 21: Inspiration from RubyConf Taiwan x COSCUP 2025
   - Page 22: Insights from Kaneko's Talk
   - Page 23: RomanParser - Parslet Implementation
   - Pages 24-26: Parser analysis and comparison
   - **Page 27: Why Kanji Doesn't Need a Parser?**
     - POJ syllable count = Kanji character count
     - 1:1 automatic alignment principle

6. **Act 5: Ruby's Advantages** (Pages 28-29)
   - Page 28: Ruby's 3 Key Advantages
   - Page 29: Project Results

7. **Conclusion** (Pages 30-31)
   - Page 30: Summary
   - Page 31: Thank You

### Key Page Markers

- 🆕 **Pages 16-20**: Completely reorganized with 3-phase structure (WASH → SPLIT → ALIGN)
- 🆕 **Page 16**: New flowchart overview page using `images/rwc2025-setarr.drawio.svg`
- ✨ **Page 17**: Merged Phase 1-1 and 1-2 into single two-column page (WASH)
- 📝 **Edge Case Example**: All pages 16-20 use `做工課的Lín--sàng。` / `tsò-khang-khuè ê Lín--sàng.`
- ⭐ **Page 27**: Core insight page explaining why Kanji doesn't need independent Parser
- 🔄 **Layout**: All new pages use two-column layout with `scale-85`, `scale-80`, or `scale-75`

## Important Revision Log

### 2025-11-01: Pages 16-20 Complete Reorganization & Page Merge 🎯

#### Major Structural Changes
1. **Replaced Pages 16-21 with 3-Phase Implementation Flow (Now Pages 16-20)**
   - **Old Structure**: 4-step linear flow (Step 1-4)
   - **New Structure**: 3-phase approach (WASH → SPLIT → ALIGN)
   - **Reason**: Better alignment with compiler theory concepts, clearer separation of concerns

2. **New Page 16: Flowchart Overview**
   - **Purpose**: Visual overview of entire 3-phase process
   - **Image**: `images/rwc2025-setarr.drawio.svg`
   - **Layout**: `center` class with 860px image width
   - **Fix**: Resolved header overlap issue by using proper Marp directives

3. **Phase 1: WASH (正規化) - Page 17** ✨ **Merged**
   - **Old**: Two separate pages (Page 17 + Page 18)
   - **New**: Single two-column page
   - Left column: `washed_kanji` - Kanji normalization with KANJI_GSUB_PATTERNS
   - Right column: `washed_roman` - POJ normalization with ROMAN_GSUB_PATTERNS
   - Both show before/after examples with edge case
   - **Layout**: `scale-65` (adjusted from `scale-75` to fix 28px overflow)

4. **Phase 2: SPLIT (分割) - Pages 18-19**
   - Page 18: `splitted_kanji` - Kanji splitting with RXP_SPK regex
   - Page 19: `splitted_roman` - POJ splitting (simple space-based split)
   - Emphasis on syllable counting for alignment

5. **Phase 3: ALIGN (対齊) - Page 20**
   - Shows `roman_kanji_array` and `set_arrays` methods
   - Demonstrates final array construction and balance validation
   - Includes complete result table

#### Edge Case Example Unification
- **Consistent Example**: All pages 16-20 now use:
  - Kanji: `做工課的Lín--sàng。`
  - Roman: `tsò-khang-khuè ê Lín--sàng.`
- **Reason**: Demonstrates Roman text embedded in Kanji, a critical edge case

#### Speaker Notes Localization Improvement
- **Problem**: Original Speaker Notes contained Taiwanese romanization pronunciations
- **Issue**: Japanese audience cannot pronounce Taiwanese POJ
- **Solution**: Removed all Taiwanese romanization from Speaker Notes
- **Changes**:
  - Page 16: "画面に表示されている入力データ" instead of specific Taiwanese text
  - Page 17: "漢字の中の Roman 文字" instead of "Lín--sàng"
  - Page 19: "Roman 文字部分" instead of "「Lín--sàng」"
  - Page 20: "最初の単語は 3 音節" instead of "「tsò-khang-khuè」は 3 音節"
  - Page 21: "Edge Case の部分は特別" instead of "「Lín--sàng」は Edge Case"

#### Layout Consistency
- **Two-column layout**: All pages use `<div class="two-columns">`
- **Scale classes**: Applied `scale-85`, `scale-80`, or `scale-75` based on content density
- **Code blocks**: Consistent syntax highlighting and formatting
- **Tables**: Aligned data presentation in Phase 3

#### Technical Accuracy
- All code examples verified against `/Users/ryudo/RailsPrjs/NaerTDSS/app/models/concerns/corpora_array_settable.rb`
- Method implementations match actual production code
- Constants (KANJI_GSUB_PATTERNS, ROMAN_GSUB_PATTERNS) accurately represented

### 2025-11-01 (Part 2): Phase 1 Page Merge Completion ✨

#### Page Simplification Achievement
1. **Successfully Merged Phase 1-1 and 1-2 into Single Page**
   - **Old Structure**: 2 separate pages (lines 686-830)
   - **New Structure**: 1 two-column page (lines 686-764)
   - **Reduction**: Saved 1 page (from 6 pages → 5 pages for Phase 1-3 sections)

2. **Layout Optimization**
   - **Initial attempt**: `scale-75` → 28px overflow detected
   - **Second attempt**: `scale-70` → 10px overflow remaining
   - **Final solution**: `scale-65` → 0px overflow ✓
   - **Verification**: Chrome DevTools measurement confirmed perfect fit

3. **Page Numbering Updates**
   - Updated CLAUDE.md presentation structure (Act 3: Pages 12-21 → Pages 12-20)
   - Updated Act 4 page numbers (Pages 22-27 → Pages 21-26)
   - Updated Act 5 page numbers (Pages 29-30 → Pages 28-29)
   - Updated Conclusion page numbers (Pages 31-32 → Pages 30-31)
   - Fixed slide-ja.md reference: "Page 17 & 18" → "Page 17"

4. **Documentation Updates**
   - Key Page Markers section updated to reflect merge
   - Added ✨ marker for merged page
   - Updated Edge Case Example reference (Pages 16-21 → Pages 16-20)

#### Testing Results
- **Browser**: Chrome DevTools at http://localhost:8080/slide-ja.md
- **Page Position**: Index 18 (Page 19 in presentation)
- **Final Measurements**:
  - scrollHeight: 720px
  - clientHeight: 720px
  - overflowAmount: 0px ✓
  - hasOverflow: false ✓

### 2025-10-19: Presentation Structure Reorganization and Optimization 🎯

#### Removed Redundant Pages
1. **Deleted Original Page 28 "3-Phase Analysis Details"**
   - **Reason**: Duplicates Phase 1/2/3 detail pages
   - **Location**: Lines 2017-2066
   - **Impact**: Presentation more focused, avoiding repetition

2. **Deleted Original Page 29 "Compiler Theory Application"**
   - **Reason**: Only repeats abstract concepts, no new information
   - **Content**: Only explains Parser knowledge can apply to NLP, already proven in Page 27 comparison
   - **Impact**: After removal, flows directly into Ruby advantages section, better logic

#### Added Key Page
3. **Added Page 28 "Why Kanji Doesn't Need a Parser?"** ⭐
   - **Position**: After Page 27 "Comparison with Ruby Parser"
   - **Core Concept**: POJ syllable count = Kanji character count
   - **Content Structure**:
     - Left column: POJ Parser output and syllable counting
       - `"suà-lo̍h".split('-').size # => 2`
       - Hyphen = syllable separator
     - Right column: Kanji automatic alignment
       - 2 syllables → Take 2 Kanji "紲落"
       - 3 syllables → Take 3 Kanji "新竹市"
   - **Conclusion**:
     - ✅ Kanji split using POJ Parser's syllable info
     - ✅ Kanji Parser unnecessary
     - ✅ Achieved through simple character counting
   - **Speaker Notes Key Points**:
     - Explain 1 syllable = 1 Kanji correspondence
     - Show concrete steps from POJ syllable count to Kanji count
     - Analogy to Ruby Parser principle: complex structure parsed first, simple structure naturally corresponds
     - Emphasize universality of Compiler theory

#### Logic Improvements
- **Before**: Comparison → 3-Phase Details → Abstract Theory → Ruby Advantages
- **After**: Comparison → **Why Kanji Doesn't Need Parser** → Ruby Advantages
- **Improvements**:
  - Reduced repetition
  - Added key insight (Parser one-way dependency)
  - More coherent logic: Parser comparison → Deep understanding (why Kanji doesn't need) → Technical advantages

### 2025-10-12: Terminology Unification
- **Change**: `拆字（分詞）` → `分詞アライメント処理` (Word Segmentation Alignment Processing)
- **Location**: Line 295
- **Reason**: Use more precise technical terminology

### 2025-10-12: Page 12a Major Correction
- **Issue**: Originally listed 4 hyphen handling types, but type 4 (`文脈依存の分離`) not actually implemented
- **Fix**: Changed to 3 handling types
  1. Intra-word hyphens (preserve)
  2. Double hyphen (boundary marker)
  3. Prefix hyphen (inter-word pause)
- **New Example**: `ji̍t--sî` (date-time)
  ```
  Kanji: "日時斷斷仔"
  POJ:   "ji̍t--sî tuān-tuān-á"
  ```
- **Key Findings**:
  - Final split uses space (`split(/\s/)`), not hyphen
  - `--` handled on KANJI side (line 68), but commented out on ROMAN side (lines 48-49)
  - Prefix hyphen specially handled in `roman_kanji_array` method (lines 146-149)

## Scale Classes Usage

To prevent content overflow into footer area, this presentation uses custom scale utility classes:

```css
section.scale-95 { font-size: 95%; }
section.scale-90 { font-size: 90%; }
section.scale-85 { font-size: 85%; }
section.scale-80 { font-size: 80%; }
section.scale-75 { font-size: 75%; }
section.scale-70 { font-size: 70%; }
section.scale-65 { font-size: 65%; }
```

### Current Usage
- **Pages 12a-12d**: Using `scale-75` (75%)
  - Reason: Technical detail pages, dense content
  - Contains: Code examples, demonstrations, explanatory text

### When to Use Scale Classes
1. Pages rich in technical details
2. Pages with multiple code blocks
3. Pages showing input/output examples simultaneously
4. When content approaches or exceeds footer area

## Code Source Reference

All code examples in this presentation come from actual project, located in parent directory.

### Key Constants
- **ROMAN_GSUB_PATTERNS**: 65+ pattern replacement rules (lines 9-66)
- **KANJI_GSUB_PATTERNS**: Kanji-side pattern rules (lines 67-79)
- **ONE_KANJI_WORDS**: Special single-kanji handling (lines 81-85)
- **SP_MIRRORS**: Special mirror handling (lines 87-89)

### Core Methods
1. **`roman_kanji_array`** (lines 146-176)
   - Main alignment logic
   - Handles prefix hyphens
   - Handles double hyphens

2. **`splitted_roman`** (lines 115-117)
   - Splits POJ using space
   - **Key**: `split(/\s/)`, not splitting by hyphen

3. **`splitted_kanji`** (lines 119-123)
   - Splits Kanji using RXP_SPK regex
   - Combines with `ONE_KANJI_WORDS` handling

4. **`washed_roman`** (lines 101-106)
   - Applies all ROMAN_GSUB_PATTERNS
   - Normalization processing

5. **`set_arrays`** (lines 134-144)
   - Sets arrays and validates balance
   - Error handling

## Technical Terminology Reference (For Presentation)

### Core Terminology (Unified Usage)

| Chinese | Japanese | English | Usage Context | Notes |
|---------|----------|---------|---------------|-------|
| 分詞 | 分詞アライメント処理 | Word Segmentation Alignment | All contexts | Unified full term |
| 台羅 | 台羅（POJ） | Tâi-lô (POJ) | First introduction | Full formal name |
| 白話字 | POJ | Pe̍h-ōe-jī | Technical & general | Unified short form |
| 羅馬字 | POJ 文字 | POJ text/characters | Edge cases, examples | NOT "Roman 文字" |
| 聲調標記 | 声調記号 | Tone Marks | Technical | Unicode combining characters |
| 連字符 | ハイフン | Hyphen | Technical | `-` or `--` |
| 語間停頓 | 語間停頓 | Inter-word Pause | Technical | `--` symbol |
| 對齊 | アライメント | Alignment | Technical | - |
| 平衡性檢查 | バランス検証 | Balance Check | Technical | `arrays_balanced` |
| 字句解析 | 字句解析 | Lexical Analysis | Parser theory | Tokenization |
| 構文解析 | 構文解析 | Syntax Analysis | Parser theory | Pattern Matching |
| 意味解析 | 意味解析 | Semantic Analysis | Parser theory | Validation |

### POJ/台羅 Terminology Guidelines

**Context-based Usage:**
1. **First Introduction** (Page 9): `台羅（POJ）とは？`
2. **Technical Code** (Pages 17-21): `POJ` (in method names, variables)
3. **General Explanation** (Throughout): `POJ` (consistent short form)
4. **Edge Cases** (Pages 17, 19): `POJ 文字` (NOT `Roman 文字`)
5. **Historical Context** (Page 9): `白話字 (POJ)` (only when discussing history)

**Deprecated Terms:**
- ❌ `Roman 文字` → ✅ `POJ 文字`
- ❌ `白話字：` (as label) → ✅ `POJ：`
- ❌ Mixed usage → ✅ Consistent `POJ`

## Speaker Notes Guide

Each page contains detailed Speaker Notes between `<!--` and `-->`.

### Speaker Notes Structure
```markdown
<!--
Speaker Notes Content:
- Key points for this page
- Estimated speaking time
- Technical details to emphasize
- Audience interaction points
-->
```

### Speaker Notes Writing Guidelines

**IMPORTANT**: Since the presentation is for a Japanese audience at RubyWorld Conference, Speaker Notes must follow these rules:

1. **No Taiwanese Romanization Pronunciation**
   - ❌ Don't write: "「tsò-khang-khuè」は 3 音節です"
   - ✅ Instead write: "最初の単語は 3 音節です"
   - **Reason**: Japanese audience cannot pronounce Taiwanese POJ

2. **Use Positional References**
   - ✅ "最初の単語" (first word)
   - ✅ "Edge Case の部分" (Edge Case portion)
   - ✅ "画面に表示されている" (displayed on screen)

3. **Generic Technical Descriptions**
   - ✅ "漢字の中の POJ 文字" (POJ text within Kanji)
   - ✅ "POJ 文字部分" (POJ text portion)

4. **When to Show Taiwanese Text**
   - ✅ On slides (visual reference is fine)
   - ✅ In code examples
   - ✅ In tables
   - ❌ In Speaker Notes (speaker cannot pronounce)

### Example: Pages 16-21 Speaker Notes
```markdown
<!-- Good Example - Page 20 -->
音節数(おんせつすう)の計算(けいさん)について説明(せつめい)します。
最初(さいしょ)の単語(たんご)は 3 音節(おんせつ)です。
Edge Case の部分(ぶぶん)は 2 音節(おんせつ)です。
二重(にじゅう)ハイフン（--）は音節数(おんせつすう)に含(ふく)まれません。

<!-- Bad Example - Avoid This -->
「tsò-khang-khuè」は 3 音節(おんせつ)です。
「Lín--sàng」は 2 音節(おんせつ)です。
```

## Maintenance Notes

### 1. Maintain Code Accuracy
- All code examples must match actual project
- Check latest Git commits before updating code
- Should not show non-existent features

### 2. Scale Classes Adjustment
- Try adjusting scale percentage if content overflows
- Avoid below `scale-65` (65%), affects readability
- Consider splitting into multiple slides

### 3. Terminology Consistency
- Use `分詞アライメント処理` instead of `拆字（分詞）`
- Keep terminology reference table updated (Chinese, Japanese, English)
- Confirm Japanese correctness before adding new terms

### 4. Example Updates
- Examples must come from real corpus data
- Provide complete input/output examples
- Explain representativeness of examples

## Preview and Export

### Local Preview
```bash
npx @marp-team/marp-cli@latest -s ./
```

Open http://localhost:8080/slide-ja.md to check

### Checklist
- [ ] All page content doesn't overflow into footer
- [ ] Code syntax highlighting correct
- [ ] Japanese grammar and terminology correct
- [ ] Speaker Notes complete and clear
- [ ] Example data correct
- [ ] Time controlled within 15 minutes
- [ ] Images and logos display correctly

## Related Resources

### Project Links
- **GitLab**: https://git.5xruby.com/naer/naer/
- **Redmine**: https://redmine.5xruby.com/issues/5432
- **GitHub (Public)**: https://github.com/5xruby/naer

### Reference Documents
- Corpus Model: `app/models/corpus.rb`
- CorporaArraySettable: `app/models/concerns/corpora_array_settable.rb`
- Backend Database File Examples: `後台資料庫檔案範例.xlsx`
- Pre-split Examples: `拆字前的表格範例.xlsx`
- Split Correction Results: `拆字校正結果的範例.xlsx`

### Conference Information
- **Conference**: RubyWorld Conference 2025
- **Date**: November 6-7, 2025
- **Location**: Matsue City, Shimane Prefecture
- **Presentation Time**: 15 minutes (pure presentation, no Q&A)
- **Language**: Japanese

## Basic Information
- **Presentation Title**: コードのように台湾語を解析：Rubyによる白話字ローマ字の3段階解析
- **Presenter**: Mu-Fan Teng (鄧慕凡)
- **Affiliation**: 5xRuby CO., LTD
- **Presentation Time**: 15 minutes (pure presentation, no Q&A)
- **Language**: Japanese
- **Date**: November 6-7, 2025
- **Location**: Matsue City, Shimane Prefecture

## Project Background

### GitLab Project
- **Project URL**: https://git.5xruby.com/naer/naer/
- Please use MCP to reference
- **Key PRs**:
  - PR #30: Initial implementation (basic rules)
  - PR #68: Introduced ROMAN_GSUB_PATTERNS (40+ rules)
  - PR #73: Special case fixes

### Redmine Issue
- **Issue #5432**: https://redmine.5xruby.com/issues/5432
- Please use MCP to reference
- **Content**: Word splitting requirements and examples

### System Overview
- **Name**: Taiwan Taiwanese Corpus Application Search System (NAER)
- **Client**: Ministry of Education / National Academy for Educational Research
- **Scale**: 208 hours of audio data
- **Target Audience**: Elementary and junior high schools across Taiwan for Taiwanese language education

### Original Data Examples

- Backend Database File Examples.xlsx

## Word Splitting Examples (Core Problem)

- Pre-split Table Examples.xlsx
- Split Correction Results Examples.xlsx

### Input Data
```
TA23_43969	紲落來看新竹市明仔載二十六號的天氣	suà-lo̍h lâi-khuànn Sin-tik-tshī bîn-á-tsài gī-tsa̍p-la̍k hō ê thinn-khì
```

### Expected Output

#### Kanji Array
```
紲落｜來看｜新竹市｜明仔載｜二十六｜號｜的｜天氣
```

#### POJ Array
```
suà-lo̍h｜lâi-khuànn｜Sin-tik-tshī｜bîn-á-tsài｜gī-tsa̍p-la̍k｜hō｜ê｜thinn-khì
```

### Technical Challenges
1. Hyphen handling
2. Tone marks
3. Mixed Japanese handling
4. Numeric phonetic changes
5. Special symbol handling

## Japanese Technical Terminology Reference

| Chinese/English | Japanese | Reading |
|----------------|----------|---------|
| Word Splitting | 分詞 | ぶんし |
| POJ | 白話字 | ペーオージー |
| Tone Marks | 声調記号 | せいちょうきごう |
| Hyphen | ハイフン | - |
| Alignment | アライメント | - |
| Complex | 煩雑 | はんざつ |
| Parser | パーサー | - |
| Lexical Analysis | 字句解析 | じくかいせき |
| Syntax Analysis | 構文解析 | こうぶんかいせき |
| Semantic Analysis | 意味解析 | いみかいせき |
| Regular Expression | 正規表現 | せいきひょうげん |
| Ruby Evangelist | Ruby伝道師 | Ruby でんどうし |

### Simplified Demo Code
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

# Execution example
parser = TaigiParser.new
parser.parse("suà-lo̍h lâi-khuànn Sin-tik-tshī")
```

### Running Tests

```bash
# Test sample data (default, ~3,000 entries)
ruby test_parser.rb

# Or specify test file
ruby test_parser.rb test_data/sample_data.json

# Test full 64,554 entries
ruby test_parser.rb test_data/corpora_data_new.json
```

**Test Script Features**:
- Progress bar display (█ and ░ visual effects)
- Real-time percentage updates
- Final statistics
- Error case display (if any)
- Celebration message on 100% success

## Marp Format Notes

### Basic Settings
```yaml
---
marp: true
theme: default
paginate: true
header: 'RubyWorld Conference 2025'
footer: '© 2025 5xRuby'
---
```

### Suggested Styles
```css
/* Custom styles */
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

## Visual Material Suggestions

1. **Opening Page**: 5xRuby Logo + Matsue MOU photo
2. **Story Timeline Chart**: 8 losses → No bidders → Win
3. **POJ Comparison Table**: Animation showing Kanji and POJ correspondence
4. **Code Evolution**: Before/After comparison
5. **Parser Analogy Diagram**: Side-by-side flow chart
6. **Results Data**: Infographic showing 208 hours, schools nationwide
7. **QR Code**: GitHub link

## Time Management Reminders

- Average 30-45 seconds per slide
- Reserve buffer time for demo
- Prepare 15-20 slides
- Use syntax highlighting for key code
- Avoid excessive text, use more visuals

## References

1. **CFP Submission Content**: RubyWorld Conference 2025 Call for Speakers response
2. **System Documentation**: National Academy for Educational Research Taiwan Taiwanese Corpus Application Search System Construction Project
3. **Ministry of Education Project**: Minnan Language Audio Corpus Construction Project (2019-2022)
4. **Technical Documentation**: GitLab project documentation and PR records

## Contact Information

- **Email**: ryudo@5xruby.com
- **GitHub**: https://github.com/5xruby
- **Company**: 5xRuby CO., LTD
- **Phone**: +886939090146

---

*This document is for Claude to generate Marp format slides. Please generate corresponding slide content based on the above.*

---


## Parser Development History

The detailed development history of RomanParserPure (V3 → V8, achieving 100% perfect parsing) has been moved to:

**[PARSER_HISTORY.md](./PARSER_HISTORY.md)**

Key milestones:
- **V3 → V4**: str() vs match[] optimization (99.44%)
- **V5**: Prefix hyphen handling (99.46%)
- **V6**: Complete Unicode range support (99.88%)
- **V7**: Edge case breakthrough (99.99%)
- **V8**: 100% perfect parsing 🏆 (64,554/64,554)

For complete technical details, implementation strategies, and test results, see PARSER_HISTORY.md.

---

**Last Updated:** 2026-02-20
**Maintainer:** 5xRuby Development Team
