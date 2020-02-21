require_relative "../lib/entities/player.rb"

class MockField
    def initialize
    end
end

RSpec.describe Player do
    describe ".initialize" do
        context "When passed with field-compliant object" do
            it "Could be executed successfully" do
                field_compliant_obj = MockField.new
                expect{player_in_test = Player.new(field_compliant_obj)}.not_to raise_error
            end
        end
    end
end