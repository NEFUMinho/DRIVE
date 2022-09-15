--2
dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = x*2 : dobros xs

somadobros :: [Float] -> Float
somadobros [] = 0
somadobros (x:xs) = (x*2 + (somadobros xs))

numOcorre :: Char -> String -> Int 
numOcorre a [] = 0
numOcorre a (x:xs) = if a==x then (1 + numOcorre a xs) else (numOcorre a xs) 

positivos :: [Int] -> Bool
positivos [] = True
positivos (x:xs) = if x<0 then False else (positivos xs)

soPos :: [Int] -> [Int]
soPos [] = [] 
soPos (x:xs) = if x<0 then soPos xs else x : soPos xs

somaNeg :: [Int] -> Int 
somaNeg [] = 0
somaNeg (x:xs) 
 |x>0 = somaNeg xs 
 |x<0 = x + somaNeg xs

tresUlt :: [a] -> [a]
tresUlt l = if length l <=3 then l else tresUlt (tail l)

segundos :: [(a,b)] -> [b]
segundos [] = []
segundos ((x,y):xs) = y : segundos xs
--segundos (x:xs) = snd x : segundos xs

nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros c [] = False 
nosPrimeiros c ((x,y):xs)
 |c==x =True
 |nosPrimeiros c xs = True 
 |otherwise = False

sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos ((x,y,z):(x1,y1,z1):xs) = sumTriplos((x+x1,y+y1,z+z1):xs)
--sumTriplos [] = (0,0,0)
--sumTriplos ((x,y,z):xs)=
--let (s1,s2,s3) = sumTriplos xs
--in (s1+x,s2+y,s3+z)

--3
--soDigitos :: [Char] -> [Char]
--soDigitos [] = []
--soDigitos 

--4
type Polinomio = [Monomio]
type Monomio (Float,Int)
--p = [(2,3), (3,4), (5,3), (4,5), (3,5), (6,3)]
-- 
--conta' :: Int -> Polinomio -> Int
--conta' n [] = 0
--conta' n ((x,y):xs) 
-- | n==y = 1 + conta' n xs 
-- |n/= y = conta' n xs

grau :: Polinomio -> Int 
grau ((x,y):xs) = grau (y (grau xs)) 

selgrau :: Int -> Polinomio -> Polinomio
selgrau n [] = []
selgrau n ((x,y):xs) = if n==y then (x,y):(selgrau n xs) else selgrau n xs
 
deriv :: Polinomio -> Polinomio
deriv ((x,y):xs) =
 | y>1 = (x*(fromIntegral y), y-1): deriv xs 
 | y<0 = deriv xs
 
calcula :: Float -> Polinomio -> Float
calcula n ((x,y):xs) = x*(n^e) + calcula n xs 

simp :: Polinomio -> Polinomio
simp [] = []
simp ((x,y):xs) = if y==0 then simp xs else (x,y) : simp xs

mult :: Monomio -> Polinomio -> Polinomio 
--(1,2) [(2,3), (3,4)] = [(2,6) , (3,8)]
mult (a,b) [] = []
mult (a,b) ((x,y):xs) = (x*a , y*b): mult (a,b) xs
--
--normaliza :: Polinomio -> Polinomio
--p = [(2,3), (3,4), (5,3), (4,5), (3,5), (6,3)] = [(13,3), (3,4), (7,5)]
normaliza [] = []
normaliza ((x1,y1):(x2,y2):xs) 
 | y1==y2 = (x1+x2, y1): normaliza xs
 | y1/=y2 = normaliza xs 
--não esta acabado


--soma :: Polinomio -> Polinomio -> Polinomio
soma [] [] = []
soma ((x1,y1):xs) ((x2,y2):ys) = normaliza ((x1+x2, y1+y2): soma xs ys)
 
produto :: Polinomio -> Polinomio -> Polinomio 
produto [] [] = [] 
produto ((x1,y1):xs) ((x2,y2):ys) = ((x1*x2, y1*y2): produto xs ys)

ordena :: Polinomio -> Polinomio 
ordena [] = []
ordena (m:p) = insere m (ordena p)
 where insere :: Monomio -> Polinomio -> Polinomio
       insere n [] = [n]
	   insere (c,e) ((c1,e1):p)
	    | e<e1 = ((c,e):(c1,e1):p)
		| e>e1 = (c1,e1): insere (c,e) p 
		| e==e1 = if (c+c1)/=0 then ((c+c1),e):p else p 

equiv :: Polinomio -> Polinomio -> Bool
equiv [] [] = True
equiv (m1:p1) (m2:p2) 
 | if m1=m2 && equiv p1 p2 = True
 | otherwise = False
-- equiv p1 p2 = if (ordena (normaliza p1) == ordena (normalizap2))
--               then True else False






























 


