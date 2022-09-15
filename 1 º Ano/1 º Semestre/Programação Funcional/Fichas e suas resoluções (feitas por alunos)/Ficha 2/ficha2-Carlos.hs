  module Ficha2 where
  import Data.Char

--ex.2

  -- (a)

  dobros :: [Float] -> [Float]
  dobros [] = []
  dobros (x:xs) = (x^2) : dobros xs

  -- (b)

  numOcorre :: Char -> String -> Int
  numOcorre _ [] = 0
  numOcorre x (y:ys) = if x==y then 1 + numOcorre x ys else numOcorre x ys

  -- (c)

  positivos :: [Int] -> Bool
  positivos [] = True
  positivos (h:t) = h > 0 && positivos t
 
  -- (d)

  soPos :: [Int] -> [Int]
  soPos [] = []
  soPos (h:t) | h > 0 = h : soPos t
              | otherwise = soPos t

  -- (e)

  somaNeg :: [Int] -> Int
  somaNeg [] = 0
  somaNeg (h:t) | h<0 = h + somaNeg t
                | otherwise = somaNeg t

  -- (f)

  tresUlt :: [a] -> [a] 
  tresUlt [] = []
  tresUlt (h:t) | length (h:t) <= 3 = (h:t)
                | otherwise = tresUlt t

  -- (g)

  segundos :: [(a,b)] -> [b]
  segundos [] = []
  segundos ((h,t):ts) = t : segundos ts

  -- (h)

  nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
  nosPrimeiros _ [] = False
  nosPrimeiros x ((a,b):cs) | (x == a) = True
                            | otherwise = nosPrimeiros x cs

  -- (i)

  sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
  sumTriplos [] = (0,0,0)
  sumTriplos [(a,b,c)] = (a,b,c)
  sumTriplos ((a1,b1,c1):(a2,b2,c2):ts) = sumTriplos ((a1+a2,b1+b2,c1+c2):ts)
                                        

  {-
  sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
  sumTriplos [(x,y,z)] = (x,y,z)
  sumTriplos ((x,y,z):ts) = (x + sumX, y + sumY, z + sumZ)
        where (sumX, sumY, sumZ) = sumTriplos' ts

  sumTriplos' l = (sumA, sumB, sumC)
        where sumA = sum [a | (a,_,_) <- l]
              sumB = sum [b | (_,b,_) <- l]
              sumC = sum [c | (_,_,c) <- l]
  -}

--ex.3

  -- (a)

  soDigitos :: [Char] -> [Char]
  soDigitos [] = []
  soDigitos (h:t) | isDigit h = h : soDigitos t
                  | otherwise = soDigitos t 
  
  -- (b)

  minusculas :: [Char] -> Int
  minusculas [] = 0
  minusculas (h:t) | isLower h = 1 + minusculas t
                   | otherwise = minusculas t

  -- (c)

  nums :: String -> [Int]
  nums "" = []
  nums (h:t) | isDigit h = (digitToInt h) : nums t
             | otherwise = nums t

--ex.4
  
  type Polinomio = [Monomio]
  type Monomio = (Float,Int)

  -- (a)

  conta :: Int -> Polinomio -> Int
  conta n [] = 0
  conta n ((a,b) : bs) | n == b = 1 + conta n bs
                       | otherwise = conta n bs

  -- (b)

  grau :: Polinomio -> Int
  grau [] = 0
  grau [(a,b)] = b
  grau ((a,b):(c,d):ds) | b>d = grau ((a,b):ds)
--nao acabei
  -- (c)

  selgrau :: Int -> Polinomio -> Polinomio
  selgrau _ [] = []
  selgrau n ((a,b):bs) | n==b = ((a,b) : (selgrau n bs))
                       | otherwise = selgrau n bs

  -- (d)

  deriv :: Polinomio -> Polinomio
  deriv [] = []
  deriv [(a,0)] = [(0,0)]
  deriv ((a,b):bs) = ( ( (a * fromIntegral b) , (b - 1) ) : deriv bs)

  -- (e)

  calcula :: Float -> Polinomio -> Float
  calcula _ [] = 0
  calcula x ((a,b):bs) = (a * (x^b)) + calcula x bs

  -- (f)

  simp :: Polinomio -> Polinomio
  simp [] = []
  simp ((a,b):bs) | a == 0 = simp bs
                  | otherwise = ((a,b) : simp bs)

  -- (g)

  mult :: Monomio -> Polinomio -> Polinomio
  mult _ [] = []
  mult (0,0) _ = [(0,0)]
  mult (a,b) ((c,d):ds) | b /= 0 = ((a * c , b + d) : mult (a,b) ds)
                        | otherwise = ((a * c , d) : mult (a,b) ds)

  -- (h)

  normaliza :: Polinomio -> Polinomio
  normaliza [] = []
  normaliza [(a,b)] = [(a,b)]
  normaliza ((a,b) : cs) = ( a + ( sum [as | (as,bs) <- selgrau b cs] ) , b ) : normaliza ( remove b cs)

  remove :: Int -> Polinomio -> Polinomio
  remove a [] = []
  remove a ( (b,c) : cs) | a == c = remove a cs
                         | otherwise = (b,c) : remove a cs

  -- (i)

  soma :: Polinomio -> Polinomio -> Polinomio
  soma x y = normaliza (x ++ y)

  -- (j)

  produto :: Polinomio -> Polinomio -> Polinomio
  produto ((c,d):ds) b =  soma (mult (c,d) b) (produto ds b)

  -- (k)

  ordena :: Polinomio -> Polinomio
  ordena [] = []
  ordena l = let ((b,c):ds) = normaliza l
             in ordena' (b,c) (ordena ds)

  ordena' :: Monomio -> Polinomio -> Polinomio
  ordena' a [] = [a]
  ordena' (b,c) ((d,e):es) | c < e = (b,c) : (d,e) : es 
                           | otherwise = (d,e) : ordena' (b,c) es

  -- (l)

  equiv :: Polinomio -> Polinomio -> Bool
  equiv [] [] = True
  equiv _ [] = False
  equiv [] _ = False

  equiv a b | ordena a == ordena b = True
            | otherwise = False
      