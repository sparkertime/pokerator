require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/four_of_a_kind'

describe Pokerator::HandType::FourOfAKind do
  describe "#matching_cards" do
    it "return the four cards when there is four of a kind" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D")
      Pokerator::HandType::FourOfAKind.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("2", "C"),
        Pokerator::Card.new("2", "H"),
        Pokerator::Card.new("2", "S"),
      ]
    end

    it "returns nothing when there is no four of a kind" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 3S 6D")
      Pokerator::HandType::FourOfAKind.new(hand).matching_cards.should be_empty
    end
  end

  describe "#kickers" do
    it "is the leftover card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D")
      type = Pokerator::HandType::FourOfAKind.new(hand)
      type.kickers.should == [Pokerator::Card.new("6", "D")]
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D")
      type = Pokerator::HandType::FourOfAKind.new(hand)
      type.high_card.rank.should == "2"
    end
  end

  describe "#strength" do
    it "is seven" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D")
      type = Pokerator::HandType::FourOfAKind.new(hand)
      type.strength.should == 7
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D")
      type = Pokerator::HandType::FourOfAKind.new(hand)
      type.to_s.should == "Four of a Kind, 2-High"
    end
  end
end
