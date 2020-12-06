input = ARGF.read

count = input.lines.count do |line|
  data = line.match(/\A(\d+)-(\d+) ([a-z]): (\w+)\n\z/)
  count = data[4].count(data[3])
  count.between?(data[1].to_i, data[2].to_i)
end

puts count

count_2 = input.lines.count do |line|
  data = line.match(/\A(\d+)-(\d+) ([a-z]): (\w+)\n\z/)
  count = data[4].count(data[3])
  a = data[4][data[1].to_i - 1]
  b = data[4][data[2].to_i - 1]
  (a != b) && (a == data[3] || b == data[3])
end

puts count_2
