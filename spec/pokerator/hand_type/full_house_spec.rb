require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/full_house'

describe Pokerator::HandType::FullHouse do
  describe "#matching_cards" do
    it "return matching cards when there is a full house" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C")
      Pokerator::HandType::FullHouse.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("2", "S"),
        Pokerator::Card.new("2", "H"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("5", "C"),
      ]
    end

    it "returns empty collection when there is no full house" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 6D 5C")
      Pokerator::HandType::FullHouse.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "has none" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C")
      type = Pokerator::HandType::FullHouse.new(hand)
      type.kickers.should == []
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C")
      type = Pokerator::HandType::FullHouse.new(hand)
      type.high_card.rank.should == "5"
    end
  end

  describe "#strength" do
    it "is six" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C")
      type = Pokerator::HandType::FullHouse.new(hand)
      type.strength.should == 6
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C")
      type = Pokerator::HandType::FullHouse.new(hand)
      type.to_s.should == "Full House, 5-High"
    end
  end
end
