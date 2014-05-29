require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/high_card'

describe Pokerator::HandType::HighCard do
  describe "#matching_cards" do
    it "always returns the highest card" do
      hand = Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 5C")
      Pokerator::HandType::HighCard.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("Q", "S"),
      ]
    end
  end

  describe "#kickers" do
    it "contains all other cards" do
      hand = Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 5C")
      type = Pokerator::HandType::HighCard.new(hand)
      type.kickers.should == [
        Pokerator::Card.new("6", "D"),
        Pokerator::Card.new("5", "C"),
        Pokerator::Card.new("3", "H"),
        Pokerator::Card.new("2", "D")
      ]
    end
  end

  describe "#high_card" do
    it "is the high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 5C")
      type = Pokerator::HandType::HighCard.new(hand)
      type.high_card.rank.should == "Q"
    end
  end

  describe "#strength" do
    it "is 0" do
      hand = Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 5C")
      type = Pokerator::HandType::HighCard.new(hand)
      type.strength.should == 0
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 5C")
      type = Pokerator::HandType::HighCard.new(hand)
      type.to_s.should == "High Card, Q-High"
    end
  end
end
