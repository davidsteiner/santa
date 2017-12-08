module Main (main) where

import ResultWriter
import Santa
import System.Environment
import System.TimeIt

main :: IO ()
main = do
    args <- getArgs
    let solution = findSolution (read $ head args)
    writeResults solution
    print $ calculateCheckSum solution
