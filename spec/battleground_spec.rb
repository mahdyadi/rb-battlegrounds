require_relative "../entities/battleground.rb"

RSpec.describe "Battleground" do
    it "can be built by giving number of rows and columns" do
        battleground = Battleground.new(1,1)
    end
end