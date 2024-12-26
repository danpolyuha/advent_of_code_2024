# https://adventofcode.com/2024/day/12

@garden = File.readlines('input12.txt').map(&:chomp).map(&:chars)
@height = @garden.length
@width = @garden[0].length

def calculate_region(plant, y, x, region, processed_points)
  return if y < 0 || y >= @height || x < 0 || x >= @width || @garden[y][x] != plant
  return if processed_points.include?([y, x])

  region[:cells] << [y, x]
  processed_points << [y, x]

  calculate_region(plant, y - 1, x, region, processed_points)
  calculate_region(plant, y + 1, x, region, processed_points)
  calculate_region(plant, y, x - 1, region, processed_points)
  calculate_region(plant, y, x + 1, region, processed_points)
end

def form_regions
  processed_points = Set.new
  regions = []

  @garden.each_with_index do |row, y|
    row.each_with_index do |plant, x|
      next if processed_points.include?([y, x])

      region = { plant: plant, cells: [] }
      regions << region
      calculate_region(plant, y, x, region, processed_points)
    end
  end

  regions
end

########################################################################################################################
# 1
########################################################################################################################

regions = form_regions

regions.each do |region|
  perimeter = 0
  region[:cells].each do |y, x|
    perimeter += 1 if y == 0 || @garden[y - 1][x] != region[:plant]
    perimeter += 1 if x == 0 || @garden[y][x - 1] != region[:plant]
    perimeter += 1 if y == @height - 1 || @garden[y + 1][x] != region[:plant]
    perimeter += 1 if x == @width - 1 || @garden[y][x + 1] != region[:plant]
  end

  region[:perimeter] = perimeter
end

puts regions.sum { |r| r[:perimeter] * r[:cells].count }
# 1319878

########################################################################################################################
# 2 This can be done wiser, but again, I don't have time
########################################################################################################################

regions = form_regions

regions.each do |region|
  top_edges = region[:cells].select do |y, x|
    !region[:cells].include?([y - 1, x]) &&
      (!region[:cells].include?([y, x - 1]) ||
        (region[:cells].include?([y, x - 1]) && region[:cells].include?([y - 1, x - 1])))
  end
  bottom_edges = region[:cells].select do |y, x|
    !region[:cells].include?([y + 1, x]) &&
      (!region[:cells].include?([y, x - 1]) ||
        (region[:cells].include?([y, x - 1]) && region[:cells].include?([y + 1, x - 1])))
  end
  left_edges = region[:cells].select do |y, x|
    !region[:cells].include?([y, x - 1]) &&
      (!region[:cells].include?([y - 1, x]) ||
        (region[:cells].include?([y - 1, x]) && region[:cells].include?([y - 1, x - 1])))
  end
  right_edges = region[:cells].select do |y, x|
    !region[:cells].include?([y, x + 1]) &&
      (!region[:cells].include?([y - 1, x]) ||
        (region[:cells].include?([y - 1, x]) && region[:cells].include?([y - 1, x + 1])))
  end

  region[:perimeter] = top_edges.count + bottom_edges.count + left_edges.count + right_edges.count
end

puts regions.sum { |r| r[:perimeter] * r[:cells].count }
# 784982
