require 'spec_helper'
require 'pokerator/hand'
require 'pokerator/hand_type/one_pair'

describe Pokerator::HandType::OnePair do
  describe "self.for_hand" do
    {
      Pokerator::HandType::StraightFlush => Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D"),
      Pokerator::HandType::FourOfAKind   => Pokerator::Hand.parse_line("Scott 2D 2C 2H 2S 6D"),
      Pokerator::HandType::FullHouse     => Pokerator::Hand.parse_line("Scott 2D 2S 2H 5D 5C"),
      Pokerator::HandType::Flush         => Pokerator::Hand.parse_line("Scott 2D AD 5D 8D 6D"),
      Pokerator::HandType::Straight      => Pokerator::Hand.parse_line("Scott 2D 4D 3H 5D 6D"),
      Pokerator::HandType::ThreeOfAKind  => Pokerator::Hand.parse_line("Scott 2D 2C 2H 5D 6D"),
      Pokerator::HandType::TwoPair       => Pokerator::Hand.parse_line("Scott 2D 2S 3H 5D 5C"),
      Pokerator::HandType::OnePair       => Pokerator::Hand.parse_line("Scott 2D 2S 3H 6D 5C"),
      Pokerator::HandType::HighCard      => Pokerator::Hand.parse_line("Scott 2D QS 3H 6D 8C"),
    }.each do |klass, hand|

      it "returns #{klass} types for matching hands" do
        Pokerator::HandType.for_hand(hand).should be_a(klass)
      end
    end
  end

  describe "ordering" do
    it "orders hand types by strength" do
      dummy_hand = Pokerator::Hand.parse_line("Scott 2D 4D 3D 5D 6D")

      all_types = [
        four_of_a_kind = Pokerator::HandType::FourOfAKind.new(dummy_hand),
        straight_flush = Pokerator::HandType::StraightFlush.new(dummy_hand),
        flush = Pokerator::HandType::Flush.new(dummy_hand),
        full_house = Pokerator::HandType::FullHouse.new(dummy_hand),
        three_of_a_kind = Pokerator::HandType::ThreeOfAKind.new(dummy_hand),
        straight = Pokerator::HandType::Straight.new(dummy_hand),
        one_pair = Pokerator::HandType::OnePair.new(dummy_hand),
        two_pair = Pokerator::HandType::TwoPair.new(dummy_hand),
        high_card = Pokerator::HandType::HighCard.new(dummy_hand),
      ]

      all_types.sort.should == [
        high_card,
        one_pair,
        two_pair,
        three_of_a_kind,
        straight,
        flush,
        full_house,
        four_of_a_kind,
        straight_flush
      ]
    end

    it "resolves ties in hand types by high card then by kickers" do
      types = [
        highest_one_pair = Pokerator::HandType.for_hand(Pokerator::Hand.parse_line("Scott 4D 4H AD 7D 6D")),
        lowest_one_pair = Pokerator::HandType.for_hand(Pokerator::Hand.parse_line("Scott 3D 3H 2D 5H 6H")),
        middle_one_pair = Pokerator::HandType.for_hand(Pokerator::Hand.parse_line("Scott 4S 4C AS 5D 6C")),
      ]

      types.sort.should == [
        lowest_one_pair,
        middle_one_pair,
        highest_one_pair,
      ]
    end
  end
end
