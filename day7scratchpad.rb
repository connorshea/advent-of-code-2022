require 'debug'

tree = {
  "/" => {
    :files => [
      {:filename => "b.txt", :size => 14848514},
      {:filename => "c.dat", :size => 8504156}
    ],
    "a" => {
      :files => [
        {:filename => "f", :size => 29116},
        {:filename => "g", :size => 2557},
        {:filename => "h.lst", :size => 62596}
      ],
      "e" => {
        :files => [
          {:filename => "i", :size => 584}
        ]
      }
    },
    "d" => {
      :files => [
        {:filename => "j", :size => 4060174},
        {:filename => "d.log", :size => 8033020},
        {:filename => "d.ext", :size => 5626152},
        {:filename => "k", :size => 7214296}
      ]
    }
  }
}

# Given a tree of files, calculate the sizes for each dir based on its direct descendant files.
def map_sizes_for_dirs(file_tree)
  file_tree.keys.each do |key|
    if key == :files
      file_tree[key] = handle_size(file_tree[key])
      next
    end
    map_sizes_for_dirs(file_tree[key])
  end
end

def handle_size(files)
  files.sum { |file| file[:size] }
end

# Given a hash like so:
# {"/"=>{:files=>23352670, "a"=>{:files=>94269, "e"=>{:files=>584}}, "d"=>{:files=>24933642}}}
# Return an array of all the dir paths, like so:
# ['/', '/.a', '/.a.e', '/.d']
def get_subdir_paths(file_tree, path = [])
  dir_paths = []

  if path.empty?
    file_tree.keys.each do |key|
      dir_paths << key
      dir_paths = dir_paths.concat(get_subdir_paths(file_tree, [key]))
    end
  else
    # Gotta make this recursive
    file_tree.dig(*path).except(:files).keys.each do |key|
      dir_paths << path.dup.push(key).join('.')
      dir_paths = dir_paths.concat(get_subdir_paths(file_tree, path.dup.push(key))).flatten
    end
  end

  dir_paths
end

def get_size_for_path(file_tree, path)
  dir = file_tree.dig(*path)
  size = dir[:files]

  # Bail if this dir has no further subdirs.
  return size if dir.except(:files).keys.empty?

  # Recursively add to the size of the dir
  dir.except(:files).keys.each do |key|
    size += get_size_for_path(file_tree, path.dup.push(key))
  end

  size
end

def get_sizes_including_subdirs(file_tree)
  sizes = {}

  paths = get_subdir_paths(file_tree)

  paths.each do |path|
    sizes[path] = get_size_for_path(file_tree, path.split('.'))
  end

  sizes
end

# Modifies the tree in place.
map_sizes_for_dirs(tree)

dir_sizes = get_sizes_including_subdirs(tree)

puts "Part 1 answer: #{dir_sizes.values.filter { |size| size <= 100000 }.sum }"

