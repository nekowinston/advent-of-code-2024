module Main (main) where 

import Test.HUnit
import System.Exit

import qualified Days.Day1

tests :: Test
tests = TestList [
  TestLabel "day 1, part 1" Days.Day1.test1,
  TestLabel "day 1, part 2" Days.Day1.test2
  ]

main :: IO ()
main = do
  counts' <- runTestTT tests
  if (errors counts' + failures counts' == 0)
    then exitSuccess
    else exitFailure
