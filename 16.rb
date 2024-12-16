#############################################################################
# 1
#############################################################################

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

paths = [{ y: start_y, x: start_x }]
dirs = { [start_y, start_x] => 'e' }

loop do
  new_paths = []

  paths.each do |path|
    score = map[path[:y]][path[:x]]

    if dirs[[path[:y], path[:x]]] == 'e'
      if map[path[:y]][path[:x] + 1] == 0 || map[path[:y]][path[:x] + 1] > score + 1
        new_paths << { y: path[:y], x: path[:x] + 1 }
        map[path[:y]][path[:x] + 1] = score + 1
        dirs[[path[:y], path[:x] + 1]] = 'e'
      end
      if map[path[:y] - 1][path[:x]] == 0 || map[path[:y] - 1][path[:x]] > score + 1001
        new_paths << { y: path[:y] - 1, x: path[:x] }
        map[path[:y] - 1][path[:x]] = score + 1001
        dirs[[path[:y] - 1, path[:x]]] = 'n'
      end
      if map[path[:y] + 1][path[:x]] == 0 || map[path[:y] + 1][path[:x]] > score + 1001
        new_paths << { y: path[:y] + 1, x: path[:x] }
        map[path[:y] + 1][path[:x]] = score + 1001
        dirs[[path[:y] + 1, path[:x]]] = 's'
      end
    end

    if dirs[[path[:y], path[:x]]] == 'n'
      if map[path[:y] - 1][path[:x]] == 0 || map[path[:y] - 1][path[:x]] > score + 1
        new_paths << { y: path[:y] - 1, x: path[:x] }
        map[path[:y] - 1][path[:x]] = score + 1
        dirs[[path[:y] - 1, path[:x]]] = 'n'
      end
      if map[path[:y]][path[:x] + 1] == 0 || map[path[:y]][path[:x] + 1] > score + 1001
        new_paths << { y: path[:y], x: path[:x] + 1 }
        map[path[:y]][path[:x] + 1] = score + 1001
        dirs[[path[:y], path[:x] + 1]] = 'e'
      end
      if map[path[:y]][path[:x] - 1] == 0 || map[path[:y]][path[:x] - 1] > score + 1001
        new_paths << { y: path[:y], x: path[:x] - 1 }
        map[path[:y]][path[:x] - 1] = score + 1001
        dirs[[path[:y], path[:x] - 1]] = 'w'
      end
    end

    if dirs[[path[:y], path[:x]]] == 's'
      if map[path[:y] + 1][path[:x]] == 0 || map[path[:y] + 1][path[:x]] > score + 1
        new_paths << { y: path[:y] + 1, x: path[:x] }
        map[path[:y] + 1][path[:x]] = score + 1
        dirs[[path[:y] + 1, path[:x]]] = 's'
      end
      if map[path[:y]][path[:x] + 1] == 0 || map[path[:y]][path[:x] + 1] > score + 1001
        new_paths << { y: path[:y], x: path[:x] + 1 }
        map[path[:y]][path[:x] + 1] = score + 1001
        dirs[[path[:y], path[:x] + 1]] = 'e'
      end
      if map[path[:y]][path[:x] - 1] == 0 || map[path[:y]][path[:x] - 1] > score + 1001
        new_paths << { y: path[:y], x: path[:x] - 1 }
        map[path[:y]][path[:x] - 1] = score + 1001
        dirs[[path[:y], path[:x] - 1]] = 'w'
      end
    end

    if dirs[[path[:y], path[:x]]] == 'w'
      if map[path[:y]][path[:x] - 1] == 0 || map[path[:y]][path[:x] - 1] > score + 1
        new_paths << { y: path[:y], x: path[:x] - 1 }
        map[path[:y]][path[:x] - 1] = score + 1
        dirs[[path[:y], path[:x] - 1]] = 'w'
      end
      if map[path[:y] - 1][path[:x]] == 0 || map[path[:y] - 1][path[:x]] > score + 1001
        new_paths << { y: path[:y] - 1, x: path[:x] }
        map[path[:y] - 1][path[:x]] = score + 1001
        dirs[[path[:y] - 1, path[:x]]] = 'n'
      end
      if map[path[:y] + 1][path[:x]] == 0 || map[path[:y] + 1][path[:x]] > score + 1001
        new_paths << { y: path[:y] + 1, x: path[:x] }
        map[path[:y] + 1][path[:x]] = score + 1001
        dirs[[path[:y] + 1, path[:x]]] = 's'
      end
    end
  end

  break if new_paths.empty?
  paths = new_paths
end

puts map[finish_y][finish_x]

#############################################################################
# 2 Hmmmmm...
#############################################################################

# The problem is that I can't find all paths during backtracking, because comparison of scores fails in some cases due
# to overwriting. Idea for future: each cell is not a single score, but a hash with directions as keys and scores as
# values. Then, during backtracking, we pick a value according to our next step.
