require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/one_pair'

describe Pokerator::HandType::OnePair do
  describe "#matching_cards" do
    it "return cards when there is one pair" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 6D 5C")
      Pokerator::HandType::OnePair.new(hand).matching_cards.should =~ [
        Pokerator::Card.new("2", "D"),
        Pokerator::Card.new("2", "S"),
      ]
    end

    it "returns empty collection when there is no pair" do
      hand = Pokerator::Hand.parse_line("Scott 2D 4S 3H 6D 5C")
      Pokerator::HandType::OnePair.new(hand).matching_cards.should == []
    end
  end

  describe "#kickers" do
    it "all leftover cards" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 7C")
      type = Pokerator::HandType::OnePair.new(hand)
      type.kickers.should == [
        Pokerator::Card.new("7", "C"),
        Pokerator::Card.new("5", "D"),
        Pokerator::Card.new("3", "H")
      ]
    end
  end

  describe "#high_card" do
    it "uses the high card of the hand" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 7C")
      type = Pokerator::HandType::OnePair.new(hand)
      type.high_card.rank.should == "2"
    end
  end

  describe "#strength" do
    it "is 1" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 7C")
      type = Pokerator::HandType::OnePair.new(hand)
      type.strength.should == 1
    end
  end

  describe "#to_s" do
    it "includes the name and high card" do
      hand = Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 7C")
      type = Pokerator::HandType::OnePair.new(hand)
      type.to_s.should == "One Pair, 2-High"
    end
  end
end
