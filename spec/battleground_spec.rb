# frozen_string_literal: true

require_relative '../lib/entities/battleground.rb'

class MockBattlegroundCompliantObject
  def orientation
    :vertical
  end

  def length
    1
  end

  def to_s
    'hehehe'
  end
end

class MockBattlegroundIncompliantObject
end

RSpec.describe Battleground do
  describe '.initialize' do
    context 'when called by passing vector containing column & row number as args' do
      it 'should succesfully creates new instance' do
        battleground = Battleground.new([1, 1])
      end

      it 'should raise error if given non number value' do
        expect { Battleground.new(['foo', 1]) }.to raise_error(ArgumentError)
        expect { Battleground.new([1, 'foo']) }.to raise_error(ArgumentError)
      end

      it 'should raise error if given zero column/row number' do
        expect { Battleground.new([0, 1]) }.to raise_error(ArgumentError)
        expect { Battleground.new([1, 0]) }.to raise_error(ArgumentError)
      end
    end

    context 'when called by passing vector containing column and row and also initial object' do
      it 'should successfully creates new instance' do
        obj = MockBattlegroundCompliantObject.new
        battleground = Battleground.new([1, 1], [obj, [0, 0]])
      end

      it 'should raise error if given non number value for the position' do
        obj = MockBattlegroundCompliantObject.new
        expect { Battleground.new([0, 0], [obj, ['foo', 1]]) }.to raise_error(ArgumentError)
        expect { Battleground.new([0, 0], [obj, [1, 'foo']]) }.to raise_error(ArgumentError)
      end

      it 'should raise error if given initial object which does not conform to the format of [object, [column position, row position]]' do
        obj = MockBattlegroundCompliantObject.new
        expect { Battleground.new([5, 5], [obj, 1, 2]) }.to raise_error(ArgumentError)
        expect { Battleground.new([5, 5], [obj, [1]]) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#get_object' do
    context 'when given position as arguments' do
      it 'should returns nil if no object/part of it exist in specified position' do
        battleground = Battleground.new([1, 1])
        result = battleground.get_object(0, 0)
        expect(result).to eql(nil)
      end

      it 'should returns the object if the location matches' do
        test_obj = MockBattlegroundCompliantObject.new
        battleground = Battleground.new([5, 5], [test_obj, [0, 0]])
        result = battleground.get_object(0, 0)
        expect(result).to eql(test_obj)
      end

      it 'should raise error if position is outside range of the battlegrounds' do
        battleground = Battleground.new([5, 5])
        expect { battleground.get_object(5, 5) }.to raise_error(ArgumentError)
      end
    end

    context 'when given no arguments' do
      it 'should raise error' do
        battleground = Battleground.new([1, 1])
        expect { battleground.get_object }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#place_object' do
    context 'When given a vector of object and position' do
      it 'should return nil and successfully place object' do
        correct_obj = MockBattlegroundCompliantObject.new
        battleground = Battleground.new([1, 1])
        expect { battleground.place_object(correct_obj, [0, 0]) }.not_to raise_error
      end

      it 'should raise error when the object is not conforming to the required interface' do
        incorrect_obj = MockBattlegroundIncompliantObject.new
        battleground = Battleground.new([1, 1])
        expect { battleground.place_object(incorrect_obj, [0, 0]) }.to raise_error(ArgumentError)
      end
    end
  end
end
