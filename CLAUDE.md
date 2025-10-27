# CLAUDE.md

## RubyWorld Conference 2025 Presentation

This project aims to generate Marp format slides for presentation at RubyWorld Conference 2025 on November 6th. A Chinese version will also be prepared for RubyJam on October 28th.

## Slide Files

- **Main File**: `rubyworld-2025-taigi-parser.md`
- **Theme**: `5xruby.css`
- **Presentation Time**: 15 minutes (pure presentation, no Q&A)

## Project Goals

- Generate Marp format slides in Japanese for RubyWorld Conference 2025 (15-minute presentation) with speaker notes
- Target file: rubyworld-2025-taigi-parser.md
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

## Presentation Structure Overview (Latest Version 2025-10-19)

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

4. **Act 3: Word Segmentation Alignment Implementation** (Pages 12-17)
   - Page 12: Pattern Rule Systematization (65+ patterns)
   - Pages 13-16: Implementation Flow
     - Step 1: Kanji Splitting Processing
     - Step 2: POJ Splitting Processing
     - Step 3: Alignment Logic
     - Step 4: Array Construction and Validation

5. **Act 4: Encounter with Parser** (Pages 18-27) ⭐ Core Section
   - Page 18: Inspiration from RubyConf Taiwan x COSCUP 2025
   - Page 19: Insights from Kaneko's Talk
   - Page 20: RomanParser - Parslet Implementation
   - Pages 21-23: 3-Phase Details
     - Phase 1: Lexical Analysis
     - Phase 2: Syntax Analysis
     - Phase 3: Semantic Analysis
   - Page 24: Comparison with Ruby Parser
   - **Page 25: Why Kanji Doesn't Need a Parser?** 🆕
     - POJ syllable count = Kanji character count
     - 1:1 automatic alignment principle

6. **Act 5: Ruby's Advantages** (Pages 26-28)
   - Page 26: Ruby's 3 Key Advantages
   - Page 27: Project Results

7. **Conclusion** (Pages 28-30)
   - Page 28: Summary
   - Page 29: Thank You

### Key Page Markers

- ⭐ **Page 25**: New core insight page explaining why Kanji doesn't need independent Parser
- 🔄 **Deleted**: Original Page 28 "3-Phase Analysis Details" (duplicate)
- 🔄 **Deleted**: Original Page 29 "Compiler Theory Application" (abstract and duplicate)

## Important Revision Log

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

| Chinese | Japanese | English | Notes |
|---------|----------|---------|-------|
| 分詞 | 分詞 | Word Segmentation | Now unified as "分詞アライメント処理" |
| 白話字 | 白話字 | Pe̍h-ōe-jī (POJ) | Taiwanese romanization system |
| 聲調標記 | 声調記号 | Tone Marks | Unicode combining characters |
| 連字符 | ハイフン | Hyphen | - |
| 語間停頓 | 語間停頓 | Inter-word Pause | `--` symbol, similar to Japanese "っ" |
| 對齊 | アライメント | Alignment | - |
| 平衡性檢查 | バランス検証 | Balance Check | `arrays_balanced` |
| 字句解析 | 字句解析 | Lexical Analysis | Tokenization |
| 構文解析 | 構文解析 | Syntax Analysis | Pattern Matching |
| 意味解析 | 意味解析 | Semantic Analysis | Validation |

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

### Page 12a Speaker Notes Example
```markdown
Now, we reach the core section of this presentation.
The first challenge is the complexity of hyphens.

POJ in Taiwanese requires 3 types of hyphen handling.

First, intra-word hyphens.
These should be preserved.
...

Third, prefix hyphen handling.
Let's look at an actual example.
There's a sentence "日時斷斷仔".
In POJ, it's written as "ji̍t--sî tuān-tuān-á".

This "--" is a special marker representing inter-word pause.
It's similar to the Japanese geminate consonant "っ".
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

Open http://localhost:8080/rubyworld-2025-taigi-parser.md to check

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

**Last Updated:** 2025-10-20
**Maintainer:** 5xRuby Development Team
