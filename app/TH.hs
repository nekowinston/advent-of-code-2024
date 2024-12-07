module TH where

import Language.Haskell.TH

genSolvers :: Int -> Q Exp
genSolvers dayCount = do
  return $
    ListE
      [TupE [Just $ VarE $ mkSolver day part | part <- [1, 2]] | day <- [1 .. dayCount]]
 where
  mkSolver :: Int -> Int -> Name
  mkSolver day part = mkName $ "AOC.Day" ++ show day ++ ".solve" ++ show part
