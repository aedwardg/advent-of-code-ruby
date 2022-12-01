File
  .read('./inputs/01.txt')
  .split("\n\n")
  .map { |s| s.split("\n").map(&:to_i).sum }
  .then { p [_1.max, _1.max(3).sum] }
