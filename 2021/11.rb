require_relative '../utils/reader'

include AOC

def part_one(year, day)
  octopi = set_up_octopi(year, day)
  100.times do
    octopi.each { |o| o.increment }
    octopi.each { |o| o.toggle_flash if o.flashed }
  end

  octopi.map { |o| o.flashes }.sum
end

def part_two(year, day)
  octopi = set_up_octopi(year, day)

  count = 0
  loop do
    count += 1
    octopi.each { |o| o.increment }
    break if octopi.all? { |o| o.flashed }
    octopi.each { |o| o.toggle_flash if o.flashed }
  end

  count
end

def set_up_octopi(year, day)
  data = Reader.readlines(year, day).map { |l| l.chars.map(&:to_i) }
  matrix = data.map.with_index { |row, i| row.map.with_index { |e, j| Octopus.new e, i, j } }
  octopi = matrix.flatten
  octopi.each { |o| o.find_adjacent(matrix)}
  octopi
end

class Octopus
  attr_reader :energy, :flashed, :flashes
  
  def initialize(energy, row, col)
    @energy = energy
    @row = row
    @col = col
    @flashed = false
    @flashes = 0
  end
  
  def find_adjacent(m)
    @left = m[@row][@col - 1] unless @col.zero?
    @right = m[@row][@col + 1] unless @col == m[@row].length - 1
  
    if @row != 0
      @up = m[@row - 1][@col] #up
      @upleft = m[@row - 1][@col - 1] unless @col.zero?
      @upright = m[@row - 1][@col + 1] unless @col == m[@row].length - 1
    end
  
    if @row < m.length - 1
      @down = m[@row + 1][@col]
      @downleft = m[@row + 1][@col - 1] unless @col.zero?
      @downright = m[@row + 1][@col + 1] unless @col == m[@row].length - 1
    end
  end

  def adjacent
    [@left, @right, @up, @upleft, @upright, @down, @downleft, @downright]
  end

  def increment
    return if @flashed
    @energy += 1
    if @energy > 9
      @energy = 0
      toggle_flash
      @flashes += 1
      adjacent.each { |o| o.increment if o }
    end
  end

  def toggle_flash
    @flashed = !@flashed
  end
end
