word_search = File.readlines('input04.txt').map(&:chomp).map(&:chars)
height = word_search.length
width = word_search[0].length

########################################################################################################################
# 1
########################################################################################################################

all_lines = word_search + word_search.transpose

(0..width - 1).each do |hor_index|
  diag1, diag2 = [], []
  hor_start = [0, hor_index - height + 1].max
  (hor_start..hor_index).reverse_each do |x|
    diag1 << word_search[hor_index - x][x]
    diag2 << word_search[height - 1 - (hor_index - x)][x]
  end

  all_lines += [diag1, diag2]
end

(1..height - 1).each do |ver_index|
  diag1, diag2 = [], []
  ver_finish = [height - 1, ver_index + width - 1].min
  (ver_index..ver_finish).each do |y|
    diag1 << word_search[y][width - 1 - (y - ver_index)]
    diag2 << word_search[height - y - 1][width - 1 - (y - ver_index)]
  end

  all_lines += [diag1, diag2]
end

all_lines += all_lines.map(&:reverse)

puts all_lines.map { |line| line.join.scan(/XMAS/).count }.sum
# 2718

########################################################################################################################
# 2
########################################################################################################################

def x_mas?(c1, c2, c3)
  ['MAS', 'SAM'].include?(c1 + c2 + c3)
end

x_mas_count = 0
(0..height - 3).each do |y|
  (0..width - 3).each do |x|
    diag1_mas = x_mas?(word_search[y][x], word_search[y + 1][x + 1], word_search[y + 2][x + 2])
    diag2_mas = x_mas?(word_search[y][x + 2], word_search[y + 1][x + 1], word_search[y + 2][x])
    x_mas_count += 1 if diag1_mas && diag2_mas
  end
end

puts x_mas_count
# 2046
