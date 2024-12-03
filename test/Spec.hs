import System.Exit
import Test.HUnit

import qualified Days.Day1
import qualified Days.Day2
import qualified Days.Day3

tests :: Test
tests =
  TestList
    [ TestLabel "day 1, part 1" Days.Day1.test1
    , TestLabel "day 1, part 2" Days.Day1.test2
    , TestLabel "day 2, part 1" Days.Day2.test1
    , TestLabel "day 2, part 2" Days.Day2.test2
    , TestLabel "day 3, part 1" Days.Day3.test1
    , TestLabel "day 3, part 2" Days.Day3.test2
    ]

main :: IO ()
main = do
  counts' <- runTestTT tests
  if errors counts' + failures counts' == 0
    then exitSuccess
    else exitFailure
