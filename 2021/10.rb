require_relative '../utils/reader'

include AOC

def part_one(year, day)
  lines, pairs = parse_data(year, day)
  points = {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}
  illegal = []
  lines.each do |l|
    ok = []
    l.each do |c|      
      ok.pop && next if c == ok[-1]
      illegal << c && break unless pairs.keys.include? c
      ok << pairs[c]
    end
  end
  
  illegal.map(&points).sum
end

def part_two(year, day)
  lines, pairs = parse_data(year, day)
  points = {')' => 1, ']' => 2, '}' => 3, '>' => 4}
  all_totals = []
  ok = Hash.new{ |h,k| h[k] = [] }
  lines.each_with_index do |l, i|
    total = 0
    l.each do |c|
      ok[i].pop && next if c == ok[i][-1]
      (ok[i] = ['illegal'] ; total = nil ; break) unless pairs.keys.include? c
      ok[i] << pairs[c] 
    end

    ok[i].reverse!.each do |sym|
      total = total * 5 + points[sym] unless ok[i] == ['illegal']
    end
    all_totals << total unless total.nil?
  end
  
  all_totals.sort[all_totals.length / 2]
end

def parse_data(year, day)
  return Reader.readlines(year, day).map(&:chars), {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}
end
