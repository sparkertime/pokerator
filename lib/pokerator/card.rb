module Pokerator
  class Card
    include Comparable

    attr_reader :suit, :rank

    SUITS = ["S", "C", "H", "D"]

    RANKS = {
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14,
    }

    def self.parse(str)
      rank = str[0..-2]
      suit = str[-1]
      Card.new(rank, suit) if _valid_rank_and_suit?(rank, suit)
    end

    def initialize(rank, suit)
      @rank = rank
      @suit = suit
    end

    def value
      RANKS[@rank]
    end

    def to_s
      "#{rank}#{suit}"
    end

    def ==(other)
      rank == other.rank && suit == other.suit
    end

    def self._valid_rank_and_suit?(rank, suit)
      RANKS.keys.include?(rank) && SUITS.include?(suit)
    end

    def <=>(other)
      self.value <=> other.value
    end
  end
end
