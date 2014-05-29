require 'pokerator/hand_type/straight_flush'
require 'pokerator/hand_type/four_of_a_kind'
require 'pokerator/hand_type/full_house'
require 'pokerator/hand_type/flush'
require 'pokerator/hand_type/straight'
require 'pokerator/hand_type/three_of_a_kind'
require 'pokerator/hand_type/two_pair'
require 'pokerator/hand_type/one_pair'
require 'pokerator/hand_type/high_card'

module Pokerator
  module HandType
    ALL_TYPES = [
      HandType::StraightFlush,
      HandType::FourOfAKind,
      HandType::FullHouse,
      HandType::Flush,
      HandType::Straight,
      HandType::ThreeOfAKind,
      HandType::TwoPair,
      HandType::OnePair,
      HandType::HighCard,
    ]

    def self.for_hand(hand)
      ALL_TYPES.
        map { |type| type.new(hand) }.
        detect { |instance| instance.matching_cards.size > 0 }
    end
  end
end
