# Taiwanese POJ Parser - Pure Parser Implementation

[English](#english) | [日本語](#japanese) | [中文](#chinese)

---

<a name="english"></a>
## English

### Overview

This project demonstrates **how to apply Compiler Theory to Natural Language Processing** through a pure parser-based implementation for Taiwanese Pe̍h-ōe-jī (POJ) romanization.

**Achievement**: 🏆 **100% parsing accuracy** on 64,554 real-world corpus entries

### Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd rwc2025-slide

# Install dependencies
bundle install

# Run tests with sample data (~3,000 entries)
ruby test_parser.rb

# Run full test with all 64,554 entries
ruby test_parser.rb test_data/corpora_data_new.json
```

### Project Structure

```
rwc2025-slide/
├── experimental/              # Parser implementations
│   ├── roman_parser_pure.rb  # ⭐ Pure parser (100% accuracy)
│   └── roman_parser.rb       # Hybrid parser (uses regex patterns)
├── test_data/                # Test datasets
│   ├── corpora_data_new.json # Full dataset (64,554 entries)
│   └── sample_data.json      # Sample dataset (~3,000 entries)
├── test_parser.rb            # Test script with progress bar
└── README.md                 # This file
```

### Two Parser Implementations

#### 1. `roman_parser_pure.rb` - Pure Parser Implementation ⭐

**Purpose**: Educational demonstration of compiler theory application

**Architecture**:
- **Phase 1: Lexical Analysis** - Tokenization using Parslet grammar rules
- **Phase 2: Syntax Analysis** - AST (Abstract Syntax Tree) construction
- **Phase 3: Semantic Analysis** - Validation and transformation

**Features**:
- Zero regex dependency for tokenization
- Complete Unicode support (U+0000-U+26FF)
- Handles edge cases: zero-width space, combining marks, emoticons
- **100.00% accuracy** (64,554/64,554)

**Usage**:
```ruby
require_relative 'experimental/roman_parser_pure'

parser = Experimental::RomanParserPure.new
result = parser.parse_roman("suà-lo̍h lâi-khuànn")
# => ["suà-lo̍h", "lâi-khuànn"]
```

#### 2. `roman_parser.rb` - Hybrid Parser Implementation

**Purpose**: Production-ready parser with pattern-based transformation

**Architecture**:
- **Phase 1: Lexical Analysis** - Accept entire input
- **Phase 2-3: Transformation** - Apply washing patterns + split

**Features**:
- Uses YAML-based pattern definitions
- Fallback mechanism for edge cases
- **100.00% compatibility** with production system

### Test Script Features

The `test_parser.rb` script provides:

- ✅ Visual progress bar with percentage
- ✅ Real-time statistics
- ✅ Error case reporting (if any)
- ✅ Celebration message on 100% success

**Example output**:

```
================================================================================
Testing RomanParserPure with 64554 records
================================================================================
[██████████████████████████████████████████████████] 100.0% (64554/64554)

================================================================================
Final Results
================================================================================
Total records:    64554
Parse success:    64554 (100.0%)
Parse errors:     0 (0.0%)
================================================================================

🎉 PERFECT! 100% success rate achieved!
```

### Evolution History

| Version | Implementation | Success Rate | Parse Errors |
|---------|---------------|--------------|--------------|
| V1 | Basic implementation | 98.34% | 1,073 |
| V2 | Latin Extended support | 98.39% | 1,038 |
| V3 | Unicode quotes | 99.44% | 363 |
| V4 | match[] optimization | 99.44% | 363 |
| V5 | Prefix hyphen handling | 99.46% | 346 |
| V6 | Full Unicode ranges | 99.88% | 78 |
| V7 | Edge case handling | 99.99% | 6 |
| **V8** | **Perfect parsing** | **100.00%** | **0** |

### Key Technologies

- **Parslet** - PEG (Parsing Expression Grammar) parser library
- **Ruby 3.x** - Programming language
- **Unicode** - Complete character set support (U+0000-U+26FF)

### Resources

- Detailed development history: See `CLAUDE.md` → "Parser 開發歷程記錄"
- RubyWorld Conference 2025 slides: `rubyworld-2025-taigi-parser.md`

---

<a name="japanese"></a>
## 日本語

### 概要

このプロジェクトは、**コンパイラ理論を自然言語処理に応用する方法**を、台湾語白話字（POJ）ローマ字の純粋なパーサーベース実装を通じて実証します。

**成果**: 🏆 **64,554件の実際のコーパスエントリで100%の解析精度**

### クイックスタート

```bash
# リポジトリをクローン
git clone <repository-url>
cd rwc2025-slide

# 依存関係をインストール
bundle install

# サンプルデータでテスト実行（約3,000件）
ruby test_parser.rb

# 全64,554件のデータでフルテスト実行
ruby test_parser.rb test_data/corpora_data_new.json
```

### プロジェクト構造

```
rwc2025-slide/
├── experimental/              # パーサー実装
│   ├── roman_parser_pure.rb  # ⭐ 純粋パーサー（100%精度）
│   └── roman_parser.rb       # ハイブリッドパーサー（正規表現パターン使用）
├── test_data/                # テストデータセット
│   ├── corpora_data_new.json # 完全データセット（64,554件）
│   └── sample_data.json      # サンプルデータセット（約3,000件）
├── test_parser.rb            # プログレスバー付きテストスクリプト
└── README.md                 # このファイル
```

### 2つのパーサー実装

#### 1. `roman_parser_pure.rb` - 純粋パーサー実装 ⭐

**目的**: コンパイラ理論応用の教育的デモンストレーション

**アーキテクチャ**:
- **Phase 1: 字句解析** - Parslet文法規則によるトークン化
- **Phase 2: 構文解析** - AST（抽象構文木）構築
- **Phase 3: 意味解析** - 検証と変換

**特徴**:
- トークン化に正規表現依存なし
- 完全なUnicodeサポート（U+0000-U+26FF）
- エッジケース対応：ゼロ幅スペース、結合記号、絵文字
- **100.00%精度**（64,554/64,554）

**使用方法**:
```ruby
require_relative 'experimental/roman_parser_pure'

parser = Experimental::RomanParserPure.new
result = parser.parse_roman("suà-lo̍h lâi-khuànn")
# => ["suà-lo̍h", "lâi-khuànn"]
```

#### 2. `roman_parser.rb` - ハイブリッドパーサー実装

**目的**: パターンベース変換を使用した本番環境対応パーサー

**アーキテクチャ**:
- **Phase 1: 字句解析** - 入力全体を受け入れ
- **Phase 2-3: 変換** - 洗浄パターン適用 + 分割

**特徴**:
- YAMLベースのパターン定義使用
- エッジケース用フォールバック機構
- 本番システムと **100.00%互換性**

### テストスクリプト機能

`test_parser.rb` スクリプトの提供機能:

- ✅ パーセンテージ表示付きビジュアルプログレスバー
- ✅ リアルタイム統計
- ✅ エラーケースレポート（存在する場合）
- ✅ 100%成功時の祝福メッセージ

**出力例**:

```
================================================================================
Testing RomanParserPure with 64554 records
================================================================================
[██████████████████████████████████████████████████] 100.0% (64554/64554)

================================================================================
Final Results
================================================================================
Total records:    64554
Parse success:    64554 (100.0%)
Parse errors:     0 (0.0%)
================================================================================

🎉 PERFECT! 100% success rate achieved!
```

### 進化の歴史

| バージョン | 実装内容 | 成功率 | パースエラー |
|-----------|---------|--------|-------------|
| V1 | 基本実装 | 98.34% | 1,073 |
| V2 | Latin Extended サポート | 98.39% | 1,038 |
| V3 | Unicode クオート | 99.44% | 363 |
| V4 | match[] 最適化 | 99.44% | 363 |
| V5 | 前置ハイフン処理 | 99.46% | 346 |
| V6 | 完全 Unicode 範囲 | 99.88% | 78 |
| V7 | エッジケース処理 | 99.99% | 6 |
| **V8** | **完璧な解析** | **100.00%** | **0** |

### 主要技術

- **Parslet** - PEG（解析表現文法）パーサーライブラリ
- **Ruby 3.x** - プログラミング言語
- **Unicode** - 完全な文字セットサポート（U+0000-U+26FF）

### リソース

- 詳細な開発履歴: `CLAUDE.md` → 「Parser 開発歷程記錄」を参照
- RubyWorld Conference 2025 スライド: `rubyworld-2025-taigi-parser.md`

---

<a name="chinese"></a>
## 中文

### 概述

本專案透過台語白話字（POJ）羅馬拼音的純 Parser 實作，展示**如何將編譯器理論應用於自然語言處理**。

**成果**: 🏆 **在 64,554 筆真實語料庫資料上達成 100% 解析準確度**

### 快速開始

```bash
# 複製專案
git clone <repository-url>
cd rwc2025-slide

# 安裝相依套件
bundle install

# 使用範例資料執行測試（約 3,000 筆）
ruby test_parser.rb

# 使用完整 64,554 筆資料執行測試
ruby test_parser.rb test_data/corpora_data_new.json
```

### 專案結構

```
rwc2025-slide/
├── experimental/              # Parser 實作
│   ├── roman_parser_pure.rb  # ⭐ 純 Parser（100% 準確度）
│   └── roman_parser.rb       # 混合式 Parser（使用 regex patterns）
├── test_data/                # 測試資料集
│   ├── corpora_data_new.json # 完整資料集（64,554 筆）
│   └── sample_data.json      # 範例資料集（約 3,000 筆）
├── test_parser.rb            # 含進度條的測試腳本
└── README.md                 # 本檔案
```

### 兩種 Parser 實作

#### 1. `roman_parser_pure.rb` - 純 Parser 實作 ⭐

**目的**: 編譯器理論應用的教學展示

**架構**:
- **Phase 1: Lexical Analysis（字句分析）** - 使用 Parslet 文法規則進行 tokenization
- **Phase 2: Syntax Analysis（語法分析）** - 建立 AST（抽象語法樹）
- **Phase 3: Semantic Analysis（語意分析）** - 驗證與轉換

**特色**:
- Tokenization 階段零正規表達式依賴
- 完整 Unicode 支援（U+0000-U+26FF）
- 處理邊緣案例：zero-width space、combining marks、表情符號
- **100.00% 準確度**（64,554/64,554）

**使用方式**:
```ruby
require_relative 'experimental/roman_parser_pure'

parser = Experimental::RomanParserPure.new
result = parser.parse_roman("suà-lo̍h lâi-khuànn")
# => ["suà-lo̍h", "lâi-khuànn"]
```

#### 2. `roman_parser.rb` - 混合式 Parser 實作

**目的**: 使用 pattern-based transformation 的產品級 Parser

**架構**:
- **Phase 1: Lexical Analysis** - 接受完整輸入
- **Phase 2-3: Transformation** - 套用 washing patterns + split

**特色**:
- 使用 YAML-based pattern 定義
- 邊緣案例的 fallback 機制
- 與產品系統 **100.00% 相容**

### 測試腳本功能

`test_parser.rb` 腳本提供：

- ✅ 視覺化進度條與百分比顯示
- ✅ 即時統計資訊
- ✅ 錯誤案例報告（如有）
- ✅ 100% 成功時的慶祝訊息

**輸出範例**:

```
================================================================================
Testing RomanParserPure with 64554 records
================================================================================
[██████████████████████████████████████████████████] 100.0% (64554/64554)

================================================================================
Final Results
================================================================================
Total records:    64554
Parse success:    64554 (100.0%)
Parse errors:     0 (0.0%)
================================================================================

🎉 PERFECT! 100% success rate achieved!
```

### 演進歷史

| 版本 | 實作方式 | 成功率 | Parse 錯誤數 |
|------|---------|--------|-------------|
| V1 | 基礎實作 | 98.34% | 1,073 |
| V2 | Latin Extended 支援 | 98.39% | 1,038 |
| V3 | Unicode 引號 | 99.44% | 363 |
| V4 | match[] 最佳化 | 99.44% | 363 |
| V5 | 前置連字符處理 | 99.46% | 346 |
| V6 | 完整 Unicode 範圍 | 99.88% | 78 |
| V7 | 邊緣案例處理 | 99.99% | 6 |
| **V8** | **完美解析** | **100.00%** | **0** |

### 關鍵技術

- **Parslet** - PEG (Parsing Expression Grammar) parser 函式庫
- **Ruby 3.x** - 程式語言
- **Unicode** - 完整字元集支援（U+0000-U+26FF）

### 資源

- 詳細開發歷程：見 `CLAUDE.md` → 「Parser 開發歷程記錄」段落
- RubyWorld Conference 2025 簡報：`rubyworld-2025-taigi-parser.md`

---

## About 5xRuby | 5xRuby について | 關於 5xRuby

5xRuby is a professional Ruby on Rails development team in Taiwan.

5xRuby は台湾のプロフェッショナルな Ruby on Rails 開発チームです。

5xRuby 是台灣專業的 Ruby on Rails 開發團隊。

- Website | ウェブサイト | 網站: https://5xruby.com
- GitHub: https://github.com/5xRuby

## License | ライセンス | 授權

MIT License
