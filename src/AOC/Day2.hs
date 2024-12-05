module AOC.Day2 where

import AOC.Common
import Data.Either (rights)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Read as Text

type Level = Int
type Report = [Level]

parseInput :: [Text] -> [Report]
parseInput = map (map fst . rights . map Text.decimal . Text.words)

data Order = Increasing | Decreasing

-- | Checks that a list of numbers is either all increasing or decreasing.
isMonotonic :: Report -> Bool
isMonotonic = (||) <$> isMonotonic' Increasing <*> isMonotonic' Decreasing

isMonotonic' :: Order -> Report -> Bool
isMonotonic' order (x : y : xs) =
  case order of
    Decreasing -> x > y && isMonotonic' order (y : xs)
    Increasing -> x < y && isMonotonic' order (y : xs)
isMonotonic' _ _ = True

isValidDiff :: Report -> Bool
isValidDiff (x : y : xs) = abs (x - y) `elem` [1 .. 3] && isValidDiff (y : xs)
isValidDiff _ = True

isSafe :: Report -> Bool
isSafe = (&&) <$> isMonotonic <*> isValidDiff

solve1 :: Solver
solve1 = length . filter isSafe . parseInput

removeOne :: [a] -> [[a]]
removeOne xs = [removeAt i xs | i <- [0 .. length xs - 1]]
 where
  removeAt i ys = take i ys ++ drop (i + 1) ys

isSafeAfterDamping :: Report -> Bool
isSafeAfterDamping xs = any isSafe $ removeOne xs

solve2 :: Solver
solve2 = length . filter isSafeAfterDamping . parseInput
