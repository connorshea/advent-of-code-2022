require 'debug'
lines = File.readlines('day5input.txt')
# lines = File.readlines('day5testinput.txt')
lines.map! { |line| line.delete("\n") }

breaking_line = lines.find_index { |line| line == '' }

graphic_lines = lines[0...breaking_line - 1]
move_lines = lines[(breaking_line + 1)..]

graphic_lines.map! { |line| line.gsub('    ', '~').gsub(' ', '').gsub(/\[|\]/, '') }

# Turn each line into an array of elements, where the first item is the bottom
# of each stack, and then yeet the empty spaces.
@rotated_graphic_lines = graphic_lines.map { |line| line.split('') }.transpose.map(&:reverse).map do |line|
  line.map { |el| el == '~' ? nil : el }.compact
end

move_lines.map! do |line|
  count, from, to = line.match(/move (\d+) from (\d+) to (\d+)/).to_a[1..].map(&:to_i)

  {
    count: count,
    from: from - 1, # make it zero-indexed
    to: to - 1
  }
end

move_lines.each do |move_hash|
  move_hash[:count].times do
    to = move_hash[:to]
    from = move_hash[:from]
    @rotated_graphic_lines[to].push(@rotated_graphic_lines[from].pop)
  end
end

puts @rotated_graphic_lines.map { |line| line.last }.join('')
