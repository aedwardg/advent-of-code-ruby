# frozen_string_literal: true

require_relative '../utils/reader'

include AOC

def part_one(year, day)
  parse_data(year, day).max
end

def part_two(year, day)
  parse_data(year, day).max(3).sum
end

  private

def parse_data(year, day)
  Reader
    .read(year, day)
    .split("\n\n")
    .map { |s| s.split("\n") }
    .map { |l| l.map(&:to_i) }
    .map(&:sum)
end
