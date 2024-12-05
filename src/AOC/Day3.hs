{-# LANGUAGE QuasiQuotes #-}

module AOC.Day3 where

import AOC.Common
import Data.Either (fromRight)
import Data.Maybe (listToMaybe)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Read as Text
import Text.RawString.QQ (r)
import Text.Regex.TDFA (AllTextMatches (getAllTextMatches), (=~))

type Instruction = (Int, Int)
type RegexMatches = (Text, Text, Text, [Text])

mulRegex :: String
mulRegex = [r|mul\(([[:digit:]]+),([[:digit:]]+)\)|]

dumbRead :: Text -> Int
dumbRead = fst . fromRight (0, Text.empty) . Text.decimal

parseInstructions :: [Instruction] -> Text -> [Instruction]
parseInstructions acc input =
  case input =~ mulRegex :: RegexMatches of
    (_, _, rest, [x, y]) -> parseInstructions ((dumbRead x, dumbRead y) : acc) rest
    _ -> reverse acc

solve1 :: Solver
solve1 = sum . fmap (uncurry (*)) . parseInstructions [] . Text.unlines

checkForToggleInstruction :: Text -> Bool -> Bool
checkForToggleInstruction input state =
  case (listToMaybe instructions, state) of
    (Just "don't()", _) -> False
    (Just "do()", _) -> True
    (_, keep) -> keep
 where
  instructions = map Text.unpack $ reverse $ getAllTextMatches (input =~ [r|do(n't)?\(\)|]) :: [String]

parseInstructions' :: [Instruction] -> Bool -> Text -> [Instruction]
parseInstructions' acc state input =
  case input =~ mulRegex :: RegexMatches of
    (prefix, _, rest, [x, y]) -> parseInstructions' ((x', y') : acc) shouldAct rest
     where
      shouldAct = checkForToggleInstruction prefix state
      (x', y') = if shouldAct then (dumbRead x, dumbRead y) else (0, 0) -- replace it with a noop if disabled
    _ -> reverse acc

solve2 :: Solver
solve2 = sum . fmap (uncurry (*)) . parseInstructions' [] True . Text.unlines
