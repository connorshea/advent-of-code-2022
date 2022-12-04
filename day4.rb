lines = File.readlines('day4input.txt')
# lines = File.readlines('day4testinput.txt')

# File format:
# 2-4,6-8
# 2-3,4-5
# 5-7,7-9
# 2-8,3-7
# 6-6,4-6
# 2-6,4-8

fully_contained_pairs = 0

# Look for pairs where one of the elves' assigned area fully covers the other.
lines.each do |line|
  elves = line.strip.split(',')

  elf_range1, elf_range2 = elves.map { |elf| (elf.split('-')[0].to_i..elf.split('-')[1].to_i) }
  fully_contained_pairs += 1 if elf_range1.cover?(elf_range2) || elf_range2.cover?(elf_range1)
end

puts fully_contained_pairs

### Part 2 ###

overlapping_pairs = 0

# Look for pairs where one of the elves' assigned areas overlaps with the other.
lines.each do |line|
  elves = line.strip.split(',')

  elf_range1, elf_range2 = elves.map { |elf| (elf.split('-')[0].to_i..elf.split('-')[1].to_i) }

  if elf_range1.to_a.intersect?(elf_range2.to_a)
    overlapping_pairs += 1
  end
end

puts overlapping_pairs
