import Data.Char
--1
unlines1 :: [String] -> String
unlines1 [] = ""
unlines1 [x] = x 
unlines1 (x:xs) = x ++ "\n" ++ unlines1 xs

--retira :: (Eq a) => [a] -> [a] -> [a]
--retira l1 [] = l1
--retira [] l2 = []
--retira (x:xs) l2 = retira (exceto (x:xs) (head l2)) (tail l2)
--   where exceto :: (Eq a) => [a] -> a -> [a]
--         exceto [] _ = []
--         exceto (y:ys) n | y==n = ys 
--                         | otherwise = y : exceto ys n

retira :: (Eq a) => [a] -> [a] -> [a]
retira l1 [] = l1 
retira [] l2 = []
retira l1 l2 = acumulador l1 l2 []  
 where acumulador :: (Eq a) => [a] -> [a] -> [a] -> [a]
       acumulador [] l2 c = acumulador c (tail l2) [] 
       acumulador l1 [] c = c ++ l1
       acumulador (x:xs) (y:ys) c | x==y = acumulador (c ++ xs) ys [] 
                                  | otherwise = acumulador xs (y:ys) (c ++ [x]) 

--2
data Seq a = Nil | Inicio a (Seq a) | Fim (Seq a) a

primeiro :: Seq a -> a
primeiro (Inicio x s) = x 
primeiro (Fim s1 y) = primeiro s1 

semUltimo :: Seq a -> Seq a
semUltimo (Fim s1 y) = s1 
semUltimo (Inicio x s2) = (Inicio x (semUltimo s2))

--3
data BTree a = Empty | Node a (BTree a) (BTree a)
      deriving Show   
t :: BTree Int
t = Node 7 (Node 2 Empty Empty)
           (Node 3 (Node 1 Empty Empty)
                   (Node 10 Empty Empty))

prune :: Int -> BTree a -> BTree a
prune n Empty = Empty
prune n (Node i e d) | n==1 = (Node i Empty Empty)
                     | otherwise = (Node i (prune (n-1) e) (prune (n-1) d))

semMinimo :: (Ord a) => BTree a -> BTree a
semMinimo Empty = Empty
semMinimo (Node i Empty Empty) = Empty
semMinimo (Node i Empty d) = d 
semMinimo (Node 1 e d) = (Node (semMinimo e) d)


--4                                               

type Tabuleiro = [String]
exemplo :: Tabuleiro
exemplo = ["..R.",
           "R...",
           "...R",
           ".R.."]
ex1 :: Tabuleiro
ex1 = [ "..R."]

pos :: String -> Char -> Int
pos (x:xs) a | x==a = 0
             | otherwise = 1 + pos xs a 

posicoes :: Tabuleiro -> [(Int,Int)]
posicoes [] = []
posicoes [x] = [(pos x 'R' , 0)]
posicoes (x:xs) = acumulador1 (x:xs) (0,0)
 where  acumulador1 :: Tabuleiro -> (Int,Int) -> [(Int,Int)]
        acumulador1 [] (a,b) = []
        acumulador1 [x] (a,b) = [(pos x 'R' + a , b)]
        acumulador1 (x:xs) (a,b) = (pos x 'R' + a , b) : acumulador1 xs (a, b+1)


valido :: Tabuleiro -> Bool
valido [] = True 
valido t = linhas t && colunas t && diagonais t 
     where  linhas [] = True 
            linhas [x] = True
            linhas (x:y:xs) | (pos x 'R') == (pos y 'R') = False
                            | otherwise = valido (y:xs)
            colunas :: Tabuleiro -> Bool               
            colunas [] = True
            colunas [x] = True
            colunas lt | (snd a) == (snd h) = False
                       | otherwise = colunas (tail lt)
                          where (a:h:ts) = posicoes lt       
            diagonais :: Tabuleiro -> Bool
            diagonais [] = True 
            diagonais [x] = True
            diagonais dd | ((fst c) - (snd c)) == ((fst d) - (snd d)) = False
                         | ((fst c) + (snd c)) == ((fst d) + (snd d)) = False
                         | otherwise = diagonais (tail dd)
                              where (c:d:ds) = posicoes dd 

bemFormado :: Int -> Tabuleiro -> Bool
bemFormado n [] = False
bemFormado n t = foldr (&&) (n == length t) (w:y:x)
 where x = map (\x -> x == n) (map length t)
       y = length (filter (== 'R') (unlines1 t)) == n 
       w = length (filter (== '.') (unlines1 t)) == (n* (n-1))
              --  filter ( == n) (map length t) 