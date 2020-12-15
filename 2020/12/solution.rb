input = ARGF.read

insts = input.scan(/(N|S|E|W|L|R|F)(\d+)/)

def move_to_dir(coords, dir, num)
  case dir
  when "N"
    coords[0] += num
  when "S"
    coords[0] -= num
  when "E"
    coords[1] += num
  when "W"
    coords[1] -= num
  end
  coords
end

coords = [0, 0]
ref = %w(E N W S)
insts.each do |(dir, no)|
  no = no.to_i
  case dir
  when "N", "S", "E", "W"
    coords = move_to_dir(coords, dir, no)
  when "L"
    rotations = no / 90
    ref.rotate!(rotations)
  when "R"
    rotations = no / 90
    ref.rotate!(-rotations)
  when "F"
    coords = move_to_dir(coords, ref.first, no)
  end
end

puts coords[0].abs + coords[1].abs

coords = [0, 0]
waypoint = [1, 10]
insts.each do |(dir, no)|
  no = no.to_i
  case dir
  when "N", "S", "E", "W"
    waypoint = move_to_dir(waypoint, dir, no)
  when "L"
    rotations = no / 90
    waypoint = [waypoint[0], waypoint[1], -waypoint[0], -waypoint[1]].rotate!(rotations)[0..1]
  when "R"
    rotations = no / 90
    waypoint = [waypoint[0], waypoint[1], -waypoint[0], -waypoint[1]].rotate!(-rotations)[0..1]
  when "F"
    coords = move_to_dir(coords, waypoint[0].positive? ? "N" : "S", no * waypoint[0].abs)
    coords = move_to_dir(coords, waypoint[1].positive? ? "E" : "W", no * waypoint[1].abs)
  end
end

puts coords[0].abs + coords[1].abs
