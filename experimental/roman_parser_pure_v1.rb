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
    # Precomposed: à (U+E0), ê (U+EA), ō (U+14D)
    # Combining: a + grave (U+0300), e + circumflex (U+0302)
    rule(:unicode_letter) { match['\u0080-\u024F'] }  # Latin Extended-A and Extended-B
    rule(:combining_mark) { match['\u0300-\u036F'] }  # Combining Diacritical Marks

    # Any letter: ASCII or Unicode
    rule(:letter) { unicode_letter | (ascii_letter >> combining_mark.repeat) | ascii_letter }

    # Hyphen types
    rule(:single_hyphen) { str('-') }
    rule(:double_hyphen) { str('--') }

    # Punctuation marks that should be separated
    rule(:punctuation) do
      str('...') | str('⋯⋯') | str('……') |  # Multi-char first
      str(',') | str('.') | str('!') | str('?') |
      str('？') | str('！') |  # Full-width punctuation
      str(';') | str(':') | str('(') | str(')') |
      str('"') | str("'") | str('「') | str('」') |
      str('『') | str('』') | str('─') | str('…') | str('⋯') |
      str('/') | str('~') | str('、')  # Additional symbols
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

    # Standalone number
    rule(:number) { digit.repeat(1) }

    # ============================================================
    # Phase 2: Syntax Analysis - Token Sequence
    # ============================================================

    # Token: any recognizable unit
    rule(:token) do
      hyphenated_word.as(:word) |
      number.as(:num) |
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
