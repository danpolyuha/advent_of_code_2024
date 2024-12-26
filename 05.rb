# https://adventofcode.com/2024/day/5

input_lines = File.readlines('input05.txt')
sep_index = input_lines.index("\n")
rules = input_lines[..sep_index - 1].map { |line| line.split('|').map(&:to_i) }
updates = input_lines[sep_index..].map { |line| line.split(',').map(&:to_i) }

@rule_hash = Hash.new { |h, k| h[k] = Set.new }
rules.each { |page1, page2| @rule_hash[page1] << page2 }

########################################################################################################################
# 1
########################################################################################################################

def ordered_update?(update)
  update == update.sort do |page1, page2|
    @rule_hash[page1].include?(page2) ? -1 : (@rule_hash[page2].include?(page1) ? 1 : 0)
  end
end

puts updates.select { |update| ordered_update?(update) }.sum { |update| update[update.length / 2] }
# 5091

########################################################################################################################
# 2
########################################################################################################################

def order_update(update)
  sorted_update = update.sort do |page1, page2|
    @rule_hash[page1].include?(page2) ? -1 : (@rule_hash[page2].include?(page1) ? 1 : 0)
  end

  sorted_update if sorted_update != update
end

puts updates.filter_map { |update| order_update(update) }.sum { |update| update[update.length / 2] }
# 4681
