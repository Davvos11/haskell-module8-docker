module PComb where
import Data.Char


{-
This is a small parser combinator library with the definitions from the lecture on parser combinators.
For understanding this code, the theory presented in the parser combinators lecture is essential.

Do not use this for your ParSec lab exercises!

Since <*> and <|> already exist within the Prelude, the implementation below defines <**> and <||> instead.
During the lecture on "Advanced Type Classes" you will learn how this can be fixed.
-}


-- A parser is a function from the input to a list of tuples with the parse result and the remaining string to be parsed.
-- This list provides all possible ways to parse the input, and [] means failure (slide 14).
data Parser r = P {
  runParser :: String -> [(r, String)]
}


-- Functor for the parser (slides 15+16)
instance Functor Parser where
  fmap f p = P (\x -> [(f r, s) | (r,s) <- runParser p x ])

{-
-- Another way to define the Functor:
instance Functor Parser where
  fmap f (P p) = P p'
    where p' x = [ (f r, s) | (r,s) <- p x ]
-}

-- Parser for a single character (slide 14)
char :: Char -> Parser Char
char c  = P p
 where p (x:xs) | c == x    = [(x, xs)]
                | otherwise = []

-- Sequential parser combinator (slides 23-25)
(<**>) :: Parser (a -> b) -> Parser a -> Parser b
p1 <**> p2 = P (\s -> [ (r1 r2, s2)
                       | (r1, s1) <- runParser p1 s,
                         (r2, s2) <- runParser p2 s1 ])

-- Another way to define <**>
(<***>) :: Parser (a -> b) -> Parser a -> Parser b
(P p1) <***> (P p2) = P p
  where p x = [ (r r2, s2) | (r,s) <- p1 x, (r2, s2) <- p2 s ]

-- Alternative parser combinator (slides 19+20)
(<||>) :: Parser a -> Parser a -> Parser a
(P p1) <||> (P p2) = P p
  where p x = p1 x ++ p2 x

-- Another way to define <||>
(<|||>) :: Parser a -> Parser a -> Parser a
p1 <|||> p2 = P (\x -> runParser p1 x ++ runParser p2 x)


-- Embedded Domain Specific Language (EDSL) for our grammar (slide 12+13)
-- Note: associativity of these operators is different from what you see with ParSec
data S = S1 Q | S2 R deriving Show
data Q = Q Char Char deriving Show
data R = R1 Char Q Q | R2 Char Q Char deriving Show

parseS :: Parser S
parseS = (S1 <$> parseQ) <||> (S2 <$> parseR)

parseQ :: Parser Q
parseQ = (Q <$> char 'a') <**> char 'b'

parseR :: Parser R
parseR =      (((R1 <$> char 'b') <**> parseQ) <**> parseQ)
         <||> (((R2 <$> char 'c') <**> parseQ) <**> char 'c')

-- Using the parser (slide 16):
test1 = runParser parseS "ab"
test2 = runParser parseS "abc" -- 'c' remains -> [(S1 (Q 'a' 'b'), "c")]
test3 = runParser parseS "babab"
test4 = runParser parseS "cabc"
test5 = runParser parseS "cabab" -- failure -> []
