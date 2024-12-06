module MakeTests where

import Data.Functor ((<&>))
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Test.Hspec
import Test.Hspec.Core.Spec

import Tests

mkTest :: TestDef -> Int -> IO (SpecTree ())
mkTest (part, solver, inputsOutputs) dayNr =
  mapM mkDef inputsOutputs <&> specGroup ("part" ++ show part) . map mkSpecItem
 where
  mkSpecItem (input, expected, label) = specItem label $ solver input `shouldBe` expected

  readFixture io = case io of
    (Input _) -> Text.readFile $ "./data/day" ++ show dayNr ++ ".txt"
    (Fixture _) -> Text.readFile $ "./test/fixtures/day" ++ show dayNr ++ ".txt"
    (InlineFixture _ inline) -> pure $ Text.pack inline

  mkDef inputOutput = do
    content <- Text.lines <$> readFixture inputOutput
    return $ case inputOutput of
      (InlineFixture expected _) -> (content, expected, "inline fixture")
      (Input expected) -> (content, expected, "day input")
      (Fixture expected) -> (content, expected, "day fixture")

makeDayTests :: IO [SpecTree ()]
makeDayTests = sequence (mapInd mkTree solverTests)
 where
  mapInd f i = zipWith f i [1 ..]
  mkTree allDefs dayNr = mapM (\defs -> do mkTest defs dayNr) allDefs <&> specGroup ("Day " ++ show dayNr)
