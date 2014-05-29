require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class FullHouse < HandType::Base
      def matching_cards
        cards = _find_kind(3) + _find_kind(2)

        (cards.size == 5) ? cards : []
      end

      def strength; 6; end
      def name; "Full House"; end
    end
  end
end
