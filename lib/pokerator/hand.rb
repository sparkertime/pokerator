require 'pokerator/card'
require 'pokerator/hand_type'

module Pokerator
  class Hand
    include Comparable

    attr_reader :player, :cards

    def self.parse_line(line)
      player, *card_strs = line.split
      cards = card_strs.map { |card_str| Card.parse(card_str) }.compact
      Hand.new(player, cards)
    end

    def initialize(player, cards)
      @player = player
      @cards = cards
    end

    def type
      HandType.for_hand(self)
    end

    def <=>(other)
      self.type <=> other.type
    end

    def to_s
      "#{player}: #{type}"
    end
  end
end
