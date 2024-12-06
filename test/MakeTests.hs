module MakeTests where

import Data.Bitraversable (bimapM)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Test.Hspec
import Test.Hspec.Core.Spec

import Tests
import UniversalSolver

mapInd :: (a -> Int -> c) -> [a] -> [c]
mapInd f i = zipWith f i [1 ..]

mkTest :: ([InputOutput], [InputOutput]) -> Int -> IO [SpecTree ()]
mkTest inputsOutputs dayNr = do
  (defs1, defs2) <- bimapM (mapM mkDef) (mapM mkDef) inputsOutputs
  (results1, results2) <- bimapM (computeResults 1) (computeResults 2) (defs1, defs2)
  return $
    mapInd
      (\args part -> specGroup ("part " ++ show part) (uncurry (zipWith mkSpecItem) args))
      [(defs1, results1), (defs2, results2)]
 where
  computeResults partNr = mapM (\(input, _, _) -> universalSolver dayNr partNr input)

  mkSpecItem :: ([Text], Expected, String) -> Maybe Int -> SpecTree (Arg Expectation)
  mkSpecItem (_, expected, label) result = specItem label $ result `shouldBe` Just expected

  readFixture :: InputOutput -> IO Text
  readFixture io = case io of
    (Input _) -> Text.readFile $ "./data/day" ++ show dayNr ++ ".txt"
    (Fixture _) -> Text.readFile $ "./test/fixtures/day" ++ show dayNr ++ ".txt"
    (InlineFixture _ inline) -> pure $ Text.pack inline

  mkDef :: InputOutput -> IO ([Text], Expected, String)
  mkDef inputOutput = do
    content <- Text.lines <$> readFixture inputOutput
    return $ case inputOutput of
      (InlineFixture expected _) -> (content, expected, "inline fixture")
      (Input expected) -> (content, expected, "day input")
      (Fixture expected) -> (content, expected, "day fixture")

makeDayTests :: IO [SpecTree ()]
makeDayTests = do
  dayTests <- mapM (uncurry mkTest) $ mapInd (,) solverTests
  return $ mapInd (\el dayNr -> specGroup ("Day " ++ show dayNr) el) dayTests
