require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class HighCard < HandType::Base
      def matching_cards
        [hand.cards.max]
      end

      def strength; 0; end
      def name; "High Card"; end
    end
  end
end
