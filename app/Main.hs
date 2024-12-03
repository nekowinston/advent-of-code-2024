module Main (main) where

import Data.Maybe (fromMaybe)
import Options.Applicative

import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3

data CliArgs = MkCliArgs
  { _day :: Int
  , _input :: Maybe FilePath
  }

cliParser :: Parser CliArgs
cliParser =
  MkCliArgs
    <$> argument
      auto
      ( help "Day of Advent of Code to solve"
          <> metavar "DAY"
      )
    <*> option
      auto
      ( long "input"
          <> help "Input data for the day's problem, defaults to `./data/day<N>.txt` where <N> is the value of `--day`"
          <> value Nothing
          <> metavar "FILENAME"
      )

main :: IO ()
main = execParser opts >>= solve
 where
  opts =
    info
      (cliParser <**> helper)
      (fullDesc <> header "advent-of-code-2024")

type Solver = String -> Int

solvers :: [(Solver, Solver)]
solvers =
  [ (AOC.Day1.solve1, AOC.Day1.solve2)
  , (AOC.Day2.solve1, AOC.Day2.solve2)
  , (AOC.Day3.solve1, AOC.Day3.solve2)
  ]

printSolutions :: Int -> Solver -> Solver -> String -> IO ()
printSolutions day s1 s2 input =
  putStr $
    unlines $
      ("Day " ++ show day ++ ":") : map unwords [["Part 1:", show solution1], ["Part 2:", show solution2]]
 where
  solution1 = s1 input
  solution2 = s2 input

solve :: CliArgs -> IO ()
solve (MkCliArgs day input) = do
  content <- readFile path
  printSolutions day s1 s2 content
 where
  path = fromMaybe ("./data/day" ++ show day ++ ".txt") input
  (s1, s2) = solvers !! (day - 1)
