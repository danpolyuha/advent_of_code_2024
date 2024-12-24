input_lines = File.readlines('input01.txt')
loc_id_lists = input_lines.map { |line| line.split.map(&:to_i) }.transpose

########################################################################################################################
# 1
########################################################################################################################

loc_ids1_sorted = loc_id_lists[0].sort
loc_ids2_sorted = loc_id_lists[1].sort

puts loc_ids1_sorted.each_with_index.sum { |item, index| (item - loc_ids2_sorted[index]).abs }
# 1882714

########################################################################################################################
# 2
########################################################################################################################

loc_ids1 = loc_id_lists[0]
loc_ids2 = loc_id_lists[1]

loc_ids2_tallied = loc_ids2.tally

puts loc_ids1.sum { |item| item * (loc_ids2_tallied[item] || 0) }
# 19437052
