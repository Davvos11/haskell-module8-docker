module Set5 where

import Data.List
import Data.Functor
import Data.Either

import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Language
import qualified Text.ParserCombinators.Parsec.Token as Token

import Test.QuickCheck

fromLeft' :: Either l r -> l
fromLeft' (Left x) = x -- Newer GHC versions contain a fromLeft :: l -> Either l r -> l

fromRight' :: Either l r -> r
fromRight' (Right x) = x -- Newer GHC versions contain a fromRight :: r -> Either l r -> r

parser :: Parser a -> String -> a
parser p xs | isLeft res = error $ show $ fromLeft' res
          | otherwise  = fromRight' res
  where res = parse p "" xs


-- Uncomment for later exercises:
{-
-- Expression EDSL
data Expr = Const Integer
          | Var String
          | Mult Expr Expr
          | Add Expr Expr
          deriving Show
-}
{-
fib :: Integer -> Integer
fib = (evalfun . parserFun)
 "function fib x = if x == 0 then 1 else (if x == 1 then 1 else fib(dec x)+fib(dec dec x))"
-}
