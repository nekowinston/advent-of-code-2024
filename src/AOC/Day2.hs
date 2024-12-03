module AOC.Day2 where

type Level = Int
type Report = [Level]

parseInput :: String -> [Report]
parseInput = map (map read . words) . lines

data Order = Increasing | Decreasing

-- | Checks that a list of numbers is either all increasing or decreasing.
isMonotonic :: Report -> Bool
isMonotonic = (||) <$> isMonotonic' Increasing <*> isMonotonic' Decreasing

isMonotonic' :: Order -> Report -> Bool
isMonotonic' _ [] = True
isMonotonic' _ [_] = True
isMonotonic' order (x : y : xs) =
  case order of
    Decreasing -> x > y && isMonotonic' order (y : xs)
    Increasing -> x < y && isMonotonic' order (y : xs)

isValidDiff :: Report -> Bool
isValidDiff [] = True
isValidDiff [_] = True
isValidDiff (x : y : xs) = abs (x - y) `elem` [1 .. 3] && isValidDiff (y : xs)

isSafe :: Report -> Bool
isSafe = (&&) <$> isMonotonic <*> isValidDiff

solve1 :: String -> Int
solve1 = length . filter isSafe . parseInput

removeOne :: [a] -> [[a]]
removeOne xs = [removeAt i xs | i <- [0 .. length xs - 1]]
 where
  removeAt i ys = take i ys ++ drop (i + 1) ys

isSafeAfterDamping :: Report -> Bool
isSafeAfterDamping xs = any isSafe $ removeOne xs

solve2 :: String -> Int
solve2 = length . filter isSafeAfterDamping . parseInput
