require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/two_pair'

describe Pokerator::HandType::TwoPair do
  describe "#matching_cards" do
    it "return matching cards when there is two pair" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C")
      Pokerator::HandType::TwoPair.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("2", "S"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("5", "C"),
      ]
    end

    it "returns no cards when there is no two pair" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 6D 5C")
      Pokerator::HandType::TwoPair.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "is the leftover card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C")
      type = Pokerator::HandType::TwoPair.new(hand)
      type.kickers.should == [Pokerator::Card.new("3", "H")]
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C")
      type = Pokerator::HandType::TwoPair.new(hand)
      type.high_card.rank.should == "5"
    end
  end

  describe "#strength" do
    it "is 2" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C")
      type = Pokerator::HandType::TwoPair.new(hand)
      type.strength.should == 2
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C")
      type = Pokerator::HandType::TwoPair.new(hand)
      type.to_s.should == "Two Pair, 5-High"
    end
  end
end
