module Main where

import Arith.Evaluator
import Arith.Parser
import System.Environment
import Text.Parsec

main :: IO ()
main =
  do args <- getArgs
     case args of
       [sourceFile] ->
         do parseTree <- parse parseTerm "arith" <$> readFile sourceFile
            print parseTree
            case parseTree of
              Right expr -> putStrLn $ "=> " ++ (show . eval) expr
              Left err   -> print err
       _ -> putStrLn "Usage: arith <sourceFile>"
