lines = File.readlines('input01.txt')
transposed_matrix = lines.map { |line| line.split.map(&:to_i) }.transpose

#############################################################################
# 1
#############################################################################

a1_sorted = transposed_matrix[0].sort
a2_sorted = transposed_matrix[1].sort

puts a1_sorted.each_with_index.sum { |item, index| (item - a2_sorted[index]).abs }

#############################################################################
# 2
#############################################################################

a1 = transposed_matrix[0]
a2 = transposed_matrix[1]

a2_tallied = a2.tally

puts a1.sum { |item| item * (a2_tallied[item] || 0) }
