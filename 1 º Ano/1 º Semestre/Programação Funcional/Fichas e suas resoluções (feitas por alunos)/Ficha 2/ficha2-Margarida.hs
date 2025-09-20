import GHC.Builtin.Types (falseDataCon)
import Data.Char
--ex1
--a) funA [2,3,5,1] = 4 + 9 + 25 + 1 = 39 -> soma dos quadrados
--b) funB [8,5,12] = [8,12] -> elementos pares da lista
--c) funC [1,2,3,4,5] = [5]
--d) funD "otrec" = "certo"

--ex2
dobros1 :: [Float] -> [Float]
dobros1 [] = []
dobros1 (h:t) = 2*h : t

dobros2 :: [Float] -> [Float]
dobros2 = map (2*) -- não recursivamente

numOcorre1 :: Char -> String -> Int
numOcorre1 x "" = 0
numOcorre1 x (h:t)
    | x == h = 1 + numOcorre1 x t
    | otherwise = numOcorre1 x t

positivos1 :: [Int] -> Bool
positivos1 [] = True
positivos1 (h:t)
    | h > 0 = positivos1 t
    | otherwise = False

positivos2 :: [Int] -> Bool
positivos2 l = length (takeWhile (>0) l) == length l

soPos1 :: [Int] -> [Int]
soPos1 [] = []
soPos1 (h:t) = if h > 0 then h : soPos1 t else soPos1 t

somaNeg1 :: [Int] -> Int
somaNeg1 [] = 0
somaNeg1 (h:t) = if h < 0 then h + somaNeg1 t else somaNeg1 t

tresUlt1 :: [a] -> [a]
tresUlt1 (h:t)
    | length (h:t) <= 3 = h:t
    | otherwise = tresUlt1 t

segundos1 :: [(a,b)] -> [b]
segundos1 [] = []
segundos1 ((a,b):t) = b : b2 where b2 = segundos1 t

nosPrimeiros1 :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros1 x [] = False
nosPrimeiros1 x ((a,b):t) = x == a || nosPrimeiros1 x t

sumTriplos1 :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos1 [] = (0,0,0)
sumTriplos1 ((a,b,c):t) = (a+a2,b+b2,c+c2) where (a2,b2,c2) = sumTriplos1 t

--ex3
isDigit1 :: Char -> Bool
isDigit1 n = ord n >= 48 && ord n <= 57 --ficha1

soDigitos1 :: [Char] -> [Char]
soDigitos1 [] = []
soDigitos1 (h:t) = if isDigit1 h then h : soDigitos1 t else soDigitos1 t


isLower1 :: Char -> Bool
isLower1 l = ord l <= 122 && ord l >= 97 --ficha1

minusculas1 :: [Char] -> Int
minusculas1 [] = 0
minusculas1 (h:t) = if isLower1 h then 1 + minusculas1 t else minusculas1 t

nums1 :: String -> [Int]
nums1 "" = []
nums1 (h:t)
    | isDigit1 h = reverse (digitToInt h : nums1 t)
    | otherwise = nums1 t

--ex4
type Polinomio = [Monomio]
type Monomio = (Float,Int)

p1 = [(2,3), (3,4), (5,3), (4,5)]

conta1 :: Int -> Polinomio -> Int
conta1 n [] = 0
conta1 n ((x,y):t)
    | n == y = 1 + conta1 n t
    | otherwise = conta1 n t

grau1 :: Polinomio -> Int
grau1 = aux 0 
    where aux n [] = n
          aux n ((x,y):t)
            | y > n = aux y t
            | otherwise = aux n t

selgrau1 :: Int -> Polinomio -> Polinomio
selgrau1 n [] = []
selgrau1 n ((x,y):t) = if y == n then (x,y) : selgrau1 n t else selgrau1 n t 

deriv1 :: Polinomio -> Polinomio
deriv1 [] = []
deriv1 ((x,y):t)
    | y == 0 = deriv1 t
    | otherwise = (x*fromIntegral y,y-1) : deriv1  t

calcula1 :: Float -> Polinomio -> Float
calcula1 n [] = 0
calcula1 n ((x,y):t) = x*(n^y) + calcula1 n t

simp1 :: Polinomio -> Polinomio
simp1 [] = []
simp1 ((x,y):t)
    | y == 0 = simp1 t
    | otherwise = (x,y) : simp1 t

mult1 :: Monomio -> Polinomio -> Polinomio
mult1 _ [] = []
mult1 (x,y) ((x2,y2):t) = (x*x2,y+y2): mult1 (x,y) t

normaliza1 :: Polinomio -> Polinomio
normaliza1 [] = []
normaliza1 ((x,y):t) = aux (x,y) (normaliza1 t)
    where aux (x,y) [] = [(x,y)]
          aux (x,y) ((x2,y2):t)
            | y == y2 = (x+x2,y) :t
            | otherwise = (x2,y2) : aux (x,y) t

soma1 :: Polinomio -> Polinomio -> Polinomio
soma1 p [] = p
soma1 [] p = p
soma1 ((x,y):t) p2 = if normaliza1 ((x,y):t) == ((x,y):t) && normaliza1 p2 == p2
              then normaliza1 (aux (x,y) (soma1 t p2))
              else aux (x,y) (soma1 t p2)
              where  aux (x,y) [] = [(x,y)]
                     aux (x,y) ((x2,y2):t)
                         | y == y2 = (x+x2,y) :t
                         | otherwise = (x2,y2) : aux (x,y) t

produto1 :: Polinomio -> Polinomio -> Polinomio
produto1 p [] = []
produto1 [] p = []
produto1 ((x,y):t) p = aux (x,y) p ++ produto1 t p
    where aux (x,y) [] = []
          aux (x,y) ((x2,y2):t) = (x*x2,y+y2) : aux (x,y) t

ordena1 :: Polinomio -> Polinomio
ordena1 [] = []
ordena1 [p] = [p]
ordena1 ((x,y) :t) = if y <= y2 then (x,y): (x2,y2):t2 else (x2,y2) : ordena1 ((x,y):t2)
    where (x2,y2) : t2 = ordena1 t

equiv1 :: Polinomio -> Polinomio -> Bool
equiv1 p1 p2 = ordena1 (normaliza1 p1) == ordena1 (normaliza1 p2)

