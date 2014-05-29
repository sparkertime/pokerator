# Pokerator!

Pokerator is a simple program that reads hands from a file and determines the winners. So for example, given this input:

(from ```examples/one_winner.txt```)
```
Scott 2D 3D 4D 5D 6D
Alice 3C 3S 3D KH KC
Phil AC AD 5C 3D 7H
```

The program should provide this output:

```
Winners:
Scott: Straight Flush, 6-High

Losers:
Alice: Full House, K-High
Phil: One Pair, A-High
```

The program should also indicate when there is a tie, as follows:

(from ```examples/tie.txt```)
```
Peter 2D 3D 4D 5D 6D
Ryan AC AD 5C 3D 7H
Niki 2C 3C 4C 5C 6C
```

Output:

```
Winners:
Peter: Straight Flush, 6-High
Niki: Straight Flush, 6-High

Losers:
Ryan: One Pair, A-High
```

The program will also break ties on kickers whenever possible:

(from ```examples/tie_broken_by_kicker.txt```)
```
Tony 10H KC 9D 9C 4H
Jill 10H KC 9D 9C 5H
```

Output:

```
Winners:
Jill: One Pair, 9-High

Losers:
Tony: One Pair, 9-High
```

## Usage

(Note: This project assumes Ruby 2.0)

```bin/summarize FILENAME```

## Implementation Notes

Only limited error-checking is provided - hands should contain valid cards only (2-10, J, Q, K, A) and valid suits only (C, H, D, S). Any card that cannot be parsed will be ignored.
