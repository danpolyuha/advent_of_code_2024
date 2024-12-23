#############################################################################
# 1
#############################################################################

map = File.readlines('input20.txt').map(&:chomp).map(&:chars)

height = map.length
width = map[0].length

start_y = map.index { |r| r.include?('S') }
start_x = map[start_y].index('S')
finish_y = map.index { |r| r.include?('E') }
finish_x = map[finish_y].index('E')

map.each_index do |y|
  map[y].each_with_index do |item, x|
    item == '#' ? (map[y][x] = -1) : (map[y][x] = 0)
  end
end

x, y = start_x, start_y
cur_value = 0
loop do
  if map[y][x + 1] == 0
    x += 1
  elsif map[y][x - 1] == 0
    x -= 1
  elsif map[y - 1][x] == 0
    y -= 1
  elsif map[y + 1][x] == 0
    y += 1
  end

  cur_value += 1
  map[y][x] = cur_value

  break if x == finish_x && y == finish_y
end

result = 0
map.each_with_index do |line, y|
  line.each_with_index do |item, x|
    if item != -1
      result += 1 if x < width - 3 && map[y][x + 1] == -1 && map[y][x + 2] - item >= 102
      result += 1 if x > 2 && map[y][x - 1] == -1 && map[y][x - 2] - item >= 102
      result += 1 if y < height - 3 && map[y + 1][x] == -1 && map[y + 2][x] - item >= 102
      result += 1 if y > 2 && map[y - 1][x] == -1 && map[y - 2][x] - item >= 102
    end
  end
end

puts result

#############################################################################
# 2
#############################################################################

map = File.readlines('input20.txt').map(&:chomp).map(&:chars)

height = map.length
width = map[0].length

start_y = map.index { |r| r.include?('S') }
start_x = map[start_y].index('S')
finish_y = map.index { |r| r.include?('E') }
finish_x = map[finish_y].index('E')

map.each_index do |y|
  map[y].each_with_index do |item, x|
    item == '#' ? (map[y][x] = -1) : (map[y][x] = 0)
  end
end

x, y = start_x, start_y
cur_value = 0
loop do
  if map[y][x + 1] == 0
    x += 1
  elsif map[y][x - 1] == 0
    x -= 1
  elsif map[y - 1][x] == 0
    y -= 1
  elsif map[y + 1][x] == 0
    y += 1
  end

  cur_value += 1
  map[y][x] = cur_value

  break if x == finish_x && y == finish_y
end

result = 0
map.each_with_index do |line, y|
  line.each_with_index do |item, x|
    if item != -1
      y1 = [1, y - 20].max
      y2 = [height - 2, y + 20].min
      (y1..y2).each do |cur_y|
        distance_y = (y - cur_y).abs
        x1 = [1, x - (20 - distance_y)].max
        x2 = [width - 2, x + (20 - distance_y)].min
        (x1..x2).each do |cur_x|
          distance_x = (x - cur_x).abs
          result += 1 if map[cur_y][cur_x] != -1 && map[cur_y][cur_x] - item >= 100 + distance_y + distance_x
        end
      end
    end
  end
end

puts result
