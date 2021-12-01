require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.read(year, day).chomp
  floor = 0
  data.each_char do |step|
    if step == "("
      floor += 1
    else
      floor -= 1
    end
  end

  floor
end

def part_two(year, day)
  data = Reader.read(year, day).chomp
  floor = 0
  data.each_char.with_index(1) do |step, i|
    if step == "("
      floor += 1
    else
      floor -= 1
    end

    return i if floor < 0
  end
end
