{-# LANGUAGE QuasiQuotes #-}

module AOC.Day3 where

import Data.Maybe (listToMaybe)
import Text.RawString.QQ (r)
import Text.Regex.TDFA

type Instruction = (Int, Int)

mulRegex :: String
mulRegex = [r|mul\(([[:digit:]]+),([[:digit:]]+)\)|]

parseInstructions1 :: [Instruction] -> String -> [Instruction]
parseInstructions1 acc input =
  case input =~ mulRegex :: (String, String, String, [String]) of
    (_, _, rest, [x, y]) -> parseInstructions1 ((read x, read y) : acc) rest
    _ -> reverse acc

solve1 :: String -> Int
solve1 = sum . uncurry (zipWith (*)) . unzip . parseInstructions1 []

checkForToggleInstruction :: String -> Bool -> Bool
checkForToggleInstruction input state =
  case (listToMaybe instructions, state) of
    (Just "don't()", _) -> False
    (Just "do()", _) -> True
    (_, keep) -> keep
 where
  instructions = reverse $ getAllTextMatches (input =~ [r|do(n't)?\(\)|]) :: [String]

parseInstructions2 :: [Instruction] -> Bool -> String -> [Instruction]
parseInstructions2 acc state input =
  case input =~ mulRegex :: (String, String, String, [String]) of
    (prefix, _, rest, [x, y]) ->
      parseInstructions2 ((xInt, yInt) : acc) shouldAct rest
     where
      shouldAct = checkForToggleInstruction prefix state
      (xInt, yInt) = if shouldAct then (read x, read y) else (0, 0) -- replace it with a noop if disabled
    _ -> reverse acc

solve2 :: String -> Int
solve2 = sum . uncurry (zipWith (*)) . unzip . parseInstructions2 [] True
