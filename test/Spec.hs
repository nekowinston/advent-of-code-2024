import Test.Hspec
import Test.Hspec.Core.Spec

import MakeTests

main :: IO ()
main = do
  dayTests <- makeDayTests
  hspec $ 
    describe "daily tests" $ fromSpecList dayTests
