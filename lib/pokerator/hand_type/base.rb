module Pokerator
  module HandType
    class Base
      include Comparable

      attr_reader :hand

      def matching_cards
        raise NotImplementedError
      end

      def strength
        raise NotImplementedError
      end

      def name
        raise NotImplementedError
      end

      def initialize(hand)
        @hand = hand
      end

      def kickers
        (@hand.cards - matching_cards).sort.reverse
      end

      def high_card
        matching_cards.max
      end

      def _flush?
        @hand.cards.map(&:suit).uniq.size == 1
      end

      def _straight?
        all_values = @hand.cards.map(&:value).uniq
        all_values.size == 5 && (all_values.max - all_values.min) == 4
      end

      def _find_kinds(amount)
        _cards_by_value.select { |value, cards| cards.size == amount }.map { |_, cards| cards }
      end

      def _find_kind(amount)
        _find_kinds(amount).first || []
      end

      def _cards_by_value
        @hand.cards.reduce({}) do |cards_by_value, card|
          cards_by_value[card.value] ||= []
          cards_by_value[card.value] << card
          cards_by_value
        end
      end

      def _compare_kickers(other)
        self.kickers.zip(other.kickers).each do |our_card, their_card|
          comparison = our_card <=> their_card
          return comparison if comparison.nonzero?
        end
        0
      end

      def <=>(other)
        (self.strength <=> other.strength).nonzero? ||
          (self.high_card <=> other.high_card).nonzero? ||
          _compare_kickers(other)
      end

      def to_s
        "#{name}, #{high_card.rank}-High"
      end
    end
  end
end
