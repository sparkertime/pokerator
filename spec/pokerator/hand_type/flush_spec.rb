require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/four_of_a_kind'

describe Pokerator::HandType::Flush do
  describe "#matching_cards" do
    it "return the four cards when there is a flush" do
      hand = Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D")
      Pokerator::HandType::Flush.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("A", "D"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("8", "D"),
        Pokerator::Card.new("6", "D"),
      ]
    end

    it "returns nothing when there is no flush" do
      hand = Pokerator::Hand.parse_line("Scott 2D AS 5D 8D 6D")
      Pokerator::HandType::Flush.new(hand).matching_cards.should be_empty
    end
  end

  describe "#kickers" do
    it "has none" do
      hand = Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D")
      type = Pokerator::HandType::Flush.new(hand)
      type.kickers.should == []
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D")
      type = Pokerator::HandType::Flush.new(hand)
      type.high_card.rank.should == "A"
    end
  end

  describe "#strength" do
    it "is five" do
      hand = Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D")
      type = Pokerator::HandType::Flush.new(hand)
      type.strength.should == 5
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D")
      type = Pokerator::HandType::Flush.new(hand)
      type.to_s.should == "Flush, A-High"
    end
  end
end
