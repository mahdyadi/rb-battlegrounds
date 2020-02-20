class Battleground
    def initialize(columns,rows)
        raise ArgumentError,"columns and rows passed needs to be numeric" unless (columns.is_a?(Numeric) && rows.is_a?(Numeric))

        @tiles = Array.new(columns,Array.new(rows,:empty))
    end

    def get_object(columns,row)
        obj_at_position = @tiles[columns][row]
        return nil unless obj_at_position != :empty
        return obj_at_position
    end

    def place_object(obj,position)
        raise "passed object/first argument doesn't have orientation" unless obj.respond_to?(:orientation)
        raise "passed object/first argument doesn't have length" unless obj.respond_to?(:orientation)

        raise "passed object/first argument's length should be a number" unless obj.length.is_a?(Numeric)

        raise "position/second argument should be a two-length array" unless (position.is_a?(Array) && position.length == 2)

        raise "all element in the position array should be numeric" unless (position.all?{|elem| elem.is_a?(Numeric)})

        raise "passed position should be in the range of current tiles" unless (
            @tiles.length > position[0] && 
            position[0] >= 0 && 
            @tiles[0].length > position[1] &&
            position[1] >= 0
        )

        raise "passed object length cannot be zero" unless obj.length > 0

        case obj.orientation
        when :vertical
            raise "cannot find available space for the object #{obj} in the battleground" unless @tiles.length > (position[0]+obj.length-1)

            (0...obj.length).each do |idx|
                @tiles[position[0]+idx][position[1]] = obj
            end
        when :horizontal
            raise "cannot find available space for the object #{obj} in the battleground" unless @tiles[0].length > (position[1]+obj.length-1)

            (0...obj.length).each do |idx|
                @tiles[position[0]][position[1]+idx] = obj
            end
        else
            raise "passed object's orientation needs to return a :vertical or :horizontal"
        end
    end
end