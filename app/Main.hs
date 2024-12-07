{-# LANGUAGE TemplateHaskell #-}

module Main (main) where

import Data.Bifunctor (bimap)
import Data.Text (Text)

import Cli
import qualified TH

import AOC.Common (Solver)
import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3
import qualified AOC.Day4
import qualified AOC.Day5

allSolvers :: [(Solver, Solver)]
allSolvers = $(TH.genSolvers 5)

main :: IO ()
main = parseCli >>= uncurry solve

solve :: Int -> [Text] -> IO ()
solve day input = putStr $ unlines $ ("Day " ++ show day ++ ":") : map unwords [["Part 1:", s1], ["Part 2:", s2]]
 where
  solver = allSolvers !! (day - 1)
  calc f = show $ f input
  (s1, s2) = bimap calc calc solver
