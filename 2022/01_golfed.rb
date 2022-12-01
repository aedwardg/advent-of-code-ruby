File
  .read('./inputs/01.txt')
  .split("\n\n")
  .map { |s| s.split("\n") }
  .map { |l| l.map(&:to_i) }
  .map(&:sum)
  .tap { p _1.max }
  .then { p _1.max(3).sum }
