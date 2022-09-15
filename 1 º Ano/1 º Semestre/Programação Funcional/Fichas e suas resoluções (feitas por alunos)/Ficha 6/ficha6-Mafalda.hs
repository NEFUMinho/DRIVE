--1
data BTree a = Empty
             | Node a (BTree a) (BTree a)
             deriving Show

t :: BTree Int
t = Node 7 (Node 3 Empty Empty)
           (Node 2 (Node 9 Empty Empty)
                   Empty
           )

altura :: BTree a -> Int
altura Empty = 0
altura (Node i e d) = 1 + max (altura e) (altura d)

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node _ e d) = 1 + contaNodos e + contaNodos d

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node _ e d) = folhas e + folhas d


prune :: Int -> BTree a -> BTree a
prune 0 _ = Empty
prune n Empty = Empty
prune n (Node i e d) = Node i (prune (n-1) e) 
                              (prune (n-1) d)

-- false - dir
-- true  - esq

-- path [False, True] t  
-- [7,2,9]

path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path [] (Node i _ _) = [i]
path (False:is) (Node i e d) = i : path is d
path (True:is) (Node i e d) = i : path is e

--mirror :: BTree a -> BTree a 
--mirror Empty = Empty 
--mirror (Node a e d) = Node ... ( mirror e ) (mirror d)

--unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)

--2
-- Arvore Binario de Procura

tp :: BTree Int
tp = Node 7 (Node  3 Empty (Node 5 Empty Empty))
            (Node 12 (Node 9 Empty Empty)
                     Empty
            )

minimo :: Ord a => BTree a -> a
minimo (Node i Empty _) = i
minimo (Node _ e _)     = minimo e

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node i Empty d) = d
semMinimo (Node i e d) = Node i (semMinimo e) d

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node r Empty d) = (r, d)
minSmin (Node r e d ) = (minimo e, (Node r (semMinimo e) d))

--remove ::  Ord a => a -> BTree a -> BTree a

--3
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String

data Regime = ORD 
            | TE 
            | MEL 
            deriving Show

data Classificacao = Aprov Int
                   | Rep
                   | Faltou
                   deriving Show

type Turma = BTree Aluno -- árvore binária de procura (ordenada por número)

tp1 :: Turma
tp1 = Node (7,"Ana",ORD,Aprov 16) 
           (Node  (3,"Ze",TE,Aprov 14) 
                    Empty 
                    (Node (5,"To",ORD,Rep) Empty Empty))
           (Node (12,"Rui",TE,Faltou)
                  (Node (9,"Te",ORD,Rep) Empty Empty)
                  Empty)
           

inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node (num,_,_,_) e d) 
          | n == num = True
          | n < num  = inscNum n e
          | n > num  = inscNum n d

inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (_,nome,_,_) e d ) 
          | n == nome = True
          | otherwise = inscNome n e || inscNome n d

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (num,nome,TE,_) e d) = 
                trabEst e ++ [(num, nome)] ++ trabEst d 
trabEst	(Node i e d) = trabEst e ++ trabEst d











