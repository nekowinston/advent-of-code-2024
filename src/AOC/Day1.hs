{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module AOC.Day1 where

import Data.Bifunctor (bimap)
import Data.List (elemIndices, sort)

type Location = Int

parseInput :: String -> ([Location], [Location])
parseInput = unzip . map ((\(x : y : _) -> (read x, read y)) . words) . lines

getDistances :: ([Location], [Location]) -> [Int]
getDistances = uncurry (zipWith (\x y -> abs (x - y))) . bimap sort sort

getSimilarities :: ([Location], [Location]) -> [Int]
getSimilarities (xs, ys) = map (\el -> el * length (elemIndices el ys)) xs

solve1 :: String -> Int
solve1 = sum . getDistances . parseInput

solve2 :: String -> Int
solve2 = sum . getSimilarities . parseInput
