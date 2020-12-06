input = ARGF.read

sum = input.split("\n\n").map do |n|
  n.gsub("\n", "").chars.uniq.size
end.sum

puts sum

sum_2 = input.split("\n\n").map do |n|
  lines = n.split("\n")
  if lines.size == 1
    lines.first.size
  else
    lines.map(&:chars).reduce(:&).size
  end
end

puts sum_2.sum
