require_relative "../lib/entities/player.rb"

class MockField
    def initialize
    end
end

class MockShip
    def initialize
    end
end

RSpec.describe Player do
    describe ".initialize" do
        context "When passed only with field-compliant object" do
            it "Should set field member variable successfully" do
                field_compliant_obj = MockField.new
                expect{Player.new(field_compliant_obj)}.not_to raise_error
            end

            it "Should raise error if nil is passed" do
                expect{Player.new(nil)}.to raise_error(ArgumentError)
            end
        end

        context "When passed only with number of ammunition available" do
            it "Should raise error" do
                expect{Player.new(10)}.to raise_error(ArgumentError)
            end
        end

        context "When passed with field-compliant object and ammunition number" do
            it "Should successfully set field member var and ammo number var" do
                field_compliant_obj = MockField.new
                player_in_test = Player.new(field_compliant_obj,10)

                expect(player_in_test.ammo).to eq(10)
                expect()
            end
        end
    end

    describe "#place_ship" do
        before(:each) do 
            @mock_field = MockField.new
            @player_in_test = Player.new(@mock_field,10)
        end

        context "When passed with position only as argument" do
            it "Should raise error" do
                expect{@player_in_test.place_ship([0,0])}.to raise_error(ArgumentError)
            end
        end

        context "When passed with ship object as argument" do
            it "Should raise error" do
                mock_ship = MockShip.new
                expect{@player_in_test.place_ship(mock_ship)}
            end
        end

        context "When passed with ship object and position as argument" do
            it "Should successfully place ship in the specified field" do
                mock_ship = MockShip.new
                expect{@player_in_test.place_ship(mock_ship,[0,0])}
                placed_ship = @mock_field.get_ship([0,0])
                expect(placed_ship == mock_ship).to eq(true)
            end
        end
    end
end