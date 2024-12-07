#############################################################################
# 1 Both parts can be optimized by generation of the permutations manually, but it's good enough for the input
#############################################################################

lines = File.readlines('input07.txt')
data = lines.map { |line| line.scan(/\d+/).map(&:to_i) }; 0

def ok?(goal, items)
  ['*', '+'].repeated_permutation(items.length - 1).each do |ops|
    n = items[0]
    ops.each_with_index do |op, index|
      op == '*' ? n += items[index + 1] : n *= items[index + 1]
      break if n > goal
    end

    return true if n == goal
  end

  false
end

puts data.sum { |items| ok?(items[0], items[1..]) ? items[0] : 0 }

#############################################################################
# 2
#############################################################################

lines = File.readlines('input07.txt')
data = lines.map { |line| line.scan(/\d+/).map(&:to_i) }; 0

def ok2?(goal, items)
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

      break if n > goal
    end

    return true if n == goal
  end

  false
end

puts data.sum { |items| ok2?(items[0], items[1..]) ? items[0] : 0 }
