#############################################################################
# 1
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input04.txt').map(&:chomp)
m = lines.first.length
n = lines.length

all_lines = lines.dup

m.times do |x|
  string = ''
  n.times do |y|
    string += lines[y][x]
  end

  all_lines << string
end

m.times do |i|
  string = ''
  j = 0
  k = i
  while j < n && k < m
    string += lines[j][k]
    j += 1
    k += 1
  end

  all_lines << string
end

(n - 1).times do |i|
  string = ''
  j = i + 1
  k = 0
  while j < n && k < m
    string += lines[j][k]
    j += 1
    k += 1
  end

  all_lines << string
end

m.times do |i|
  s = ''
  j = 0
  k = m - i - 1
  while j < lines.length && k >= 0
    s += lines[j][k]
    j += 1
    k -= 1
  end

  all_lines << s
end

(n - 1).times do |i|
  s = ''
  j = i + 1
  k = m - 1
  while j < n && k >= 0
    s += lines[j][k]
    j += 1
    k -= 1
  end

  all_lines << s
end

all_lines += all_lines.map(&:reverse); 0

puts all_lines.map { |line| line.scan(/XMAS/).count }.sum

#############################################################################
# 2
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input04.txt').map(&:chomp)
m = lines.first.length
n = lines.length

def ok?(c1, c2, c3)
  c1 == 'M' && c2 == 'A' && c3 == 'S' || c1 == 'S' && c2 == 'A' && c3 == 'M'
end

result = 0
(0..n - 3).each do |i|
  (0..m - 3).each do |j|
    ok1 = ok?(lines[i][j], lines[i + 1][j + 1], lines[i + 2][j + 2])
    ok2 = ok?(lines[i][j + 2], lines[i + 1][j + 1], lines[i + 2][j])
    result += 1 if ok1 && ok2
  end
end

puts result
