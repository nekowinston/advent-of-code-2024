module TH where

import qualified Data.FileEmbed
import Language.Haskell.TH

genSolvers :: Int -> Q Exp
genSolvers dayCount = do
  inputs <- mapM (\i -> Data.FileEmbed.embedFile ("./data/day" ++ show i ++ ".txt")) [1 .. dayCount]
  return $
    ListE
      [ TupE
        [ Just $ VarE $ mkSolver day 1
        , Just $ VarE $ mkSolver day 2
        , Just $ inputs !! (day - 1)
        ]
      | day <- [1 .. dayCount] :: [Int]
      ]
 where
  mkSolver :: Int -> Int -> Name
  mkSolver day part = mkName $ "AOC.Day" ++ show day ++ ".solve" ++ show part
