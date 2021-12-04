require_relative '../utils/reader'

include AOC

def part_one(year, day)
  data = Reader.read(year, day).split("\n\n")
  to_call = data[0].split(',')
  called = []
  winner = nil
  boards = create_boards(data)

  to_call.each do |num|
    break if winner
    called << num
    boards.each do |b|
      b.mark(num)
      if b.winner?
        winner = b
        break
      end
    end
  end

  winner.unmarked * called[-1].to_i
end

def part_two(year, day)
  data = Reader.read(year, day).split("\n\n")
  to_call = data[0].split(',')
  called = []
  winners = []
  boards = create_boards(data)

  to_call.each do |num|
    break if winners.length == boards.length
    called << num
    boards.each do |b|
      if !winners.include?(b)
        b.mark(num)
        if b.winner?
          winners << b
        end
      end
    end
  end

  winners[-1].unmarked * called[-1].to_i
end

def create_boards(data)
  boards = []
  boards_rows = data[1..-1].map {|b| b.split("\n").map(&:split)}
  boards_cols = boards_rows.each_with_object([]) { |b, arr| arr << b.transpose }
  boards_rows.length.times { |i| boards << Board.new(boards_rows[i], boards_cols[i])}
  boards
end

class Board
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
  end

  def mark(num)
    @rows = @rows.map { |r| r.map { |i| i == num ? 'x' : i } }
    @columns = @columns.map { |c| c.map { |i| i == num ? 'x' : i } }
  end

  def unmarked
    @rows.flatten.filter { |num| num != 'x' }.map(&:to_i).sum
  end

  def winner?
    @rows.each { |r| return true if bingo?(r) }
    @columns.each { |c| return true if bingo?(c) }
    false
  end

  def bingo?(arr)
    arr.all?('x')
  end
end