module Days.Day3 where

import Test.HUnit

import AOC.Day3

sample :: String
sample = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

test1 :: Test
test1 =
  TestCase $
    assertEqual "mul instructions work correctly" (solve1 sample) 161

test2 :: Test
test2 =
  TestCase $
    assertEqual "TODO" (solve2 sample) 0
