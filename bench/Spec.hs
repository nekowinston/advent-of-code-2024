{-# LANGUAGE TemplateHaskell #-}

import Criterion.Main

import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3
import qualified AOC.Day4
import Data.FileEmbed (embedStringFile)

type Solver = String -> Int

-- variant of map that passes each element's index as a second argument to i
mapInd :: (a -> Int -> b) -> [a] -> [b]
mapInd f i = zipWith f i [0 ..]

main :: IO ()
main =
  defaultMain $ mapInd mkDays solvers
 where
  mkDays (s1, s2, input) i =
    bgroup ("day " ++ show (i + 1)) $ mapInd mkParts [s1, s2]
   where
    mkParts solver p =
      bench ("part " ++ show (p + 1)) $ nf solver input

  solvers :: [(Solver, Solver, String)]
  solvers =
    [ (AOC.Day1.solve1, AOC.Day1.solve2, $(embedStringFile "./data/day1.txt"))
    , (AOC.Day2.solve1, AOC.Day2.solve2, $(embedStringFile "./data/day2.txt"))
    , (AOC.Day3.solve1, AOC.Day3.solve2, $(embedStringFile "./data/day3.txt"))
    , (AOC.Day4.solve1, AOC.Day4.solve2, $(embedStringFile "./data/day4.txt"))
    ]
