input = ARGF.read.lines.map(&:strip)

def calculate(input, right, down)
  width = input.first.size

  x = 0
  y = 0
  count = 0
  while y < input.size
    count += 1 if input[y][x] == "#"
    if x + right < width
      x += right
    else
      x = x + right - width
    end

    y += down
  end

  count
end

puts calculate(input, 3, 1)

puts calculate(input, 1, 1) * calculate(input, 3, 1) * calculate(input, 5, 1) * calculate(input, 7, 1) * calculate(input, 1, 2)
