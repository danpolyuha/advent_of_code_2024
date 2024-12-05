#############################################################################
# 1
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input05.txt').map(&:chomp)
first_update_index = lines.find_index { |line| line.include?(',') }
rules = lines[..first_update_index - 2]
updates = lines[first_update_index..].map { |line| line.split(',').map(&:to_i) }

rule_hash = {}
rules.each do |rule|
  items = rule.split('|').map(&:to_i)
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

result = 0
updates.each do |update|
  if ok?(update, rule_hash)
    result += update[update.length / 2]
  end
end

puts result

#############################################################################
# 2
#############################################################################

lines = File.readlines('tmp/adventofcode2024/input05.txt').map(&:chomp)
first_update_index = lines.find_index { |line| line.include?(',') }
rules = lines[..first_update_index - 2]
updates = lines[first_update_index..].map { |line| line.split(',').map(&:to_i) }

rule_hash = {}
rules.each do |rule|
  items = rule.split('|').map(&:to_i)
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

result = 0
updates.each do |update|
  result += update[update.length / 2] if fix?(update, rule_hash)
end

puts result
