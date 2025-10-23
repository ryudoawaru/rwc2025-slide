#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require_relative 'experimental/roman_parser_pure'

# Check command line arguments
data_file = if ARGV.empty?
              'test_data/sample_data.json'
            else
              ARGV[0]
            end

unless File.exist?(data_file)
  puts "Error: Data file '#{data_file}' not found."
  exit 1
end

# Load data
puts "Loading data from #{data_file}..."
data = JSON.parse(File.read(data_file))
total = data.size

puts "\n" + "=" * 80
puts "Testing RomanParserPure with #{total} records"
puts "=" * 80

# Initialize parser
parser = Experimental::RomanParserPure.new
parse_success = 0
parse_errors = 0
error_cases = []

# Progress bar configuration
progress_interval = total > 1000 ? 1000 : 100
bar_width = 50

# Process each record
data.each_with_index do |record, idx|
  roman = record['roman']
  next if roman.nil? || roman.strip.empty?

  begin
    result = parser.parse_roman(roman)
    parse_success += 1
  rescue Parslet::ParseFailed => e
    parse_errors += 1
    error_cases << {
      index: idx,
      id: record['id'],
      roman: roman,
      error: e.message.lines.first&.strip
    }
  end

  # Show progress bar
  if (idx + 1) % progress_interval == 0 || (idx + 1) == total
    progress = (idx + 1).to_f / total
    filled = (bar_width * progress).round
    bar = "█" * filled + "░" * (bar_width - filled)
    percentage = (progress * 100).round(2)

    print "\r[#{bar}] #{percentage}% (#{idx + 1}/#{total})"
    $stdout.flush
  end
end

puts "\n"

# Display results
puts "\n" + "=" * 80
puts "Final Results"
puts "=" * 80
puts "Total records:    #{total}"
puts "Parse success:    #{parse_success} (#{(parse_success * 100.0 / total).round(4)}%)"
puts "Parse errors:     #{parse_errors} (#{(parse_errors * 100.0 / total).round(4)}%)"
puts "=" * 80

# Show error cases if any
if parse_errors > 0
  puts "\nError Cases:"
  puts "-" * 80
  error_cases.first(10).each_with_index do |err, i|
    puts "\n#{i + 1}. [#{err[:index]}] ID: #{err[:id]}"
    puts "   Roman: #{err[:roman]}"
    puts "   Error: #{err[:error]}"
  end

  if error_cases.size > 10
    puts "\n... and #{error_cases.size - 10} more errors"
  end
end

# Success indicator
if parse_success == total
  puts "\n🎉 PERFECT! 100% success rate achieved!"
else
  puts "\n⚠️  #{parse_errors} cases need attention."
end

puts "\n" + "=" * 80
