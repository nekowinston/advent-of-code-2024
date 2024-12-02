module AOC.Day1 (solve1, solve2) where

import Data.Bifunctor (bimap)
import Data.List (sort)

-- | Turns a list containing two elements into a tuple.
tuplify :: [a] -> (a, a)
tuplify [a, b] = (a, b)
tuplify _ = undefined

-- | Returns how often element `x` appears inside a list.
count :: (Eq a) => a -> [a] -> Int
count x = length . filter (x ==)

parseInput :: String -> [(Int, Int)]
parseInput content = map (tuplify . map read . words) $ lines content

solve1 :: String -> Int
solve1 input = sum listOfDiffs
 where
  parsed = parseInput input
  sortedListOfTuples = uncurry zip $ bimap sort sort $ unzip parsed
  listOfDiffs = map (abs . uncurry (-)) sortedListOfTuples

solve2 :: String -> Int
solve2 input = sum listOfSimilarities
 where
  (left, right) = unzip $ parseInput input
  listOfSimilarities = map (\x -> x * count x right) left
