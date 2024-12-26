# https://adventofcode.com/2024/day/14

lines = File.readlines('input14.txt')
points = []
velocities = []
lines.each do |line|
  x, y, v1, v2 = line.scan(/\-?\d+/).map(&:to_i)
  points << { x:, y: }
  velocities << { x: v1, y: v2 }
end

########################################################################################################################
# 1
########################################################################################################################

q1_robot_count, q2_robot_count, q3_robot_count, q4_robot_count = 0, 0, 0, 0

points.each_with_index do |point, index|
  x = (point[:x] + velocities[index][:x] * 100) % 101
  y = (point[:y] + velocities[index][:y] * 100) % 103

  q1_robot_count += 1 if x.between?(0, 49) && y.between?(0, 50)
  q2_robot_count += 1 if x.between?(51, 100) && y.between?(0, 50)
  q3_robot_count += 1 if x.between?(0, 49) && y.between?(52, 102)
  q4_robot_count += 1 if x.between?(51, 100) && y.between?(52, 102)
end

puts q1_robot_count * q2_robot_count * q3_robot_count * q4_robot_count
# 230436441

########################################################################################################################
# 2 Let's assume that a tree must have a straight horizontal line of 8
########################################################################################################################

current_step = 1
loop do
  current_points = Set.new
  points.each_with_index do |point, index|
    x = (point[:x] + velocities[index][:x] * current_step) % 101
    y = (point[:y] + velocities[index][:y] * current_step) % 103
    current_points << { x:, y: }
  end

  break if current_points.any? do |point|
    (point[:x]..point[:x] + 8).all? { |x| current_points.include?({ x:, y: point[:y] }) }
  end

  current_step += 1
end

puts current_step
# 8270
