require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class Flush < HandType::Base
      def matching_cards
        _flush? ? hand.cards : []
      end

      def strength; 5; end
      def name; "Flush"; end
    end
  end
end
