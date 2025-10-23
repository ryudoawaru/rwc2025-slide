# frozen_string_literal: true

require 'parslet'
require 'yaml'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/enumerable'
module Experimental
  # RomanParser: Parser-based implementation for RubyWorld Conference 2025 presentation
  # This demonstrates the 3-phase analysis approach similar to Ruby's own parser
  #
  # Phase 1: Lexical Analysis (Tokenization)
  #   - Break text into tokens using Parslet grammar rules
  #   - Identify words, punctuation, hyphens
  #
  # Phase 2: Syntax Analysis (AST Construction)
  #   - Build Abstract Syntax Tree from tokens
  #   - Capture structural relationships
  #
  # Phase 3: Semantic Analysis (Transformation)
  #   - Transform AST into final array format
  #   - Apply washing rules during transformation
  #
  # Usage:
  #   parser = Experimental::RomanParser.new
  #   result = parser.parse_roman("suà-lo̍h lâi-khuànn")
  #   # => ["suà-lo̍h", "lâi-khuànn"]
  #
  WASHING_PATTERNS = YAML.load_file("#{File.dirname(__FILE__)}/roman_gsub_patterns.yml", permitted_classes: [Regexp])
  class RomanParser < Parslet::Parser
    # ============================================================
    # Phase 1: Lexical Analysis - Accept entire input
    # ============================================================
    # Strategy: Parse the entire string as a single text node
    # Then apply washing patterns in Transform phase (Phase 2+3)

    root(:text)

    rule(:text) { any.repeat.as(:raw_text) }

    # ============================================================
    # Phase 3: Semantic Analysis - AST Transformation
    # ============================================================

    # Transform class to convert AST to array
    class RomanTransform < Parslet::Transform
      # Transform word node
      rule(word: simple(:w)) { w.to_s }

      # Transform number node
      rule(number: simple(:n)) { n.to_s }

      # Transform punctuation node
      rule(punct: simple(:p)) { p.to_s }

      # Transform sentence node with multiple tokens (sequence)
      rule(sentence: sequence(:tokens)) do
        WASHING_PATTERNS.reduce(tokens.join(' ')) { |result, (pattern, replacement)| result.gsub(pattern, replacement) }.split(/\s/).compact_blank
      end

      # Transform sentence node with single token (not a sequence)
      rule(sentence: simple(:token)) do
        WASHING_PATTERNS.reduce(token.to_s) { |result, (pattern, replacement)| result.gsub(pattern, replacement) }.split(/\s/).compact_blank
      end
    end

    # ============================================================
    # Public API
    # ============================================================

    # Parse roman text and return array
    # This method demonstrates the complete 3-phase process
    #
    # @param text [String] Roman text to parse
    # @return [Array<String>] Array of tokens
    #
    # Example:
    #   parser = RomanParser.new
    #   parser.parse_roman("suà-lo̍h lâi-khuànn")
    #   # => ["suà-lo̍h", "lâi-khuànn"]
    #
    def parse_roman(text)
      # Phase 1 & 2: Parse text to AST, then Phase 3: Transform to array
      RomanTransform.new.apply(parse(text))
    rescue Parslet::ParseFailed => e
      # Fallback to regex-based approach if parser fails
      puts("Parser failed, falling back to regex: #{e.message}")
      fallback_parse(text)
    end

    # Class method for convenience
    def self.parse_roman(text)
      new.parse_roman(text)
    end

    private

    # Fallback to original GSUB approach if parser fails
    def fallback_parse(text)
      WASHING_PATTERNS.reduce(text) do |result, (pattern, replacement)|
        result.gsub(pattern, replacement)
      end.split(/\s/).compact_blank
    end
  end
end
