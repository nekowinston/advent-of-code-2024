{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module AOC.Day4 where

import Data.Bool (bool)
import Data.Massiv.Array (Comp (..), Ix2 (..), Sz (..), U)
import qualified Data.Massiv.Array as Massiv
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

masStencil :: Massiv.Stencil Ix2 Char Int
masStencil = do
  Massiv.makeStencil (Sz (3 :. 3)) (1 :. 1) $ fmap (bool 0 1) solver
 where
  solver get = get (0 :. 0) == 'A' && or [case1, case2, case3, case4]
   where
    case1 = get (-1 :. -1) == 'M' && get (-1 :. 1) == 'M' && get (1 :. -1) == 'S' && get (1 :. 1) == 'S'
    case2 = get (-1 :. -1) == 'S' && get (-1 :. 1) == 'M' && get (1 :. -1) == 'S' && get (1 :. 1) == 'M'
    case3 = get (-1 :. -1) == 'S' && get (-1 :. 1) == 'S' && get (1 :. -1) == 'M' && get (1 :. 1) == 'M'
    case4 = get (-1 :. -1) == 'M' && get (-1 :. 1) == 'S' && get (1 :. -1) == 'M' && get (1 :. 1) == 'S'
{-# INLINE masStencil #-}

solve2 :: String -> Int
solve2 =
  Massiv.sum
    . Massiv.compute @U
    . Massiv.applyStencil Massiv.noPadding masStencil
    . Massiv.fromLists' @U Seq
    . lines
