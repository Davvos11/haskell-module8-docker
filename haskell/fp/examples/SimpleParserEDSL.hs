module SimpleParserEDSL where
import Text.ParserCombinators.Parsec

-- For understanding this code, the theory presented in the parser combinators lecture is essential.

-- Implementation of the parser on slide 13 in ParSec


{-
S -> Q | R
Q -> 'a' 'b'
R -> 'b' Q Q
R -> 'c' Q 'c'
-}

-- Embedded Domain Specific Language (EDSL) - slide 12
data S = S1 Q | S2 R deriving Show
data Q = Q Char Char deriving Show
data R = R1 Char Q Q | R2 Char Q Char deriving Show

parseS :: Parser S
parseS = S1 <$> parseQ <|> S2 <$> parseR

parseQ :: Parser Q
parseQ = Q <$> char 'a' <*> char 'b'

parseR :: Parser R
parseR =     R1 <$> char 'b' <*> parseQ <*> parseQ
         <|> R2 <$> char 'c' <*> parseQ <*> char 'c'



-- Using the ParSec parser (slide 31):
test1 = parse parseS "" "ab"
test2 = parse parseS "" "abc" -- 'c' remains
test3 = parse parseS "" "babab"
test4 = parse parseS "" "cabc"
test5 = parse parseS "" "cabab" -- failure -> Left ...

