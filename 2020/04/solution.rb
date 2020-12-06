input = ARGF.read

passports = input.split("\n\n").map { |p| p.split(/ |\n/).map { |s| s.split(":") }.to_h }

required = %w(byr iyr eyr hgt hcl ecl pid)

puts passports.count { |p| [] == required - p.keys }

def validate_year(value_str, min, max)
  value_str =~ /\A\d{4}\z/ && value_str.to_i >= min && value_str.to_i <= max
end

def validate_height(value)
  if value =~ /\A(\d{3})cm\z/
    $1.to_i >= 150 && $1.to_i <= 193
  elsif value =~ /\A(\d{2})in\z/
    $1.to_i >= 51 && $1.to_i <= 76
  else
    false
  end
end

count_2 = passports.count do |p|
  next unless [] == required - p.keys

  byr = validate_year(p["byr"], 1920, 2002)
  iyr = validate_year(p["iyr"], 2010, 2020)
  eyr = validate_year(p["eyr"], 2020, 2030)
  hgt = validate_height(p["hgt"])

  hcl = p["hcl"] =~ /\A#[a-f|0-9]{6}\z/
  ecl = %w(amb blu brn gry grn hzl oth).include?(p["ecl"])
  pid = p["pid"] =~ /\A\d{9}\z/

  byr && iyr && eyr && hgt && hcl && ecl && pid
end

puts count_2
