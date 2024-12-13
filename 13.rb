#############################################################################
# 1 The thing is that there's only 1 solution per each equation
#############################################################################

lines = File.readlines('input13.txt')
a = []
b = []
prizes = []
lines.each_slice(4) do |lines|
  x, y = lines[0].scan(/\d+/).map(&:to_i)
  a << { x:, y: }
  x, y = lines[1].scan(/\d+/).map(&:to_i)
  b << { x:, y: }
  x, y = lines[2].scan(/\d+/).map(&:to_i)
  prizes << { x:, y: }
end

result = 0

prizes.each_with_index do |prize, index|
  a_numerator = prize[:x] * b[index][:y] - b[index][:x] * prize[:y]
  b_numerator = prize[:y] * a[index][:x] - a[index][:y] * prize[:x]
  denominator = b[index][:y] * a[index][:x] - a[index][:y] * b[index][:x]

  if denominator != 0 && a_numerator % denominator == 0 && b_numerator % denominator == 0
    a_count = a_numerator / denominator
    b_count = b_numerator / denominator
    result += a_count * 3 + b_count
  end
end

puts result

#############################################################################
# 2
#############################################################################

lines = File.readlines('input13.txt')
a = []
b = []
prizes = []
lines.each_slice(4) do |lines|
  x, y = lines[0].scan(/\d+/).map(&:to_i)
  a << { x:, y: }
  x, y = lines[1].scan(/\d+/).map(&:to_i)
  b << { x:, y: }
  x, y = lines[2].scan(/\d+/).map(&:to_i)
  prizes << { x: x + 10000000000000, y: y + 10000000000000 }
end

result = 0

prizes.each_with_index do |prize, index|
  a_numerator = prize[:x] * b[index][:y] - b[index][:x] * prize[:y]
  b_numerator = prize[:y] * a[index][:x] - a[index][:y] * prize[:x]
  denominator = b[index][:y] * a[index][:x] - a[index][:y] * b[index][:x]

  if denominator != 0 && a_numerator % denominator == 0 && b_numerator % denominator == 0
    a_count = a_numerator / denominator
    b_count = b_numerator / denominator
    result += a_count * 3 + b_count
  end
end

puts result
