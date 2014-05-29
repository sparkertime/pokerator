require 'pokerator/hand_type/base'

module Pokerator
  module HandType
    class OnePair < HandType::Base
      def matching_cards
        _find_kind(2)
      end

      def strength; 1; end
      def name; "One Pair"; end
    end
  end
end
