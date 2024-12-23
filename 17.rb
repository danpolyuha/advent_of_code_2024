#############################################################################
# 1
#############################################################################

lines = File.readlines('input17.txt')
@a = lines[0][/\d+/].to_i
@b = lines[1][/\d+/].to_i
@c = lines[2][/\d+/].to_i
program = lines[4].scan(/\d+/).map(&:to_i)
pointer = 0

def combo(n)
  return @a if n == 4
  return @b if n == 5
  return @c if n == 6
  n
end

output = []

loop do
  if program[pointer] == 0
    @a /= 2 ** combo(program[pointer + 1])
    pointer += 2
  elsif program[pointer] == 1
    @b ^= program[pointer + 1]
    pointer += 2
  elsif program[pointer] == 2
    @b = combo(program[pointer + 1]) % 8
    pointer += 2
  elsif program[pointer] == 3
    @a == 0 ? pointer += 2 : pointer = program[pointer + 1]
  elsif program[pointer] == 4
    @b ^= @c
    pointer += 2
  elsif program[pointer] == 5
    output << combo(program[pointer + 1]) % 8
    pointer += 2
  elsif program[pointer] == 6
    @b = @a / 2 ** combo(program[pointer + 1])
    pointer += 2
  elsif program[pointer] == 7
    @c = @a / 2 ** combo(program[pointer + 1])
    pointer += 2
  end

  break if pointer >= program.length
end

puts output.join(',')

#############################################################################
# 2 Hmmmmmmmm...
#############################################################################
