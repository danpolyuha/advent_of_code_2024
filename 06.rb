#############################################################################
# 1
#############################################################################

matrix = File.readlines('tmp/adventofcode2024/input06.txt').map(&:chomp).map(&:chars)
m = matrix.first.length
n = matrix.length

y, x = nil, nil
matrix.each_with_index do |line, index|
  line.each_with_index do |char, index2|
    if char == '^'
      y = index
      x = index2
      break
    end
  end

  break unless y.nil?
end

dir = '^'

loop do
  matrix[y][x] = 'X'

  if dir == '^'
    break if y == 0

    if matrix[y - 1][x] == '#'
      dir = '>'
    else
      y -= 1
    end
  elsif dir == '>'
    break if x == m - 1

    if matrix[y][x + 1] == '#'
      dir = 'v'
    else
      x += 1
    end
  elsif dir == 'v'
    break if y == n - 1

    if matrix[y + 1][x] == '#'
      dir = '<'
    else
      y += 1
    end
  elsif dir == '<'
    break if x == 0

    if matrix[y][x - 1] == '#'
      dir = '^'
    else
      x -= 1
    end
  end
end

result = matrix.sum { |line| line.count { |c| c == 'X' } }
puts result

#############################################################################
# 2
#############################################################################

initial_matrix = File.readlines('tmp/adventofcode2024/input06.txt').map(&:chomp).map(&:chars)
m = initial_matrix.first.length
n = initial_matrix.length

y_start, x_start = nil, nil
initial_matrix.each_with_index do |line, index|
  line.each_with_index do |char, index2|
    if char == '^'
      y_start = index
      x_start = index2
      break
    end
  end

  break unless y_start.nil?
end

x, y = x_start, y_start
matrix = initial_matrix.map(&:dup)
dir = '^'
path = []

loop do
  matrix[y][x] = 'X'
  path << [y, x]

  if dir == '^'
    break if y == 0

    if matrix[y - 1][x] == '#'
      dir = '>'
    else
      y -= 1
    end
  elsif dir == '>'
    break if x == m - 1

    if matrix[y][x + 1] == '#'
      dir = 'v'
    else
      x += 1
    end
  elsif dir == 'v'
    break if y == n - 1

    if matrix[y + 1][x] == '#'
      dir = '<'
    else
      y += 1
    end
  elsif dir == '<'
    break if x == 0

    if matrix[y][x - 1] == '#'
      dir = '^'
    else
      x -= 1
    end
  end
end

def ok?(matrix, y, x)
  m = matrix.first.length
  n = matrix.length

  matrix = matrix.map(&:dup)
  dir = '^'

  loop do
    item = "dir#{dir}"
    return false if matrix[y][x].include?(item)

    matrix[y][x] += item

    if dir == '^'
      return true if y == 0

      if matrix[y - 1][x] == '#'
        dir = '>'
      else
        y -= 1
      end
    elsif dir == '>'
      return true if x == m - 1

      if matrix[y][x + 1] == '#'
        dir = 'v'
      else
        x += 1
      end
    elsif dir == 'v'
      return true if y == n - 1

      if matrix[y + 1][x] == '#'
        dir = '<'
      else
        y += 1
      end
    elsif dir == '<'
      return true if x == 0

      if matrix[y][x - 1] == '#'
        dir = '^'
      else
        x -= 1
      end
    end
  end
end

result = 0

path[1..].uniq.each do |index, index2|
  initial_matrix[index][index2] = '#'
  result += 1 unless ok?(initial_matrix, y_start, x_start)
  initial_matrix[index][index2] = '.'
end

puts result
