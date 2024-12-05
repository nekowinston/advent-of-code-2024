import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import System.Exit
import Test.HUnit

import AOC.Common
import qualified AOC.Day1
import qualified AOC.Day2
import qualified AOC.Day3
import qualified AOC.Day4

type Day = Int
type Part = Int
type Expected = Int
data TestInput = DayFixture | Inline String

type TestDef = (Day, Part, Solver, Expected, TestInput)

solverTests :: [TestDef]
solverTests =
  [ (1, 1, AOC.Day1.solve1, 11, DayFixture)
  , (1, 2, AOC.Day1.solve2, 31, DayFixture)
  , (2, 1, AOC.Day2.solve1, 2, DayFixture)
  , (2, 2, AOC.Day2.solve2, 4, DayFixture)
  , (3, 1, AOC.Day3.solve1, 161, Inline "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
  , (3, 2, AOC.Day3.solve2, 48, Inline "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
  , (4, 1, AOC.Day4.solve1, 18, DayFixture)
  , (4, 2, AOC.Day4.solve2, 9, DayFixture)
  ]

mkTest :: TestDef -> IO Test
mkTest (day, part, solver, expected, input) = do
  content <-
    Text.lines <$> case input of
      DayFixture -> Text.readFile $ "./test/fixtures/day" ++ show day ++ ".txt"
      Inline s -> pure $ Text.pack s
  pure $
    TestLabel ("day " ++ show day ++ ", part " ++ show part) $
      TestCase $
        assertEqual "" expected $
          solver content

main :: IO ()
main = do
  tests <- mapM mkTest solverTests
  counts' <- runTestTT $ TestList tests
  if errors counts' + failures counts' == 0
    then exitSuccess
    else exitFailure
