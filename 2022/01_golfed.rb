File
  .read('./inputs/01.txt')
  .split("\n\n")
  .map { |s| s.split("\n").map(&:to_i).sum }
  .tap { p _1.max }
  .then { p _1.max(3).sum }
