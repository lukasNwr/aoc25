def draw_map(room)
  room.each do |line|
    line.each do |char|
      print char
    end
    puts "\n"
  end
end

def check_neighbors(arr, row, col, coords)
  rolls = 0
  coords.each do |coord|
    target_row = row + coord[0]
    target_col = col + coord[1]

    next unless target_row >= 0 && target_row < arr.length && target_col >= 0 && target_col < arr[0].length && (arr.dig(
      row + coord[0], col + coord[1]
    ) == '@')

    rolls += 1
  end

  rolls
end

if __FILE__ == $0
  room = []

  coords = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  count = 0
  lines = File.readlines('input.txt')
  lines.each do |line|
    room.push(line.chomp.chars)
  end

  # Debug: check specific positions
  puts "Character at [0,0]: '#{room[0][0]}'"
  puts "Character at [0,1]: '#{room[0][1]}'"
  puts "Character at [0,2]: '#{room[0][2]}'"
  puts "First row: #{room[0].join}"

  puts "Second row: #{room[1].join}"
  puts 'Characters around [0,2]:'
  puts "  [1,1] = '#{room[1][1]}'"
  puts "  [1,2] = '#{room[1][2]}'"
  puts "  [1,3] = '#{room[1][3]}'"

  puts "Room size: #{room.length} x #{room[0].length}"

  room_copy = room.map(&:dup)

  room.each_with_index do |row, row_index|
    row.each_with_index do |_col, col_index|
      neighbors = check_neighbors(room, row_index, col_index, coords)

      if row_index == 0 && room[row_index][col_index] == '@'
        puts "Position [#{row_index}, #{col_index}] = '#{room[row_index][col_index]}', neighbors: #{neighbors}"
      end

      if neighbors < 4 && room[row_index][col_index] == '@'
        count += 1
        room_copy[row_index][col_index] = 'x'
      end
    end
  end
  draw_map(room_copy)
  puts count

end
