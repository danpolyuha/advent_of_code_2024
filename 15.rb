# https://adventofcode.com/2024/day/15

lines = File.readlines('input15.txt').map(&:chomp)
separator_index = lines.index('')
room = lines[..separator_index - 1].map { |l| l.chars }
path = lines[separator_index + 1..].join

########################################################################################################################
# 1
########################################################################################################################

room_dup = room.map(&:dup)
start_y = room_dup.index { |r| r.include?('@') }
start_x = room_dup[start_y].index('@')

path.each_char do |dir|
  y, x = start_y, start_x

  if dir == '^'
    loop do
      y -= 1
      break if room_dup[y][x] == '#'

      if room_dup[y][x] == '.'
        y.upto(start_y - 1).each do |i|
          room_dup[i][x] = room_dup[i + 1][x]
        end
        room_dup[start_y][start_x] = '.'
        start_y -= 1
        break
      end
    end
  elsif dir == 'v'
    loop do
      y += 1
      break if room_dup[y][x] == '#'

      if room_dup[y][x] == '.'
        y.downto(start_y + 1).each do |i|
          room_dup[i][x] = room_dup[i - 1][x]
        end
        room_dup[start_y][start_x] = '.'
        start_y += 1
        break
      end
    end
  elsif dir == '>'
    loop do
      x += 1
      break if room_dup[y][x] == '#'

      if room_dup[y][x] == '.'
        x.downto(start_x + 1).each do |i|
          room_dup[y][i] = room_dup[y][i - 1]
        end
        room_dup[start_y][start_x] = '.'
        start_x += 1
        break
      end
    end
  elsif dir == '<'
    loop do
      x -= 1
      break if room_dup[y][x] == '#'

      if room_dup[y][x] == '.'
        x.upto(start_x - 1).each do |i|
          room_dup[y][i] = room_dup[y][i + 1]
        end
        room_dup[start_y][start_x] = '.'
        start_x -= 1
        break
      end
    end
  end
end

result = 0
room_dup.each_index do |y_coord|
  room_dup[y_coord].each_index do |x_coord|
    result += x_coord + y_coord * 100 if room_dup[y_coord][x_coord] == 'O'
  end
end

puts result
# 1559280

########################################################################################################################
# 2
########################################################################################################################

@updated_room = []
room.each do |row|
  updated_row = []
  row.each do |c|
    if c == '@'
      updated_row += ['@', '.']
    elsif c == 'O'
      updated_row += ['[', ']']
    else
      updated_row += [c, c]
    end
  end

  @updated_room << updated_row
end

start_y = @updated_room.index { |r| r.include?('@') }
start_x = @updated_room[start_y].index('@')

def boxes_up(box_coords, y, x)
  if @updated_room[y - 1][x] == '['
    box_coords << [y - 1, x]
    boxes_up(box_coords, y - 1, x)
    boxes_up(box_coords, y - 1, x + 1)
  elsif @updated_room[y - 1][x] == ']'
    box_coords << [y - 1, x - 1]
    boxes_up(box_coords, y - 1, x - 1)
    boxes_up(box_coords, y - 1, x)
  end
end

def boxes_down(box_coords, y, x)
  if @updated_room[y + 1][x] == '['
    box_coords << [y + 1, x]
    boxes_down(box_coords, y + 1, x)
    boxes_down(box_coords, y + 1, x + 1)
  elsif @updated_room[y + 1][x] == ']'
    box_coords << [y + 1, x - 1]
    boxes_down(box_coords, y + 1, x - 1)
    boxes_down(box_coords, y + 1, x)
  end
end

path.each_char do |dir|
  y, x = start_y, start_x

  if dir == '>'
    loop do
      x += 1
      break if @updated_room[y][x] == '#'

      if @updated_room[y][x] == '.'
        x.downto(start_x + 1).each do |i|
          @updated_room[y][i] = @updated_room[y][i - 1]
        end
        @updated_room[start_y][start_x] = '.'
        start_x += 1
        break
      end
    end
  elsif dir == '<'
    loop do
      x -= 1
      break if @updated_room[y][x] == '#'

      if @updated_room[y][x] == '.'
        x.upto(start_x - 1).each do |i|
          @updated_room[y][i] = @updated_room[y][i + 1]
        end
        @updated_room[start_y][start_x] = '.'
        start_x -= 1
        break
      end
    end
  elsif dir == '^'
    move = false

    if @updated_room[y - 1][x] == '[' || @updated_room[y - 1][x] == ']'
      box_coords = []
      boxes_up(box_coords, y, x)

      can_move = box_coords.all? do |box_y, box_x|
        @updated_room[box_y - 1][box_x] != '#' && @updated_room[box_y - 1][box_x + 1] != '#'
      end
      if can_move
        box_coords.sort_by(&:first).each do |box_y, box_x|
          @updated_room[box_y - 1][box_x] = '['
          @updated_room[box_y - 1][box_x + 1] = ']'
          @updated_room[box_y][box_x] = '.'
          @updated_room[box_y][box_x + 1] = '.'
        end

        move = true
      end
    else
      move = true if @updated_room[y - 1][x] == '.'
    end

    if move
      @updated_room[y - 1][x] = '@'
      @updated_room[y][x] = '.'
      start_y -= 1
    end
  elsif dir == 'v'
    move = false

    if @updated_room[y + 1][x] == '[' || @updated_room[y + 1][x] == ']'
      box_coords = []
      boxes_down(box_coords, y, x)

      can_move = box_coords.all? do |box_y, box_x|
        @updated_room[box_y + 1][box_x] != '#' && @updated_room[box_y + 1][box_x + 1] != '#'
      end
      if can_move
        box_coords.sort_by(&:first).reverse.each do |box_y, box_x|
          @updated_room[box_y + 1][box_x] = '['
          @updated_room[box_y + 1][box_x + 1] = ']'
          @updated_room[box_y][box_x] = '.'
          @updated_room[box_y][box_x + 1] = '.'
        end

        move = true
      end
    else
      move = true if @updated_room[y + 1][x] == '.'
    end

    if move
      @updated_room[y + 1][x] = '@'
      @updated_room[y][x] = '.'
      start_y += 1
    end
  end
end

result = 0
@updated_room.each_index do |y_coord|
  @updated_room[y_coord].each_index do |x_coord|
    result += x_coord + y_coord * 100 if @updated_room[y_coord][x_coord] == '['
  end
end

puts result
# 1576353
