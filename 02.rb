#############################################################################
# 1
#############################################################################

matrix = File.readlines('input02.txt').map { |line| line.split.map(&:to_i) }

result = matrix.count do |line|
  diffs = line.each_cons(2).map { |a, b| b - a }
  diffs.all? { |item| item.in?(-3..-1) } || diffs.all? { |n| n.in?(1..3) }
end

puts result

#############################################################################
# 2
#############################################################################

matrix = File.readlines('input02.txt').map { |line| line.split.map(&:to_i) }

def ok?(array)
  diffs = array.each_cons(2).map { |a, b| b - a }
  diffs.all? { |item| item.in?(-3..-1) } || diffs.all? { |n| n.in?(1..3) }
end

result = matrix.count do |line|
  ok?(line) || line.each_index.any? do |index_to_remove|
    ok?(line[0, index_to_remove] + line[index_to_remove + 1..])
  end
end

puts result
