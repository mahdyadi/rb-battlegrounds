class Player
    def initialize(field,ammunition = 0)
        raise ArgumentError,"passed field object should not be nil" unless field != nil

        raise ArgumentError,"passed field object should not be numeric" unless !field.is_a?(Numeric)

        @field = field
    end

    def attack_location(x,y)
    end

    def place_ship(x,y)
    end
end