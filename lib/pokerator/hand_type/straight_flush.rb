require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class StraightFlush < HandType::Base
      def matching_cards
        (_flush? && _straight?) ? hand.cards : []
      end

      def strength; 8; end
      def name; "Straight Flush"; end
    end
  end
end
