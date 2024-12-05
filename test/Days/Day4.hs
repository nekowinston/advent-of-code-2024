module Days.Day4 where

import Test.HUnit

import AOC.Day4

sample :: String
sample =
  unlines
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
    assertEqual "TODO" (solve2 sample) (-1)
