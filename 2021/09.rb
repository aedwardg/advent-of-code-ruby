require_relative '../utils/reader'

include AOC

def part_one(year, day)
  heights = parse_data(year, day)
  lows = find_lows(heights)
  lows.map { |_, v| v + 1 }.sum
end

def part_two(year, day)
  heights = parse_data(year, day)
  lows = find_lows(heights)
  basins = []
  lows.each_key do |low|
    basin = find_basin_size(heights, low)
    basins << basin 
  end
  
  basins.sort_by(&:length)[-3..-1].map(&:length).reduce(:*)
end

def parse_data(year, day)
  heights = Reader.readlines(year, day).map { |l| l.chars.map(&:to_i) }
end

def find_lows(heights)
  lows = {}
  heights.each_with_index do |row, i|
    row.each_with_index do |col, j|
      adj = {}
      adj[:up] = heights[i-1][j] unless i.zero?
      adj[:down] = heights[i+1][j] unless i == heights.length - 1
      adj[:left] = heights[i][j-1] unless j.zero?
      adj[:right] = heights[i][j+1] unless j == row.length - 1
      lows[[i, j]] = col if col < adj.values.min
    end
  end

  lows
end

def find_basin_size(heights, low)
  basin = [low]
  basin.each do |p|
    step_up_down(heights, p, basin)
    step_left_right(heights, p, basin)
  end
  basin
end

def step_up_down(heights, start, basin)
  i, j = start
  while i > 0
    break if heights[i-1][j] > 8
    basin << [i-1, j] unless basin.include? [i-1, j]
    i -= 1
  end
  while i + 1 < heights.length
    break if heights[i+1][j] > 8
    basin << [i+1, j] unless basin.include? [i+1, j]
    i += 1
  end
end

def step_left_right(heights, start, basin)
  i, j = start
  while j > 0
    break if heights[i][j-1] > 8
    basin << [i, j-1] unless basin.include? [i, j-1]
    j -= 1
  end
  while j + 1 < heights[i].length
    break if heights[i][j+1] > 8
    basin << [i, j+1] unless basin.include? [i, j+1]
    j += 1
  end
end
