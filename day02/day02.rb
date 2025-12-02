def check(first, last, count)
  for i in first..last
    ch = i.to_s
    len = ch.length

    next unless len.even?

    fh = ch.slice(0, len / 2)
    sh = ch.slice(len / 2, len)

    count += i if fh == sh
  end
  count
end

def findUniuqe(id)
  length = id.length

  (1..length / 2).each do |pattern_len|
    next unless length % pattern_len == 0

    pattern = id[0...pattern_len]

    repetitions = length / pattern_len
    return pattern if pattern * repetitions == id
  end

  false
end

def checkInvalid(id, uniq)
  len = id.length
  uniqLen = uniq.length

  steps = len / uniqLen

  (1..steps).each do |i|
    startidx = (i - 1) * uniqLen
    endIdx = i * uniqLen

    part = id[startidx...endIdx]
    # puts "Id: #{id}, uniq: #{uniq}, part: #{part}, i: #{i}, startidx: #{startidx}, endIdx: #{endIdx} "

    return false if part != uniq
  end
  true
end

def check2(first, last, count)
  for i in first..last
    ch = i.to_s
    ch.length

    uniq = findUniuqe(ch)
    next if uniq == false

    next unless uniq.length < ch.length

    isInvalid = checkInvalid(ch, uniq)
    # puts "ID: #{i}, #{uniq}, #{isInvalid}"

    count += i if isInvalid
  end

  count
end

if __FILE__ == $0
  content = File.read('./input.txt')
  ranges = content.split(',')
  count = 0

  ranges.each do |range|
    id1, id2 = range.split('-')
    id1 = id1.to_i
    id2 = id2.to_i

    # count = check(id1, id2, count)
    # puts "ID: #{id1}-#{id2}"
    count = check2(id1, id2, count)
    # puts '------------------ '
  end

  puts "Total count: #{count}"
end
