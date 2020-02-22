# frozen_string_literal: true

require_relative '../lib/entities/player.rb'

class MockField
  def initialize
    @field = {}
  end

  def get_object((x, y))
    @field["#{x}#{y}"]
  end

  def place_object(obj, (x, y))
    @field["#{x}#{y}"] = obj
  end
end

class MockShip
  def initialize(health)
    @health = health
  end

  def receive_damage
    @health = @health-1
    return @health
  end
end

RSpec.describe Player do
  describe '.initialize' do
    context 'When passed only with field-compliant object' do
      it 'Should set field member variable successfully' do
        field_compliant_obj = MockField.new
        expect { Player.new(field_compliant_obj) }.not_to raise_error
      end

      it 'Should raise error if nil is passed' do
        expect { Player.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'When passed only with number of ammunition available' do
      it 'Should raise error' do
        expect { Player.new(10) }.to raise_error(ArgumentError)
      end
    end

    context 'When passed with field-compliant object and ammunition number' do
      it 'Should successfully be executed' do
        field_compliant_obj = MockField.new
        expect { Player.new(field_compliant_obj, 10) }.not_to raise_error
      end

      it "Should raise error if passed field-compliant object doesn't have #place_object method" do
        non_field_compliant_obj = Class.new do
          def initialize; end
        end.new

        expect { player_in_test = Player.new(non_field_compliant_obj, 10) }.to raise_error
      end
    end
  end

  describe '#place_ship' do
    before(:each) do
      @mock_field = MockField.new
      @player_in_test = Player.new(@mock_field, 10)
    end

    context 'When passed with position only as argument' do
      it 'Should raise error' do
        expect { @player_in_test.place_ship([0, 0]) }.to raise_error(ArgumentError)
      end
    end

    context 'When passed with ship object as argument' do
      it 'Should raise error' do
        mock_ship = MockShip.new(1)
        expect { @player_in_test.place_ship(mock_ship) }
      end
    end

    context 'When passed with ship object and position as argument' do
      it 'Should successfully place ship in the specified field' do
        mock_ship = MockShip.new(1)
        expect { @player_in_test.place_ship(mock_ship, [0, 0]) }.not_to raise_error
        placed_ship = @mock_field.get_object([0, 0])
        expect(placed_ship == mock_ship).to eq(true)
      end
    end
  end

  describe '#receive_attack' do
    before(:each) do
      @mock_field = MockField.new
      @player_in_test = Player.new(@mock_field, 10)
    end

    context 'When passed with location of the attack' do
      it 'Should return -1 if no ship is in the position' do
        result = @player_in_test.receive_attack([0, 0])
        expect(result).to eq(-1)
      end

      it "should return 0 if the ship's on that position is destroyed because of the attack" do
        mock_ship = MockShip.new(1)
        @mock_field.place_object(mock_ship, [0, 0])
        result = @player_in_test.receive_attack([0, 0])
        expect(result).to eq(0)
      end
    end
  end
end
