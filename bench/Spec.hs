{-# LANGUAGE TemplateHaskell #-}

import Criterion.Main
import Data.FileEmbed (embedFile)
import qualified Data.Text as Text
import Data.Text.Encoding (decodeUtf8Lenient)

import AOC.Common
import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3
import qualified AOC.Day4

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

  solvers :: [(Solver, Solver, [Text.Text])]
  solvers =
    map
      (\(s1, s2, p) -> (s1, s2, Text.lines $ decodeUtf8Lenient p))
      [ (AOC.Day1.solve1, AOC.Day1.solve2, $(embedFile "./data/day1.txt"))
      , (AOC.Day2.solve1, AOC.Day2.solve2, $(embedFile "./data/day2.txt"))
      , (AOC.Day3.solve1, AOC.Day3.solve2, $(embedFile "./data/day3.txt"))
      , (AOC.Day4.solve1, AOC.Day4.solve2, $(embedFile "./data/day4.txt"))
      ]
