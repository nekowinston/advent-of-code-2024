module Cli (parseCli) where

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Options.Applicative

data CliArgs = MkCliArgs
  { day :: Int
  , input :: Maybe FilePath
  }

cliParser :: Parser CliArgs
cliParser =
  MkCliArgs
    <$> argument
      auto
      ( help "Day of Advent of Code to solve"
          <> metavar "DAY"
      )
    <*> option
      auto
      ( long "input"
          <> help "Input data for the day's problem, defaults to `./data/day<N>.txt` where <N> is the value of `--day`"
          <> value Nothing
          <> metavar "FILENAME"
      )

parseCli :: IO (Int, [Text])
parseCli = do
  args <-
    execParser $
      info (helper <*> cliParser) (fullDesc <> header "advent-of-code-2024")
  content <-
    Text.lines
      <$> Text.readFile (fromMaybe ("./data/day" ++ show (day args) ++ ".txt") (input args))
  return (day args, content)
