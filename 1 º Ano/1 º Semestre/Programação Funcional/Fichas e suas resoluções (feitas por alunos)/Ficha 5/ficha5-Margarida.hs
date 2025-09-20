--ex1
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

any1 :: (a -> Bool) -> [a] -> Bool
any1 f [] = False
any1 f (h:t) = f h || any1 f t

zipWith1 :: (a->b->c) -> [a] -> [b] -> [c]
zipWith1 f [] l = []
zipWith1 f l [] = []
zipWith1 f (h:t) (x:y) = (f h x) : zipWith f t y

takeWhile1 :: (a->Bool) -> [a] -> [a]
takeWhile1 f [] = []
takeWhile1 f (h:t)
    | f h = h : takeWhile1 f t
    | otherwise = takeWhile1 f t

dropWhile1 :: (a->Bool) -> [a] -> [a]
dropWhile1 f [] = []
dropWhile1 f (h:t)
    | f h = dropWhile1 f t
    | otherwise = h : dropWhile1 f t

span1 :: (a-> Bool) -> [a] -> ([a],[a])
span1 f l = (takeWhile1 f l, dropWhile1 f l)

span2 :: (a-> Bool) -> [a] -> ([a],[a])
span2 f [] = ([],[])
span2 f (h:t) = if f h then ([h],t) else (a,h:b)
    where (a,b) = span2 f t

deleteBy1 :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy1 f x (h:t)
    | f x h = t
    | otherwise = h : deleteBy1 f x t

sortOn1 :: Ord b => (a -> b) -> [a] -> [a]
sortOn1 f [] = []
sortOn1 f (h:t) = insertOn1 f h (sortOn1 f t)
    where insertOn1 f x [] = [x]
          insertOn1 f x (h:t)
            | f x <= f h = x : h : t
            | otherwise = h : insertOn1 f x t

--ex2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

selgrau1 :: Int -> Polinomio -> Polinomio
selgrau1 n = filter (\x -> snd x == n)

conta1 :: Int -> Polinomio -> Int
conta1 n = length . selgrau1 n --o "." significa após

grau1 :: Polinomio -> Int
grau1 = snd . last . sortOn1 snd

deriv1 :: Polinomio -> Polinomio
deriv1 [] = []
deriv1 ((x,y):t)
    | y == 0 = deriv1 t
    | otherwise = (x*fromIntegral y ,y-1) : deriv1 t

deriv2 :: Polinomio -> Polinomio
deriv2 [] = []
deriv2 p = map (\(x,y) -> (x*fromIntegral y ,y-1)) (filter (\(x,y) -> y /= 0 ) p)

calcula1 :: Float -> Polinomio -> Float
calcula1 n [(x,y)]= x * (n^y)
calcula1 n ((x,y):t) = x * (n^y) + calcula1 n t

simp1 :: Polinomio -> Polinomio
simp1 = filter (\(x,y) -> x /= 0)

mult1 :: Monomio -> Polinomio -> Polinomio
mult1 (x1, y1)= map (\(x2,y2) -> (x1*x2,y1+y2))

ordena1 :: Polinomio -> Polinomio
ordena1 = sortOn1 snd

normaliza1 :: Polinomio -> Polinomio
normaliza1 [] = []
normaliza1 [(x,y)] = [(x,y)]
normaliza1 ((x,y):t) = if y == y1 then (x+x1,y): t1 else (x,y) : normaliza1 ((x,y):t1)
    where ((x1,y1):t1) = normaliza1 t

soma1 :: Polinomio -> Polinomio -> Polinomio
soma1 p1 p2 = foldl (\a m -> aux_soma m a) p1 p2
    where aux_soma m [] = [m]
          aux_soma (x1,y1) ((x2,y2):t)
            | y1 == y2 = (x1+x2,y1):t
            | otherwise = (x2,y2) : aux_soma (x1,y1) t

equiv1 :: Polinomio -> Polinomio -> Bool
equiv1 p1 p2 = ordena1 (normaliza1 p1) == ordena1 (normaliza1 p2)

--ex3

type Mat a = [[a]]

m1 = [[1,2,3], [0,4,5], [0,0,6]]
m2 = [[1,2],[3,4]]


dimOK1 ::  Mat a -> Bool
dimOK1 [x] = True
dimOK1 (h:t) = length h == length (head t) && dimOK1 t

dimMat1 :: Mat a -> (Int,Int)
{- dimMat1 [] = (0,0) -} --para por uma seleção em coment´´ario, pressionar ao mesmmo tempo "shift" "alt" e "A"
dimMat1 (h:t) = (length (h:t), length h)

addMat1 :: Num a => Mat a -> Mat a -> Mat a
addMat1 m [] = m
addMat1 [] m = m
addMat1 (h:t) (h2:t2) = aux h h2 : addMat1 t t2
    where aux [] l = []
          aux l [] = []
          aux (h:t) (h2:t2) = (h+h2) : aux t t2

addMat2 :: Num a => Mat a -> Mat a -> Mat a
addMat2 [] m = m
addMat2 m [] = m
addMat2 (h1:t1) (h2:t2) = zipWith (+) h1 h2 : addMat2 t1 t2

transpose1 :: Mat a -> Mat a
transpose1 m = [ map ( !! i) m | i <- [0 .. (y-1)]]
    where (x,y) = dimMat1 m

multMat1 :: Num a => Mat a -> Mat a -> Mat a
multMat1 _ [] = []
multMat1 [] _ = []
multMat1 (h1:t1) (h2:t2) = produtoEscalarAux h1 (h2':t2') : multMat1 t1 (h2:t2)
    where (h2':t2') = transpose1 (h2:t2)

produtoEscalar :: Num a => [a] -> [a] -> a
produtoEscalar [] _ = 0
produtoEscalar _ [] = 0
produtoEscalar (h1:t1) (h2:t2) = h1*h2 + produtoEscalar t1 t2

produtoEscalarAux :: Num a => [a] -> [[a]] -> [a]
produtoEscalarAux _ [] = []
produtoEscalarAux h (h2:t2) = produtoEscalar h h2 : produtoEscalarAux h t2

zipWMat1 :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipWMat1 = zipWith1 . zipWith1

triSup1 :: (Eq a, Num a) => Mat a -> Bool
triSup1 [[]] = True
triSup1 ((x:y):t) = aux 1 1 t

aux n n2 [[x]] = True
aux n n2 ((x:xs):t)
    | n2 == 0 = aux (n+1) (n+1) t
    | otherwise = x == 0 && aux n (n2 - 1) (xs:t)

rotateLeft1 :: Mat a -> Mat a
rotateLeft1 [[]] = [[]]
rotateLeft1 m = [ map (!! i) m | i <- [c-1,c-2..0]] 
    where (l,c) = dimMat1 m

