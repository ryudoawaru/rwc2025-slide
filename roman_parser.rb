# frozen_string_literal: true

require 'parslet'

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
  #
  # Import washing patterns from original implementation
  WASHING_PATTERNS = {
    /''/ => "'",
    /(.)([_+=\:;"'~`“”\\」「\?!])(.)/ => '\1 \2 \3',
    /^([\(_+=\:;"'~`“”\\」「\?!])/ => '\1 ',
    /([\)_+=\:;"'~`“”\\」「\?!])$/ => ' \1',
    /(\.)([^\.])/ => '\1 \2',
    /([^\.])(\.)/ => '\1 \2',
    /(.)(')(.)/ => '\1 \2 \3',
    /(.)(\u2019)(.)/u => '\1 \2 \3',  # Smart right single quote
    /(.)(\u2018)(.)/u => '\1 \2 \3',  # Smart left single quote
    /(.)(")(.)/ => '\1 \2 \3',
    /(.)(\u201D)(.)/u => '\1 \2 \3',  # Smart right double quote
    /(.)(\u201C)(.)/u => '\1 \2 \3',  # Smart left double quote
    /(")([^\"])/ => '\1 \2',
    /(\u201C)([^\u201C])/u => '\1 \2',  # Smart left double quote before non-quote
    /(\u201D)([^\u201D])/u => '\1 \2',  # Smart right double quote before non-quote
    /(.)(:)(.)/ => '\1 \2 \3',
    /(.)(,)(.)/ => '\1 \2 \3',
    /(.)(~)(.)/ => '\1 \2 \3',
    /(.)(\))(.)/ => '\1 \2 \3',
    /(.)(\()(.)/ => '\1 \2 \3',
    /(.)(」)(.)/ => '\1 \2 \3',
    /(.)(「)(.)/ => '\1 \2 \3',
    /(.)(\?)(.)/ => '\1 \2 \3',
    '─' => ' ─ ',
    /(.)(,)$/ => '\1 \2',
    /(.)(:)$/ => '\1 \2',
    /(.)(\?)$/ => '\1 \2',
    /(.)(⋯⋯)/ => '\1 \2',
    /(⋯⋯)(.)/ => '\1 \2',
    /(.)(……)/ => '\1 \2',
    /(……)(.)/ => '\1 \2',
    /(.)(！)/ => '\1 \2',
    /(！)(.)/ => '\1 \2',
    /(.)(？)/ => '\1 \2',
    /(？)(.)/ => '\1 \2',
    /(.)(－)/ => '\1 \2',
    /(－)(.)/ => '\1 \2',
    /^"/ => '" ',
    /^\u201C/u => "\u201C ",     # Smart left double quote at start
    /^\u2018/u => "\u2018 ",     # Smart left single quote at start
    /^'/ => "' ",
    /'$/ => " '",
    /\u2019$/u => " \u2019",     # Smart right single quote at end
    /"$/ => ' "',
    /\u201D$/u => " \u201D",     # Smart right double quote at end
    /─\s+?─/ => '──',
    /\s\.\s\.\s\.$/ => ' ...',
    '. ..' => '...',
    '.. .' => '...',
    /([^\.])(\.\.\.)\s/ => '\1 \2 ',
    /([^\.])(\.)([^\.])/ => '\1 \2 \3',
    /([a-zA-Z0-9]+)\s\.\s([a-zA-Z0-9]+)\.([a-zA-Z0-9]+)/ => '\1.\2.\3',
    '  ' => ' ',
    /（([^（]+)/ => ' （ \1',
    /([^）]+)）/ => '\1 ） ',
    /\(\s([a-zA-Z0-9]+)\s\)/ => '(\1)',
    /([^\.])(\.\.\.)/ => '\1 \2',
    /(\.\.\.)([^\.])/ => '\1 \2',
    /(\.\.\.) (\.\.\.)/ => '\1\2',
    /([^‧])(‧‧‧)/ => '\1 \2',
    /(‧‧‧)([^‧])/ => '\1 \2',
    /\s{2,}/ => ' '
  }.freeze


  class RomanParser < Parslet::Parser
    # ============================================================
    # Phase 1: Lexical Analysis - Character-level Rules
    # ============================================================

    # Basic whitespace
    rule(:space) { str(' ') | str('\t') }
    rule(:spaces) { space.repeat(1) }
    rule(:spaces?) { space.repeat }

    # Roman alphabetic character (a-z, A-Z) with precomposed accents
    # Includes both basic ASCII and precomposed accented letters
    rule(:letter) { match['a-zA-ZàáâãäåèéêëìíîïòóôõöùúûüÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ'] }

    # Digit (0-9)
    rule(:digit) { match['0-9'] }

    # Hyphen
    rule(:hyphen) { str('-') }
    rule(:double_hyphen) { str('--') }

    # Punctuation that needs to be separated
    rule(:punctuation) do
      str(',') | str('.') | str('!') | str('?') |
      str(';') | str(':') | str('"') | str("'") |
      str('(') | str(')') | str('[') | str(']') |
      str('「') | str('」') | str('『') | str('』') |
      str('─') | str('─') | str('…') | str('⋯') |
      str("\u201C") | str("\u201D") | str("\u2018") | str("\u2019")  # Smart quotes
    end

    # Letter with optional combining diacriticals (tone marks)
    # A letter can be followed by zero or more combining marks
    # Examples: "o̍" = o + U+030D, "â" = precomposed U+00E2
    rule(:letter_with_tone) do
      letter >> match['\u0300-\u036F'].repeat
    end

    # Roman word: letters with optional hyphens
    # Examples: "suà-lo̍h", "lâi-khuànn", "Sin-tik-tshī", "tsi̍t"
    # Key insight: Combining diacriticals can appear BETWEEN letters within a word
    # So we need: (letter + tone)+ with optional hyphens
    rule(:roman_word) do
      (
        letter_with_tone.repeat(1) >>
        (hyphen >> letter_with_tone.repeat(1)).repeat
      ).as(:word)
    end

    # Standalone number
    rule(:number) do
      digit.repeat(1).as(:number)
    end

    # Token: a word, number, or punctuation
    rule(:token) do
      roman_word | number | punctuation.as(:punct)
    end

    # ============================================================
    # Phase 2: Syntax Analysis - Sentence Structure
    # ============================================================

    # Sentence: sequence of tokens separated by optional spaces
    # Some texts have punctuation attached to words without spaces (e.g., "Kà)
    rule(:sentence) do
      (
        spaces? >>
        token >>
        (spaces? >> token).repeat >>
        spaces?
      ).as(:sentence)
    end

    root(:sentence)

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
        WASHING_PATTERNS.reduce(tokens.join(' ')) { |result, (pattern, replacement)| result.gsub(pattern, replacement) }.split(/\s/).compact
      end

      # Transform sentence node with single token (not a sequence)
      rule(sentence: simple(:token)) do
        WASHING_PATTERNS.reduce(token.to_s) { |result, (pattern, replacement)| result.gsub(pattern, replacement) }.split(/\s/).compact
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
      washed = WASHING_PATTERNS.reduce(text) do |result, (pattern, replacement)|
        result.gsub(pattern, replacement)
      end
      washed.split(/\s/).compact
    end
  end
end
