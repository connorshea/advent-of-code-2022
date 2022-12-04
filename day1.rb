lines = File.readlines('day1input.txt')

lines.map! { |line| line.strip }

elf_calories = []
current_elf_calories = 0

lines.each do |line|
  if line.empty?
    puts 'empty line, so start over'
    elf_calories << current_elf_calories
    current_elf_calories = 0
    next
  end

  current_elf_calories += line.to_i
end

# puts elf_calories.inspect
puts "Part 1 answer: #{elf_calories.max}"
puts "Part 2 answer: #{elf_calories.max(3).sum}"
