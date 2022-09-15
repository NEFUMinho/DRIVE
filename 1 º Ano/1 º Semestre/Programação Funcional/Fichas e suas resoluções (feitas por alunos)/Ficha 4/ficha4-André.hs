import Data.Char
--2
a=[2^x|x <- [0..10]]
b=[(a,6-a)|a<-[1..5]]
c=[[1..x]|x<-[1..5]]
d=[replicate x 1|x<-[1..5]]
e=[ fatorial x | x <- [1..6]]
 where fatorial 0 = 1
       fatorial x = x * fatorial (x - 1)
--3
digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha s = aux s ([],[])
 where aux [] (x,y) = (x,y)
       aux (h:t) (x,y) = if isAlpha h then aux t (x,y++[h]) else aux t (x++[h],y)
--4
nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp l = aux l (0,0,0)
 where aux [] (n,z,p) = (n,z,p)
       aux (h:t) (n,z,p)
        | h>0 = aux t (n,z,p+1)
        | h==0 = aux t (n,z+1,p)
        | otherwise = aux t (n+1,z,p)
--5
divMod' :: Integral a => a -> a -> (a, a)
divMod' x y
 | x<y = (0,x)
 | x>=y = let (q,r) = divMod' (x-y) y
          in (q+1,r)
--6
fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits l = aux l 0
 where aux [] n = n
       aux (h:t) n = aux t (h+10*n)
--7
{-maxSumInit :: (Num a, Ord a) => [a] -> a 
maxSumInit l = maximum [sum m | m <- inits l]

inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (take ((length l)-1) l) ++ [l]-}
maxSumInit :: (Num a, Ord a) => [a] -> a 
maxSumInit [] = 0
maxSumInit l = aux l 0
 where aux [] n = n
       aux (h:t) n = aux t n+h
--8
fib :: Int -> Int
fib 0 = 0
fib n = aux 0 1 n
 where aux n1 n2 1 = n2
       aux n1 n2 n = aux n2 (n1+n2) (n-1) 
