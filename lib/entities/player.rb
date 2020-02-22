class Player
  def initialize(field, ammunition = 0)
    raise ArgumentError, "passed field object should not be nil" unless field != nil

    raise ArgumentError, "passed field object should not be numeric" unless !field.is_a?(Numeric)

    raise ArgumentError, "passed field object should have #place_object method" unless field.respond_to?(:place_object)

    unless field.respond_to?(:get_object)
      raise "passed field object should have defined #get_object method"
    end

    @field = field
    @ammo = ammunition
  end

  def receive_attack((x, y))
    ship = @field.get_object([x, y])
    unless ship != nil
      return :missed
    end

    return :destroyed
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
