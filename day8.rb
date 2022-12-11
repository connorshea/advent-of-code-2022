require 'debug'

# lines = File.readlines('day8input.txt')
lines = File.readlines('day8testinput.txt')
# Yeet the linebreaks.
lines.map!(&:strip)

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
    rows.map { |row| row[i] }
  end

  private

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
