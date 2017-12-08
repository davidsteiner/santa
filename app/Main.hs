module Main (main) where

import Data.Semigroup ((<>))
import Options.Applicative
import Santa

newtype Args = Args{ n :: Integer }

args :: Parser Args
args = Args
  <$> option auto
      ( long "number"
     <> short 'n'
     <> help "Target product in Santa's challenge"
     <> metavar "N")

main :: IO ()
main = santa =<< execParser opts
  where
    opts = info (args <**> helper)
      ( fullDesc
     <> progDesc "Calculate Santa's checksum for provided n input"
     <> header "Santa's Christmas challenge" )

santa :: Args -> IO ()
santa (Args n) = print $ findSolution n
