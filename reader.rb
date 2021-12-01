module AOC
  class Reader
    def self.read(day)
      File.read("./inputs/#{day}.txt")
    end

    def self.readlines(day, chomp: true)
      File.readlines("./inputs/#{day}.txt", chomp: chomp)
    end
  end
end
