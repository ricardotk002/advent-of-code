input = ARGF.read

input = input.lines(chomp: true).map!(&:to_i)

PREAMBLE_SIZE = 25

response_1 = input.detect.with_index do |n, idx|
  next if idx < PREAMBLE_SIZE

  !input.slice(idx - PREAMBLE_SIZE, PREAMBLE_SIZE).combination(2).map(&:sum).include?(n)
end

puts response_1

2.upto(input.size) do |n|
  if response_2 = input.each_cons(n).detect { |n| n.sum == response_1 }
    puts response_2.min + response_2.max
    break
  end
end
