require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.readlines(year, day).map(&:to_i)
  increases = 0

  data.each_with_index do |element, i|
    increases += 1 if element > data[i - 1]
  end
  increases
end

def part_two(year, day)
  data = Reader.readlines(year, day).map(&:to_i)
  previous = data[0..2].sum
  increases = 0

  data.each_with_index do |element, i|
    break unless i + 2 < data.length

    increases += 1 if (element + data[i + 1] + data[i + 2]) > previous
    previous = element + data[i + 1] + data[i + 2]
  end

  increases
end
