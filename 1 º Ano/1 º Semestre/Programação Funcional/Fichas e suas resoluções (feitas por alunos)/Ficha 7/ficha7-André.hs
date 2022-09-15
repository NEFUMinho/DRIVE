--1
data ExpInt = Const Int | Simetrico ExpInt | Mais ExpInt ExpInt | Menos ExpInt ExpInt | Mult ExpInt ExpInt
--a
calcula :: ExpInt -> Int 
calcula x = case x of Const v -> v
                      Simetrico v -> -(calcula v)
                      Mais e d -> (calcula e)+(calcula d)
                      Menos e d -> (calcula e)-(calcula d)
                      Mult e d -> (calcula e)*(calcula d)
--b
infixa :: ExpInt -> String 
infixa x = case x of Const v -> show v
                     Simetrico v -> "-("++infixa v++")" 
                     Mais e d -> "("++infixa e++" + "++infixa d++")"
                     Menos e d -> "("++infixa e++" - "++infixa d++")"
                     Mult e d -> "("++infixa e++" * "++infixa d++")"
--c
posfixa :: ExpInt -> String 
posfixa x = case x of Const v -> show v
                      Simetrico v -> '-':posfixa v
                      Mais e d -> posfixa e++posfixa d++" +"
                      Menos e d -> posfixa e++posfixa d++" -"
                      Mult e d -> posfixa e++posfixa d++" *"
--2
data RTree a = R a [RTree a] deriving Show
r= R 6 [R 4 [R 7 [R 1 [],R 3 []],R 9 []],R 3 [R 12 []],R 6 [],R 11 []]
--a
soma :: Num a => RTree a -> a 
soma (R a []) = a
soma (R a l) =a+ sum(map (soma) l) 
--b
altura :: RTree a -> Int 
altura (R a []) = 1
altura (R a l) = 1 + maximum(map altura l)
--c
prune :: Int -> RTree a -> RTree a
prune 1 (R a _) = R a []
prune n (R a []) = R a [] 
prune n (R a l) = R a (map (prune (n-1)) l)
--d
mirror :: RTree a -> RTree a
mirror (R a []) = R a []
mirror (R a l) = R a (reverse(map mirror l))
--e
--postorder :: RTree a -> [a]
--3
data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show
data LTree a = Tip a | Fork (LTree a) (LTree a) deriving Show
--a
ltSum :: Num a => LTree a -> a 
ltSum (Tip a) = a
ltSum (Fork e d) = ltSum e + ltSum d
--b
listaLT :: LTree a -> [a]
listaLT (Tip a) = [a]
listaLT (Fork e d) = (listaLT e)++(listaLT d)
--c
ltHeight :: LTree a -> Int 
ltHeight (Tip a) = 1
ltHeight (Fork e d) = max (1+(ltHeight e)) (1+(ltHeight d))
--4
data FTree a b = Leaf b | No a (FTree a b) (FTree a b) deriving Show
--a
splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf b) = (Empty,Tip b)
splitFTree (No a e d) = (Node a be bd,Fork le ld)
 where (be,le) = splitFTree e
       (bd,ld) = splitFTree d
--b
joinTrees :: BTree a -> LTree b -> Maybe (FTree a b) 
joinTrees Empty (Tip a) = Just (Leaf a)
joinTrees (Node r e1 d1) (Fork e2 d2) = Just ( No r je jd)
 where Just je = joinTrees e1 e2
       Just jd = joinTrees d1 d2
joinTrees _ _ = Nothing