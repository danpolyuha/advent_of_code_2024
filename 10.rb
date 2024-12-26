# https://adventofcode.com/2024/day/10

@map = File.readlines('input10.txt').map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) }
@height = @map.size
@width = @map[0].size

########################################################################################################################
# 1
########################################################################################################################

def peak_count(y, x, current_elevation, current_peaks)
  return 0 if y < 0 || y > @height - 1 || x < 0 || x > @width - 1
  return 0 if @map[y][x] != current_elevation || current_peaks.include?([y, x])

  current_peaks.add([y, x]) and return 1 if current_elevation == 9

  current_elevation += 1
  peak_count(y + 1, x, current_elevation, current_peaks) + peak_count(y - 1, x, current_elevation, current_peaks) +
    peak_count(y, x + 1, current_elevation, current_peaks) + peak_count(y, x - 1, current_elevation, current_peaks)
end

result = 0
@map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    result += peak_count(y, x, 0, Set.new) if cell == 0
  end
end

puts result
# 489

########################################################################################################################
# 2
########################################################################################################################

def path_count(y, x, current_elevation)
  return 0 if y < 0 || y > @height - 1 || x < 0 || x > @width - 1 || @map[y][x] != current_elevation

  return 1 if current_elevation == 9

  current_elevation += 1
  path_count(y + 1, x, current_elevation) + path_count(y - 1, x, current_elevation) +
    path_count(y, x + 1, current_elevation) + path_count(y, x - 1, current_elevation)
end

result = 0
@map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    result += path_count(y, x, 0) if cell == 0
  end
end

puts result
# 1086
