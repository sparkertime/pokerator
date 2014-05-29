require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/straight_flush'

describe Pokerator::HandType::StraightFlush do
  describe "#matching_cards" do
    it "return matching cards when there is a straight flush" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")
      Pokerator::HandType::StraightFlush.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("3", "D"),
        Pokerator::Card.new("4", "D"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("6", "D"),
      ]
    end

    it "returns nothing when there is no straight flush" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H JH AC")
      Pokerator::HandType::StraightFlush.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "has none" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")
      type = Pokerator::HandType::StraightFlush.new(hand)
      type.kickers.should == []
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")
      type = Pokerator::HandType::StraightFlush.new(hand)
      type.high_card.should == Pokerator::Card.new("6", "D")
    end
  end

  describe "#strength" do
    it "is eight" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")
      type = Pokerator::HandType::StraightFlush.new(hand)
      type.strength.should == 8
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")
      type = Pokerator::HandType::StraightFlush.new(hand)
      type.to_s.should == "Straight Flush, 6-High"
    end
  end
end
