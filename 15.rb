#############################################################################
# 1
#############################################################################

lines = File.readlines('input15.txt').map(&:chomp)
div_index = lines.index('')
room = lines[..div_index - 1].map { |l| l.chars }
path = lines[div_index + 1..].join

cur_y = room.index { |r| r.include?('@') }
cur_x = room[cur_y].index('@')

path.each_char do |dir|
  y, x = cur_y, cur_x

  if dir == '^'
    loop do
      y -= 1
      break if room[y][x] == '#'

      if room[y][x] == '.'
        y.upto(cur_y - 1).each do |i|
          room[i][x] = room[i + 1][x]
        end
        room[cur_y][cur_x] = '.'
        cur_y -= 1
        break
      end
    end
  elsif dir == 'v'
    loop do
      y += 1
      break if room[y][x] == '#'

      if room[y][x] == '.'
        y.downto(cur_y + 1).each do |i|
          room[i][x] = room[i - 1][x]
        end
        room[cur_y][cur_x] = '.'
        cur_y += 1
        break
      end
    end
  elsif dir == '>'
    loop do
      x += 1
      break if room[y][x] == '#'

      if room[y][x] == '.'
        x.downto(cur_x + 1).each do |i|
          room[y][i] = room[y][i - 1]
        end
        room[cur_y][cur_x] = '.'
        cur_x += 1
        break
      end
    end
  elsif dir == '<'
    loop do
      x -= 1
      break if room[y][x] == '#'

      if room[y][x] == '.'
        x.upto(cur_x - 1).each do |i|
          room[y][i] = room[y][i + 1]
        end
        room[cur_y][cur_x] = '.'
        cur_x -= 1
        break
      end
    end
  end
end

result = 0
room.each_index do |y|
  room[y].each_index do |x|
    result += x + y * 100 if room[y][x] == 'O'
  end
end

puts result

#############################################################################
# 2 This one was the most difficult so far
#############################################################################

lines = File.readlines('input15.txt').map(&:chomp)
div_index = lines.index('')
original_room = lines[..div_index - 1].map { |l| l.chars }
path = lines[div_index + 1..].join

@room = []
original_room.each do |original_line|
  line = []
  original_line.each do |c|
    if c == '@'
      line += ['@', '.']
    elsif c == 'O'
      line += ['[', ']']
    else
      line += [c, c]
    end
  end

  @room << line
end

cur_y = @room.index { |r| r.include?('@') }
cur_x = @room[cur_y].index('@')

def boxes_up(coords, y, x)
  if @room[y - 1][x] == '['
    coords << [y - 1, x]
    boxes_up(coords, y - 1, x)
    boxes_up(coords, y - 1, x + 1)
  elsif @room[y - 1][x] == ']'
    coords << [y - 1, x - 1]
    boxes_up(coords, y - 1, x - 1)
    boxes_up(coords, y - 1, x)
  end
end

def boxes_down(coords, y, x)
  if @room[y + 1][x] == '['
    coords << [y + 1, x]
    boxes_down(coords, y + 1, x)
    boxes_down(coords, y + 1, x + 1)
  elsif @room[y + 1][x] == ']'
    coords << [y + 1, x - 1]
    boxes_down(coords, y + 1, x - 1)
    boxes_down(coords, y + 1, x)
  end
end

path.each_char do |dir|
  y, x = cur_y, cur_x

  if dir == '>'
    loop do
      x += 1
      break if @room[y][x] == '#'

      if @room[y][x] == '.'
        x.downto(cur_x + 1).each do |i|
          @room[y][i] = @room[y][i - 1]
        end
        @room[cur_y][cur_x] = '.'
        cur_x += 1
        break
      end
    end
  elsif dir == '<'
    loop do
      x -= 1
      break if @room[y][x] == '#'

      if @room[y][x] == '.'
        x.upto(cur_x - 1).each do |i|
          @room[y][i] = @room[y][i + 1]
        end
        @room[cur_y][cur_x] = '.'
        cur_x -= 1
        break
      end
    end
  elsif dir == '^'
    move = false

    if @room[y - 1][x] == '[' || @room[y - 1][x] == ']'
      coords = []
      boxes_up(coords, y, x)

      ok = coords.all? { |yy, xx| @room[yy - 1][xx] != '#' && @room[yy - 1][xx + 1] != '#' }
      if ok
        coords.sort_by(&:first).each do |yy, xx|
          @room[yy - 1][xx] = '['
          @room[yy - 1][xx + 1] = ']'
          @room[yy][xx] = '.'
          @room[yy][xx + 1] = '.'
        end

        move = true
      end
    else
      move = true if @room[y - 1][x] == '.'
    end

    if move
      @room[y - 1][x] = '@'
      @room[y][x] = '.'
      cur_y -= 1
    end
  elsif dir == 'v'
    move = false

    if @room[y + 1][x] == '[' || @room[y + 1][x] == ']'
      coords = []
      boxes_down(coords, y, x)

      ok = coords.all? { |yy, xx| @room[yy + 1][xx] != '#' && @room[yy + 1][xx + 1] != '#' }
      if ok
        coords.sort_by(&:first).reverse.each do |yy, xx|
          @room[yy + 1][xx] = '['
          @room[yy + 1][xx + 1] = ']'
          @room[yy][xx] = '.'
          @room[yy][xx + 1] = '.'
        end

        move = true
      end
    else
      move = true if @room[y + 1][x] == '.'
    end

    if move
      @room[y + 1][x] = '@'
      @room[y][x] = '.'
      cur_y += 1
    end
  end
end

result = 0
@room.each_index do |y|
  @room[y].each_index do |x|
    if @room[y][x] == '['
      result += x + y * 100
    end
  end
end

puts result
