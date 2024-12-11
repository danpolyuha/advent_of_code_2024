#############################################################################
# 1
#############################################################################

items = File.read('input11.txt').scan(/\d+/).map(&:to_i)

tallied_items = Hash.new(0).merge(items.tally)

25.times do
  tallied_items.dup.each do |key, value|
    if key == 0
      tallied_items[1] += value
      tallied_items[0] -= value
    elsif (s = key.to_s).length.even?
      n1 = s[0..s.length / 2 - 1].to_i
      n2 = s[s.length / 2..-1].to_i
      tallied_items[n1] += value
      tallied_items[n2] += value
      tallied_items[key] -= value
    else
      tallied_items[key * 2024] += value
      tallied_items[key] -= value
    end
  end

  tallied_items.delete_if { |_, value| value == 0 }
end

puts tallied_items.values.sum

#############################################################################
# 2
#############################################################################

items = File.read('input11.txt').scan(/\d+/).map(&:to_i)

tallied_items = Hash.new(0).merge(items.tally)

75.times do
  tallied_items.dup.each do |key, value|
    if key == 0
      tallied_items[1] += value
      tallied_items[0] -= value
    elsif (s = key.to_s).length.even?
      n1 = s[0..s.length / 2 - 1].to_i
      n2 = s[s.length / 2..-1].to_i
      tallied_items[n1] += value
      tallied_items[n2] += value
      tallied_items[key] -= value
    else
      tallied_items[key * 2024] += value
      tallied_items[key] -= value
    end
  end

  tallied_items.delete_if { |_, value| value == 0 }
end

puts tallied_items.values.sum
