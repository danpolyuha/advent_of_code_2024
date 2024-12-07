#############################################################################
# 1
#############################################################################

matrix = File.readlines('input06.txt').map(&:chomp).map(&:chars)
n = matrix.length
m = matrix.first.length

y, x = nil, nil
matrix.each_with_index do |line, index|
  x = line.index('^')
  y = index and break if x
end

dir = '^'

loop do
  matrix[y][x] = 'X'

  if dir == '^'
    break if y == 0

    matrix[y - 1][x] == '#' ? dir = '>' : y -= 1
  elsif dir == '>'
    break if x == m - 1

    matrix[y][x + 1] == '#' ? dir = 'v' : x += 1
  elsif dir == 'v'
    break if y == n - 1

    matrix[y + 1][x] == '#' ? dir = '<' : y += 1
  elsif dir == '<'
    break if x == 0

    matrix[y][x - 1] == '#' ? dir = '^' : x -= 1
  end
end

puts matrix.sum { |line| line.count { |c| c == 'X' } }

#############################################################################
# 2 This is not a perfect performance, but it works for the input. It can be probably optimized by calculation during
# initial path finding.
#############################################################################

initial_matrix = File.readlines('input06.txt').map(&:chomp).map(&:chars)
@n = initial_matrix.length
@m = initial_matrix.first.length

y_start, x_start = nil, nil
initial_matrix.each_with_index do |line, index|
  x_start = line.index('^')
  y_start = index and break if x_start
end

x, y = x_start, y_start
dir = '^'
path = []

loop do
  path << [y, x]

  if dir == '^'
    break if y == 0

    initial_matrix[y - 1][x] == '#' ? dir = '>' : y -= 1
  elsif dir == '>'
    break if x == @m - 1

    initial_matrix[y][x + 1] == '#' ? dir = 'v' : x += 1
  elsif dir == 'v'
    break if y == @n - 1

    initial_matrix[y + 1][x] == '#' ? dir = '<' : y += 1
  elsif dir == '<'
    break if x == 0

    initial_matrix[y][x - 1] == '#' ? dir = '^' : x -= 1
  end
end

def ok?(matrix, y, x)
  matrix = matrix.map(&:dup)
  dir = '0'

  loop do
    return false if matrix[y][x].include?(dir)

    matrix[y][x] += dir

    if dir == '0'
      return true if y == 0

      matrix[y - 1][x] == '#' ? dir = '1' : y -= 1
    elsif dir == '1'
      return true if x == @m - 1

      matrix[y][x + 1] == '#' ? dir = '2' : x += 1
    elsif dir == '2'
      return true if y == @n - 1

      matrix[y + 1][x] == '#' ? dir = '3' : y += 1
    elsif dir == '3'
      return true if x == 0

      matrix[y][x - 1] == '#' ? dir = '0' : x -= 1
    end
  end
end

result = 0

path[1..].uniq.each do |y, x|
  initial_matrix[y][x] = '#'
  result += 1 unless ok?(initial_matrix, y_start, x_start)
  initial_matrix[y][x] = '.'
end

puts result
