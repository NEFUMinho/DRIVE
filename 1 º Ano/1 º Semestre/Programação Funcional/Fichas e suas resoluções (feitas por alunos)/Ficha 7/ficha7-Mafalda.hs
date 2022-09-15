--1
data ExpInt = Const Int
             | Simetrico ExpInt
             | Mais ExpInt ExpInt
             | Menos ExpInt ExpInt
             | Mult ExpInt ExpInt
--3+4*5
e :: ExpInt
e = Mais (Const 3)
         (Mult (Const 4) (Const 5)

calcula :: ExpInt -> Int
calcula (Const v) = v
calcula (Simetrico e) = (-1)*(calcula e)
calcula (Mais e1 e2) = calcula e1 + calcula e2
calcula (Menos e1 e2) = calcula e1 - calcula e2
calcula (Mult e1 e2) = calcula e1 * calcula e2

infixa :: ExpInt -> String
infixa (Const v) = show v
infixa (Simetrico e) = "(-" ++ (infixa e) ++ ")"
infixa (Mais e1 e2) = "(" ++ (infixa e1) ++ "+" ++ (infixa e2) ++ ")"
infixa (Menos e1 e2) = "(" ++ (infixa e1) ++ "-" ++ (infixa e2) ++ ")"
infixa (Mult e1 e2) = "(" ++ (infixa e1) ++ "*" ++ (infixa e2) ++ ")"

posfixa :: ExpInt -> String
posfixa (Const v) = show v
posfixa (Simetrico e) = (posfixa e) ++ "-"
posfixa (Mais e1 e2) = (posfixa e1) ++ (posfixa e2) ++ "+"
posfixa (Menos e1 e2) = (posfixa e1) ++  (posfixa e2) ++ "-"
posfixa (Mult e1 e2) = (posfixa e1) ++ (posfixa e2) ++ "*"

--2
data RTree a = R a [RTree a]
   deriving Show

r :: Num a => RTree a
r = R 5 [  R 4 [ R 3 [], R 2 []],
          R 6 [] ]

soma :: Num a => RTree a -> a
soma (R a []) = a
soma (R a l) = a + sum (map soma l)

altura :: RTree a -> Int 
altura (R a []) = 1
altura (R a l) = 1 + maximum (map altura l)

prune :: Int -> RTree a -> RTree a
prune 1 (R a _) = R a []
prune n (R a l) = R a (map (prune (n-1)) l)

mirror :: RTree a -> RTree a
mirror (R a []) = R a []
mirror (R a (x:xs)) = R a ((map mirror xs) ++ (map mirror [x]))

postorder :: RTree a -> [a]
postorder (R a []) = [a]
postorder (R a l) = concat (map postorder l) ++ [a]

--3
data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show
data LTree a = Tip a | Fork (LTree a) (LTree a) deriving Show

ltSum :: Num a => LTree a -> a
ltSum Tip i = 1
ltSum (Fork e d) = sum (ltSum e) (ltSum d) 

listaLT :: LTree a -> [a]
listaLT Fork i = [i]
listaLT (Fork e d) = [listaLT e] ++ [listaLT d]

ltHeight :: LTree a -> Int
ltHeight Tip i = 1
ltHeight (Fork e d) = max (1 + (ltHeight e)) (1+(ltHeight d))

--4
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree Leaf i = (Empty, Tip i)
splitFTree (No i e d) = ( Node i be bd, Fork le ld) 
 where (be,bd) = splitFTree e 
       (bd,ld) = splitFTree d

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees Empty (Tip a) = Just (Leaf a)
joinTrees (Node r e1 d1) (No  e2 d2) = Just ( No r je jd)
 where je = joinTrees e1 e2
       jd = joinTrees d1 d2
joinTrees _ _ = Nothing 
