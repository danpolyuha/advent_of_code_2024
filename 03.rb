# https://adventofcode.com/2024/day/3

corrupted_memory = File.read('input03.txt')

########################################################################################################################
# 1
########################################################################################################################

regex = /mul\((\d{1,3})\,(\d{1,3})\)/
puts corrupted_memory.scan(regex).sum { |mults| mults[0].to_i * mults[1].to_i }
# 167650499

########################################################################################################################
# 2
########################################################################################################################

result = 0
enabled = true
corrupted_memory.scan(/mul\((\d{1,3})\,(\d{1,3})\)|(don't\(\)|do\(\))/) do |found_items|
  enabled = false and next if found_items[2] == "don't()"
  enabled = true and next if found_items[2] == 'do()'
  result += found_items[0].to_i * found_items[1].to_i if enabled
end

puts result
# 95846796
