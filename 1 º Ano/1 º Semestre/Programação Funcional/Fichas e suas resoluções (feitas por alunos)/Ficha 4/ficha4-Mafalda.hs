--CADERNO 
--3
digitAlpha' :: String -> (String,String)
-- "ab23fc5" = ("abfc", 235)
digitAlpha' [] = ([], [])
digitAlpha' (x:xs) =
 let (ll,ld) = digitAlpha' xs
 in if isAlpha x then (x:ll, ld) else if isDigit x then (ll, x:ld) else (ll,ld)

digitAlpha2 :: String -> (String,String)
digitAlpha2 s = parte s ([], [])
 where parte (x:xs) (ll,ld)
      | isAlpha x = parte xs (x:ll, ld) -- parte xs (ll++[x], ld)
	  | isDigit x = parte xs (ll, x:ld)
	  | otherwise = parte xs (ll,ld)

--4
nzp :: [Int] -> (Int, Int,Int)
--[1,4,0,-3,6,0] = (1,2,3)
nzp [] = (0,0,0)
nzp l = conta l (0,0,0)
 where conta :: [Int] -> (Int,Int,Int) -> (Int,Int,Int)
       conta [] (nn,nz,np) = (nn,nz,np)
       conta (x:xs) (nn,nz,np) 
       | x<0 = conta xs (1+nn, nz,np)
       | x==0 = conta xs (nn, 1+nz,np)
       | x>0 = conta xs (nn, nz, 1+np)
--nzp [] = (0,0,0)
--nzp (x:xs) 
-- | x<0 = (1+nn, nz,np)
-- | x==0 = (nn, 1+nz,np)
-- | x>0 = (nn, nz, 1+np)
-- where (nn,nz,np) = nzp xs

--6
fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t

fromDigits' :: [Int] -> Int 
fromDigits' [] = 0
fromDigits' l = corresponde l (length tail l)
 where corresponde :: [Int] -> Int -> Int
       corresponde [] _ = 0
	   corresponde (x:xs) n = n*10^n + corresponde xs (n-1)
	   
fromDigits2 :: [Int] -> Int
fromDigits2 l = converte (reverse l) 
 where converte :: [Int] -> Int
       converte [] = 0
	   converte (x:xs) = x + 10*(fromDigits2 xs)

fromDigits3 :: [Int] -> Int
fromDigits3 l = parte l (0)
 where parte :: [Int] -> Int -> Int
       parte (x:xs) s = parte xs (x+10*s)
	   parte [] s = s ghci