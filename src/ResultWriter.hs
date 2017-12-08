module ResultWriter (writeResults) where

import Data.List
import Santa
import System.IO
import Text.Printf

writeResults :: [AllocatedPresent] -> IO ()
writeResults presents =
  writeFile "./santa_results" fileContent
  where
    asString p = printf "%d %d %d" (sack p) (present p) (kid p)
    fileContent = intercalate "\n" (map asString presents)
