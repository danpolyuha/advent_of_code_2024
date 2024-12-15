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
  antenna_points.permutation(2).each do |(y1, x1), (y2, x2)|
    y = y1 - (y2 - y1)
    x = x1 - (x2 - x1)
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
  antenna_points.permutation(2).each do |(y1, x1), (y2, x2)|
    y_delta, x_delta = y2 - y1, x2 - x1
    y, x = y1, x1

    loop do
      locations << [y, x]

      y -= y_delta
      x -= x_delta
      break unless y.between?(0, n - 1) && x.between?(0, m - 1)
    end
  end
end

puts locations.count
