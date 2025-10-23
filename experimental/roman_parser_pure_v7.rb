# frozen_string_literal: true

require 'parslet'
require 'active_support/core_ext/object/blank'

module Experimental
  # RomanParserPure: Pure parser-based implementation for educational purposes
  # 純 Parser 實現，用於教學展示
  #
  # This version demonstrates a true parser approach without relying on
  # regex washing patterns. Designed for RubyWorld Conference 2025 presentation.
  #
  # Architecture:
  # Phase 1: Lexical Analysis - Identify all token types
  # Phase 2: Syntax Analysis - Build token sequence
  # Phase 3: Semantic Analysis - Transform to array format

  class RomanParserPure < Parslet::Parser
    # ============================================================
    # Phase 1: Lexical Analysis - Token Types
    # ============================================================

    # Basic character classes
    rule(:ascii_letter) { match['a-zA-Z'] }
    rule(:digit) { match['0-9'] }
    rule(:space) { match['\s'].repeat(1) }
    rule(:space?) { match['\s'].repeat }

    # Unicode letter with diacritics (both precomposed and combining)
    # Precomposed: à (U+E0), ê (U+EA), ō (U+14D), ḿ (U+1E3F)
    # Combining: a + grave (U+0300), e + circumflex (U+0302)
    rule(:unicode_letter) { match['\u0080-\u024F\u1E00-\u1EFF'] }  # Latin Extended-A, B, and Additional
    rule(:combining_mark) { match['\u0300-\u036F'] }  # Combining Diacritical Marks
    rule(:modifier_letter) { match['\u02C0-\u02FF'] }  # Spacing Modifier Letters (ˇ ˋ)
    rule(:superscript) { match['\u2070-\u209F'] }  # Superscripts and Subscripts (ⁿ)

    # Any letter: ASCII or Unicode
    rule(:letter) do
      unicode_letter |
      (ascii_letter >> combining_mark.repeat) |
      ascii_letter |
      modifier_letter |
      superscript
    end

    # Hyphen types
    rule(:single_hyphen) { str('-') }
    rule(:double_hyphen) { str('--') }

    # Punctuation marks that should be separated
    rule(:punctuation) do
      str('...') | str('⋯⋯') | str('……') |  # Multi-char first
      match[',.:;()!?？！/~、─…⋯\u2027%'] |  # Single-char punctuation + hyphenation point + percent
      match["\"'\u201C\u201D\u2018\u2019"] |  # Quotes (ASCII and curly)
      match['\u3000-\u303F'] |  # CJK symbols and punctuation (includes 「」『』【】。、etc)
      match['\uFF01-\uFF5E'] |  # Fullwidth ASCII variants (！％（）－／etc)
      match['\u2014'] |  # Em dash
      match['\u2600-\u26FF']  # Miscellaneous symbols (☐ etc)
    end

    # ============================================================
    # Phase 1: Complex Token Definitions
    # ============================================================

    # Syllable: one or more letters
    # Examples: "suà", "lo̍h", "ê", "Sin", "tik"
    # Each letter can be ASCII or Unicode (precomposed with diacritics)
    rule(:syllable) do
      letter.repeat(1)
    end

    # Word with hyphens: syllable-syllable-syllable
    # Examples: "suà-lo̍h", "tsi̍t-sì-lâng"
    # Can end with hyphen: "kàu-"
    # Can have double hyphen: "kóng--kuè"
    rule(:hyphenated_word) do
      syllable >>
      (
        double_hyphen >> syllable |  # Double hyphen case
        single_hyphen >> syllable |  # Normal hyphen case
        single_hyphen                # Trailing hyphen case
      ).repeat
    end

    # Prefix hyphen word: starts with hyphen
    # Examples: "-pha", "-siâu", "-á"
    # Used in parentheses for alternative pronunciation: "(-pha)"
    rule(:prefix_hyphen_word) do
      single_hyphen >> syllable
    end

    # Standalone number
    rule(:number) { digit.repeat(1) }

    # Bopomofo (注音符號): ㄅㄆㄇㄈ etc.
    # Treat as special tokens that should be kept intact
    rule(:bopomofo) { match['\u3105-\u312F'].repeat(1) }

    # CJK characters (漢字): for mixed text cases
    # When Roman text includes Chinese characters
    rule(:cjk_char) { match['\u4E00-\u9FFF'] }

    # ============================================================
    # Phase 2: Syntax Analysis - Token Sequence
    # ============================================================

    # Token: any recognizable unit
    rule(:token) do
      prefix_hyphen_word.as(:word) |  # Try prefix hyphen first (more specific)
      hyphenated_word.as(:word) |
      number.as(:num) |
      bopomofo.as(:bopomofo) |  # Bopomofo symbols
      cjk_char.as(:cjk) |  # CJK characters
      punctuation.as(:punct)
    end

    # Sentence: sequence of tokens with optional spaces
    rule(:sentence) do
      space? >>
      (token >> space?).repeat(1)
    end

    root(:sentence)

    # ============================================================
    # Phase 3: Semantic Analysis - AST Transformation
    # ============================================================

    class Transform < Parslet::Transform
      # Word token
      rule(word: simple(:w)) { w.to_s }

      # Number token
      rule(num: simple(:n)) { n.to_s }

      # Punctuation token
      rule(punct: simple(:p)) { p.to_s }

      # Bopomofo token
      rule(bopomofo: simple(:b)) { b.to_s }

      # CJK character token
      rule(cjk: simple(:c)) { c.to_s }
    end

    # ============================================================
    # Public API
    # ============================================================

    def parse_roman(text)
      # Phase 1 & 2: Parse text to AST
      ast = parse(text)

      # Phase 3: Transform AST to array
      result = Transform.new.apply(ast)

      # Handle both array and single value
      result.is_a?(Array) ? result : [result]
    rescue Parslet::ParseFailed => e
      # For debugging: show parse error
      puts "Parser failed: #{e.message}"
      raise
    end

    def self.parse_roman(text)
      new.parse_roman(text)
    end
  end
end
