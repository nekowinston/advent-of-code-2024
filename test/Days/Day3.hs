module Days.Day3 where

import Data.Text (Text)
import qualified Data.Text as Text
import Test.HUnit

import AOC.Day3

sample1 :: [Text]
sample1 = [Text.pack "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"]

test1 :: Test
test1 =
  TestCase $
    assertEqual "mul instructions work correctly" (solve1 sample1) 161

sample2 :: [Text]
sample2 = [Text.pack "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"]

test2 :: Test
test2 =
  TestCase $
    assertEqual "do() and don't() toggle state correctly" (solve2 sample2) 48
