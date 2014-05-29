require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/straight'

describe Pokerator::HandType::Straight do
  describe "#matching_cards" do
    it "returns cards when there is a straight" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3C 5D 6D")
      Pokerator::HandType::Straight.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("3", "C"),
        Pokerator::Card.new("4", "D"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("6", "D"),
      ]
    end

    it "returns no cards when there is no straight" do
      hand = Pokerator::Hand.parse_line("Scott 2D 3S 10H JH AC")
      Pokerator::HandType::Straight.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "has none" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3C 5D 6D")
      type = Pokerator::HandType::Straight.new(hand)
      type.kickers.should == []
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3C 5D 6D")
      type = Pokerator::HandType::Straight.new(hand)
      type.high_card.should == Pokerator::Card.new("6", "D")
    end
  end

  describe "#strength" do
    it "is four" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3C 5D 6D")
      type = Pokerator::HandType::Straight.new(hand)
      type.strength.should == 4
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4D 3C 5D 6D")
      type = Pokerator::HandType::Straight.new(hand)
      type.to_s.should == "Straight, 6-High"
    end
  end
end
