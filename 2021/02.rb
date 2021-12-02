require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.readlines(year, day).map(&:split)
    .each_with_object(Hash.new(0)) do |cmd, hash|
      dir, amt = cmd
      hash['h'] += amt.to_i if dir == 'forward'
      hash['d'] -= amt.to_i if dir == 'up'
      hash['d'] += amt.to_i if dir == 'down'
    end.values.reduce(&:*)
end

def part_two(year, day)
  aim = 0
  data = Reader.readlines(year, day).map(&:split)
    .each_with_object(Hash.new(0)) do |cmd, hash|
      dir, amt = cmd
      aim -= amt.to_i if dir == 'up'
      aim += amt.to_i if dir == 'down'
      (hash['h'] += amt.to_i ; hash['d'] += amt.to_i * aim) if dir == 'forward'
    end.values.reduce(&:*)
end
