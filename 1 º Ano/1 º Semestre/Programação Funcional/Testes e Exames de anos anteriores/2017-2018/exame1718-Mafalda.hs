--1
--elemento :: [a] -> Int -> a
--elemento (x:xs) n | n==0 = x 
--                  | otherwise = elemento xs (n-1)
elemento :: Num a => [a] -> Int -> a 
elemento l n = acumulador1 l n 0
 where acumulador1 :: [a] -> Int -> Int -> a  
       acumulador1 (x:xs) n c | n==c = x  
                              | otherwise = acumulador1 xs n (c+1)

--2
data Movimento = Norte | Sul | Este | Oeste 
                   deriving (Show, Eq)

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
--posicao (a,b) [] = (a,b)
--posicao (a,b) (Norte:xs) = posicao (a, b+1) xs 
--posicao (a,b) (Sul:xs) = posicao (a, b-1) xs
--posicao (a,b) (Este:xs) = posicao (a+1, b) xs
--posicao (a,b) (Oeste:xs) = posicao (a-1, b) xs  
posicao (a,b) lm = acumulador (a,b) lm (0,0)
  where acumulador :: (Int,Int) -> [Movimento] -> (Int,Int) -> (Int,Int)
        acumulador (a,b) [] (c,d) = (a+c, b+d) 
        acumulador (a,b) (x:xs) (c,d) 
             | (x == Norte) = acumulador (a,b) xs (c, d+1)
             | (x == Sul) = acumulador (a,b) xs (c, d-1)
             | (x == Este) = acumulador (a,b) xs (c+1, d)
             | (x == Oeste) = acumulador (a,b) xs (c-1,d)

--3
any1 :: (a -> Bool) -> [a] -> Bool
any1 f [] = False
any1 f (x:xs) = f x || any1 f xs

--5
--movimenta :: IO (Int,Int)
--movimenta = x <- getLine 
--            return (posicao (0,0) (transf x))
--             where transf [] = []
--                   transf (a:b) 
--                     |a =='N' = (Norte: transf b)
--                     |a =='S' = (Sul: transf b)
--                     |a =='E' = (Este: transf b)
--                     |a =='O' = (Oeste: transf b)
--                     |otherwise = []  

--6
data Imagem = Quadrado Int
              | Mover (Int,Int) Imagem
              | Juntar [Imagem] 
                 deriving Show

ex :: Imagem
ex = Mover (5,5)
     (Juntar [Mover (0,1) (Quadrado 5),
               Quadrado 4,
               Mover (4,3) (Quadrado 2)])


vazia :: Imagem -> Bool
vazia (Quadrado n) = False
vazia (Mover (a,b) n) = vazia n 
vazia (Juntar []) = True
vazia (Juntar (x:xs)) = vazia x && vazia (Juntar xs) 

maior :: Imagem -> Int
maior (Quadrado n) =  n 
maior (Mover (a,b) y) = maior y
maior (Juntar l1) = acumulador2 l1 (Quadrado 0) 
 where acumulador2 :: [Imagem] -> Imagem -> Int
       acumulador2 [] (Quadrado c) = c 
       acumulador2 ((Quadrado x):xs) (Quadrado c) | x>=c = acumulador2 xs (Quadrado x)
                                                  | otherwise = acumulador2 xs (Quadrado c)
       acumulador2 ((Mover (a,b) x):ys) (Quadrado c) | (maior x) > c = acumulador2 ys (Quadrado (maior x))
                                                     | otherwise = acumulador2 ys (Quadrado c) 
       acumulador2 ((Juntar []):ws) (Quadrado c) = acumulador2 ws (Quadrado c)
       acumulador2 ((Juntar (x:xs)):t) (Quadrado c) 
         | (maior x) >= c = acumulador2 ((Juntar xs):t) (Quadrado (maior x))
         | otherwise = acumulador2 ((Juntar xs):t)  (Quadrado c)

--instance Eq Imagem where
-- (==) (Quadrado x) (Quadrado y) = (x == y)
-- (==) (Mover (a,b) n) (Mover (c,d) m) = (b-a)==(d-c) && n==m                                                
-- (==) (Juntar l1) (Juntar l2) = (==) l1 l2 
-- 
 
 
 
 
 
 
