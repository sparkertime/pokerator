require 'spec_helper'
require 'pokerator/table'

describe Pokerator::Table do
  describe "self.parse_lines" do
    it "loads hands from a collection of lines" do
      table = Pokerator::Table.parse_lines(["Scott 2D 3D 4D 5D 6D",
                                            "Alice 3C 3S 3D KH KC",
                                            "Phil AC AD 5C 3D 7H"])
      table.hands.should =~ [
        Pokerator::Hand.parse_line("Scott 2D 3D 4D 5D 6D"),
        Pokerator::Hand.parse_line("Alice 3C 3S 3D KH KC"),
        Pokerator::Hand.parse_line("Phil AC AD 5C 3D 7H"),
      ]
    end
  end

  describe "self.from_file" do
    it "loads hands from a file" do
      table = Pokerator::Table.from_file("spec/test_files/one_winner.txt")

      table.hands.should =~ [
        Pokerator::Hand.parse_line("Scott 2D 3D 4D 5D 6D"),
        Pokerator::Hand.parse_line("Alice 3C 3S 3D KH KC"),
        Pokerator::Hand.parse_line("Phil AC AD 5C 3D 7H"),
      ]
    end
  end

  describe "#winning_hands" do
    it "returns only one hand when there is only one winner" do
      table = Pokerator::Table.parse_lines(["Alice 3C 3S 3D KH KC",
                                            "Scott 2D 3D 4D 5D 6D",
                                            "Phil AC AD 5C 3D 7H"])

      table.winning_hands.should == [Pokerator::Hand.parse_line("Scott 2D 3D 4D 5D 6D")]
    end

    it "returns all tying hands when there are multiple winners" do
      table = Pokerator::Table.parse_lines(["Alice 3C 3S 4D 5H 6C",
                                            "Scott 3H 3D 4H 5D 6S",
                                            "Phil AC KD QC 2D 7H"])

      table.winning_hands.should =~ [
        Pokerator::Hand.parse_line("Alice 3C 3S 4D 5H 6C"),
        Pokerator::Hand.parse_line("Scott 3H 3D 4H 5D 6S"),
      ]
    end
  end

  describe "#losing_hands" do
    it "returns all losers" do
      table = Pokerator::Table.parse_lines(["Alice 3C 3S 3D KH KC",
                                            "Scott 2D 3D 4D 5D 6D",
                                            "Phil AC AD 5C 3D 7H"])

      table.losing_hands.should =~ [
        Pokerator::Hand.parse_line("Alice 3C 3S 3D KH KC"),
        Pokerator::Hand.parse_line("Phil AC AD 5C 3D 7H"),
      ]
    end

    it "returns losers when there is a tie for winning" do
      table = Pokerator::Table.parse_lines(["Alice 3C 3S 4D 5H 6C",
                                            "Scott 3H 3D 4H 5D 6S",
                                            "Phil AC KD QC 2D 7H"])

      table.losing_hands.should == [Pokerator::Hand.parse_line("Phil AC KD QC 2D 7H")]
    end
  end

  describe "#to_s" do
    it "prints a summary of winners and losers" do
      table = Pokerator::Table.parse_lines(["Alice 3C 3S 4D 5H 6C",
                                            "Scott 3H 3D 4H 5D 6S",
                                            "Phil AC KD QC 2D 7H"])
      table.to_s.should == <<EOF
Winners:
Alice: One Pair, 3-High
Scott: One Pair, 3-High

Losers:
Phil: High Card, A-High
EOF
    end
  end
end
