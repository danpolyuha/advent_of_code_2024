#############################################################################
# 1
#############################################################################

@lines = File.readlines('input10.txt').map(&:chomp).map(&:chars).map { |line| line.map(&:to_i) }
@n = @lines.size
@m = @lines[0].size

def paths(y, x, h, peaks)
  return 0 if y < 0 || y > @n - 1 || x < 0 || x > @m - 1 || @lines[y][x] != h || peaks.include?([y, x])

  peaks.add([y, x]) and return 1 if h == 9

  h += 1
  paths(y + 1, x, h, peaks) + paths(y - 1, x, h, peaks) + paths(y, x + 1, h, peaks) + paths(y, x - 1, h, peaks)
end

result = 0
@lines.each_with_index do |line, y|
  line.each_with_index do |cell, x|
    result += paths(y, x, 0, Set.new) if cell == 0
  end
end

puts result

#############################################################################
# 2
#############################################################################

@lines = File.readlines('input10.txt').map(&:chomp).map(&:chars).map { |line| line.map(&:to_i) }
@n = @lines.size
@m = @lines[0].size

def paths2(y, x, h)
  return 0 if y < 0 || y > @n - 1 || x < 0 || x > @m - 1 || @lines[y][x] != h

  return 1 if h == 9

  h += 1
  paths2(y + 1, x, h) + paths2(y - 1, x, h) + paths2(y, x + 1, h) + paths2(y, x - 1, h)
end

result = 0
@lines.each_with_index do |line, y|
  line.each_with_index do |cell, x|
    result += paths2(y, x, 0) if cell == 0
  end
end

puts result
