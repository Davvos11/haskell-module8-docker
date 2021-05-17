module FPCore where

-- For understanding this code, the theory presented in the parser combinators lecture is essential.

data Op = OpAdd | OpMul | OpSub
        deriving Show

data Instr = InsPush Int
           | InsCalc Op
        deriving Show

g OpAdd = (+)
g OpMul = (*)
g OpSub = (-)

f stack (InsPush n)  = n : stack
f stack (InsCalc op) = v : drop 2 stack
  where v = g op (stack!!1) (stack!!0)

test0 prog = foldl f [] prog
test1 prog = scanl f [] prog


-- Example program for expression: (((5*10) - (3*(4+6))) * (2+1))

prog = [ InsPush 5
       , InsPush 10
       , InsCalc OpMul
       , InsPush 3
       , InsPush 4
       , InsPush 6
       , InsCalc OpAdd
       , InsCalc OpMul
       , InsCalc OpSub
       , InsPush 2
       , InsPush 1
       , InsCalc OpAdd
       , InsCalc OpMul
       ]

prog2 = [ InsPush 5, InsPush 3, InsPush 1, InsCalc OpAdd, InsCalc OpMul]
prog3 = codegen x

data Expr = Plus   Expr Expr
          | Min    Expr Expr
          | Times  Expr Expr
          | C  Int
          deriving Show

x = ((C 1) `Plus` (C 3)) `Times` (C 5)

calc :: Expr -> Int
calc (Plus    x y) = calc x + calc y
calc (Min     x y) = calc x - calc y
calc (Times   x y) = calc x * calc y
calc (C       x)   = x

codegen :: Expr -> [Instr]
codegen (C       x)   = [InsPush x]
codegen (Plus    x y) = codegen x ++ codegen y ++ [InsCalc OpAdd]
codegen (Min     x y) = codegen x ++ codegen y ++ [InsCalc OpSub]
codegen (Times   x y) = codegen x ++ codegen y ++ [InsCalc OpMul]
