module Days.Day1 where

import Test.HUnit

import AOC.Day1

sample :: String
sample = unlines ["3 4", "4 3", "2 5", "1 3", "3 9", "3 3"]

test1 :: Test
test1 =
  TestCase $
    assertEqual "distance is correct" (solve1 sample) 11

test2 :: Test
test2 =
  TestCase $
    assertEqual "similarity works" (solve2 sample) 31
