# frozen_string_literal: true

class Battleground
  def initialize(size, *initial_objects)
    unless size.length == 2
      raise ArgumentError, 'size passed should be a vector of length two: [columns,rows]'
      end

    columns = size[0]
    rows = size[1]
    unless columns.is_a?(Numeric) && rows.is_a?(Numeric)
      raise ArgumentError, 'columns and rows passed needs to be numeric'
    end

    unless columns > 0 && rows > 0
      raise ArgumentError, 'columns/row size should not be zero'
    end

    @tiles = Array.new(columns, Array.new(rows, :empty))

    unless initial_objects.empty?
      initial_objects.each do |obj_coord|
        unless obj_coord.length == 2
          raise ArgumentError, 'passed initial objects information should be consisted of the object and the position'
            end

        obj_pos = obj_coord[1]
        obj = obj_coord[0]
        place_object(obj, obj_pos)
      end
    end
  end

  def get_object(column, row)
    unless (column < @tiles.length && column >= 0) && (row < @tiles[0].length && row >= 0)
      raise ArgumentError, 'passed column value cannot be outside range of tile size'
      end

    obj_at_position = @tiles[column][row]
    return nil unless obj_at_position != :empty

    obj_at_position
  end

  def place_object(obj, position)
    unless obj.respond_to?(:orientation)
      raise ArgumentError, "passed object/first argument doesn't have orientation"
      end

    unless obj.length.is_a?(Numeric)
      raise ArgumentError, "passed object/first argument's length should be a number"
    end

    unless position.is_a?(Array) && position.length == 2
      raise ArgumentError, 'position/second argument should be a two-length array'
    end

    unless position.all? { |elem| elem.is_a?(Numeric) }
      raise ArgumentError, 'all element in the position array should be numeric'
      end

    raise ArgumentError, 'passed position should be in the range of current tiles' unless
        @tiles.length > position[0] &&
        position[0] >= 0 &&
        @tiles[0].length > position[1] &&
        position[1] >= 0

    raise ArgumentError, 'passed object length cannot be zero' if obj.length == 0

    case obj.orientation
    when :vertical
      unless @tiles.length > (position[0] + obj.length - 1)
        raise "cannot find available space for the object #{obj} in the battleground"
        end

      (0...obj.length).each do |idx|
        @tiles[position[0] + idx][position[1]] = obj
      end
    when :horizontal
      unless @tiles[0].length > (position[1] + obj.length - 1)
        raise "cannot find available space for the object #{obj} in the battleground"
        end

      (0...obj.length).each do |idx|
        @tiles[position[0]][position[1] + idx] = obj
      end
    else
      raise "passed object's orientation needs to return a :vertical or :horizontal"
    end
  end
end
