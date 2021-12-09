require_relative '../utils/reader'

include AOC

ONE_FOUR_SEVEN_EIGHT = /(\b[a-g]{2,4}\b|\b[a-g]{7}\b)/.freeze

def part_one(year, day)
  sigs, output = parse_data(year, day)
  count = 0

  output.each do |s|
    count += s.scan(ONE_FOUR_SEVEN_EIGHT).length
  end
  count
end

def part_two(year, day)
  sigs, output = parse_data(year, day)
  sorted_sigs = sigs.map { |s| s.split.sort_by(&:length) }
  outs = output.map { |o| o.split.map{ |s| s.split('') } }
  total = 0

  sorted_sigs.each_with_index do |sorted, i|
    mapping = Hash.new(0)
    sorted = sorted.map {|s| s.split('')}
    mapping[1], mapping[7], mapping[4] = sorted[0..2]
    mapping[8] = sorted[-1]
  
    six_nine_zero = sorted[6..8]
    nine = six_nine_zero.filter {|arr| (mapping[4] - arr).empty? }.first
    six_nine_zero.delete nine
    zero = six_nine_zero.filter {|arr| (mapping[7] - arr).empty? }.first
    six_nine_zero.delete zero
    mapping[6], mapping[9], mapping[0] = six_nine_zero.first, nine, zero
  
    two_three_five = sorted[3..5]
    three = two_three_five.filter {|arr| (mapping[7] - arr).empty? }.first
    two_three_five.delete three
    five = two_three_five.filter {|arr| (arr - mapping[9]).empty? }.first
    two_three_five.delete five
    mapping[2], mapping[3], mapping[5] = two_three_five.first, three, five

    digits = []
    outs[i].each do |o|
      mapping.each do |k, v|
        digits << k if o.sort.eql? v.sort
      end
    end

    total += digits.join.to_i
  end

  total
end

def parse_data(year, day)
  sigs, output = Reader.readlines(year, day).map { |l| l.split(' |') }.transpose
end
