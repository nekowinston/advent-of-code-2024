module Tests where

import AOC.Common
import qualified AOC.Day1 as D1
import qualified AOC.Day2 as D2
import qualified AOC.Day3 as D3
import qualified AOC.Day4 as D4
import qualified AOC.Day5 as D5

type Part = Int
type Expected = Int
data InputOutput
  = Input Expected -- user input
  | Fixture Expected -- puzzle fixtures
  | InlineFixture Expected String -- puzzle fixtures provided as string
  deriving (Show)
type TestDef = (Part, Solver, [InputOutput])

solverTests :: [[TestDef]]
solverTests =
  [
    [ (1, D1.solve1, [Fixture 11, Input 2192892])
    , (2, D1.solve2, [Fixture 31, Input 22962826])
    ]
  ,
    [ (1, D2.solve1, [Fixture 2, Input 332])
    , (2, D2.solve2, [Fixture 4, Input 398])
    ]
  ,
    [ (1, D3.solve1, [InlineFixture 161 "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))", Input 175015740])
    , (2, D3.solve2, [InlineFixture 48 "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))", Input 112272912])
    ]
  ,
    [ (1, D4.solve1, [Fixture 18, Input 2483])
    , (2, D4.solve2, [Fixture 9, Input 1925])
    ]
  ,
    [ (1, D5.solve1, [Fixture 143, Input 4774])
    , (2, D5.solve2, [Fixture 123, Input 6004])
    ]
  ]
