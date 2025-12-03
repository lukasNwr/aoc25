def p2(arr)
  steps = 12
  left_side = []
  right_side = []

  while steps > 0
    max = arr.max
    max_idx = arr.index(max)
    len = arr.length

    break if arr.empty?

    if max_idx > len - steps
      r_index = arr.rindex(max)
      chunk = arr[r_index..-1]
      right_side.prepend(*chunk)
      arr = arr[0...r_index]
      steps -= chunk.length
    else
      left_side << max
      arr = arr[max_idx + 1..]
      steps -= 1
    end

  end

  total = left_side.join + right_side.join
  total.to_i
end

def p1(arr)
  total_jol = []
  max = arr.max

  max_idx = arr.index(max)
  if max_idx == arr.length - 1
    total_jol << arr[0...-1].max << max
  else
    total_jol << max << arr[max_idx + 1..].max
  end

  total_jol.join.to_i
end

if __FILE__ == $0
  lines = File.readlines('./input.txt')

  count_p1 = 0
  count_p2 = 0

  lines.each do |line|
    arr = line.strip.chars.map(&:to_i)

    count_p1 += p1(arr)
    count_p2 += p2(arr)
  end

  puts "total in part1: #{count_p1}"
  puts "total in part2: #{count_p2}"

end
