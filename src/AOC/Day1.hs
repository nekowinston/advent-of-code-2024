{-# LANGUAGE LambdaCase #-}

module AOC.Day1 where

import AOC.Common
import Data.Bifunctor (bimap)
import Data.Either (fromRight)
import Data.List (elemIndices, sort)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Read as Text

type Location = Int

parseInput :: [Text] -> ([Location], [Location])
parseInput = unzip . map (fRead . Text.words)
 where
  readWithDefault = fst . fromRight (0, Text.empty) . Text.decimal
  fRead = \case
    (x : y : _) -> (readWithDefault x, readWithDefault y)
    _ -> (0, 0)

getDistances :: ([Location], [Location]) -> [Int]
getDistances = uncurry (zipWith (\x y -> abs (x - y))) . bimap sort sort

getSimilarities :: ([Location], [Location]) -> [Int]
getSimilarities (xs, ys) = map (\el -> el * length (elemIndices el ys)) xs

-- | Returns how often element `x` appears inside a list.
count :: (Eq a) => a -> [a] -> Int
count x = length . filter (x ==)

-- this seems to perform ~1ms faster than the other getSimilarities
getSimilarities' :: ([Location], [Location]) -> [Int]
getSimilarities' it = map (\x -> x * count x right) left
 where
  (left, right) = it

solve1 :: Solver
solve1 = sum . getDistances . parseInput

solve2 :: Solver
solve2 = sum . getSimilarities' . parseInput
