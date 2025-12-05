def clear_ranges(ranges)
  merged_ranges = []
  ranges = ranges.sort_by { |start, _end| start }
  current_start, current_end = ranges.first

  ranges[1..].each do |start, finish|
    if start <= current_end
      current_end = [current_end, finish].max
    else
      merged_ranges << [current_start, current_end]
      current_start = start
      current_end = finish
    end
  end

  merged_ranges << [current_start, current_end]
  merged_ranges
end

def build_mega_range(ranges)
  mega_range = []
  ranges.each do |range|
    full_range = (range[0]..range[1]).to_a
    mega_range.concat(full_range)
  end

  mega_range
end

def is_in_range(range, id)
  id >= range[0] && id <= range[1]
end

if __FILE__ == $PROGRAM_NAME
  lines = File.readlines('input.txt')

  ranges = []
  ids = []

  lines.each do |line|
    if line.include?('-')
      ranges << line.split('-').map(&:to_i)
    else
      ids << line.to_i
    end
  end

  total = 0

  cleared_ranges = clear_ranges(ranges)

  cleared_ranges.each do |range|
    total += ids.count do |id|
      is_in_range(range, id)
    end
  end

  # puts "Ranges: #{ranges}"
  # puts "IDs: #{ids}"
  puts "Total: #{total}"
end
