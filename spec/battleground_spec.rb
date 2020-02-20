require_relative "../entities/battleground.rb"

class TestObject
    def orientation
        :vertical
    end

    def length
        1
    end

    def to_s
        "hehehe"
    end
end

RSpec.describe "Battleground" do
    it "can be built by giving number of rows and columns" do
        battleground = Battleground.new(1,1)
    end

    it "should raise error if initialized with non number arguments" do
        expect{Battleground.new("foo",:bar)}.to raise_error(ArgumentError)
    end

    it "get_object returns nil if a tile coordinate is given but no object/part of exist in that tile" do
        battleground = Battleground.new(1,1)
        result = battleground.get_object(0,0)
        expect(result).to eql(nil)
    end

    it "get_object returns the object if a given tile coordinate is the location of an object/part of an object" do
        battleground = Battleground.new(5,5)
        test_obj = TestObject.new
        battleground.place_object(test_obj,[1,2])
        result = battleground.get_object(1,2)
        expect(result).to eql(test_obj)
    end
end