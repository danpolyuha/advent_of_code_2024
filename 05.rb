lines = File.readlines('input05.txt')
first_update_index = lines.find_index { |line| line.include?(',') }
rules = lines[..first_update_index - 2].map { |line| line.split('|').map(&:to_i) }
updates = lines[first_update_index..].map { |line| line.split(',').map(&:to_i) }

@rule_hash = Hash.new { |h, k| h[k] = Set.new }
rules.each { |items| @rule_hash[items[0]] << items[1] }

#############################################################################
# 1
#############################################################################

def ok?(update)
  update == update.sort do |a, b|
    @rule_hash[a].include?(b) ? -1 : (@rule_hash[b].include?(a) ? 1 : 0)
  end
end

puts updates.select { |update| ok?(update) }.sum { |update| update[update.length / 2] }

#############################################################################
# 2
#############################################################################

def fix?(update)
  sorted_update = update.sort do |a, b|
    @rule_hash[a].include?(b) ? -1 : (@rule_hash[b].include?(a) ? 1 : 0)
  end

  sorted_update if sorted_update != update
end

puts updates.filter_map { |update| fix?(update) }.sum { |update| update[update.length / 2] }
