--1
data Frac = F Integer Integer

mdc :: Integer -> Integer -> Integer
mdc x y | x==y = x
        | x<y = mdc x (y-x)
        | otherwise = (x-y) y 

normaliza :: Frac -> Frac
normaliza (F x y) = let s = if (x*y)<0 then -1 1 
                        k = mdc (abs x) (abs y)
                    in F (s*(div(abs x) k)) (div (abd d) k)
 
instance Eq Frac where 
 (F a b) == (F c d) = (a*d) == (b*c)
 
instance Ord Frac where 
 (F a b) < (F c d) = (a*d) < (b*c)
 (F a b) <= (F c d) = (a*d) <= (b*c)
 (F a b) > (F c d) = (a*d) > (b*c)

instance Show Frac where 
 (F a b) = (show a) ++ "/" ++ (show b)
 
instance Num Frac where 
 (F a b) + (F c d) = F (a*d + b*c) (b*d)
 (F a b) - (F c d) = F (a*d - b*c) (b*d)
 (F a b) * (F c d) = F (a*c) (b*d)
 abs (F a b) = F (abs a) (abs b)
 signum (F n d)
  | n*d == 0 = F 0 1
  | (n*d)>0 = F 1 1
  | (n*d)<0 = F (-1) 1
 negate (F a b) = F (-a) b 
 fromIntegral a = F (fromIntegral a) 1

funçao :: Frac -> [Frac] -> [Frac]
funçao f [] = []
funçao f (x:xs) | x> (f*2) = x: funçao f xs else funçao f xs 

--2
data Exp a = Const a | Simetrico (Exp a) | Mais (Exp a) (Exp a) | Menos (Exp a) (Exp a) | Mult (Exp a) (Exp a)
--a
instance Show a => Show (Exp a) where
 show (Const a) = show a
 show (Simetrico a) = "-"++show a
 show (Mais a b) = "("++show a++" + "++show b++")"
 show (Menos a b) = "("++show a++" - "++show b++")"
 show (Mult a b) = "("++show a++" * "++show b++")"
--b
calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Mais x y) = calcula x + calcula y
calcula (Simetrico x) = (-1)*calcula x
calcula (Menos x y) = calcula x - calcula y
calcula (Mult x y) = calcula x * calcula y

instance (Num a,Eq a) => Eq (Exp a) where
 e1 == e2 = (calcula e1) == (calcula  e2)
--c
instance (Num a,Eq a) => Num (Exp a) where
 e1+e2 = Const( (calcula e1)+(calcula e2))
 e1-e2 = Const( (calcula e1)-(calcula e2))
 e1*e2 = Const( (calcula e1)*(calcula e2))
 negate e1 = Const(-(calcula e1))
 abs e1 = Const(abs(calcula e1))
 signum e1 = Const(signum(calcula e1))
 fromInteger e1 = Const(fromInteger e1)


--3
data Movimento = Credito Float | Debito Float 
data Data = D Int Int Int deriving Eq
data Extracto = Ext Float [(Data, String, Movimento)]
--a
instance Ord Data where
 (D d1 m1 a1) > (D d2 m2 a2) = a1>a2 || (a1==a2&&m1>m2) || (a1==a2&&m1==m2&&d1>d2)
 (D d1 m1 a1) >= (D d2 m2 a2) = a1>a2 || (a1==a2&&m1>m2) || (a1==a2&&m1==m2&&d1>=d2)
 (D d1 m1 a1) <= (D d2 m2 a2) = a1<a2 || (a1==a2&&m1<m2) || (a1==a2&&m1==m2&&d1<=d2)
--b
instance Show Data where
 show (D d m a) = (show d)++"-"++(show m)++"-"++(show a)
--c
ordena :: Extracto -> Extracto
ordena (Ext e l) = Ext e (sort' l)

sort' :: [(Data, String, Movimento)] -> [(Data, String, Movimento)]
sort' [] = []
sort' (h:t) = insert h (sort' t)
 where insert h [] = [h]
       insert (a,b,c) ((a1,b1,c1):t) = if a>(a1) then (a1,b1,c1):(insert (a,b,c) t) else (a,b,c):(a1,b1,c1):t 




