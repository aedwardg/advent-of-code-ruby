module AOC
  class Reader
    def self.read(year, day)
      File.read("./#{year}/inputs/#{day}.txt")
    end

    def self.readlines(year, day, chomp: true)
      File.readlines("./#{year}/inputs/#{day}.txt", chomp: chomp)
    end
  end
end
