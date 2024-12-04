#############################################################################
# 1
#############################################################################

string = File.read('tmp/adventofcode2024/input03.txt'); 0

result = string.scan(/mul\((\d{1,3})\,(\d{1,3})\)/).sum do |item|
  item[0].to_i * item[1].to_i
end

puts result

#############################################################################
# 2
#############################################################################

string = File.read('tmp/adventofcode2024/input03.txt'); 0

result = 0
enabled = true
string.scan(/mul\((\d{1,3})\,(\d{1,3})\)|(don't\(\))|(do\(\))/) do |item|
  if item[2] == "don't()"
    enabled = false
    next
  elsif item[3] == 'do()'
    enabled = true
    next
  else
    result += item[0].to_i * item[1].to_i if enabled
  end
end

puts result
