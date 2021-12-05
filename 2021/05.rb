require_relative '../utils/reader'

include AOC

COORD_REGEX = /^(?<x1>\d{1,3}),(?<y1>\d{1,3}) -> (?<x2>\d{1,3}),(?<y2>\d{1,3})$/.freeze

def part_one(year, day)
  coords = parse_coords(year, day)
  hv_lines = coords.filter { |c| c[:x1] == c[:x2] || c[:y1] == c[:y2] }
  vents = Hash.new(0)
  hv_lines.each { |line| map_vents(line, vents) }
  vents.values.filter {|x| x > 1}.count
end

def part_two(year, day)
  coords = parse_coords(year, day)
  vents = Hash.new(0)
  coords.each { |line| map_vents(line, vents) }
  vents.values.filter {|x| x > 1}.count
end

def parse_coords(year, day)
  data = Reader.readlines(year, day)
  coords = data
    .map { |l| l.match(COORD_REGEX) }
    .map { |m| {x1: m[:x1].to_i, x2: m[:x2].to_i, y1: m[:y1].to_i, y2: m[:y2].to_i} }
end

def map_vents(line, vents)
  min_x, max_x = [line[:x1], line[:x2]].sort
  min_y, max_y = [line[:y1], line[:y2]].sort

  if min_x == max_x
    (min_y..max_y).each { |y| vents[[min_x, y]] += 1}
  elsif min_y == max_y
    (min_x..max_x).each { |x| vents[[x, min_y]] += 1}
  else
    if line[:x1] < line[:x2] && line[:y1] < line[:y2] || line[:x1] > line[:x2] && line[:y1] > line[:y2]
      (min_x..max_x).each_with_index { |x, i| vents[[x, min_y+i]] += 1 }
    else
      (min_x..max_x).each_with_index { |x, i| vents[[x, max_y-i]] += 1 }
    end
  end
end
