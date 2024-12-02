module Main (main) where

import qualified AOC.Day1

main :: IO ()
main = do
  content <- readFile "data/day1/input.txt"
  AOC.Day1.printSolutions content
