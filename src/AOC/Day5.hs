{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PartialTypeSignatures #-}

module AOC.Day5 where

import qualified Data.Bifunctor as Bifunctor
import Data.Bool (bool)
import Data.List (elemIndex, find, sortBy)
import Data.Maybe (fromJust)
import qualified Data.Ord as Ord
import Data.Text (Text)
import qualified Data.Text as Text

import AOC.Common

type PageNr = Int
type Rule = (PageNr, PageNr)

type Update = [PageNr]

tuplify :: [b] -> (b, b)
tuplify [x, y] = (x, y)
tuplify _ = undefined

parser :: [Text] -> ([Rule], [Update])
parser content =
  ( map (Bifunctor.bimap unwrapDecimal unwrapDecimal . tuplify . Text.splitOn "|") rules
  , map (map unwrapDecimal . Text.splitOn ",") updates
  )
 where
  emptyLineIndex = fromJust $ elemIndex Text.empty content
  (rules, updates) = Bifunctor.second (drop 1) $ splitAt emptyLineIndex content

sortFn :: [Rule] -> Int -> Int -> Ordering
sortFn rules x y =
  case find (\(a, b) -> (a == x && b == y) || (a == y && b == x)) rules of
    (Just (f, s)) -> bool Ord.GT Ord.LT $ f == x && s == y
    _ -> bool Ord.EQ undefined $ x == y

data Annotation a = Valid a | Invalid a

ruleChecker :: [Rule] -> [Update] -> (Int, Int)
ruleChecker rules updates = (validSum, correctedSum)
 where
  classify el = bool (Invalid el) (Valid el) sorted
   where
    sorted = sortBy (sortFn rules) el == el

  annotatedUpdates = map classify updates

  getMiddle xs = xs !! div (length xs) 2
  foldFn = foldr (\el acc -> acc + getMiddle el) 0

  validSum = foldFn [el | Valid el <- annotatedUpdates]
  correctedSum = foldFn [sortBy (sortFn rules) el | Invalid el <- annotatedUpdates]

solve1 :: Solver
solve1 = fst . uncurry ruleChecker . parser

solve2 :: Solver
solve2 = snd . uncurry ruleChecker . parser
