
enumFromTo1 :: Int -> Int -> [Int]
enumFromTo1 x y
    | x > y = []
    | x == y = [x]
    | otherwise =  x : enumFromTo1 (x+1) y

enumFromThenTo1 :: Int -> Int -> Int -> [Int]
enumFromThenTo1 x y z
    | y > x || y > z || x > y || x > z = []
    | y == z = [x,y]
    | otherwise = x : y : enumFromThenTo1 (y+y) y z

concatena1 :: [a] -> [a] -> [a]
concatena1 l [] = l
concatena1 [] l = l
concatena1 (h:t) l = h: concatena1 t l

posicao1 :: [a] -> Int -> a
posicao1 (h:t) n
    | n == 0 = h
    | otherwise = posicao1 t (n-1)

reverse1 :: [a] -> [a]
reverse1 [] = []
reverse1 (h:t) = reverse1 t ++ [h]

take1 :: Int -> [a] -> [a]
take1 n (h:t)
    | n >= length (h:t) = h:t
    | n <= 0 = []
    | otherwise = h : take1 (n-1) t

drop1 :: Int -> [a] -> [a]
drop1 n (h:t)
    | n >= length (h:t) = []
    | n <= 0 = h:t
    | otherwise = drop1 (n-1) t

zip1 :: [a] -> [b] -> [(a,b)]
zip1 l [] = []
zip1 [] l = []
zip1 (h:t) (x:y) = (h,x) : zip1 t y

replicate1 :: Int -> a -> [a]
replicate1 n x
    | n <= 0 = []
    | otherwise = x : replicate1 (n-1) x

intersperse1 :: a -> [a] -> [a]
intersperse1 n [x] = [x]
intersperse1 n (h:t) = h : n : intersperse1 n t

group1 :: Eq a => [a] -> [[a]]
group1 [] = []
group1 [x] = [[x]]
group1 (h:t)= if h == head h2 then (h:h2) : t2 else [h] : (h2:t2)
    where (h2:t2) = group1 t

concat1 :: [[a]] -> [a]
concat1 [[]] = []
concat1 [[x]] = [x]
concat1 ((x:y):t) = [x] ++ y ++ concat1 t

inits1 :: [a] -> [[a]]
inits1 [] = [[]]
inits1 l = inits1 (init l) ++ [l]

tails1 :: [a] -> [[a]]
tails1 [] = [[]]
tails1 (h:t) = (h:t) : tails1 t

heads1 :: [[a]] -> [a]
heads1 [[]] = []
heads1 ((x:y):t) = x : heads1 t

total1 :: [[a]] -> Int
total1 [[]] = 0
total1 [] = 0
total1 ((x:y):t) = length (x:y) + total1 t

fun :: [(a,b,c)] -> [(a,c)]
fun [] = []
fun ((x,y,z):t) = (x,z) : fun t

cola :: [(String,b,c)] -> String
cola [] = ""
cola ((x,y,z):t) = x ++ cola t

idade :: Int -> Int -> [(String,Int)] -> [String]
idade a i [] = []
idade a i ((s,i2) :t)
    | (a-i2) >= i = s : idade a i t
    | otherwise = idade a i t

powerEnumFrom :: Int -> Int -> [Int]
powerEnumFrom n m
    | m == 1 = [1]
    | m > 1 = powerEnumFrom n (m-1) ++ [n ^(m-1)]
    | otherwise = []

isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | otherwise = aux n 2
        where aux n m
                | n < m*m= True
                | mod n m == 0 = False
                | otherwise = aux n (m+1)

isPrefixOf1 :: Eq a => [a] -> [a] -> Bool
isPrefixOf1 [] l = True
isPrefixOf1 l [] = False
isPrefixOf1 (x:y) (h:t) = x == h && isPrefixOf1 y t

isSuffixOf1 :: Eq a => [a] -> [a] -> Bool
isSuffixOf1 [] l = True
isSuffixOf1 l [] = False
isSuffixOf1 l1 l2 = isPrefixOf1 (reverse l1) (reverse l2)

isSubsequenceOf1 :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf1 l [] = False
isSubsequenceOf1 [] l = True
isSubsequenceOf1 (x:y) (h:t)
    | x == h = isSubsequenceOf1 y t
    | otherwise = isSubsequenceOf1 (x:y) t

elemIndices1 :: Eq a => a -> [a] -> [Int]
elemIndices1 _ [] = []
elemIndices1 x l = aux 0 x l
    where aux n x [] = []
          aux n x (h:t)
            | h == x = n : aux (n+1) x t
            | otherwise = aux (n+1) x t

nub1 :: Eq a => [a] -> [a]
nub1 [] = []
nub1 (h:t)
    | elem h t = nub1 t
    | otherwise = h : nub1 t

delete1 :: Eq a => a -> [a] -> [a]
delete1 _ [] = []
delete1 x (h:t) = if x == h then t else h : delete1 x t

(\\):: Eq a => [a] -> [a] -> [a]
(\\) l [] = l
(\\) [] l = []
(\\) l (h:t) = (\\) (delete1 h l) t

union1 :: Eq a => [a] -> [a] -> [a]
union1 [] l = l
union1 l [] = l
union1 l (x:y)
    | elem x l = union1 l y
    | otherwise = union1 l y ++ [x]

intersect1 :: Eq a => [a] -> [a] -> [a]
intersect1 [] l = []
intersect1 l [] = []
intersect1 (h:t) l
    | elem h l = h : intersect1 l t
    | otherwise = intersect1 l t

insert1 :: Ord a => a -> [a] -> [a]
insert1 x [] = [x]
insert1 x (h:t)
    | x <= h = x : h : t
    | otherwise = h : insert1 x t

unwords1 :: [String] -> String
unwords1 [] = ""
unwords1 [x] = x
unwords1 (h:t) = h ++ " " ++ unwords1 t

unlines1 :: [String] -> String
unlines1 [] = ""
unlines1 (h:t) = h ++ "\n" ++ unlines1 t

pMaior1 :: Ord a => [a] -> Int
pMaior1 l = posicao2 (maior l) l 0

maior [x] = x
maior (h:t)
    | h >= maior t = h
    | otherwise = maior t

posicao2 x (h:t) n
    | x == h = n
    | otherwise = posicao2 x t (n+1)

lookup1:: Eq a => a -> [(a,b)]-> Maybe b
lookup1 x [] = Nothing
lookup1 x ((h1,h2):t)
    | x == h1 = Just h2
    | otherwise = lookup1 x t

preCrescente1 :: Ord a => [a] -> [a]
preCrescente1 [] = []
preCrescente1 [x] = [x]
preCrescente1 (h:t)= if  h <= h2 then h:h2:t2 else [h]
    where (h2:t2) = preCrescente1 t

iSort1 :: Ord a => [a] -> [a]
iSort1 [] = []
iSort1 [x] = [x]
iSort1 (h:t) = insert1 h (iSort1 t)

menor1 :: String -> String -> Bool
menor1 "" s = True
menor1 s "" = False
menor1 (x:y) (h:t) = x < h || x == h && menor1 y t

elemMSet1 :: Eq a => a -> [(a,Int)] -> Bool
elemMSet1 x [] = False
elemMSet1 x ((h,h2):t) = x == h || elemMSet1 x t

converteMSet1 :: [(a,Int)] -> [a]
converteMSet1 [] = []
converteMSet1 ((h,n):t)
    | n == 0 = converteMSet1 t
    | otherwise = h : converteMSet1 ((h,n-1):t)

insereMSet1 :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet1 x [] = [(x,1)]
insereMSet1 x ((h,n):t)
    | x == h = (h, n+1) : t
    | otherwise = (h,n) : insereMSet1 x t

removeMSet1 :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet1 x [] = []
removeMSet1 x ((h,n):t)
    | x == h && n == 1 = t
    | x == h && n /= 1 = (h,n-1) :t
    | otherwise = (h,n) : removeMSet1 x t

constroiMSet1 :: Ord a => [a] -> [(a,Int)]
constroiMSet1 [] = []
constroiMSet1 (h:t) = insereMSet1 h (constroiMSet1 t)

constroiMSet2 :: Ord a => [a] -> [(a,Int)]
constroiMSet2 = reverse1 . foldr insereMSet1 []

partitionEithers1 :: [Either a b] -> ([a],[b])
partitionEithers1 [] = ([],[])
partitionEithers1 ((Left x):t) = (x:a,b)
    where (a,b) = partitionEithers1 t
partitionEithers1 ((Right x):t) = (a,x:b)
    where (a,b) = partitionEithers1 t

catMaybes1 :: [Maybe a] -> [a]
catMaybes1 [] = []
catMaybes1 ((Just a):t) = a : catMaybes1 t
catMaybes1 (Nothing:t) = catMaybes1 t

data Movimento = Norte | Sul | Este | Oeste
    deriving Show

caminho1 :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho1 posi posf = aux posi posf []
    where aux (x1,y1) (x2,y2) l
            | x1 == x2 && y2 == y1 = l
            | x1 > x2 = aux (x1-1, y1) (x2, y2) (Oeste : l)
            | x1 < x2 = aux (x1+1, y1) (x2, y2) (Este : l)
            | y1 > y2 = aux (x1, y1-1) (x2, y2) (Sul : l)
            | y1 < y2 = aux (x1, y1+1) (x2, y2) (Norte : l)

hasLoops1 :: (Int,Int) -> [Movimento] -> Bool
hasLoops1 p [] = False
hasLoops1 p m
    | p == percurso p m = True
    | otherwise = hasLoops1 p (init m)

percurso (x,y) [] = (x,y)
percurso (x,y) (Norte:t) = percurso (x,y+1) t
percurso (x,y) (Sul:t) = percurso (x,y-1) t
percurso (x,y) (Este:t) = percurso (x+1,y) t
percurso (x,y) (Oeste:t) = percurso (x-1,y) t

type Ponto = (Float,Float)
data Rectangulo = Rect Ponto Ponto

contaQuadrados1 :: [Rectangulo] -> Int
contaQuadrados1 retangulos = aux retangulos 0
    where aux [] n = n
          aux ((Rect (x1,y1) (x2,y2)):t) n
            | abs (x2-x1) == abs (y2-y1) = aux t (n+1)
            | otherwise = aux t n

areaTotal1 :: [Rectangulo] -> Float
areaTotal1 [] = 0
areaTotal1 ((Rect (x1,y1) (x2,y2)):t) = (abs (x2-x1) * abs (y2-y1)) + areaTotal1 t

data Equipamento = Bom | Razoavel | Avariado
    deriving Show

naoReparar1 :: [Equipamento] -> Int
naoReparar1 [] = 0
naoReparar1 (Bom :t) = 1+ naoReparar1 t
naoReparar1 (Razoavel : t) = 1+ naoReparar1 t
naoReparar1 (Avariado :t) = naoReparar1 t