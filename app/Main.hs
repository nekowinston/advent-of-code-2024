module Main (main) where

import qualified AOC.Day1
import qualified AOC.Day2

printSolutions :: (Show a1, Show a2) => (p -> a1) -> (p -> a2) -> p -> IO ()
printSolutions s1 s2 input =
  putStr $
    unlines $
      map unwords [["Part 1:", show solution1], ["Part 2:", show solution2]]
 where
  solution1 = s1 input
  solution2 = s2 input

main :: IO ()
main = readFile "data/day1.txt"
  >>= printSolutions AOC.Day1.solve1 AOC.Day1.solve2
  >> readFile "data/day2.txt"
  >>= printSolutions AOC.Day2.solve1 AOC.Day2.solve2
