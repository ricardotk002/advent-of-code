input = ARGF.read

input = input.lines(chomp: true).map(&:to_i)

input.unshift(0) # initial adapter
input << (input.max + 3) # device input

deltas = input.sort.each_cons(2).map do |n|
  n[1] - n[0]
end

puts deltas.count(1) * deltas.count(3)

seq = 0
res = 1
combinations = { 0 => 1, 1 => 1, 2 => 2, 3 => 4, 4 => 7 }
hsh = Hash.new(0)
deltas.each_with_index do |n, idx|
  if n == 1
    seq += 1
    if idx == deltas.size - 1
      res *= combinations[seq]
      hsh[seq] += 1
    end
  else
    res *= combinations[seq]
    hsh[seq] += 1
    seq = 0
  end
end

puts res

# used = [0]
# counters = Hash.new(0)
# input.size.times do
#   value = (input - used).select { |x| x - used.last <= 3 }.min
#   counters[value - used.last] += 1
#   used << value
# end
#
# def calculate_combinations(xs, used)
#   options = (xs - used).select { |x| x - used.last > 0 && x - used.last <= 3 }

#   if options.empty?
#     used
#   else
#     options.map do |n|
#       calculate_combinations(xs - [n], used + [n])
#     end
#   end
# end

# def deep_flatten_array(xs)
#   xs.reduce([]) do |res, x|
#     if x.is_a?(Array) && x.first.is_a?(Integer)
#       res << x
#     elsif x.is_a?(Array)
#       res.concat(deep_flatten_array(x))
#     else
#       res << x
#     end
#   end
# end

# puts deep_flatten_array(calculate_combinations(input, [0])).count
