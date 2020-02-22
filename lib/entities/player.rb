class Player
  def initialize(field, ammunition = 0)
    raise ArgumentError, "passed field object should not be nil" unless field != nil

    raise ArgumentError, "passed field object should not be numeric" unless !field.is_a?(Numeric)

    raise ArgumentError, "passed field object should have #place_object method" unless field.respond_to?(:place_object)

    @field = field
    @ammo = ammunition
  end

  def attack_location(x, y)
  end

  def place_ship(ship, (x, y))
    @field.place_object(ship, [x, y])
  end

  private

  def field
    return @field
  end

  def field=(field_obj)
    @field = field_obj
  end
end
