import Data.Char
import GHC.Int (leInt32)
import Data.Time.Format.ISO8601 (yearFormat)

--ex1
digitAlpha1 :: String -> (String,String)
digitAlpha1 "" = ("","")
digitAlpha1 (h:t)
    | isDigit h = (h:h2,t2)
    | isAlpha h = (h2,h:t2)
    | otherwise = (h2,t2)
    where (h2,t2) = digitAlpha1 t

--ex2

nzp1 :: [Int] -> (Int,Int,Int)
nzp1 [] = (0,0,0)
nzp1 l = (length l1, length l2, length l3)
    where (l1,l2,l3) = aux_nzp1 l [] [] []

aux_nzp1 [] l1 l2 l3 = (l1, l2, l3)
aux_nzp1 (h:t) l1 l2 l3
    | h > 0 = aux_nzp1 t l1 l2 (l3++[h])
    | h < 0 = aux_nzp1 t (l1++[h]) l2 l3
    | otherwise = aux_nzp1 t l1 (l2++[h]) l3

--ex3

divMod1 :: Integral a => a -> a -> (a, a)
divMod1 x y 
    | x < 0 = let (q,r) = divMod1 (-x) y in (if r == 0 then (-q,r) else (-q-1,-r+y))
    | y < 0 = let (q,r) = divMod1 (-x) (-y) in (q,-r)
    | otherwise = if x - y < 0 then (0,x) else (let (q,r) = divMod1 (x - y) y in (q+1,r))

--ex4

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t

fromDigits1 :: [Int] -> Int
fromDigits1 l = aux (reverse l) 0
    where aux [] n = 0
          aux (h:t) n = h * 10^n + aux t (n+1)

fromDigits2 :: [Int] -> Int
fromDigits2 l = aux l 0
    where aux [] n = n
          aux (h:t) n = aux t (h + 10^n)

--ex5

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (init l) ++ [l]

maxSumInit1 :: (Num a, Ord a) => [a] -> a
maxSumInit1 l = aux l 0
    where aux [] n = n
          aux (h:t) n
            | h+n > n = aux t (n+h)
            | otherwise = aux t n

--ex6

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib1 :: Int -> Int
fib1 0 = 0
fib1 1 = 1
fib1 n = aux (n-2) 0 1
    where aux :: Int -> Int -> Int -> Int
          aux 0 n _ = n
          aux i n m = aux (i - 1) m (n+ m)

--ex7

intToStr1 :: Integer -> String
intToStr1 0 = "0"
intToStr1 n = aux n ""
    where aux :: Integer -> String -> String
          aux 0 ('-':x) = x
          aux n x = aux nn ((case r of 
             0 -> "-0"
             1 -> "-1"
             2 -> "-2"
             3 -> "-3"
             4 -> "-4"
             5 -> "-5"
             6 -> "-6"
             7 -> "-7"
             8 -> "-8"
             9 -> "-9") ++ x)
                where (nn,r) = n `divMod` 10

--ex8
--a) [6,12,18]
-- [x | x <- [1..20] , mod x 6 == 0]
--b) [6,12,18]
-- [x | x <- [1..20] , mod x 6 == 0]
--c) [(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11)]
--[(x,30-x)| x <- [10..20]]
--d) [1,1,4,4,9,9,16,16,25,25]
-- [x^2 | x <- [1..5],y <- [1..2]]

--ex9
--a) [2^x | x <- [0..10]]
--b) [(x,6-x) | x <- [1..5]]
--c) [[1..x] | x <- [1..5]]
--d) [replicate 1 n | n <- [1..5]] replicate das 50Q
--e) [product [ y | y <- [1..x]] | x <- [1..6]]