#############################################################################
# 1
#############################################################################

matrix = File.readlines('input08.txt').map(&:chomp).map(&:chars)
n = matrix.length
m = matrix[0].length

antennas = Hash.new { |h, k| h[k] = [] }

matrix.each_with_index do |line, y|
  line.each_with_index do |char, x|
    antennas[char] << [y, x] if char != '.'
  end
end

locations = Set.new

antennas.each_value do |antenna_points|
  antenna_points.permutation(2).each do |point1, point2|
    y = point1[0] - (point2[0] - point1[0])
    x = point1[1] - (point2[1] - point1[1])
    locations << [y, x] if y.between?(0, n - 1) && x.between?(0, m - 1)
  end
end

puts locations.count

#############################################################################
# 2
#############################################################################

matrix = File.readlines('input08.txt').map(&:chomp).map(&:chars)
n = matrix.length
m = matrix[0].length

antennas = Hash.new { |h, k| h[k] = [] }

matrix.each_with_index do |line, y|
  line.each_with_index do |char, x|
    antennas[char] << [y, x] if char != '.'
  end
end

locations = Set.new

antennas.each_value do |antenna_points|
  antenna_points.permutation(2).each do |point1, point2|
    y_delta = point2[0] - point1[0]
    x_delta = point2[1] - point1[1]
    y = point1[0]
    x = point1[1]

    loop do
      locations << [y, x]

      y -= y_delta
      x -= x_delta
      break unless y.between?(0, n - 1) && x.between?(0, m - 1)
    end
  end
end

puts locations.count
