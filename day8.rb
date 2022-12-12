require 'debug'

lines = File.readlines('day8input.txt')
# lines = File.readlines('day8testinput.txt')
# Yeet the linebreaks.
lines.map!(&:strip)
lines.reject!(&:empty?)

class Grid
  attr_accessor :rows, :width, :height

  def initialize(lines)
    @rows = lines.map { |line| line.split('').map(&:to_i) }
    @width = @rows.first.length
    @height = @rows.length
  end

  # [1, 2] is h
  # [
  #   [a, b, c],
  #   [d, e, f],
  #   [g, h, i]
  # ]

  # Is this cell on the outside perimeter of the grid?
  #
  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  def cell_on_outside_perimeter?(x, y)
    [left_column_index, right_column_index].include?(x) || [top_row_index, bottom_row_index].include?(y)
  end

  # Get the value of a cell in the grid at the given coordinates.
  #
  # @param x [Integer]
  # @param y [Integer]
  # @return [Integer]
  def cell_at_coords(x, y)
    raise ArgumentError, "x cannot be greater than #{right_column_index} or less than 0. Was #{x}." unless (left_column_index..right_column_index).cover?(x)
    raise ArgumentError, "y cannot be greater than #{bottom_row_index} or less than 0. Was #{y}." unless (top_row_index..bottom_row_index).cover?(y)

    rows[y][x]
  end

  def row(i)
    rows[i]
  end

  def column(i)
    rows.map { |r| r[i] }
  end

  def top_row_index
    0
  end

  def bottom_row_index
    height - 1
  end

  def left_column_index
    0
  end

  def right_column_index
    width - 1
  end
end

grid = Grid.new(lines)

puts grid.inspect

cells_visible_from_outside = 0

# Go through every cell in the grid and determine if the given cell is visible.
grid.rows.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if grid.cell_on_outside_perimeter?(x, y)
      cells_visible_from_outside += 1
      next
    end

    adjacent_trees = {
      left: grid.row(y)[0...x],
      right: grid.row(y)[x+1..],
      up: grid.column(x)[0...y],
      down: grid.column(x)[y+1..]
    }

    # Check if all the adjacent trees in the row/column of the given cell have
    # at least one tree in each direction which is larger than the tree we're
    # inspecting. If they all do, skip ahead. If not, add one to the visible
    # tree count.
    next if adjacent_trees.values.map(&:max).all? { |max_height| max_height >= cell }

    cells_visible_from_outside += 1
  end
end

puts "Part 1: #{cells_visible_from_outside}"

scenic_scores = []

# Go through every cell in the grid and determine if the given cell is visible.
grid.rows.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    # If a grid cell is on the perimeter, at least one of the values for an
    # adjacent tree will be 0. This makes the scenic score for this tree 0,
    # no matter what.
    if grid.cell_on_outside_perimeter?(x, y)
      scenic_scores << 0
      next
    end

    adjacent_trees = {
      left: grid.row(y)[0...x],
      right: grid.row(y)[x+1..],
      up: grid.column(x)[0...y],
      down: grid.column(x)[y+1..]
    }

    # Reverse the up and left arrays (because we are checking starting from the current cell, so those need to be reversed so that the first element is the nearest tree)
    adjacent_trees[:left] = adjacent_trees[:left].reverse
    adjacent_trees[:up] = adjacent_trees[:up].reverse

    directional_scenic_scores = adjacent_trees.values.map do |heights|
      visible = 0

      if heights.length == 1
        visible = 1
      else
        heights.each do |height|
          visible += 1
          break if height >= cell
        end
      end

      visible
    end

    # Multiple the directional scores together to get the ultimate scenic score for this cell.
    scenic_scores << directional_scenic_scores.reduce(&:*)
  end
end

puts "Part 2: #{scenic_scores.max}"
