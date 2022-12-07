require 'debug'

lines = File.readlines('day6input.txt')
# lines = File.readlines('day6testinput.txt')

def get_marker(string, marker_length: 4)
  chars = string.split('')

  marker = nil
  # Subtract 1 because zero-indexed.
  # Once we reach the last marker_length characters, we don't want to keep checking because otherwise things will break.
  (chars.length - 1 - marker_length).times do |i|
    chars_to_check = chars[i...i+marker_length]
    if chars_to_check.uniq.length == chars_to_check.length
      marker = i + marker_length
      break
    end
  end
  marker
end

puts get_marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 7
puts get_marker('bvwbjplbgvbhsrlpgdmjqwftvncz') == 5
puts get_marker('nppdvjthqldpwncqszvftbrmjlhg') == 6
puts get_marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg') == 10
puts get_marker('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw') == 11


puts "Part 1 solution: #{get_marker(lines[0])}"
puts "Part 2 solution: #{get_marker(lines[0], marker_length: 14)}"
