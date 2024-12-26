# https://adventofcode.com/2024/day/11

stones = File.read('input11.txt').scan(/\d+/).map(&:to_i)
tallied_stones = Hash.new(0).merge(stones.tally)

def blink(tallied_stones)
  tallied_stones.dup.each do |stone_mark, count|
    if stone_mark == 0
      tallied_stones[1] += count
      tallied_stones[0] -= count
    elsif (stone_mark_s = stone_mark.to_s).length.even?
      left_half = stone_mark_s[..stone_mark_s.length / 2 - 1].to_i
      right_half = stone_mark_s[stone_mark_s.length / 2..].to_i
      tallied_stones[left_half] += count
      tallied_stones[right_half] += count
      tallied_stones[stone_mark] -= count
    else
      tallied_stones[stone_mark * 2024] += count
      tallied_stones[stone_mark] -= count
    end
  end

  tallied_stones.delete_if { |_, value| value == 0 }
end

########################################################################################################################
# 1
########################################################################################################################

tallied_stones_dup = tallied_stones.dup
25.times { blink(tallied_stones_dup) }
puts tallied_stones_dup.values.sum
# 211306

########################################################################################################################
# 2
########################################################################################################################

tallied_stones_dup = tallied_stones.dup
75.times { blink(tallied_stones_dup) }
puts tallied_stones_dup.values.sum
# 250783680217283
