module Days.Day2 where

import Test.HUnit

import AOC.Day2

sample :: String
sample =
  unlines
    [ "7 6 4 2 1"
    , "1 2 7 8 9"
    , "9 7 6 2 1"
    , "1 3 2 4 5"
    , "8 6 4 4 1"
    , "1 3 6 7 9"
    ]

test1 :: Test
test1 =
  TestCase $
    assertEqual "reports are correctly classified as safe/unsafe" (solve1 sample) 2

test2 :: Test
test2 =
  TestCase $
    assertEqual "report classification respects the error dampener" (solve2 sample) 4
