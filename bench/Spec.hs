{-# LANGUAGE TemplateHaskell #-}

import Criterion.Main
import qualified Data.Text as Text
import Data.Text.Encoding (decodeUtf8Lenient)

import TH

import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3
import qualified AOC.Day4
import qualified AOC.Day5

main :: IO ()
main = defaultMain $ mapInd mkDays solvers
 where
  mapInd :: (a -> Int -> b) -> [a] -> [b]
  mapInd f i = zipWith f i [1 ..]

  solvers = map (\(s1, s2, input) -> (s1, s2, Text.lines $ decodeUtf8Lenient input)) $(genSolvers 5)

  mkDays (s1, s2, input) i =
    bgroup ("day" ++ show i) $ mapInd mkParts [s1, s2]
   where
    mkParts solver p = bench ("part" ++ show p) $ nf solver input
