require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/three_of_a_kind'

describe Pokerator::HandType::ThreeOfAKind do
  describe "#matching_cards" do
    it "return matching cards when there is a straight" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D")
      Pokerator::HandType::ThreeOfAKind.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("2", "H"),
        Pokerator::Card.new("2", "C"),
      ]
    end

    it "returns no cards when there is no straight" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 3H 5D 6D")
      Pokerator::HandType::ThreeOfAKind.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "is the highest leftover card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D")
      type = Pokerator::HandType::ThreeOfAKind.new(hand)
      type.kickers.should == [
        Pokerator::Card.new("6", "D"),
        Pokerator::Card.new("5", "D"),
      ]
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D")
      type = Pokerator::HandType::ThreeOfAKind.new(hand)
      type.high_card.rank.should == "2"
    end
  end

  describe "#strength" do
    it "is three" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D")
      type = Pokerator::HandType::ThreeOfAKind.new(hand)
      type.strength.should == 3
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D")
      type = Pokerator::HandType::ThreeOfAKind.new(hand)
      type.to_s.should == "Three of a Kind, 2-High"
    end
  end
end
