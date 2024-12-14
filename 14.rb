#############################################################################
# 1
#############################################################################

lines = File.readlines('input14.txt')
points = []
velocities = []
lines.each do |lines|
  x, y, v1, v2 = lines.scan(/\-?\d+/).map(&:to_i)
  points << { x:, y: }
  velocities << { x: v1, y: v2 }
end

q1, q2, q3, q4 = 0, 0, 0, 0

points.each_with_index do |point, index|
  x = (point[:x] + velocities[index][:x] * 100) % 101
  y = (point[:y] + velocities[index][:y] * 100) % 103

  q1 += 1 if x.between?(0, 49) && y.between?(0, 50)
  q2 += 1 if x.between?(51, 100) && y.between?(0, 50)
  q3 += 1 if x.between?(0, 49) && y.between?(52, 102)
  q4 += 1 if x.between?(51, 100) && y.between?(52, 102)
end

puts q1 * q2 * q3 * q4

#############################################################################
# 2 Let's assume that a tree must have a straight horizontal line
#############################################################################

lines = File.readlines('input14.txt')
points = []
velocities = []
lines.each do |lines|
  x, y, v1, v2 = lines.scan(/\-?\d+/).map(&:to_i)
  points << { x:, y: }
  velocities << { x: v1, y: v2 }
end

step = 1
loop do
  current_points = Set.new
  points.each_with_index do |point, index|
    x = (point[:x] + velocities[index][:x] * step) % 101
    y = (point[:y] + velocities[index][:y] * step) % 103
    current_points << { x:, y: }
  end

  break if current_points.any? do |point|
    (point[:x]..point[:x] + 8).all? { |x| current_points.include?({ x:, y: point[:y] }) }
  end

  step += 1
end

puts step
