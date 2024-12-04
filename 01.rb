#############################################################################
# 1
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input01.txt')

a1 = lines.map { |line| line.split[0].to_i }.sort
a2 = lines.map { |line| line.split[1].to_i }.sort

result = 0
a1.each_with_index do |item, index|
  result += (item - a2[index]).abs
end

puts result

#############################################################################
# 2
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input01.txt')

a1 = lines.map { |line| line.split[0].to_i }
a2 = lines.map { |line| line.split[1].to_i }

tallied = a2.tally

result = a1.sum do |item|
  item * (tallied[item] || 0)
end

puts result
