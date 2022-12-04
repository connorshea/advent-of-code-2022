lines = File.readlines('day3input.txt')
# lines = File.readlines('day3testinput.txt')

# Create a map of priorities based on the rules:
# - Lowercase item types a through z have priorities 1 through 26.
# - Uppercase item types A through Z have priorities 27 through 52.

priority_map = {}

('a'..'z').to_a.each_with_index do |letter, index|
  priority_map[letter] = index + 1
end

('A'..'Z').to_a.each_with_index do |letter, index|
  priority_map[letter] = index + 1 + 26
end

priorities = []

lines.each do |line|
  items = line.strip.split('')
  compartment_size = items.length / 2
  # The compartments are each half of the letters in the given sack.
  compartment_one = items[0...compartment_size]
  compartment_two = items[compartment_size..]

  intersection = compartment_one.uniq.intersection(compartment_two.uniq)
  priority = intersection.map { |item| priority_map[item] }
  priorities << priority.sum
end

puts priorities.inspect
puts priorities.sum.inspect


### Part 2 ###

group_priorities = []

lines.each_slice(3).to_a.each do |lines|
  group_items = []
  lines.each do |line|
    group_items << line.strip.split('')
  end

  group_priorities << group_items[0].intersection(group_items[1], group_items[2]).map { |item| priority_map[item] }.sum
end


puts group_priorities.inspect
puts group_priorities.sum.inspect
