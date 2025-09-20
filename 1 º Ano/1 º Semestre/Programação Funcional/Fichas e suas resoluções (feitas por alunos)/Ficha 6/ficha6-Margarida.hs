import GHC (HsDataDefn(dd_ND), HsRuleAnn (ra_rest))
import Data.Graph (path, edges)
import GHC.CmmToAsm.AArch64.Instr (d2, d1)
--ex1
data BTree a = Empty
              | Node a (BTree a) (BTree a)
        deriving Show

arvore = Node 5 (Node 2 (Node 1 Empty
                                 Empty)
                         (Node 3 Empty
                                 Empty))
                 (Node 9 (Node 7 (Node 6 Empty
                                         Empty)
                                 (Node 8 Empty
                                         Empty))
                         Empty) --serve para testar funções

altura1 :: BTree a -> Int
altura1 Empty = 0
altura1 (Node r e d) = if altura1 e > altura1 d
                       then altura1 e + 1
                       else altura1 d + 1


contaNodos1 :: BTree a -> Int
contaNodos1 Empty = 0
contaNodos1 (Node r e d) = 1 + contaNodos1 e + contaNodos1 d

folhas1 :: BTree a -> Int
folhas1 Empty = 0
folhas1 (Node r Empty Empty) = 1
folhas1 (Node r e d) = folhas1 e + folhas1 d

prune1 :: Int -> BTree a -> BTree a
prune1 n Empty = Empty
prune1 n (Node r e d)
    | n == 0 = Empty
    | otherwise = Node r (prune1 (n-1) e) (prune1 (n-1) d)

path1 :: [Bool] -> BTree a -> [a]
path1 _ Empty = []
path1 [] (Node r e d) = [r]
path1 (h:t) (Node r e d)
    | h = r : path1 t d
    | otherwise = r : path1 t e

mirror1 :: BTree a -> BTree a
mirror1 Empty = Empty
mirror1 (Node r e d) = Node r (mirror1 d) (mirror1 e)

zipWithBT1 :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT1 f (Node r1 e1 d1) (Node r2 e2 d2) = Node (f r1 r2) (zipWithBT1 f e1 e2) (zipWithBT1 f d1 d2)
zipWithBT1 _ _ _ = Empty

unzipBT1 :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT1 Empty = (Empty,Empty,Empty)
unzipBT1 (Node (r1,r2,r3) e d) = (Node r1 e1 d1, Node r2 e2 d2, Node r3 e3 d3)
    where (e1,e2,e3) = unzipBT1 e
          (d1,d2,d3) = unzipBT1 d

--ex2
minimo1 :: Ord a => BTree a -> a
minimo1 (Node r Empty d) = r
minimo1 (Node r e d) = minimo1 e

semMinimo1 :: Ord a => BTree a -> BTree a
semMinimo1 Empty = Empty
semMinimo1 (Node r Empty d) = d
semMinimo1 (Node r e d) = Node r (semMinimo1 e) d

minSmin1 :: Ord a => BTree a -> (a,BTree a)
minSmin1 (Node r Empty d) = (r,d)
minSmin1 (Node r e d) = (m1,Node r e1 d) where (m1,e1) = minSmin1 e --m1= minimo de e && e1 = e sem o mínimo

remove1 :: Ord a => a -> BTree a -> BTree a
remove1 x Empty = Empty
remove1 x (Node r e d)
    | x < r = remove1 x e
    | x > r = remove1 x d
    | otherwise = case d of Empty -> e
                            _ -> Node r2 e d2 where (r2,d2) = minSmin1 d

--ex3
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int

type Nome = String

data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                    | Rep
                    | Faltou
    deriving Show
type Turma = BTree Aluno

turma :: Turma
turma = Node (15,"Luís",ORD,Aprov 14) (Node (12,"Joana",MEL,Faltou)
                                            (Node (7,"Diogo",TE,Rep) 
                                                Empty 
                                                Empty) 
                                            (Node (14,"Lara",ORD,Aprov 19) 
                                                Empty 
                                                Empty)) 
                                      (Node (20,"Pedro",TE,Aprov 10) 
                                            Empty 
                                            (Node (25,"Sofia",ORD,Aprov 20) 
                                                  (Node (23,"Rita",ORD,Aprov 17) 
                                                        Empty 
                                                        Empty) 
                                                  (Node (28,"Vasco",MEL,Rep) 
                                                        Empty 
                                                        Empty)))


inscNum1 :: Numero -> Turma -> Bool
inscNum1 n Empty = False
inscNum1 n (Node (num,nome,reg,clas) e d)
    | n == num = True
    | n < num = inscNum1 n e
    | otherwise = inscNum1 n d

inscNome1 :: Nome -> Turma -> Bool
inscNome1 n Empty = False
inscNome1 n (Node (num,nome,reg,clas) e d) = n == nome || inscNome1 n e || inscNome1 n d


trabEst1 :: Turma -> [(Numero,Nome)]
trabEst1 Empty = []
trabEst1 (Node (num,nome,reg,clas) e d) = case reg of TE -> trabEst1 e ++ [(num,nome)] ++ trabEst1 d
                                                      _  -> trabEst1 e ++ trabEst1 d


nota1 :: Numero -> Turma -> Maybe Classificacao
nota1 n Empty = Nothing
nota1 n (Node (num,nome,reg,clas) e d)
    | n == num = Just clas
    | n < num = nota1 n e
    | otherwise = nota1 n d

percFaltas1 :: Turma -> Float
percFaltas1 Empty = 0
percFaltas1 t = faltas1 t / fromIntegral (contaNodos1 t) *100

faltas1 :: Turma -> Float
faltas1 Empty = 0
faltas1 (Node (num,nome,reg, Faltou ) e d) = 1 + faltas1 e + faltas1 d
faltas1 (Node (num,nome,reg, _ ) e d) = faltas1 e + faltas1 d

mediaAprov1 :: Turma -> Float
mediaAprov1 Empty = 0
mediaAprov1 t = notasAprov1 t / numAprov1 t 

notasAprov1 :: Turma -> Float
notasAprov1 Empty = 0
notasAprov1 (Node (num,nome,reg, Aprov x) e d) = fromIntegral x + notasAprov1 e + notasAprov1 d
notasAprov1 (Node (num,nome,reg, _ ) e d) = notasAprov1 e + notasAprov1 d

numAprov1 :: Turma -> Float
numAprov1 Empty = 0
numAprov1  (Node (num,nome,reg, Aprov x) e d) = 1 + numAprov1 e + numAprov1 d
numAprov1 (Node (num,nome,reg, _ ) e d) = numAprov1 e + numAprov1 d

aprovAv1 :: Turma -> Float
aprovAv1 Empty = 0
aprovAv1 turma = t1 / t2 where (t1,t2) = somaAprov1 turma

somaAprov1 :: Turma -> (Float,Float)
somaAprov1 Empty = (0,0)


somaAprov1 (Node (num,nome,reg, Aprov n ) e d) = (ae + ad + 1, re + rd + 1)
    where (ae,re) = somaAprov1 e
          (ad,rd) = somaAprov1 d
somaAprov1 (Node (num,nome,reg, Rep ) e d) = (ae + ad, re + rd + 1)
    where (ae,re) = somaAprov1 e
          (ad,rd) = somaAprov1 d
somaAprov1 (Node (num,nome,reg, Faltou ) e d) = (ae + ad, re + rd)
    where (ae,re) = somaAprov1 e
          (ad,rd) = somaAprov1 d






























































