module AOC.Day1 (printSolutions, solve1, solve2) where

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
parseInput content = do
  map (tuplify . map read . words) $ lines content

solve1 :: String -> Int
solve1 input = do
  sum listOfDiffs
 where
  parsed = parseInput input
  sortedListOfTuples = uncurry zip $ bimap sort sort $ unzip parsed
  listOfDiffs = map (abs . uncurry (-)) sortedListOfTuples

solve2 :: String -> Int
solve2 input = do
  sum listOfSimilarities
 where
  (left, right) = unzip $ parseInput input
  listOfSimilarities = map (\x -> x * count x right) left

printSolutions :: String -> IO ()
printSolutions input =
  putStr $
    unlines $
      map unwords [["Part 1:", show solution1], ["Part 2:", show solution2]]
 where
  solution1 = solve1 input
  solution2 = solve2 input
