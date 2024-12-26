# https://adventofcode.com/2024/day/7

equations = File.readlines('input07.txt').map { |line| line.scan(/\d+/).map(&:to_i) }

########################################################################################################################
# 1 Both parts can be optimized by generation of the permutations manually, but it's good enough for the input
########################################################################################################################

def equation_can_be_true?(goal, operands)
  ['*', '+'].repeated_permutation(operands.length - 1).each do |ops|
    result = operands[0]
    ops.each_with_index do |op, index|
      op == '*' ? result += operands[index + 1] : result *= operands[index + 1]
      break if result > goal
    end

    return true if result == goal
  end

  false
end

puts equations.sum { |items| equation_can_be_true?(items[0], items[1..]) ? items[0] : 0 }
# 20281182715321

########################################################################################################################
# 2
########################################################################################################################

def equation_can_be_true2?(goal, operands)
  ['*', '+', '|'].repeated_permutation(operands.length - 1).each do |ops|
    result = operands[0]
    ops.each_with_index do |op, index|
      case op
      when '+'
        result += operands[index + 1]
      when '*'
        result *= operands[index + 1]
      when '|'
        result = "#{result}#{operands[index + 1]}".to_i
      end

      break if result > goal
    end

    return true if result == goal
  end

  false
end

puts equations.sum { |items| equation_can_be_true2?(items[0], items[1..]) ? items[0] : 0 }
# 159490400628354
