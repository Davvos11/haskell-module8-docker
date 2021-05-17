module ParSecExamples where
-- The various small examples that were used in the slides

-- For understanding this code, the theory presented in the parser combinators lecture is essential.

import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Language
import qualified Text.Parsec.Token as Token

languageDef =
   emptyDef { Token.commentStart    = "/*"
            , Token.commentEnd      = "*/"
            , Token.commentLine     = "//"
            , Token.identStart      = letter
            , Token.identLetter     = alphaNum
            , Token.reservedNames   = [ "for"
                                      , "while"
                                      , "if"
                                      ]
            , Token.reservedOpNames = [ "-", "+", "*"
                                      ]
            }

-- Create lexer (=tokenizer) for your language
lexer = Token.makeTokenParser languageDef

-- Create functions for all types of tokens
identifier :: Parser String
identifier = Token.identifier lexer

integer :: Parser Integer
integer = Token.integer lexer

parens :: Parser a -> Parser a
parens = Token.parens lexer

symbol :: String -> Parser String
symbol = Token.symbol lexer

reserved :: String -> Parser ()
reserved = Token.reserved lexer

assignment :: Parser (String, String, String)
assignment = (,,) <$> identifier <*> symbol "=" <*> identifier

assignment' :: Parser (String, String)
assignment' = (,) <$> identifier <*> (symbol "=" *> identifier)

assignment'' :: Parser (String, String)
assignment'' = (,) <$> (identifier <* symbol "=") <*> identifier

while :: Parser Integer
while = reserved "while" *> (parens integer)

mult :: Parser (Integer -> Integer -> Integer)
mult = (\_ -> (*)) <$> symbol "*"

rightassoc :: Parser Integer
rightassoc = integer `chainr1` mult


data Tree = Leaf Integer | Node Tree Tree deriving Show
            

mult' :: Parser (Tree -> Tree -> Tree)
mult' = (\_ -> Node) <$> symbol "*"

rightassoc' :: Parser Tree
rightassoc' = (Leaf <$> integer) `chainr1` mult'

f :: Parser String
f = identifier

f' :: Parser String
f' = identifier <?> "function name"
