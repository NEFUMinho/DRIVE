{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use concatMap" #-}
{-# HLINT ignore "Use max" #-}
import GHC.CmmToAsm.AArch64.Instr (x0, d0)
import System.Random (Random(random))
--ex1
data ExpInt = Const Int
    | Simetrico ExpInt
    | Mais ExpInt ExpInt
    | Menos ExpInt ExpInt
    | Mult ExpInt ExpInt

calcula1 :: ExpInt -> Int
calcula1 (Const x) = x
calcula1 (Simetrico x) = - calcula1 x
calcula1 (Mais x y) = calcula1 x + calcula1 y
calcula1 (Menos x y) = calcula1 x - calcula1 y
calcula1 (Mult x y) = calcula1 x * calcula1 y

infixa1 :: ExpInt -> String
infixa1 (Const x) = show x
infixa1 (Simetrico x) = "-" ++ infixa1 x
infixa1 (Mais x y) = "(" ++ infixa1 x ++ " + " ++ infixa1 y ++ ")"
infixa1 (Menos x y) = "(" ++ infixa1 x ++ " - " ++  infixa1 y ++ ")"
infixa1 (Mult x y) = "(" ++ infixa1 x ++ " * " ++ infixa1 y ++ ")"


posfixa1 :: ExpInt -> String
posfixa1 (Const x) = show x
posfixa1 (Simetrico x) = posfixa1 x ++ " " ++ "(-)"
posfixa1 (Mais x y) = posfixa1 x ++ " " ++ posfixa1 y ++ " " ++ "+ "
posfixa1 (Menos x y) = posfixa1 x ++ " " ++ posfixa1 y ++ " " ++ "- "
posfixa1 (Mult x y) = posfixa1 x ++ " " ++ posfixa1 y ++ " " ++ "* "


--ex2

data RTree a = R a [RTree a] --escrever "deriving Show" quando quiser testar as funções no terminal

arvoreRT = R 6 [R 4 [R 7 [R 1 [],
                        R 3 []],
                   R 9 []],
              R 3 [R 12 []],
              R 6 [],
              R 11 []]

somaRT :: Num a => RTree a -> a
somaRT (R r []) = r
somaRT (R r rs) = r + sum (map somaRT rs) -- função sum soma os elementos de uma lista e a função map aplica a função somarRT à lista de RTree

alturaRT :: RTree a -> Int
alturaRT (R r []) = 1
alturaRT (R r rs) = 1 + maximum (map alturaRT rs) --a função maximum devolve o maior elemento de uma lista

pruneRT :: Int -> RTree a -> RTree a
pruneRT 0 (R r _) = R r []
pruneRT n (R r []) = R r []
pruneRT n (R r rs) = R r (map (pruneRT (n-1)) rs)

mirrorRT :: RTree a -> RTree a
mirrorRT (R r []) = R r []
mirrorRT (R r rs) = R r (map mirrorRT (reverse rs))

postorderRT :: RTree a -> [a]
postorderRT (R r []) = [r]
postorderRT (R r rs) = concat (map postorderRT rs ) ++ [r]

--ex3

data BTree a = Empty | Node a (BTree a) (BTree a)
data LTree a = Tip a | Fork (LTree a) (LTree a)

arvoreLT = Fork (Fork (Tip 5)                                                                
                    (Fork (Tip 6)                                                         
                          (Tip 4)))                                                
              (Fork (Fork (Tip 3)
                          (Tip 7))
                    (Tip 5))

ltSum1 :: Num a => LTree a -> a
ltSum1 (Tip a) = a
ltSum1 (Fork e d) = ltSum1 e + ltSum1 d

listaLT1 :: LTree a -> [a]
listaLT1 (Tip a) = [a]
listaLT1 (Fork e d) = listaLT1 e ++ listaLT1 d

ltHeight1 :: LTree a -> Int
ltHeight1 (Tip a) = 1
ltHeight1 (Fork e d) = 1 + maximum [ltHeight1 e, ltHeight1 d] 
--ltHeight1 (Fork x y) = 1 + max (ltHeight x) (ltHeight y) é equivalente

--ex4
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

arvoreFT = No 8 (No 1 (Leaf 5)
                    (No 2 (Leaf 6)
                          (Leaf 4)))
              (No 9 (No 10 (Leaf 3)
                           (Leaf 7))
                    (Leaf 5))


splitFTree1 :: FTree a b -> (BTree a, LTree b)
splitFTree1 (Leaf x) = (Empty, Tip x)
splitFTree1 (No r e d) = (Node r e1 d1, Fork e2 d2)
    where (e1, e2) = splitFTree1 e
          (d1, d2) = splitFTree1 d


joinTrees1 :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees1 (Empty) (Tip x) = Just (Leaf x)
joinTrees1 (Node r e d) (Fork x y) = case (joinTrees1 e x, joinTrees1 d y) of (Just n, Just m) -> Just (No r n m)
                                                                              _ -> Nothing
joinTrees1 _ _ = Nothing
 


















