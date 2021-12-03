require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.readlines(year, day)
  gamma, epsilon = find_gamma_epsilon(data)
  gamma.to_i(2) * epsilon.to_i(2)
end

def part_two(year, day)
  data = Reader.readlines(year, day)
  gamma, epsilon = find_gamma_epsilon(data)
  oxy = []
  co2 = []
  data.each { |bin| bin[0] == gamma[0] ? oxy << bin : co2 << bin }

  gamma.length.times do |i|
    break if oxy.length == 1
    gamma, epsilon = find_gamma_epsilon(oxy)
    oxy = oxy.filter { |s| s[i] == gamma[i]}
  end
  
  epsilon.length.times do |i|
    break if co2.length == 1
    gamma, epsilon = find_gamma_epsilon(co2)
    co2 = co2.filter { |s| s[i] == epsilon[i]}
  end

  oxy[0].to_i(2) * co2[0].to_i(2)
end

def find_gamma_epsilon(data)
  counts = data.each_with_object(Hash.new { |h, k| h[k] = Hash.new(0) }) do |bin, hash|
    bin.each_char.with_index do |char, i|
      hash[i][char] += 1
    end
  end

  gamma = counts.values.map { |h| h['0'] == h['1'] ? '1' : h.key(h.values.max) }.join
  epsilon = counts.values.map { |h| h['0'] == h['1'] ? '0' : h.key(h.values.min) }.join

  return [gamma, epsilon]
end