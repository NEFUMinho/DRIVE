--1
data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show
--a
altura :: BTree a -> Int 
altura Empty = 0
altura (Node r e d) = max (1+altura e) (1+altura d)
--b
contaNodos :: BTree a -> Float 
contaNodos Empty = 0
contaNodos (Node a e d) = 1+contaNodos e +contaNodos d
--c
folhas :: BTree a -> Int
folhas (Node r Empty Empty) = 1
folhas (Node r e d) = (folhas e)+(folhas d)
--d
prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 _ = Empty
prune n (Node r e d) = Node r (prune (n-1) e) (prune (n-1) d)
--e
path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path (h:t) (Node r e d) = if h then r:(path t d) else r:(path t e)
--f
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node r e d) = Node r (mirror d) (mirror e)
--g
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty _ = Empty
zipWithBT f (Node r1 e1 d1) (Node r2 e2 d2) = Node (f r1 r2) (zipWithBT f e1 e2) (zipWithBT f d1 d2) 
--h
unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (a,b,c) e d) = (Node a ue1 ud1,Node b ue2 ud2,Node c ue3 ud3)
 where (ue1,ue2,ue3) = unzipBT e
       (ud1,ud2,ud3) = unzipBT d
--2
--a
minimo :: Ord a => BTree a -> a 
minimo (Node a Empty _) = a
minimo (Node r e d) = minimo e
--b
semMinimo :: Ord a => BTree a -> BTree a 
semMinimo (Node r Empty d) = d
semMinimo (Node r e d) = Node r (semMinimo e) d
--c
minSmin :: Ord a => BTree a -> (a,BTree a) 
minSmin (Node r Empty d) = (r,d)
minSmin (Node r e d) = (a,Node r b d)
 where (a,b) = minSmin e
--3
type Aluno = (Numero,Nome,Regime,Classificacao) 
type Numero = Int 
type Nome = String 
data Regime = ORD | TE | MEL deriving Show 
data Classificacao = Aprov Int | Rep | Faltou deriving Show 
type Turma = BTree Aluno -- árvore binária de procura (ordenada por número)
--a
inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node (num,_,_,_) e d) = if n==num then True else (inscNum n e)||(inscNum n d)
--b
inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (_,name,_,_) e d) = if n==name then True else (inscNome n e)||(inscNome n d)
--c
trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (num,name,TE,_) e d) = (trabEst e)++[(num,name)]++(trabEst d)
trabEst (Node (_,_,_,_) e d) = (trabEst e)++(trabEst d)
--d
nota :: Numero -> Turma -> Maybe Classificacao
nota n Empty = Nothing
nota n (Node (num,_,_,c) e d) = if n==num then Just c else if n<num then nota n e else nota n d
--e
percFaltas :: Turma -> Float
percFaltas Empty = 0
percFaltas t = ((faltas t)/(contaNodos t))*100
 where faltas Empty = 0
       faltas (Node (_,_,_,Faltou) e d) = 1+(faltas e)+(faltas d)
       faltas (Node r e d) = (faltas e)+(faltas d)
--f
mediaAprov :: Turma -> Float
mediaAprov t = (fromIntegral(sum(notas t)))/(fromIntegral(length (notas t)))
 where notas Empty = []
       notas (Node (_,_,_,c) e d) = (case c of Aprov v -> [v] ++ (notas e)++(notas d)
       	                                       otherwise -> []++(notas e)++(notas d) 
--g
aprovAv :: Turma -> Float
aprovAv t = a/b
 where (a,b) = aux t
       aux Empty = (0,0)
       aux (Node (_,_,_,c) e d) = plus (plus x (aux e)) (aux d)
        where x=(case c of Aprov v ->(1,1);Rep ->(0,1);otherwise -> (0,0))
              plus (a,b) (c,d) = (a+c,b+d)