# https://adventofcode.com/2024/day/13

lines = File.readlines('input13.txt')

@a = []
@b = []
prizes = []

lines.each_slice(4) do |lines|
  x, y = lines[0].scan(/\d+/).map(&:to_i)
  @a << { x:, y: }
  x, y = lines[1].scan(/\d+/).map(&:to_i)
  @b << { x:, y: }
  x, y = lines[2].scan(/\d+/).map(&:to_i)
  prizes << { x:, y: }
end

# The thing is that there's only 1 solution per each equation
def calc_min_price(prizes)
  min_price = 0

  prizes.each_with_index do |prize, index|
    a_numerator = prize[:x] * @b[index][:y] - @b[index][:x] * prize[:y]
    b_numerator = prize[:y] * @a[index][:x] - @a[index][:y] * prize[:x]
    denominator = @b[index][:y] * @a[index][:x] - @a[index][:y] * @b[index][:x]

    if denominator != 0 && a_numerator % denominator == 0 && b_numerator % denominator == 0
      a_tokens = a_numerator / denominator
      b_tokens = b_numerator / denominator
      min_price += a_tokens * 3 + b_tokens
    end
  end

  min_price
end

########################################################################################################################
# 1
########################################################################################################################

puts calc_min_price(prizes)
# 26810

########################################################################################################################
# 2
########################################################################################################################

updated_prizes = prizes.map { |prize| { x: prize[:x] + 10000000000000, y: prize[:y] + 10000000000000 } }
puts calc_min_price(updated_prizes)
# 108713182988244
