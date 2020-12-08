input = ARGF.read

TREE = input.lines(chomp: true).reduce([]) do |xs, line|
  root = line.match(/(\w+ \w+) bags contain/)[1]
  leaves = line.scan(/(\d+) (\w+ \w+) bags?/)
  xs << [root, leaves]
  xs
end

def find_possible_containers(arr, *elems)
  found = TREE.reduce([]) do |xs, x|
    xs << x[0] if x[1].any? { |y| elems.include?(y[1]) }
    xs
  end

  if found.empty?
    arr
  else
    find_possible_containers(arr + found, *found)
  end
end

def find_contained_elements(num, elem)
  found = TREE.select { |x| x[0] == elem }.map { |y| y[1] }.flatten(1)

  if found.empty?
    num
  else
    num + num * found.map { |x| find_contained_elements(x[0].to_i, x[1]) }.sum
  end
end

puts find_possible_containers([], "shiny gold").uniq.count
puts find_contained_elements(1, "shiny gold") - 1
