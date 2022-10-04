{-# LANGUAGE OverloadedStrings #-}

module Main where


import Prelude hiding (words)
import Data.Text hiding (length, head, tail,concat)

data Exp = Num Int | Literal Text | Identifier Text | Expr [Exp] deriving (Eq, Ord, Read, Show)

tokenize :: Text -> [Text]
tokenize line = words $ replace ")" " ) " (replace "(" " ( " line)

parse :: [Text] -> [Exp]
parse (x:xs)
  | length (x:xs) == 0 = error "no program"
  | x == "(" = [Expr (atomParse xs)]
  | otherwise = []

atomParse :: [Text] -> [Exp]
atomParse (x:xs) 
  | x == ")" = parse xs
  | x == "(" = parse (x:xs)
  | otherwise = Literal x : atomParse xs

main :: IO ()
main = print $ parse $ tokenize "(begin (define r 10) (* pi (* r r)))" 


