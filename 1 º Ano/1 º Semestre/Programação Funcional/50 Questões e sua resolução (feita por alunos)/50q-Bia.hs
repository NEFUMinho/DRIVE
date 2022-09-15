-- 50 questões

-- Exercício 1

enumFromTo1 :: Int -> Int -> [Int]
enumFromTo1 a b
	| a>b = []
	| a==b = [b]
	| otherwise = a : (enumFromTo1 (a+1) b)

-- Exercício 2

enumFromThenTo1 :: Int -> Int -> Int -> [Int]
enumFromThenTo1 a b c
	| a>b || a>c || b>c = []
	| a==b || b==c = enumFromTo1 a c
	| otherwise = a : (enumFromThenTo1 b (b+b-a) c)

-- Exercício 3

concatena1 :: [a] -> [a] -> [a]
concatena1 [] l = l
concatena1 l [] = l
concatena1 [] [] = []
concatena1 (a:b) l = a : (concatena1 b l) 

-- Exercício 4 

posicao1 :: [a] -> Int -> a
posicao1 (a:b) c
	| c==0 = a
	| otherwise = posicao1 b (c-1)

-- Exercício 5

	-- Versão 1

reverse1 :: [a] -> [a]
reverse1 [] = []
reverse1 l = reverseAc [] l

reverseAc :: [a] -> [a] -> [a]
reverseAc ac [] = ac
reverseAc ac (x:xs) = reverseAc (x:ac) xs

	-- Versão 2

reverse2 :: [a] -> [a]
reverse2 [] = []
reverse2 (x:xs) = (reverse2 xs) ++ [x]

-- Exercício 6

take1 :: Int -> [a] -> [a]
take1 n [] = []
take1 n l | n==0 = []
          | n>(length l) = l
          | otherwise = (head l) : (take1 (n-1) (tail l))

-- Exercício 7

drop1 :: Int -> [a] -> [a]
drop1 n [] = []
drop1 n l | n==0 = l
		  | n>(length l) = []
		  | otherwise = drop1 (n-1) (tail l)

-- Exercício 8

zip1 :: [a] -> [b] -> [(a,b)]
zip1 [] [] = []
zip1 l1 [] = []
zip1 [] l2 = []
zip1 (x:xs) (y:ys) = (x,y) : (zip1 xs ys)

-- Exercício 9

elem1 :: Eq a => a -> [a] -> Bool
elem1 _ [] = False
elem1 x (h:t) | x==h = True
			  | otherwise = elem1 x t

-- Exercício 10

replicate1 :: Int -> a -> [a]
replicate1 0 x = []
replicate1 n x = x : (replicate1 (n-1) x)

-- Exercício 11

intersperse1 :: a -> [a] -> [a]
intersperse1 x [] = [x]
intersperse1 x (h:t) = h:x:(intersperse1 x t)

-- Exercício 12

group1 :: Eq a => [a] -> [[a]]
group1 [] = [[]]
group1 (h:t) = (aux h t) : group1 (drop (length (aux h t)) (h:t))

aux :: Eq a => a -> [a] -> [a]
aux a [] = [a]
aux a (h:t) | a==h = a:aux h t
			| otherwise = aux a []

-- Exercício 13

concat1 :: [[a]] -> [a]
concat1 [] = []
concat1 (h:t) = h ++ concat1 t

-- Exercício 14

inits1 :: [a] -> [[a]]
inits1 [] = [[]]
inits1 l = inits1 (init l) ++ [l]

-- Exercício 15

tails1 :: [a] -> [[a]]
tails1 [] = [[]]
tails1 (h:t) = (h:t):(tails1 t)

-- Exercício 16

isPrefixOf1 :: Eq a => [a] -> [a] -> Bool
isPrefixOf1 [] _ = True
isPrefixOf1 _ [] = False
isPrefixOf1 (h:t) (x:xs)
	| h==x = isPrefixOf1 t xs
	| otherwise = False

-- Exercício 17

	-- Versão 1

isSuffixOf1 :: Eq a => [a] -> [a] -> Bool
isSuffixOf1 [] _ = True
isSuffixOf1 _ [] = False
isSuffixOf1 l1 l2
	| last l1 == last l2 = isSuffixOf1 (init l1) (init l2)
	| otherwise = False

	-- Versão 2

isSuffixOf2 :: Eq a => [a] -> [a] -> Bool
isSuffixOf2 [] _ = True
isSuffixOf2 _ [] = False
isSuffixOf2 l1 l2 = isPrefixOf1 (reverse l1) (reverse l2)

-- Exercício 18

isSubsequenceOf1 :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf1 [] _ = True
isSubsequenceOf1 _ [] = False
isSubsequenceOf1 (h:t) (x:xs)
	| h==x = isSubsequenceOf1 t xs
	| otherwise = isSubsequenceOf1 (h:t) xs

-- Exercício 19

elemIndices1 :: Eq a => a -> [a] -> [Int]
elemIndices1 _ [] = []
elemIndices1 n (h:t) = aux 0 n (h:t)

aux2 :: Eq a => Int -> a -> [a] -> [Int]
aux2 p x [] = []
aux2 p x (h:t)
	| x==h = p:aux2 (p+1) x t
	| otherwise = aux2 (p+1) x t

-- Exercício 20

	-- Versão 1

nub1 :: Eq a => [a] -> [a]
nub1 [] = []
nub1 (h:t) = h:nub1 (aux3 h t)

aux3 :: Eq a => Int -> [a] -> [a]
aux3 n [] = []
aux3 n (h:t) 
	| n==h = aux3 n t
	| otherwise = h:aux3 n t

	-- Versão 2

nub2 :: Eq a => [a] -> [a]
nub2 [] = []
nub2 l = aux4 [] l
	where aux4 l [] = l
		  aux4 a (x:xs) | elem x a == True = aux a xs
		  				| otherwise = aux (a++[x]) xs

-- Exercício 21

delete1 :: Eq a => a -> [a] -> [a]
delete1 a [] = []
delete1 a (x:xs)
	| elem a (x:xs)==False = (x:xs)
	| otherwise = if a==x then xs else delete a xs

-- Exercício 22

	-- Versão 1

remove1 :: Eq a => [a] -> [a] -> [a]
remove1 l [] = l
remove1 [] _ = []
remove1 (a:b) (c:d)
	| a==c = remove1 b d
	| otherwise = a : remove1 b d

	-- Versão 2

remove2 :: Eq a => [a] -> [a] -> [a]
remove2 [] _ = []
remove2 l [] = l
remove2 l (x:y) = remove2 (delete x l) y

-- Exercício 23

union1 :: Eq a => [a] -> [a] -> [a]
union1 [] l = l
union1 l [] = l
union1 (h:t) (x:xs)
	| elem x (h:t) = union1 (h:t) xs
	| otherwise = x : union1 (h:t) xs

-- Exercício 24

intersect1 :: Eq a => [a] -> [a] -> [a]
intersect1 [] _ = []
intersect1 _ [] = []
intersect1 (h:t) (x:xs)
	| elem h (x:xs) = h: intersect1 t (x:xs)
	| otherwise = intersect1 t (x:xs)

-- Exercício 25

insert1 :: Ord a => a -> [a] -> [a]
insert1 a [] = [a]
insert1 a (x:xs)
	| a<=x = a:x:xs
	| otherwise = x:insert1 a xs

-- Exercício 26

unwords1 :: [String] -> String
unwords1 (x:xs) = x ++ " " ++ unwords1 xs

-- Exercício 27

unlines1 :: [String] -> String
unlines1 (x:xs) = x ++ "\n" ++ unlines1 xs ++ "\n"

-- Exercício 28

	-- Versão 1

pMaior1 :: Ord a => [a] -> Int
pMaior1 [x] = 0
pMaior1 l = maior 0 l
	where maior c [] = c
	      maior c (h:t)
	      	| h>=maximum t = c
	      	| otherwise = maior (c+1) t

  	-- Versão 2

pMaior2 :: Ord a => [a] -> Int
pMaior2 [x] = 0
pMaior2 (h:t)
	| h>(!!) t p = 0
	| otherwise = p+1
   where p=pMaior2

   -- Versão 3

pMaior3 :: Ord a => [a] -> Int
pMaior3 l = snd (aux5 l)

aux5 :: Ord a => [a] -> (a,Int)
aux5 [x] = (x,0)
aux5 (h:t)
	| h>m = (h,0)
	| otherwise = (m,p+1)
   where (m,p)=aux5 t

-- Exercício 29

temRepetidos1 :: Eq a => [a] -> Bool
temRepetidos1 [] = False
temRepetidos1 (h:t)
	| elem h t == True = True
	| otherwise = temRepetidos1 t

-- Exercício 30

algarismos1 :: [Char] -> [Char]
algarismos1 [] = []
algarismos1 (h:t)
	| elem h [0..9]==True = h:algarismos1 t
	| otherwise = algarismos1 t

-- Exercício 31

posImpares1 :: [a] -> [a]
posImpares1 [] = []
posImpares1 [x] = []
posImpares1 (h:x:t) = x:posImpares1 t

-- Exercício 32

posPares1 :: [a] -> [a]
posPares1 [] = []
posPares1 [x] = [x]
posPares1 (h:x:t) = h:posPares1 t

-- Exercício 33

isSorted1 :: Ord a => [a] -> Bool
isSorted1 [] = False
isSorted1 [x] = True
isSorted1 (x:y:t)
	| x<y = isSorted1 (y:t)
	| otherwise = False

-- Exercício 34

iSort1 :: Ord a => [a] -> [a]
iSort1 [] = []
iSort1 (x:xs) = insert x (iSort1 xs)

-- Exercício 35

	-- Versão 1

menor1 :: String -> String -> Bool
menor1 _ [] = False
menor1 [] _ = True
menor1 (h:t) (x:xs)
	| h<x = True
	| menor1 t < menor xs = True
	| otherwise = False

	-- Versão 2

menor2 :: String -> String -> Bool
menor2 [] [] = False
menor2 [] (y:ys) = True
menor2 (x:xs) [] = False
menor2 (x:xs) (y:ys)
	| x>y = False
	| x<y = True
	| x==y = menor xs ys

-- Exercício 36

elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet x ((h,y):t)
	| x==h = True
	| otherwise = elemMSet x t

-- Exercício 37

lengthMSet :: [(a,Int)] -> Int
lengthMSet [] = 0
lengthMSet ((h,y):t) = y + lengthMSet t

-- Exercício 38

converteMSet :: [(a;Int)] -> [a]
converteMSet [] = []
converteMSet ((h,y):t) = (replicate y h):converteMSet t

-- Exercício 39

insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x [] = [(x,1)]
insereMSet x ((h,y):t)
	| x==h = ((h,y+1):t)
	| x<h = (x,1):(h,y):t
	| otherwise = (h,y):insereMSet x t

-- Exercício 40

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet a ((x,y):t)
	| a==x && y>1 = (x,y-1):t
	| a==x && y==1 = t
	| otherwise = (x,y):removeMSet a t

-- Exercício 41

constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet (h:t) = insereMSet h (constroiMSet t)

-- Exercício 42

partitionEithers :: [Either a b] -> ([a],[b])
partitionEithers [] = ([],[])
partitionEithers l = (lefts l, rights l)

lefts :: [Either a b] -> [a]
lefts [] = []
lefts ((Left a):t) = a : lefts t
lefts ((Right b):t) = lefts t

rights :: [Either a b] -> [b]
rights [] = []
rights ((Left a):t) = rights t
rights ((Right b):t) = b:rights t

-- Exercício 43

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes ((Just a):t) = a:catMaybes t
catMaybes ((Nothing):t) = catMaybes t


data Movimento = Norte | Sul | Este | Oeste
         deriving Show

-- Exercício 44

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (h:t)
	| h==Norte = posicao (x,y+1) t
	| h==Sul = posicao (x,y-1) t
	| h==Este = posicao (x+1,y) t
	| h==Oeste = posicao (x-1,y) t

-- Exercício 45

caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x,y) (a,b)
	| x<a = Este : caminho (x+1,y) (a,b)
	| x>a = Oeste : caminho (x-1,y) (a,b)
	| y<b = Norte : caminho (x,y+1) (a,b)
	| y>b = Sul : caminho (x,y-1) (a,b)
	| otherwise = []

-- Exercício 46

vertical :: [Movimento] -> Bool
vertical [] = False
vertical (h:t)
	| h==Norte = vertical t
	| h== Sul = vertical t
	| otherwise = False

data Posicao = Pos Int Int
      deriving Show

-- Exercício 47

maisCentral :: [Posicao] -> Posicao
maisCentral [Pos x y] = Pos x y
maisCentral ((Pos x y):(Pos x1 y1):t)
	| (x^2+y^2)<(x1^2+y1^2) = maisCentral ((Pos x y):t)
	| otherwise = maisCentral ((Pos x1 y1):t)

-- Exercício 48

vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos _ [] = []
vizinhos (Pos x y) ((Pos w z):t)
	| (w==x+1||w==x-1) && (z>=y+1||z<=y-1) = (Pos w z):vizinhos (Pos x y) t
	| otherwise = vizinhos (Pos x y) t

-- Exercício 49

mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [Pos x y] = True
mesmaOrdenada ((Pos x y):(Pos w z):t)
	| y==z = mesmaOrdenada ((Pos w z):t)
	| otherwise = False

data Semaforo = Verde | Amarelo | Vermelho
        deriving Show

-- Exercício 50

interseccaoOk :: [Semaforo] -> Bool
interseccaoOk l = (contanvermelho l) <= 1
	where contanvermelho [] = 0
		  contanvermelho (Vermelho:t) = contanvermelho t
		  contanvermelho (_:t) = 1 + contanvermelho t

		   

