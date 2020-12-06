input = ARGF.read

puts input.lines.map(&:to_i).combination(2).find { |e| e.sum == 2020 }.reduce(:*)
puts input.lines.map(&:to_i).combination(3).find { |e| e.sum == 2020 }.reduce(:*)
