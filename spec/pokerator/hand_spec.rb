require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/card'

describe Pokerator::Hand do
  describe "self.parse_line" do
    it "loads cards from the line" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H JH AC")
      hand.cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("3", "S"),
        Pokerator::Card.new("10", "H"),
        Pokerator::Card.new("J", "H"),
        Pokerator::Card.new("A", "C"),
      ]
    end

    it "loads the player from the line" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H JH AC")
      hand.player.should == "Scott"
    end
  end

  describe "#<=>" do
    it "compares two hands based on hand ranking" do
      losing_hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H 3H AC")
      winning_hand = Pokerator::Hand.parse_line("Scott 2D 3S 3D 3H AC")
      winning_hand.should > losing_hand
    end
  end

  describe "#type" do
    it "returns the appropriate strengths of the hand in order" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H 3H AC")
      hand.type.should be_a(Pokerator::HandType::OnePair)
      hand.type.high_card.rank.should == "3"
      hand.type.kickers.should == [
        Pokerator::Card.new("A", "C"),
        Pokerator::Card.new("10", "H"),
        Pokerator::Card.new("2", "D"),
      ]
    end
  end

  describe "#to_s" do
    it "includes the player and type" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H 3H AC")
      hand.to_s.should == "Scott: One Pair, 3-High"
    end
  end
end
