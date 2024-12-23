#############################################################################
# 1
#############################################################################

lines = File.readlines('input18.txt')

map = []
71.times do
  map << [0] * 71
end

lines[0..1023].each do |line|
  x, y = line.scan(/\d+/).map(&:to_i)
  map[y][x] = -1
end

paths = [[0, 0]]
cur_value = 1
map[0][0] = 1

loop do
  new_paths = []
  paths.each do |y, x|
    if x < 70 && map[y][x + 1] == 0
      map[y][x + 1] = cur_value + 1
      new_paths << [y, x + 1]
    end
    if x > 0 && map[y][x - 1] == 0
      map[y][x - 1] = cur_value + 1
      new_paths << [y, x - 1]
    end
    if y < 70 && map[y + 1][x] == 0
      map[y + 1][x] = cur_value + 1
      new_paths << [y + 1, x]
    end
    if y > 0 && map[y - 1][x] == 0
      map[y - 1][x] = cur_value + 1
      new_paths << [y - 1, x]
    end
  end

  break if new_paths.include?([70, 70])
  paths = new_paths
  cur_value += 1
end

puts cur_value

#############################################################################
# 2
#############################################################################

lines = File.readlines('input18.txt')

all_coords = lines.map { |line| line.scan(/\d+/).map(&:to_i) }

current_index = 1024

loop do
  map = []
  71.times do
    map << [0] * 71
  end

  all_coords[0..current_index].each do |x, y|
    map[y][x] = -1
  end

  paths = [[0, 0]]
  cur_value = 1
  map[0][0] = 1

  found = true
  loop do
    new_paths = []
    paths.each do |y, x|
      if x < 70 && map[y][x + 1] == 0
        map[y][x + 1] = cur_value + 1
        new_paths << [y, x + 1]
      end
      if x > 0 && map[y][x - 1] == 0
        map[y][x - 1] = cur_value + 1
        new_paths << [y, x - 1]
      end
      if y < 70 && map[y + 1][x] == 0
        map[y + 1][x] = cur_value + 1
        new_paths << [y + 1, x]
      end
      if y > 0 && map[y - 1][x] == 0
        map[y - 1][x] = cur_value + 1
        new_paths << [y - 1, x]
      end
    end

    break if new_paths.include?([70, 70])

    if new_paths.empty?
      found = false
      break
    end

    paths = new_paths
    cur_value += 1
  end

  break unless found
  current_index += 1
end

puts all_coords[current_index].join(',')
