module Days.Day4 where

import Data.Text (Text)
import qualified Data.Text as Text
import Test.HUnit

import AOC.Day4

sample :: [Text]
sample =
  map
    Text.pack
    [ "MMMSXXMASM"
    , "MSAMXMSMSA"
    , "AMXSXMAAMM"
    , "MSAMASMSMX"
    , "XMASAMXAMM"
    , "XXAMMXXAMA"
    , "SMSMSASXSS"
    , "SAXAMASAAA"
    , "MAMMMXMMMM"
    , "MXMXAXMASX"
    ]

test1 :: Test
test1 =
  TestCase $
    assertEqual "every `XMAS` is being found" (solve1 sample) 18

test2 :: Test
test2 =
  TestCase $
    assertEqual "every `MAS` stencil is ofund" (solve2 sample) 9
