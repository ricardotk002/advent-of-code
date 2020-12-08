input = ARGF.read

input = input.lines(chomp: true)

def traverse_statements(input)
  visited = []
  ref = 0
  acc = 0
  while !visited.include?(ref) && ref < input.size
    visited << ref
    stmt = input[ref].match(/\A(acc|jmp|nop) (\+|-)(\d+)\z/)
    case stmt[1]
    when "acc"
      acc = acc.send(stmt[2], stmt[3].to_i)
      ref += 1
    when "jmp"
      ref = ref.send(stmt[2], stmt[3].to_i)
    when "nop"
      ref += 1
    end
  end

  [ref, acc]
end

puts traverse_statements(input)[1]

input.each_with_index do |line, idx|
  aux = line.dup
  input[idx].gsub!(/(jmp|nop)/, "jmp" => "nop", "nop" => "jmp")

  ref, acc = traverse_statements(input)

  if ref >= input.size
    puts acc
    break
  end

  input[idx] = aux
end
