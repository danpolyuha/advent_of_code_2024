# https://adventofcode.com/2024/day/16

map = File.readlines('input16.txt').map(&:chomp).map(&:chars)

start_y = map.index { |r| r.include?('S') }
start_x = map[start_y].index('S')

finish_y = map.index { |r| r.include?('E') }
finish_x = map[finish_y].index('E')

map.each_index do |y|
  map[y].each_with_index do |item, x|
    item == '#' ? (map[y][x] = -1) : (map[y][x] = 0)
  end
end

########################################################################################################################
# 1
########################################################################################################################

paths = [[start_y, start_x]]
dirs = { [start_y, start_x] => 'e' }

loop do
  new_paths = []

  paths.each do |y, x|
    score = map[y][x]

    if dirs[[y, x]] == 'e'
      if map[y][x + 1] == 0 || map[y][x + 1] > score + 1
        new_paths << [y, x + 1]
        map[y][x + 1] = score + 1
        dirs[[y, x + 1]] = 'e'
      end
      if map[y - 1][x] == 0 || map[y - 1][x] > score + 1001
        new_paths << [y - 1, x]
        map[y - 1][x] = score + 1001
        dirs[[y - 1, x]] = 'n'
      end
      if map[y + 1][x] == 0 || map[y + 1][x] > score + 1001
        new_paths << [y + 1, x]
        map[y + 1][x] = score + 1001
        dirs[[y + 1, x]] = 's'
      end
    end

    if dirs[[y, x]] == 'n'
      if map[y - 1][x] == 0 || map[y - 1][x] > score + 1
        new_paths << [y - 1, x]
        map[y - 1][x] = score + 1
        dirs[[y - 1, x]] = 'n'
      end
      if map[y][x + 1] == 0 || map[y][x + 1] > score + 1001
        new_paths << [y, x + 1]
        map[y][x + 1] = score + 1001
        dirs[[y, x + 1]] = 'e'
      end
      if map[y][x - 1] == 0 || map[y][x - 1] > score + 1001
        new_paths << [y, x - 1]
        map[y][x - 1] = score + 1001
        dirs[[y, x - 1]] = 'w'
      end
    end

    if dirs[[y, x]] == 's'
      if map[y + 1][x] == 0 || map[y + 1][x] > score + 1
        new_paths << [y + 1, x]
        map[y + 1][x] = score + 1
        dirs[[y + 1, x]] = 's'
      end
      if map[y][x + 1] == 0 || map[y][x + 1] > score + 1001
        new_paths << [y, x + 1]
        map[y][x + 1] = score + 1001
        dirs[[y, x + 1]] = 'e'
      end
      if map[y][x - 1] == 0 || map[y][x - 1] > score + 1001
        new_paths << [y, x - 1]
        map[y][x - 1] = score + 1001
        dirs[[y, x - 1]] = 'w'
      end
    end

    if dirs[[y, x]] == 'w'
      if map[y][x - 1] == 0 || map[y][x - 1] > score + 1
        new_paths << [y, x - 1]
        map[y][x - 1] = score + 1
        dirs[[y, x - 1]] = 'w'
      end
      if map[y - 1][x] == 0 || map[y - 1][x] > score + 1001
        new_paths << [y - 1, x]
        map[y - 1][x] = score + 1001
        dirs[[y - 1, x]] = 'n'
      end
      if map[y + 1][x] == 0 || map[y + 1][x] > score + 1001
        new_paths << [y + 1, x]
        map[y + 1][x] = score + 1001
        dirs[[y + 1, x]] = 's'
      end
    end
  end

  break if new_paths.empty?
  paths = new_paths
end

puts map[finish_y][finish_x]

########################################################################################################################
# 2
########################################################################################################################
