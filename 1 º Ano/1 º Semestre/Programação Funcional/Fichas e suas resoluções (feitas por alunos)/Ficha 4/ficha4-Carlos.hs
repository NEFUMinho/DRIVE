  module Ficha4 where
  
  import Data.Char

--ex.2

  -- (a)
  a=[2^x|x <- [0..10]]
  -- (b)
  b=[(a,6-a)|a<-[1..5]]
  -- (c)
  c=[[1..x]|x<-[1..5]]
  -- (d)
  d=[replicate x 1|x<-[1..5]]
  -- (e)
  e=[ fatorial x | x <- [1..6]]
   where fatorial 0 = 1
         fatorial x = x * fatorial (x - 1)

--ex.3 

  digitAlpha :: String -> (String,String)
  digitAlpha [] = ([],[])
  digitAlpha s = aux1 s ([],[])
     where aux1 [] (x,y) = (x,y)
           aux1 (h:t) (x,y) | isAlpha h = aux1 t (x , y ++ [h])
                            | isDigit h = aux1 t (x ++ [h] , y)
                            | otherwise = aux1 t (x,y)

--ex.4
  
  nzp :: [Int] -> (Int,Int,Int)
  nzp [] = (0,0,0)
  nzp l = aux l (0,0,0)
    where aux [] (n,z,p) = (n,z,p)
          aux (h:t) (n,z,p)
                | h>0 = aux t (n,z,p+1)
                | h==0 = aux t (n,z+1,p)
                | otherwise = aux t (n+1,z,p)

--ex.5 ??????

--ex-6

  fromDigits :: [Int] -> Int
  fromDigits [] = 0
  fromDigits l = aux l 0
     where aux [] n = n
           aux (h:t) n = aux t (h+10*n)

--ex.7

  maxSumInit :: (Num a, Ord a) => [a] -> a 
  maxSumInit [] = 0
  maxSumInit l = aux l 0
     where aux [] n = n
           aux (h:t) n = aux t n+h

-- ex.8 ????

  fib :: Int -> Int
  fib 0 = 0
  fib n = aux 0 1 n
    where aux n1 n2 1 = n2
          aux n1 n2 n = aux n2 (n1+n2) (n-1) 
  