{-# LANGUAGE OverloadedStrings #-}

module AOC.Day4 where

import Data.String (fromString)
import qualified Data.Text as Text
import Data.Universe.Helpers (diagonals)

countWord :: Text.Text -> Text.Text -> Int
countWord word line
  | line == "" = 0 -- skip empty lines
  | Text.isPrefixOf "XMAS" line = 1 + countWord word (Text.drop n line)
  | otherwise = countWord word $ Text.drop 1 line -- skip chars not matches on prefix
 where
  n = Text.length word

solve1 :: String -> Int
solve1 =
  sum . findAllXmases . Text.lines . fromString
 where
  allAngles :: [Text.Text] -> [Text.Text]
  allAngles rows = concat [rows, cols, diag]
   where
    cols = Text.transpose rows
    diag = diag' rows <> (diag' . map Text.reverse $ rows)
    diag' = map Text.pack . diagonals . map Text.unpack

  findAllXmases :: [Text.Text] -> [Int]
  findAllXmases lns = map (countWord "XMAS") $ allAngles lns ++ map Text.reverse (allAngles lns)

solve2 :: String -> Int
solve2 input = -1
