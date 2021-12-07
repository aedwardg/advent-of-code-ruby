require_relative '../utils/reader'

include AOC

def part_one(year, day)
  locs = parse_data(year, day)
  moves = Hash.new(0)
  calculate_steps(locs, moves)
  moves.values.min
end

def part_two(year, day)
  locs = parse_data(year, day)
  moves = Hash.new(0)
  calculate_steps(locs, moves, compound: true)
  moves.values.min
end

def parse_data(year, day)
  Reader.read(year, day).chomp.split(',').map(&:to_i)
end

def calculate_steps(locs, moves, compound: false)
  0...locs.length.times do |i|
    locs.each do |loc|
      if i.zero?
        moves[i] += compound ? (0..loc).sum : loc
      else
        moves[i] += compound ? (0..(loc - i).abs).sum : (loc - i).abs
      end
    end
  end
end
