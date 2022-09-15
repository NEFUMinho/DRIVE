--1

inits :: [a] -> [[a]]
inits l1 = acumulador l1 []
 where acumulador :: [a] -> [a] -> [[a]]
       acumulador [] c = [c]
      -- acumulador [x] c = acumulador [] (c ++ [x])
       acumulador (x:xs) c = [c] ++ acumulador xs (c ++ [x])  


isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] l2 = True 
isPrefixOf l1 [] = False
isPrefixOf (x:xs) (y:ys) | x==y && isPrefixOf xs ys = True
                         | otherwise = False
                         
--2
data BTree a = Empty | Node a (BTree a) (BTree a) 
                deriving Show 
t :: BTree Int
t = Node 7 (Node 2 Empty Empty)
           (Node 3 (Node 1 Empty Empty)
                   (Node 10 Empty Empty))

folhas :: BTree a -> Int 
folhas Empty = 0 
folhas (Node a Empty Empty) = 1
folhas (Node a e d) = folhas e + folhas d 

path :: [Bool] -> BTree a -> [a]
path [] (Node a _ _) = [a]
path l Empty = []
path l (Node a Empty Empty) = [a]
path (False:xs) (Node a e d) = a : path xs e 
path (True:xs) (Node a e d) = a : path xs d 

--3
type Polinomio = [Coeficiente]
type Coeficiente = Float 

posiçao :: Float -> Polinomio -> Int
posiçao n (x:xs) | n==x = 0
                 | otherwise = 1 + posiçao n xs 

valor :: Polinomio -> Float -> Float
valor [] n = 0 
valor l n = sum (map (\x -> (x*(n^((fromIntegral (posiçao x l)))))) l)
--valor l n = sum (map(\(a,b) -> a*(n^(fromIntegral b)) (zip l [0..((length l)-1)]))


deriv :: Polinomio -> Polinomio
deriv [] = []
deriv p = map (\x -> x*(fromIntegral(posiçao x p))) p 

soma :: Polinomio -> Polinomio -> Polinomio
soma p1 [] = p1 
soma [] p2 = p2 
soma (x:xs) (y:ys) = (x+y) : soma xs ys

--4
type Mat a = [[a]] 

ex :: Num a => Mat a 
ex = [[1,4,3,2,5], [6,7,8,9,0], [3,5,4,9,1]]

quebraLinha :: [Int] -> [a] -> [[a]]
quebraLinha [] l= [l]
quebraLinha w [] = [[]]
quebraLinha (x:xs) lm = acumulador1 (x:xs) lm [] 
 where acumulador1 :: [Int] -> [a] -> [a] -> [[a]]
       acumulador1 x [] n = [n]
       acumulador1 (x:xs) (y:ys) n 
         | x==0 = [n] ++ acumulador1 xs (y:ys) []
         | otherwise = acumulador1 ((x-1):xs) ys (n++[y])


--fragmenta :: [Int] -> [Int] -> Mat a -> [Mat a]
--fragmenta 
--
--
--
--geraMat :: (Int,Int) -> (Int,Int) -> IO (Mat Int)
--geraMat ()
--



