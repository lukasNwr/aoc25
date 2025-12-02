def step(direction, distance, position, count)
  origin = position

  if distance > 99
    count += distance / 100
    distance %= 100
  end

  if direction == 'R'
    position += distance

    if position > 99
      position -= 100
      count += 1
    end

  elsif direction == 'L'
    target = position - distance


    position -= distance
    if position < 0
      position = 100 + position
    end

    count += 1 if origin > 0 && target <= 0
  end

  # puts("Origin: #{origin}, #{direction} #{distance}, Pos: #{position},  Count: #{count}#{bigd}#{smal}")

  [position, count]
end

if __FILE__ == $0
  lines = File.readlines('./input.txt')
  pos = 50
  count = 0

  lines.each do |line|
    dir = line[0]
    distance = line[1..].to_i

    pos, count = step(dir, distance, pos, count)
  end

  puts count
end
