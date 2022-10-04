{-# LANGUAGE OverloadedStrings #-}

module Main where


import Prelude hiding (words)
import Data.Text hiding (length, head)

data Exp = Num Int | Literal Text | Tree [Exp] deriving (Eq, Ord, Read, Show)

tokenize :: Text -> [Text]
tokenize line = words $ replace ")" " ) " (replace "(" " ( " line)

parse :: [Text] -> Exp
parse (x:xs)
  | length (x:xs) == 0 = error "no program"
  | x == "(" = parseLeft xs
  | otherwise = atomParse x

parseLeft :: [Text] -> Exp 
parseLeft (x:xs)
  | x == ")" = error "unexpected"
  | otherwise = Tree [Literal "left"] --Todo Parsing

atomParse :: Text -> Exp
atomParse atom
  | atom == ")" = error "unexpected"
  | otherwise = Literal atom --Todo atom type

main :: IO ()
main = print $ parse $ tokenize "(begin (define r 10) (* pi (* r r)))" 


