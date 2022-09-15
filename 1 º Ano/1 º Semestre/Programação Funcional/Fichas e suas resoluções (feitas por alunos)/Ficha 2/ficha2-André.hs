import Data.Char
--2
--a
dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:t) = h*2:dobros t
--b
numOcorre :: Char -> String -> Int
numOcorre x [] = 0
numOcorre x (h:t) = if h==x then 1+numOcorre x t else numOcorre x t
--c
positivos :: [Int] -> Bool
positivos [] = True
positivos (h:t) = h>0 && positivos t
--d
soPos :: [Int] -> [Int]
soPos [] = []
soPos (h:t) = if h>0 then h:soPos t else soPos t
--e
somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (h:t) = if h<0 then h+somaNeg t else somaNeg t
--f
tresUlt :: [a] -> [a]
tresUlt l = if length l <=3 then l else tail l
--g
segundos :: [(a,b)] -> [b]
segundos ((x,y):t) = y:segundos t
--h
nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros _ [] = False
nosPrimeiros n ((x,y):t) = if n==x then True else nosPrimeiros n t
--i
sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c) 
sumTriplos [] = (0,0,0)
sumTriplos ((x,y,z):(a,b,c):t) = sumTriplos ((x+a,y+b,z+c):t)
sumTriplos [x] = x
--3
--a
soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (h:t) = if isDigit h then h:soDigitos t else soDigitos t
--b
minusculas :: [Char] -> Int
minusculas [] = 0
minusculas (h:t) = if isLower h then 1+minusculas t else minusculas t
--c
nums :: String -> [Int]
nums "" = []
nums (h:t) = if isDigit h then (digitToInt h):nums t else nums t
--4
type Polinomio = [Monomio] 
type Monomio = (Float,Int)
--a
conta :: Int -> Polinomio -> Int
conta _ [] = 0
conta n ((x,y):t) = if n==y then 1+conta n t else conta n t
--b
grau :: Polinomio -> Int
grau [] = 0
grau ((x,y):(a,b):t) = if y>b then grau ((x,y):t) else grau ((a,b):t) 
grau [(a,b)] = b  
--c
selgrau :: Int -> Polinomio -> Polinomio 
selgrau _ [] = []
selgrau n ((x,y):t) = if n==y then (x,y):selgrau n t else selgrau n t
--d
deriv :: Polinomio -> Polinomio 
deriv [] = []
deriv ((x,y):t) = (x*fromIntegral y,y-1):deriv t
--e
calcula :: Float -> Polinomio -> Float
calcula _ [] = 0
calcula n ((x,y):t) = x*n^y+calcula n t
--f
simp :: Polinomio -> Polinomio 
simp [] = []
simp ((x,y):t) = if y==0 then simp t else (x,y):simp t
--g
mult :: Monomio -> Polinomio -> Polinomio 
mult _ [] = [] 
mult (0,0) _ = []
mult (a,b) ((x,y):t) = (a*x,b+y):mult (a,b) t
--h
normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((b,e):ps) = (sum [bs | (bs,es) <- selgrau e ps] + b,e):normaliza (remove e ps) 

remove :: Int -> Polinomio -> Polinomio
remove e [] = []
remove e ((x,y):t) = if e==y then remove e t else (x,y):remove e t
--i
soma :: Polinomio -> Polinomio -> Polinomio 
soma p1 p2 = normaliza(p1++p2)
--j
produto :: Polinomio -> Polinomio -> Polinomio 
produto _ [] = []
produto [] _ = []
produto ((x,y):t) p = soma (mult (x,y) p) (produto t p)
--k
ordena :: Polinomio -> Polinomio
ordena [] = []
ordena p = 
 let ((b,e):t) = normaliza p 
 in insert (b,e) (ordena t)
insert :: Monomio -> Polinomio -> Polinomio
insert m [] = [m]
insert (b,e) ((b',e'):t) = if e>e' then (b',e'):insert (b,e) t else (b,e):(b',e'):t
--l
equiv :: Polinomio -> Polinomio -> Bool 
equiv [] _ = False
equiv _ [] = False
equiv p1 p2 = (normaliza p1)==(normaliza p2)