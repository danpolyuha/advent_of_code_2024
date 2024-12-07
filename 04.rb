#############################################################################
# 1
#############################################################################

lines = File.readlines('input04.txt').map(&:chomp).map(&:chars)
n = lines.length
m = lines.first.length

all_lines = lines + lines.transpose

(0..m - 1).each do |hor_index|
  diag1, diag2 = [], []
  ([0, hor_index - n + 1].max..hor_index).reverse_each do |x|
    diag1 << lines[hor_index - x][x]
    diag2 << lines[n - 1 - (hor_index - x)][x]
  end

  all_lines += [diag1, diag2]
end

(1..n - 1).each do |ver_index|
  diag1, diag2 = [], []
  (ver_index..[n - 1, ver_index + m - 1].min).each do |y|
    diag1 << lines[y][m - 1 - (y - ver_index)]
    diag2 << lines[n - y - 1][m - 1 - (y - ver_index)]
  end

  all_lines += [diag1, diag2]
end

all_lines += all_lines.map(&:reverse)

puts all_lines.map { |line| line.join.scan(/XMAS/).count }.sum

#############################################################################
# 2
#############################################################################

lines = File.readlines('input04.txt').map(&:chomp)

def ok?(c1, c2, c3)
  ['MAS', 'SAM'].include?(c1 + c2 + c3)
end

result = 0
(0..lines.length - 3).each do |i|
  (0..lines.first.length - 3).each do |j|
    ok1 = ok?(lines[i][j], lines[i + 1][j + 1], lines[i + 2][j + 2])
    ok2 = ok?(lines[i][j + 2], lines[i + 1][j + 1], lines[i + 2][j])
    result += 1 if ok1 && ok2
  end
end

puts result
