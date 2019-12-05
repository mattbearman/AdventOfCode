# frozen_string_literal: true

class Grid
  attr_accessor :cells
  attr_reader :width, :height, :origin

  def initialize(bounds)
    @width, @height = bounds.width, bounds.height
    build
    set_origin(*bounds.origin)
  end

  def build
    self.cells = Array.new(width) do 
      Array.new(height, ".")
    end
  end

  def set_origin(x, y)
    @origin = {
      x: x,
      y: y
    }
  end

  def assign_cell(x, y, cell)
    x, y = offset_coords(x, y) 

    self.cells[x][y] = cell
  end

  def cell_at(x, y)
    x, y = offset_coords(x, y) 

    cells[x][y]
  end

  def offset_coords(x, y)
    return x += origin[:x], y += origin[:y]
  end

  def un_offset_coords(x, y)
    return x -= origin[:x], y -= origin[:y]
  end

  def to_s
    cells.transpose.reverse.map { | row | row.join }.join("\n")
  end

  def all_cells_with_true_coords
    cells.each_with_index do | col, x |
      col.each_with_index do | cell, y |
        yield(cell, *un_offset_coords(x, y)) if cell.is_a?(Cell)
      end
    end
  end
end

class PathList
  attr_reader :paths

  def initialize(path_string)
    setup_paths(path_string)
  end

  def setup_paths(path_string)
    @paths = path_string.split("\n").map do | path |
      Path.new(path)
    end
  end

  def find_bounds
    bounds = PathBounds.new

    walk do | x, y |
      bounds.try_point(x, y)
    end

    bounds
  end

  def walk
    paths.each do | path |
      path.walk do | x, y |
        yield(x, y)
      end
    end
  end

  def plot_to_grid(grid)
    paths.each { | path | path.plot_to_grid(grid) }
  end
end

class Path
  DIRECTIONS = {
    "U" => :up,
    "R" => :right,
    "D" => :down,
    "L" => :left
  }

  attr_reader :instructions, :start_cell
  attr_accessor :current_location

  def initialize(path_string)
    setup_instructions(path_string)
    reset_current_location
  end

  def setup_instructions(path_string)
    @instructions = path_string.split(",").map do | instruction |
      Instruction.new(instruction)
    end
  end

  def reset_current_location
    self.current_location = { x: 0, y: 0 }
  end

  def find_bounds
    bounds = PathBounds.new

    walk do | x, y |
      bounds.try_point(x, y)
    end

    bounds
  end

  def plot_to_grid(grid)
    @start_cell = Cell.new(path: self)
    grid.assign_cell(0, 0, start_cell)
    last_cell = start_cell

    walk do | x, y, instruction |
      new_cell = last_cell.add_cell(direction: DIRECTIONS[instruction.direction])
      new_cell.check_intersection_with!(grid.cell_at(x, y))
      grid.assign_cell(x, y, new_cell)
      last_cell = new_cell
    end
  end

  def walk
    instructions.each do | instruction |
      move(instruction.direction, instruction.steps) do | x, y |
        yield(x, y, instruction)
      end
    end

    reset_current_location
  end

  def move(direction, steps)
    steps.times do
      public_send(DIRECTIONS[direction])

      yield(current_location[:x], current_location[:y])
    end
  end

  def up
    current_location[:y] += 1
  end

  def right
    current_location[:x] += 1
  end

  def down
    current_location[:y] -= 1
  end

  def left
    current_location[:x] -= 1
  end
end

class Instruction
  def initialize(instruction)
    @instruction = instruction
  end

  def direction
    instruction[0]
  end

  def steps
    instruction[1..-1].to_i
  end

  private

  attr_reader :instruction
end

class PathBounds
  attr_accessor :top, :right, :bottom, :left

  def initialize
    @top, @right, @bottom, @left = 0, 0, 0, 0
  end

  def try_point(x, y)
    self.top = [top, y].max
    self.right = [right, x].max
    self.bottom = [bottom, y].min
    self.left = [left, x].min
  end

  def width
    (right - left) + 1
  end

  def height
    (top - bottom) + 1
  end

  def origin
    return left.abs, bottom.abs
  end
end

class Cell
  ORIGIN = "o"
  VERTICAL_WIRE = "|"
  HORIZONTAL_WIRE = "-"
  CORNER = "+"
  INTERSECTION = "x"

  attr_accessor :path, :up, :right, :down, :left, :direction, :intersects_with
  
  def initialize(path:)
    @path = path
    @up, @right, @down, @left, @direction = Array.new(5, nil)
  end

  def to_s
    type
  end

  def next_cell
    if direction
      public_send(direction)
    end
  end

  def check_intersection_with!(cell)
    return unless cell.is_a?(Cell) && cell.is_a_wire?

    if cell.path != path
      cell.intersects_with = self
      self.intersects_with = cell
    end

    true
  end

  def is_a_wire?
    type != ORIGIN
  end

  def type
    return INTERSECTION if intersects_with

    case attachment_count
    when 0
      ORIGIN
    when 1
      if direction
        ORIGIN
      else
        if vertical_attachments.any?
          VERTICAL_WIRE
        elsif horizontal_attachments.any?
          HORIZONTAL_WIRE
        end
      end
    when 2
      if vertical_attachments.all?
        VERTICAL_WIRE
      elsif horizontal_attachments.all?
        HORIZONTAL_WIRE
      else
        CORNER
      end
    end
  end

  def attachment_count
    attachments.reject(&:nil?).count
  end

  def attachments
    return @up, @right, @down, @left
  end

  def vertical_attachments
    return @up, @down
  end

  def horizontal_attachments
    return @left, @right
  end

  def add_cell(direction:)
    self.direction = direction

    cell = self.class.new(path: path)

    send("#{direction}=", cell)
    cell.send("#{opposite_of_direction(direction)}=", self)

    cell
  end

  def opposite_of_direction(direction)
    map = { up: :down, left: :right }
    map[direction] || map.invert[direction]
  end
end

