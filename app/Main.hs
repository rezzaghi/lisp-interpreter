{-# LANGUAGE OverloadedStrings #-}

module Main where


import Prelude hiding (words)
import Data.Text

tokenize :: Text -> [Text]
tokenize line = words $ replace ")" " ) " (replace "(" " ( " line)

main :: IO ()
main = print $ tokenize "(+ 1 1)"

