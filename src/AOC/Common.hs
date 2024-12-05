module AOC.Common (Solver, unwrapDecimal) where

import Data.Either (fromRight)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Read as Text

type Solver = [Text] -> Int

-- | read a decimal from `Text`, crashing on error.
unwrapDecimal :: Text -> Int
unwrapDecimal = fst . fromRight (undefined, Text.empty) . Text.decimal
