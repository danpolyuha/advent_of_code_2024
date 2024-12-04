#############################################################################
# 1
#############################################################################

matrix = File.readlines('tmp/adventofcode2024/input02.txt').map { |line| line.split.map(&:to_i) }

result = 0
matrix.each do |line|
  diffs = line.each_cons(2).map { |a, b| b - a }
  result += 1 if diffs.all? { |item| item.in?(-3..-1) } || diffs.all? { |n| n.in?(1..3) }
end

puts result

#############################################################################
# 2
#############################################################################

matrix = File.readlines('tmp/adventofcode2024/input02.txt').map { |line| line.split.map(&:to_i) }

def ok?(array)
  diffs = array.each_cons(2).map { |a, b| b - a }
  diffs.all? { |item| item.in?(-3..-1) } || diffs.all? { |n| n.in?(1..3) }
end

result = 0
matrix.each do |line|
  ok = ok?(line)

  unless ok
    (0..line.length - 1).each do |i|
      modified_line = line.dup
      modified_line.delete_at(i)
      if ok?(modified_line)
        ok = true
        break
      end
    end
  end

  result += 1 if ok
end

puts result
