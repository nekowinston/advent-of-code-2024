{-# LANGUAGE QuasiQuotes #-}

module AOC.Day3 where

import Data.Maybe (listToMaybe)
import Text.RawString.QQ (r)
import Text.Regex.TDFA (AllTextMatches (getAllTextMatches), (=~))

type Instruction = (Int, Int)
type RegexMatches = (String, String, String, [String])

mulRegex :: String
mulRegex = [r|mul\(([[:digit:]]+),([[:digit:]]+)\)|]

parseInstructions :: [Instruction] -> String -> [Instruction]
parseInstructions acc input =
  case input =~ mulRegex :: RegexMatches of
    (_, _, rest, [x, y]) -> parseInstructions ((read x, read y) : acc) rest
    _ -> reverse acc

solve1 :: String -> Int
solve1 = sum . fmap (uncurry (*)) . parseInstructions []

checkForToggleInstruction :: String -> Bool -> Bool
checkForToggleInstruction input state =
  case (listToMaybe instructions, state) of
    (Just "don't()", _) -> False
    (Just "do()", _) -> True
    (_, keep) -> keep
 where
  instructions = reverse $ getAllTextMatches (input =~ [r|do(n't)?\(\)|]) :: [String]

parseInstructions' :: [Instruction] -> Bool -> String -> [Instruction]
parseInstructions' acc state input =
  case input =~ mulRegex :: RegexMatches of
    (prefix, _, rest, [x, y]) -> parseInstructions' ((x', y') : acc) shouldAct rest
     where
      shouldAct = checkForToggleInstruction prefix state
      (x', y') = if shouldAct then (read x, read y) else (0, 0) -- replace it with a noop if disabled
    _ -> reverse acc

solve2 :: String -> Int
solve2 = sum . fmap (uncurry (*)) . parseInstructions' [] True
