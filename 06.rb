# https://adventofcode.com/2024/day/6

map = File.readlines('input06.txt').map(&:chomp).map(&:chars)
@height = map.length
@width = map[0].length

@start_y = map.index { |row| row.include?('^') }
@start_x = map[@start_y].index('^')

########################################################################################################################
# 1
########################################################################################################################

dup_map = map.map(&:dup)
cur_y, cur_x = @start_y, @start_x
cur_dir = '^'

loop do
  dup_map[cur_y][cur_x] = 'X'

  if cur_dir == '^'
    break if cur_y == 0

    dup_map[cur_y - 1][cur_x] == '#' ? cur_dir = '>' : cur_y -= 1
  elsif cur_dir == '>'
    break if cur_x == @width - 1

    dup_map[cur_y][cur_x + 1] == '#' ? cur_dir = 'v' : cur_x += 1
  elsif cur_dir == 'v'
    break if cur_y == @height - 1

    dup_map[cur_y + 1][cur_x] == '#' ? cur_dir = '<' : cur_y += 1
  elsif cur_dir == '<'
    break if cur_x == 0

    dup_map[cur_y][cur_x - 1] == '#' ? cur_dir = '^' : cur_x -= 1
  end
end

puts dup_map.sum { |row| row.count { |cell| cell == 'X' } }
# 5199

########################################################################################################################
# 2
# This is not a perfect performance, but it works for the input. It can be probably optimized by calculation during
# initial path finding.
########################################################################################################################

dup_map = map.map(&:dup)
cur_y, cur_x = @start_y, @start_x
cur_dir = '^'
path = []

loop do
  path << [cur_y, cur_x]

  if cur_dir == '^'
    break if cur_y == 0

    dup_map[cur_y - 1][cur_x] == '#' ? cur_dir = '>' : cur_y -= 1
  elsif cur_dir == '>'
    break if cur_x == @width - 1

    dup_map[cur_y][cur_x + 1] == '#' ? cur_dir = 'v' : cur_x += 1
  elsif cur_dir == 'v'
    break if cur_y == @height - 1

    dup_map[cur_y + 1][cur_x] == '#' ? cur_dir = '<' : cur_y += 1
  elsif cur_dir == '<'
    break if cur_x == 0

    dup_map[cur_y][cur_x - 1] == '#' ? cur_dir = '^' : cur_x -= 1
  end
end

def map_has_loop?(map)
  cur_y, cur_x = @start_y, @start_x
  dup_map = map.map(&:dup)
  cur_dir = '0'

  loop do
    return true if dup_map[cur_y][cur_x].include?(cur_dir)

    dup_map[cur_y][cur_x] += cur_dir

    if cur_dir == '0'
      return false if cur_y == 0

      dup_map[cur_y - 1][cur_x] == '#' ? cur_dir = '1' : cur_y -= 1
    elsif cur_dir == '1'
      return false if cur_x == @width - 1

      dup_map[cur_y][cur_x + 1] == '#' ? cur_dir = '2' : cur_x += 1
    elsif cur_dir == '2'
      return false if cur_y == @height - 1

      dup_map[cur_y + 1][cur_x] == '#' ? cur_dir = '3' : cur_y += 1
    elsif cur_dir == '3'
      return false if cur_x == 0

      dup_map[cur_y][cur_x - 1] == '#' ? cur_dir = '0' : cur_x -= 1
    end
  end
end

result = 0

path[1..].uniq.each do |path_point_y, path_point_x|
  dup_map[path_point_y][path_point_x] = '#'
  result += 1 if map_has_loop?(dup_map)
  dup_map[path_point_y][path_point_x] = '.'
end

puts result
# 1915
