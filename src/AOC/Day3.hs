{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module AOC.Day3 where

import Data.Maybe (listToMaybe)
import Text.RawString.QQ (r)
import Text.Regex.TDFA

type Instruction = (Int, Int)

mulRegex :: String
mulRegex = [r|mul\(([[:digit:]]+),([[:digit:]]+)\)|]

parseInstructions1 :: String -> [Instruction] -> [Instruction]
parseInstructions1 input acc =
  case input =~ mulRegex :: (String, String, String, [String]) of
    (_, _, rest, [x, y]) -> parseInstructions1 rest ((read x, read y) : acc)
    _ -> reverse acc

solve1 :: String -> Int
solve1 = sum . uncurry (zipWith (*)) . unzip . flip parseInstructions1 []

toggleRegex :: String
toggleRegex = [r|do(n't)?\(\)|]

data ParseState = ToggleOn | ToggleOff | Keep

checkForToggleInstruction :: String -> ParseState
checkForToggleInstruction input =
  case listToMaybe instructions of
    Just "don't()" -> ToggleOff
    Just "do()" -> ToggleOn
    _ -> Keep
 where
  instructions = reverse $ getAllTextMatches (input =~ toggleRegex) :: [String]

parseInstructions2 :: String -> [Instruction] -> Bool -> [Instruction]
parseInstructions2 input acc enabled = do
  case input =~ mulRegex :: (String, String, String, [String]) of
    (prefix, _, rest, [x, y]) -> do
      let
        shouldAct = case (checkForToggleInstruction prefix, enabled) of
          (ToggleOn, _) -> True
          (ToggleOff, _) -> False
          (_, keep) -> keep
        (xInt, yInt) = if shouldAct then (read x, read y) else (0, 0)
      parseInstructions2 rest ((xInt, yInt) : acc) shouldAct
    _ -> reverse acc

solve2 :: String -> Int
solve2 input = sum . uncurry (zipWith (*)) . unzip $ parseInstructions2 input [] True
