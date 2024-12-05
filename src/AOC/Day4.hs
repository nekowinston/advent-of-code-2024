{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module AOC.Day4 where

import AOC.Common
import Data.Bool (bool)
import Data.Massiv.Array (Comp (..), Ix2 (..), Sz (..), U)
import qualified Data.Massiv.Array as Massiv
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Universe.Helpers (diagonals)

countWord :: Text.Text -> Text.Text -> Int
countWord word line
  | line == "" = 0 -- skip empty lines
  | Text.isPrefixOf "XMAS" line = 1 + countWord word (Text.drop n line)
  | otherwise = countWord word $ Text.drop 1 line -- skip chars not matches on prefix
 where
  n = Text.length word

solve1 :: Solver
solve1 =
  sum . findAllXmases
 where
  allAngles :: [Text] -> [Text]
  allAngles rows = concat [rows, cols, diag]
   where
    cols = Text.transpose rows
    diag = diag' rows <> (diag' . map Text.reverse $ rows)
    diag' = map Text.pack . diagonals . map Text.unpack

  findAllXmases :: [Text] -> [Int]
  findAllXmases lns = map (countWord "XMAS") $ allAngles lns ++ map Text.reverse (allAngles lns)

masStencil :: Massiv.Stencil Ix2 Char Int
masStencil = do
  Massiv.makeStencil (Sz (3 :. 3)) (1 :. 1) $ fmap (bool 0 1) solver
 where
  solver get = get (0 :. 0) == 'A' && any mkCase cases
   where
    cases =
      [ ('M', 'M', 'S', 'S')
      , ('S', 'M', 'S', 'M')
      , ('S', 'S', 'M', 'M')
      , ('M', 'S', 'M', 'S')
      ]
    -- Check the surrounding chars in the stencil grid:
    --
    --  c1 ...  c2
    --  ..  X  ...
    --  c3 ...  c4
    --
    -- where `X` is (0 :. 0) == 'A'
    -- returns True when all chars match.
    mkCase (c1, c2, c3, c4) =
      all
        (uncurry (==))
        [ (get (-1 :. -1), c1)
        , (get (-1 :. 1), c2)
        , (get (1 :. -1), c3)
        , (get (1 :. 1), c4)
        ]
{-# INLINE masStencil #-}

solve2 :: Solver
solve2 =
  Massiv.sum
    . Massiv.compute @U
    . Massiv.applyStencil Massiv.noPadding masStencil
    . Massiv.fromLists' @U (ParN 4)
    -- TODO: figure out how to not unpack here?
    . map Text.unpack
