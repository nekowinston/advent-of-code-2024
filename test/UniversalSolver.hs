{-# LANGUAGE LambdaCase #-}

module UniversalSolver where

import Data.Text (Text)
import Language.Haskell.Interpreter

import AOC.Common (Solver)

universalSolver :: Int -> Int -> [Text] -> IO (Maybe Int)
universalSolver day part input = do
  mkSolver >>= \case
    Left err -> print err >> return Nothing
    Right solver -> return $ Just $ solver input
 where
  mkSolver :: IO (Either InterpreterError Solver)
  mkSolver = runInterpreter $ do
    loadModules ["src/AOC/Common.hs", "./src/AOC/Day" ++ show day ++ ".hs"]
    setImports ["Prelude", "Data.Text", "AOC.Day" ++ show day]
    interpret ("solve" ++ show part) (as :: Solver)
