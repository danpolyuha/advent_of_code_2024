#############################################################################
# 1 I'm sure there is a better way to do this, but I don't have time
#############################################################################

items = File.read('input09.txt').chars.map(&:to_i)

unzipped = []
items.each_with_index do |item, index|
  value = index.even? ? [index / 2] : [-1]
  unzipped += value * item
end

index_to_relocate = 0

loop do
  last_value_index = unzipped.rindex { |item| item != -1 }
  unzipped.slice!(last_value_index + 1..)

  break if index_to_relocate >= unzipped.length

  unzipped[index_to_relocate] = unzipped.delete_at(unzipped.length - 1) if unzipped[index_to_relocate] == -1
  index_to_relocate += 1
end

puts unzipped.each_with_index.sum { |item, index| item * index }

#############################################################################
# 2
#############################################################################

items = File.read('input09.txt').chars.map(&:to_i)

structure = []
items.each_with_index do |item, index|
  structure << (index.even? ? [index / 2, item] : [-1, item]) if item > 0
end

index_to_relocate = structure.length - 1
while index_to_relocate >= 0
  item_to_relocate = structure[index_to_relocate]

  if item_to_relocate[0] != -1
    free_space_index = structure[..index_to_relocate].find_index do |item|
      item[0] == -1 && item[1] >= item_to_relocate[1]
    end

    if free_space_index
      structure.insert(free_space_index, item_to_relocate.dup)
      index_to_relocate += 1
      structure[free_space_index + 1][1] -= item_to_relocate[1]
      structure[index_to_relocate][0] = -1
    end
  end

  index_to_relocate -= 1
end

unzipped = []
structure.each_with_index { |item| unzipped += [item[0]] * item[1] }
puts unzipped.each_with_index.sum { |item, index| item != -1 ? item * index : 0 }
