require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class ThreeOfAKind < HandType::Base
      def matching_cards
        _find_kind(3)
      end

      def strength; 3; end
      def name; "Three of a Kind"; end
    end
  end
end
