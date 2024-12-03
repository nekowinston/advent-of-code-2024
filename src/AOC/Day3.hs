{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module AOC.Day3 where

import Text.RawString.QQ (r)
import Text.Regex.TDFA

result :: Integer
result = 161

type Instruction = (Int, Int)

mulRegex :: String
mulRegex = [r|mul\(([[:digit:]]+),([[:digit:]]+)\)|]

parseInstructions :: String -> [Instruction] -> [Instruction]
parseInstructions input acc =
  case input =~ mulRegex :: (String, String, String, [String]) of
    (_, _, rest, [x, y]) -> parseInstructions rest ((read x, read y) : acc)
    _ -> reverse acc

solve1 :: String -> Int
solve1 = sum . uncurry (zipWith (*)) . unzip . flip parseInstructions []

solve2 :: String -> Int
solve2 input = 0
