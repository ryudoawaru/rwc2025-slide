#!/usr/bin/env ruby
# frozen_string_literal: true

# RomanParser Test Script with Statistics
# RomanParser 統計テストスクリプト
#
# This script tests the RomanParser against 3333 corpus records
# and provides detailed statistics about parser success rate.
# このスクリプトは3333件のコーパスレコードに対してRomanParserをテストし、
# パーサーの成功率に関する詳細な統計を提供します。

require './experimental/roman_parser'
require 'json'

# Initialize counters / カウンターを初期化
passed = 0          # Tests that produced correct output / 正しい出力を生成したテスト
failed = 0          # Tests that produced incorrect output / 誤った出力を生成したテスト
parser_worked = 0   # Tests where parser succeeded without fallback / フォールバックなしでパーサーが成功したテスト
fallback_used = 0   # Tests where fallback was used but output was correct / フォールバックを使用したが出力は正しいテスト

# Load test data from JSON / JSONからテストデータを読み込む
# Each record contains: id, roman, kanji, roman_array, kanji_array
# 各レコードには：id、roman、kanji、roman_array、kanji_array が含まれます
file_path = ARGV[0] || 'test_data/sample_data.json'
test_data = JSON.parse(File.read(file_path))

# Run tests / テストを実行
test_data.each do |hsh|
  roman = hsh['roman']

  # Temporarily suppress fallback messages / フォールバックメッセージを一時的に抑制
  original_stdout = $stdout
  $stdout = StringIO.new

  parsed_array = Experimental::RomanParser.parse_roman(roman)

  output = $stdout.string
  $stdout = original_stdout

  # Check result and categorize / 結果をチェックして分類
  if parsed_array == hsh['roman_array']
    passed += 1
    parser_worked += 1 unless output.include?("Parser failed")
    fallback_used += 1 if output.include?("Parser failed")
  else
    failed += 1
  end
end

total = passed + failed

# Print statistics / 統計を出力
puts "=" * 80
puts "Test Results / テスト結果統計"
puts "=" * 80
puts "Total tests / 総テスト件数: #{total}"
puts "Passed / 通過: #{passed} (#{(passed.to_f / total * 100).round(2)}%)"
puts "Failed / 失敗: #{failed} (#{(failed.to_f / total * 100).round(2)}%)"
puts
puts "Parser succeeded / Parser成功: #{parser_worked} (#{(parser_worked.to_f / total * 100).round(2)}%)"
puts "Fallback used / Fallback使用: #{fallback_used} (#{(fallback_used.to_f / total * 100).round(2)}%)"
puts "=" * 80

# Show failure examples if any / 失敗例があれば表示
if failed > 0
  puts "\nFirst 10 failure cases / 最初の10件の失敗ケース:"
  puts "=" * 80

  fail_count = 0
  test_data.each do |hsh|
    break if fail_count >= 10

    roman = hsh['roman']

    original_stdout = $stdout
    $stdout = StringIO.new
    parsed_array = Experimental::RomanParser.parse_roman(roman)
    output = $stdout.string
    $stdout = original_stdout

    if parsed_array != hsh['roman_array']
      fail_count += 1
      used_fallback = output.include?("Parser failed")
      puts "\nCase / ケース ##{fail_count} (ID: #{hsh['id']})"
      puts "Method / 使用方法: #{used_fallback ? 'Fallback' : 'Parser'}"
      puts "Input / 入力: #{roman}"
      puts "Expected / 期待値: #{hsh['roman_array'].inspect}"
      puts "Actual / 実際値: #{parsed_array.inspect}"
    end
  end
end
