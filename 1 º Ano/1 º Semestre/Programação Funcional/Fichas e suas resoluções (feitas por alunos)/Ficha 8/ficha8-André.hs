--1
import Data.List
import Data.Char
data Frac = F Integer Integer
--b
instance Eq Frac where
 (F a b) == (F c d) = (a*d) == (b*c)
--c
instance Ord Frac where
 (F a b) > (F c d) = (a*d) > (b*c)
 (F a b) < (F c d) = (a*d) < (b*c)
 (F a b) <= (F c d) = (a*d) <= (b*c)
--d
instance Show Frac where
 show (F a b) = (show a)++"/"++(show b)
--e
instance Num Frac where
 (F a b) + (F c d) = F (a*d+b*c) (b*d)
 (F a b) - (F c d) = F (a*d-b*c) (b*d)
 (F a b) * (F c d) = F (a*c) (b*d)
 abs (F a b) = F (abs a) (abs b)
 signum (F n d) 
  | n*d == 0 = F 0 1
  | (n*d)>0 = F 1 1
  | otherwise = F (-1) 1
 negate (F a b) = F (-a) b
 fromInteger a = F (fromInteger a) 1
--a
normaliza :: Frac -> Frac
normaliza (F n d) = let s = if (n*d) <0 then -1 else 1
                        k = mdc (abs n) (abs d)
                    in F (s*(div (abs n) k)) (div (abs d) k)

mdc :: Integer -> Integer -> Integer 
mdc x y 
 | x==y = x
 | x<y = mdc x (y-x)
 | x>y = mdc (x-y) y
--f
maiordobro :: Frac -> [Frac] -> [Frac]
maiordobro _ [] = []
maiordobro f (h:t) = if h>2*f then h:maiordobro f t else maiordobro f t 
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

instance Show Extracto where
 show (Ext n l) = "Saldo anterior: " ++ show n ++ "\n---------------------------------------" ++ "\nData       Descricao   Credito   Debito" ++ "\n---------------------------------------\n" ++ concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str ++ "    \n") l ++ "---------------------------------------" ++ "\nSaldo actual: " ++ show (saldo (Ext n l))

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm