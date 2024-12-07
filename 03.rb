#############################################################################
# 1
#############################################################################

input = File.read('input03.txt')

regex = /mul\((\d{1,3})\,(\d{1,3})\)/
puts input.scan(regex).sum { |mults| mults[0].to_i * mults[1].to_i }

#############################################################################
# 2
#############################################################################

input = File.read('input03.txt')

result = 0
enabled = true
input.scan(/mul\((\d{1,3})\,(\d{1,3})\)|(don't\(\)|do\(\))/) do |items|
  enabled = false and next if items[2] == "don't()"
  enabled = true and next if items[2] == 'do()'
  result += items[0].to_i * items[1].to_i if enabled
end

puts result
