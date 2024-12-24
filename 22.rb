#############################################################################
# 1
#############################################################################

initial_numbers = File.readlines('input22.txt').map(&:to_i)

def next_number(number)
  number ^= number * 64
  number %= 16777216
  number ^= (number / 32).round
  number %= 16777216
  number ^= number * 2048
  number % 16777216
end

final_numbers = initial_numbers.map do |number|
  2000.times { number = next_number(number) }
  number
end

puts final_numbers.sum

#############################################################################
# 2
#############################################################################
