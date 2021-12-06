require_relative '../utils/reader'

include AOC

def part_one(year, day)
  cycle = parse_data(year, day)
  populate(cycle, 80)
end

def part_two(year, day)
  cycle = parse_data(year, day)
  populate(cycle, 256)
end

def parse_data(year, day)
  Reader.read(year, day).chomp.split(',').map(&:to_i)
        .each_with_object(Hash.new(0)) { |i, h| h[i] += 1 }
end

def populate(cycle, days)
  days.times do
    cycle.sort_by { |k, _| k }.each do |k, v|
      if k.zero?
        cycle[6] += v
        cycle[8] += v
        cycle[k] -= v
      else
        cycle[k] -= v
        cycle[k - 1] += v
      end
    end
  end

  cycle.values.sum
end
