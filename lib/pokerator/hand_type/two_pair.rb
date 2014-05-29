require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class TwoPair < HandType::Base
      def matching_cards
        cards = _find_kinds(2).flatten.uniq

        (cards.size == 4) ? cards : []
      end

      def strength; 2; end
      def name; "Two Pair"; end
    end
  end
end
