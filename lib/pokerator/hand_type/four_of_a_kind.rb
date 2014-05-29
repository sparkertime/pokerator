require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class FourOfAKind < HandType::Base
      def matching_cards
        _find_kind(4)
      end

      def strength; 7; end
      def name; "Four of a Kind"; end
    end
  end
end
