#############################################################################
# 1
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input05.txt')
first_update_index = lines.find_index { |line| line.include?(',') }
rules = lines[..first_update_index - 2].map { |line| line.split('|').map(&:to_i) }
updates = lines[first_update_index..].map { |line| line.split(',').map(&:to_i) }

rule_hash = {}
rules.each do |items|
  rule_hash[items[0]] ||= Set.new
  rule_hash[items[0]] << items[1]
end

def ok?(update, rule_hash)
  (0..update.length - 2).each do |start|
    (start + 1..update.length - 1).each do |current|
      return false if rule_hash[update[current]]&.include?(update[start])
    end
  end
end

result = updates.select { |update| ok?(update, rule_hash) }.sum { |update| update[update.length / 2] }
puts result

#############################################################################
# 2
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input05.txt')
first_update_index = lines.find_index { |line| line.include?(',') }
rules = lines[..first_update_index - 2].map { |line| line.split('|').map(&:to_i) }
updates = lines[first_update_index..].map { |line| line.split(',').map(&:to_i) }

rule_hash = {}
rules.each do |items|
  rule_hash[items[0]] ||= Set.new
  rule_hash[items[0]] << items[1]
end

def fix?(update, rule_hash)
  result = false

  (0..update.length - 2).each do |start|
    loop do
      switched = false
      (start + 1..update.length - 1).each do |current|
        if rule_hash[update[current]]&.include?(update[start])
          switched = true
          update[start], update[current] = update[current], update[start]
          break
        end
      end

      switched ? (result = true) : break
    end
  end

  result
end

result = updates.select { |update| fix?(update, rule_hash) }.sum { |update| update[update.length / 2] }
puts result
