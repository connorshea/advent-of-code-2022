require 'debug'

# lines = File.readlines('day7input.txt')
lines = File.readlines('day7testinput.txt')
# Yeet the linebreaks.
lines.map!(&:strip)

def command?(string)
  string.start_with?('$')
end

tree = {}
current_dir = []

# Iterate through the lines
lines.each do |line|
  puts "tree: #{tree.inspect}"
  puts "current_dir: #{tree.inspect}"
  puts "line: #{line}"
  if command?(line)
    if line == '$ ls'
      puts 'listing, going to next line'
      next
    elsif line.start_with?('$ cd')
      target_dir = line.delete('$ cd')

      if current_dir.empty? && tree.keys.empty?
        tree = { target_dir => {} }
        current_dir << target_dir
        next
      end

      # Go up a directory.
      if target_dir == '..'
        current_dir.pop
      else
        current_dir[0..-1].inject(tree, :fetch)[current_dir.last] = { target_dir => {} }
        current_dir << target_dir
      end
    end
  else
    if line.start_with?('dir')
      next
    else
      size, filename = line.split(' ')
      debugger
    end
  end
end
