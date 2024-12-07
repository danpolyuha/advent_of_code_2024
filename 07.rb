# this can be heavily optimized, but it's good enough for the input size

#############################################################################
# 1
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input07.txt')
data = lines.map { |line| line.scan(/\d+/).map(&:to_i) }; 0

def ok?(number, items)
  ['*', '+'].repeated_permutation(items.length - 1).each do |ops|
    n = items[0]
    ops.each_with_index do |op, index|
      op == '*' ? n += items[index + 1] : n *= items[index + 1]
    end

    return true if n == number
  end

  return false
end

result = data.sum { |items| ok?(items[0], items[1..]) ? items[0] : 0 }
puts result

#############################################################################
# 2
#############################################################################
lines = File.readlines('tmp/adventofcode2024/input07.txt')
data = lines.map { |line| line.scan(/\d+/).map(&:to_i) }; 0

def ok2?(number, items)
  ['*', '+', '|'].repeated_permutation(items.length - 1).each do |ops|
    n = items[0]
    ops.each_with_index do |op, index|
      case op
      when '+'
        n += items[index + 1]
      when '*'
        n *= items[index + 1]
      when '|'
        n = "#{n}#{items[index + 1]}".to_i
      end
    end

    return true if n == number
  end

  return false
end

result = data.sum { |items| ok2?(items[0], items[1..]) ? items[0] : 0 }
puts result
