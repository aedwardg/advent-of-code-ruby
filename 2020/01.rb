require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.readlines(year, day).map(&:to_i)
  nums = data.filter { |n| data.include?(2020 - n) }
  nums.reduce(&:*)
end
  
def part_two(year, day)
  data = Reader.readlines(year, day).map(&:to_i)
  data.each do |n|
    data.each do |m|
      if data.include?(2020 - n - m)
        return n * m * (2020 - n - m)
      end
    end
  end
end
