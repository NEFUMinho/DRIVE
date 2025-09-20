{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
import Data.Char
--ex1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Data.Time.Format.ISO8601 (yearFormat)


data Frac = F Integer Integer

normalizafrac :: Frac -> Frac
normalizafrac (F x y)
    | y < 0 = normalizafrac (F (-x) (-y))
    | otherwise = F (div x (mdc x y)) (div y (mdc x y))

mdc :: Integer -> Integer -> Integer
mdc 0 y = y
mdc x 0 = x
mdc x y
    | y == x = x
    | y > x = aux_mdc x x y
    | otherwise = aux_mdc y x y

aux_mdc :: Integer -> Integer -> Integer -> Integer
aux_mdc n x y
    | mod x n == 0 && mod y n == 0 = n
    | otherwise = aux_mdc (n-1) x y 

instance Eq Frac where
    (==) :: Frac -> Frac -> Bool  
    (==) f1 f2 = x1 == x2 && y1 == y2
        where F x1 y1 = normalizafrac f1
              F x2 y2 = normalizafrac f2

instance Ord Frac where
    (<=) :: Frac -> Frac -> Bool
    (<=) f1 f2 = x1*y2 <= x2*y1
        where F x1 y1 = normalizafrac f1
              F x2 y2 = normalizafrac f2

instance Show Frac where
    show :: Frac -> String
    show (F x y) = "(" ++ show x ++ "/" ++ show y ++ ")"

instance Num Frac where
    (+) :: Frac -> Frac -> Frac
    (+) f1 f2 = normalizafrac (F (x1*y2+x2*y1) (y2*y1))
        where F x1 y1 = normalizafrac f1
              F x2 y2 = normalizafrac f2
    
    (-) :: Frac -> Frac -> Frac
    (-) f1 f2 = normalizafrac (F (x1*y2-x2*y1) (y2*y1))
        where F x1 y1 = normalizafrac f1
              F x2 y2 = normalizafrac f2

    (*) :: Frac -> Frac -> Frac
    (*) f1 f2 = normalizafrac (F (x1*x2) (y2*y1))
        where F x1 y1 = normalizafrac f1
              F x2 y2 = normalizafrac f2

    negate :: Frac -> Frac
    negate (F x y) = normalizafrac (F (-x) y)

    abs :: Frac -> Frac
    abs f1 = F (abs x1) (abs y1)
        where F x1 y1 = normalizafrac f1

    signum :: Frac -> Frac
    signum f1 = F (signum x1) y1
        where F x1 y1 = normalizafrac f1

    fromInteger :: Integer -> Frac
    fromInteger x = F x 1


alinea_f :: Frac -> [Frac] -> [Frac]
alinea_f f1 [] = []
alinea_f f1 lf = filter (>2*f1) lf

--ex2

data Exp a = Const a
    | Simetrico (Exp a)
    | Mais (Exp a) (Exp a)
    | Menos (Exp a) (Exp a)
    | Mult (Exp a) (Exp a)

instance Show a => Show (Exp a) where
    show :: Exp a -> String
    show (Const x) = show x
    show (Simetrico x) = "(-" ++ show x ++ ")"
    show (Mais x y) = "(" ++ show x ++ "+" ++ show y ++ ")"
    show (Menos x y) = "(" ++ show x ++ "-" ++ show y ++ ")"
    show (Mult x y) = "(" ++ show x ++ "*" ++ show y ++ ")"

calculaExp :: Num a => Exp a -> a
calculaExp (Const x) = x
calculaExp (Simetrico x) = negate (calculaExp x)
calculaExp (Mais x y) = calculaExp x + calculaExp y
calculaExp (Menos x y) = calculaExp x - calculaExp y
calculaExp (Mult x y) = calculaExp x * calculaExp y

instance (Num a , Eq a) => Eq (Exp a) where
    (==) :: (Num a, Eq a) =>Exp a -> Exp a -> Bool
    (==) x y = calculaExp x == calculaExp y


instance (Ord a , Num a ) => Num (Exp a) where
    (+) :: Num a => Exp a -> Exp a -> Exp a
    (+) x y = Mais x y
    
    (-) :: Num a => Exp a -> Exp a -> Exp a
    (-) x y = Menos x y

    (*) :: Num a => Exp a -> Exp a -> Exp a
    (*) x y = Mult x y 

    negate :: Exp a -> Exp a
    negate (Simetrico x)= x
    negate x = Simetrico x

    abs :: Exp a -> Exp a 
    abs x = if calculaExp x >= 0
            then x
            else Simetrico x

    signum :: Num a => Exp a -> Exp a
    signum x = Const (signum a) where a = calculaExp x

    fromInteger :: Num a => Integer -> Exp a
    fromInteger x = Const (fromInteger x)


--ex3

data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

creDeb1 :: Extracto -> (Float,Float)
creDeb1 (Ext saldo []) = (0,0)
creDeb1 (Ext saldo ((date, descricao, Credito x):t)) = (x+c,d)
    where (c,d) = creDeb1 (Ext saldo t)
creDeb1 (Ext saldo ((date, descricao, Debito x):t)) = (c,x+d)
    where (c,d) = creDeb1 (Ext saldo t) --ficha3


saldo1 :: Extracto -> Float
saldo1 (Ext saldo []) = saldo
saldo1 (Ext s x) = s + c - d
    where (c,d) = creDeb1 (Ext s x) --ficha3

instance Eq Data where
    (==) :: Data -> Data -> Bool
    (==) (D d1 m1 a1) (D d2 m2 a2) = a2 == a1 && m2 == m1 && d2 == d1
    
instance Ord Data where
    compare :: Data -> Data -> Ordering
    compare (D d1 m1 a1) (D d2 m2 a2)
        | a2 > a1 = LT
        | a2 == a1 && m2 > m1 = LT
        | a2 == a1 && m2 == m1 && d2 > d1 = LT
        | a2 == a1 && m2 == m1 && d2 == d1 = EQ
        | otherwise = GT

instance Show Data where
    show :: Data -> String
    show (D d m a) = show a ++ "/" ++ show m ++ "/" ++ show d

ordenaExt :: Extracto -> Extracto
ordenaExt (Ext s []) = Ext s []
ordenaExt (Ext s x) = Ext s (aux_ordena x)

aux_ordena :: Ord a => [(a, b, c)] -> [(a, b, c)]
aux_ordena [] = []
aux_ordena [x] = [x]
aux_ordena ((date,descricao,mov):t) = if date <= date2 
                                      then (date,descricao,mov):(date2,descricao2,mov2):t2 
                                      else (date2,descricao2,mov2): aux_ordena ((date,descricao,mov):t)  
                                        where (date2,descricao2,mov2):t2 = aux_ordena t



instance Show Movimento where
    show :: Movimento -> String
    show (Credito x) = show x ++ "      "
    show (Debito x) = "      " ++ show x

{- instance Show Extracto where
    show :: Extracto -> String -}
   --- show (Ext saldo []) = "Saldo anterior: " ++ show saldo ++ "\n" 
      --  ++ "------------------------------------------------" ++ "\n"
      --  ++ "Data       Descricao      Credito        Debito" ++ "\n"
      --  ++ "------------------------------------------------" ++ "\n" ++
      --  ++ "------------------------------------------------" ++ "\n"
      --  ++ "Saldo atual: " ++ show saldo
   -- show (Ext saldo [(date,descricao,mov)]) = "Saldo anterior: " ++ show saldo ++ "\n" 
     --   ++ "------------------------------------------------" ++ "\n"
       -- ++ "Data       Descricao      Credito        Debito" ++ "\n"
       -- ++ "------------------------------------------------" ++ "\n"
       -- ++ show date ++ " " ++ map toUpper descricao ++ "     " ++ show mov ++ "\n"
       -- ++ "------------------------------------------------" ++ "\n"
       -- ++ "Saldo atual: " ++ show (saldo1 (Ext saldo [(date,descricao,mov)]))
    {- show ext = "Saldo anterior: " ++ show saldo ++ "\n" 
        ++ "------------------------------------------------" ++ "\n"
        ++ "Data       Descricao      Credito        Debito" ++ "\n"
        ++ "------------------------------------------------" ++ "\n"
        ++ show date ++ "     " ++ map toUpper descricao ++ "     " ++ show mov ++ "\n"
        ++ show t ++ "\n"
        ++ "------------------------------------------------" ++ "\n"
        ++ "Saldo atual: " ++ show (saldo1 (Ext saldo ((date,descricao,mov):t)))
            where (Ext saldo ((date,descricao,mov):t)) = ordenaExt ext -}

instance Show Extracto where
    show :: Extracto -> String
    show ext = "Saldo anterior: " ++ show n ++
               "\n---------------------------------------" ++
               "\nData       Descricao" ++ replicate (desc_max - 9) ' ' ++ "Credito" ++ replicate (cred_max - 7) ' ' ++ "Debito" ++
               "\n---------------------------------------\n" ++
               unlines (map (\(dat,desc,mov) -> 
                    show dat ++ replicate (data_max - length (show dat)) ' ' 
                    ++ map toUpper desc ++ replicate (desc_max - length desc) ' ' 
                    ++ case mov of Credito quant -> show quant ++ replicate (cred_max - length (show quant)) ' '; Debito _ -> replicate cred_max ' '
                    ++ case mov of Debito quant -> show quant; Credito _ -> ""
               ) movs) ++
               "---------------------------------------" ++
               "\nSaldo actual: " ++ show (saldo1 ext)
        where (Ext n movs) = ordenaExt ext
              data_max = 11
              desc_max = max (length "Descricao   ") (maximum $ map (\(_,desc,_) -> length desc) movs)
              cred_max = max (length "Credito   ") (maximum $ map (\(_,_,mov) -> case mov of Credito x -> length (show x); _ -> 0) movs)











    
        
