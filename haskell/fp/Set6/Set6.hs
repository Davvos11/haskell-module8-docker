module Set6 where

import Data.Foldable
import Data.Monoid
import Text.Read
--import Set5

------------------------------------------------------------------------------
-- Exercise 3-FP.8
------------------------------------------------------------------------------


data A a = A { fromA :: Maybe a }
         deriving Show

------------------------------------------------------------------------------
-- Exercise 3-FP.9
------------------------------------------------------------------------------


data BinTree a = Leaf a
               | Node (BinTree a) (BinTree a)

t :: BinTree Int
t = Node (Node
            (Leaf 3)
            (Node (Leaf 6)
                  (Leaf 9)))
         (Leaf 9)
    
t2 :: BinTree Int
t2 = Node (Leaf 3) (Leaf 5)

inftree :: BinTree Int
inftree = Node (Leaf 1) inftree

------------------------------------------------------------------------------
-- Exercise 3-FP.11
------------------------------------------------------------------------------


data MyList a = Nil | Cons a (MyList a)
              deriving (Show, Eq)

mylst  = Cons 1   $ Cons 2   $ Cons 3   $ Nil
mylst2 = Cons 10  $ Cons 20  $ Cons 30  $ Nil
mylst3 = Cons 100 $ Cons 200 $ Cons 300 $ Nil

--myzipWith3' :: (a -> b -> c -> d) -> MyList a -> MyList b -> MyList c -> MyList d


------------------------------------------------------------------------------
-- Exercise 3-FP.13
------------------------------------------------------------------------------

--fact = parserFun "function factorial x = if x == 0 then 1 else factorial(dec x) * x"
