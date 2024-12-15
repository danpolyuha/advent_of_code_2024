#############################################################################
# 1
#############################################################################

@matrix = File.readlines('input12.txt').map(&:chomp).map(&:chars)
@n = @matrix.length
@m = @matrix[0].length

@processed_points = Set.new
regions = []

def process letter, y, x, region
  return if y < 0 || y >= @n || x < 0 || x >= @m || @matrix[y][x] != letter || @processed_points.include?([y, x])

  region[:cells] << [y, x]
  @processed_points << [y, x]

  process(letter, y - 1, x, region)
  process(letter, y + 1, x, region)
  process(letter, y, x - 1, region)
  process(letter, y, x + 1, region)
end

@matrix.each_with_index do |line, y|
  line.each_with_index do |item, x|
    next if @processed_points.include?([y, x])

    region = { letter: item, cells: [] }
    regions << region
    process(item, y, x, region)
  end
end

regions.each do |region|
  perimeter = 0
  region[:cells].each do |y, x|
    perimeter += 1 if y == 0 || @matrix[y - 1][x] != region[:letter]
    perimeter += 1 if x == 0 || @matrix[y][x - 1] != region[:letter]
    perimeter += 1 if y == @n - 1 || @matrix[y + 1][x] != region[:letter]
    perimeter += 1 if x == @m - 1 || @matrix[y][x + 1] != region[:letter]
  end

  region[:perimeter] = perimeter
end

puts regions.sum { |r| r[:perimeter] * r[:cells].count }

#############################################################################
# 2 This can be done wiser, but again, I don't have time
#############################################################################

@matrix = File.readlines('input12.txt').map(&:chomp).map(&:chars)
@n = @matrix.length
@m = @matrix[0].length

@processed_points = Set.new
regions = []

def process2 letter, y, x, region
  return if y < 0 || y >= @n || x < 0 || x >= @m || @matrix[y][x] != letter || @processed_points.include?([y, x])

  region[:cells] << [y, x]
  @processed_points << [y, x]
  process2(letter, y - 1, x, region)
  process2(letter, y + 1, x, region)
  process2(letter, y, x - 1, region)
  process2(letter, y, x + 1, region)
end

@matrix.each_with_index do |line, y|
  line.each_with_index do |item, x|
    next if @processed_points.include?([y, x])

    region = { letter: item, cells: [] }
    regions << region
    process2(item, y, x, region)
  end
end

regions.each do |region|
  top_cells = region[:cells].select do |y, x|
    !region[:cells].include?([y - 1, x]) &&
      (!region[:cells].include?([y, x - 1]) || (region[:cells].include?([y, x - 1]) && region[:cells].include?([y - 1, x - 1])))
  end
  bottom_cells = region[:cells].select do |y, x|
    !region[:cells].include?([y + 1, x]) &&
      (!region[:cells].include?([y, x - 1]) || (region[:cells].include?([y, x - 1]) && region[:cells].include?([y + 1, x - 1])))
  end
  left_cells = region[:cells].select do |y, x|
    !region[:cells].include?([y, x - 1]) &&
      (!region[:cells].include?([y - 1, x]) || (region[:cells].include?([y - 1, x]) && region[:cells].include?([y - 1, x - 1])))
  end
  right_cells = region[:cells].select do |y, x|
    !region[:cells].include?([y, x + 1]) &&
      (!region[:cells].include?([y - 1, x]) || (region[:cells].include?([y - 1, x]) && region[:cells].include?([y - 1, x + 1])))
  end

  region[:perimeter] = top_cells.count + bottom_cells.count + left_cells.count + right_cells.count
end

puts regions.sum { |r| r[:perimeter] * r[:cells].count }
