map = File.readlines('input08.txt').map(&:chomp).map(&:chars)
height = map.length
width = map[0].length

antennas = Hash.new { |h, k| h[k] = [] }

map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    antennas[cell] << [y, x] if cell != '.'
  end
end

########################################################################################################################
# 1
########################################################################################################################

locations = Set.new

antennas.each_value do |antennas_coords|
  antennas_coords.permutation(2).each do |(antenna1_y, antenna1_x), (antenna2_y, antenna2_x)|
    antinode_y = antenna1_y - (antenna2_y - antenna1_y)
    antinode_x = antenna1_x - (antenna2_x - antenna1_x)
    locations << [antinode_y, antinode_x] if antinode_y.between?(0, height - 1) && antinode_x.between?(0, width - 1)
  end
end

puts locations.count
# 423

########################################################################################################################
# 2
########################################################################################################################

locations = Set.new

antennas.each_value do |antennas_coords|
  antennas_coords.permutation(2).each do |(antenna1_y, antenna1_x), (antenna2_y, antenna2_x)|
    y_delta, x_delta = antenna2_y - antenna1_y, antenna2_x - antenna1_x
    antinode_y, antinode_x = antenna1_y, antenna1_x

    loop do
      locations << [antinode_y, antinode_x]

      antinode_y -= y_delta
      antinode_x -= x_delta
      break unless antinode_y.between?(0, height - 1) && antinode_x.between?(0, width - 1)
    end
  end
end

puts locations.count
# 1287
