require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class Straight < HandType::Base
      def matching_cards
        _straight? ? hand.cards : []
      end

      def strength; 4; end
      def name; "Straight"; end
    end
  end
end
