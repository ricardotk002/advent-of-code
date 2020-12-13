# frozen_string_literal: true

input = ARGF.read
input = input.lines(chomp: true)

def deep_dup(object)
  Marshal.load(Marshal.dump(object))
end

def solve_1(input)
  adjacents = [-1, 0, 1].repeated_permutation(2).reject { |(a, b)| a == 0 && b == 0 }
  repeat = true

  while repeat
    n_input = deep_dup(input)

    input.each_with_index do |line, x|
      line.each_char.with_index do |c, y|
        n_occ = adjacents.count do |(a, b)|
          (x + a).between?(0, input.size - 1) && (y + b).between?(0, line.size - 1) && input[x + a][y + b] == "#"
        end

        if c == "L" && n_occ == 0
          n_input[x][y] = "#"
        elsif c == "#" && n_occ >= 4
          n_input[x][y] = "L"
        end
      end
    end

    repeat = n_input.join != input.join
    input = deep_dup(n_input)
  end

  input.join.count("#")
end

def solve_2(input)
  repeat = true
  adjacents = [-1, 0, 1].repeated_permutation(2).reject { |(a, b)| a == 0 && b == 0 }

  while repeat
    n_input = deep_dup(input)

    input.each_with_index do |line, x|
      line.each_char.with_index do |c, y|
        n_occ = 0
        adjacents.each do |(a, b)|
          n_a = x + a
          n_b = y + b
          while n_a.between?(0, input.size - 1) && n_b.between?(0, line.size - 1)
            if ["#", "L"].include?(input[n_a][n_b])
              n_occ += 1 if input[n_a][n_b] == "#"
              break
            end
            n_a += a
            n_b += b
          end
        end

        if c == "L" && n_occ == 0
          n_input[x][y] = "#"
        elsif c == "#" && n_occ >= 5
          n_input[x][y] = "L"
        end
      end
    end

    repeat = n_input.join != input.join
    input = deep_dup(n_input)
  end

  input.join.count("#")
end

puts solve_1(input)
puts solve_2(input)
