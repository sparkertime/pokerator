require 'pokerator/hand'

module Pokerator
  class Table
    attr_reader :hands

    def self.parse_lines(lines)
      hands = lines.map { |line| Hand.parse_line(line) }
      Table.new(hands)
    end

    def self.from_file(file)
      parse_lines(File.readlines(file))
    end

    def initialize(hands)
      @hands = hands
    end

    def losing_hands
      best_hand = @hands.max
      @hands.select { |h| h < best_hand }
    end

    def winning_hands
      @hands - losing_hands
    end

    def to_s
<<EOF
Winners:
#{_winners_to_s}

Losers:
#{_losers_to_s}
EOF
    end

    def _winners_to_s
      winning_hands.map(&:to_s).join("\n")
    end

    def _losers_to_s
      losing_hands.map(&:to_s).join("\n")
    end
  end
end
