require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/card'

describe Pokerator::Card do
  describe "self.parse" do
    it "creates a card of the appropriate rank and suit" do
      card = Pokerator::Card.parse("AH")
      card.rank.should == "A"
      card.suit.should == "H"
    end

    it "return nil when the rank or suit isn't found" do
      Pokerator::Card.parse("5X").should be_nil
      Pokerator::Card.parse("51H").should be_nil
    end
  end

  describe "#to_s" do
    it "outputs the condensed string" do
      card = Pokerator::Card.new("2", "D")
      card.to_s.should == "2D"
    end
  end

  describe "#==" do
    it "is equal to a card of the same rank and value" do
      Pokerator::Card.new("2", "D").should == Pokerator::Card.new("2", "D")
    end
  end
end
