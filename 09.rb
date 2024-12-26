# https://adventofcode.com/2024/day/9

disk_map = File.read('input09.txt').chars.map(&:to_i)

########################################################################################################################
# 1 I'm sure there is a better way to do this, but I don't have time
########################################################################################################################

unzipped_map = []
disk_map.each_with_index do |length, index|
  value = index.even? ? [index / 2] : [-1]
  unzipped_map += value * length
end

index_to_relocate = 0

loop do
  last_block_cell_index = unzipped_map.rindex { |item| item != -1 }
  unzipped_map.slice!(last_block_cell_index + 1..)

  break if index_to_relocate >= unzipped_map.length

  if unzipped_map[index_to_relocate] == -1
    unzipped_map[index_to_relocate] = unzipped_map.delete_at(unzipped_map.length - 1)
  end

  index_to_relocate += 1
end

puts unzipped_map.each_with_index.sum { |item, index| item * index }
# 6398608069280

########################################################################################################################
# 2
########################################################################################################################

block_structure = []
disk_map.each_with_index do |length, index|
  block_structure << (index.even? ? [index / 2, length] : [-1, length]) if length > 0
end

index_to_relocate = block_structure.length - 1
while index_to_relocate >= 0
  item_to_relocate = block_structure[index_to_relocate]

  if item_to_relocate[0] != -1
    free_space_index = block_structure[..index_to_relocate].find_index do |value, length|
      value == -1 && length >= item_to_relocate[1]
    end

    if free_space_index
      block_structure.insert(free_space_index, item_to_relocate.dup)
      index_to_relocate += 1
      block_structure[free_space_index + 1][1] -= item_to_relocate[1]
      block_structure[index_to_relocate][0] = -1
    end
  end

  index_to_relocate -= 1
end

unzipped_map = block_structure.sum([]) { |value, length| [value] * length }
puts unzipped_map.each_with_index.sum { |item, index| item != -1 ? item * index : 0 }
# 6427437134372
