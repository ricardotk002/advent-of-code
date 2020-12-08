input = ARGF.read

def binary_reduce(xs, min, max, lower)
  xs.each do |c|
    if c == lower
      max = (min + max) / 2
    else
      min = (min + max) / 2 + 1
    end
  end

  [min, max].max
end

def seat_id(n)
  r = binary_reduce(n.chars.first(7), 0, 127, "F")
  c = binary_reduce(n.chars.last(3), 0, 7, "L")

  r * 8 + c
end

seat_ids = input.lines(chomp: true).map { |n| seat_id(n) }

puts seat_ids.max

puts seat_ids.sort[1..-2].each_cons(2).select { |x| x[1] - x[0] == 2 }.inspect
