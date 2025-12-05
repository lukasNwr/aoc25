def draw_map(room)
  room.each do |line|
    line.each do |char|
      print char
    end
    puts "\n"
  end
end

def in_bounds?(arr, row, col)
  row >= 0 && row < arr.length && col >= 0 && col < arr[0].length
end

def check_neighbors(arr, row, col, coords)
  # This is returned (ruby returns last expression)
  # .count counts all elements where the block returns true
  coords.count do |dr, dc|
    target_row = row + dr
    target_col = col + dc
    in_bounds?(arr, target_row, target_col) && arr[target_row][target_col] == '@'
  end
end

def num_of_acces_rolls(room, room_copy, coords, part = 1)
  num_of_accessible_rolls = 0

  room.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      neighbors = check_neighbors(room, row_index, col_index, coords)

      next unless neighbors < 4 && col == '@'

      num_of_accessible_rolls += 1
      room_copy[row_index][col_index] = 'x'

      room[row_index][col_index] = '.' if part == 2
    end
  end

  num_of_accessible_rolls
end

if __FILE__ == $0
  room = []
  coords = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  total_accesible_rolls = 0

  lines = File.readlines('input.txt')
  lines.each do |line|
    room.push(line.chomp.chars)
  end

  room_copy = room.map(&:dup)

  puts "Part1:  #{num_of_acces_rolls(room, room_copy, coords, 1)}"

  loop do
    ar = num_of_acces_rolls(room, room_copy, coords, 2)
    total_accesible_rolls += ar
    break if ar == 0
  end

  # draw_map(room_copy)
  puts "Part2:  #{total_accesible_rolls}"
end
