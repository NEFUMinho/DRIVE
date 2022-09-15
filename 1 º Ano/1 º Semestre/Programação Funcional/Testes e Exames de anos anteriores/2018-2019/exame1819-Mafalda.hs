import Data.String

--1
isSorted :: (Ord a) => [a] -> Bool
isSorted [] = True
isSorted [h,t] = h<t
isSorted (h:t) = h< (head t) && isSorted t 

--1
inits :: [a] -> [[a]] 
inits [] = [[]]
inits l1 = acumulador1 l1 [] 
 where acumulador1 :: [a] -> [a] -> [[a]]
       acumulador1 [] l = [l]
       acumulador1 (x:xs) l2 = [l2] ++ acumulador1 xs (l2 ++ [x])
       
--2
ex = [Nothing, Just 2, Just 3,Nothing]

--maximumMB :: (Ord a) => [Maybe a] -> Maybe a
--maximumMB [] = Nothing 
--maximumMB [Nothing] = Nothing
--maximumMB [Just a] = Just a 
--maximumMB l1 = acumulador (tail l1) (head l1)
-- where acumulador :: (Eq a, Ord a) => [Maybe a] -> Maybe a -> Maybe a 
--       acumulador [] c = c
--       acumulador [Nothing] c = c
--       acumulador (Just a:xs) Nothing = acumulador xs (Just a)
--       acumulador (Just a:xs) (Just b)
--        | (Just b) > (Just a) = acumulador xs (Just b)
--        | otherwise = acumulador xs (Just a)
--

maximumMB :: (Ord a) => [Maybe a] -> Maybe a
maximumMB l | (lm l) /= [] = Just ( maximum (lm l))
            | otherwise = Nothing
                 where lm ::(Ord a) => [Maybe a] -> [a] 
                       lm [] = []
                       lm [Nothing] = []
                       lm [Just a] = [a]
                       lm (Nothing:xs) = lm xs 
                       lm (Just a :xs) = a : lm xs 

--3
data LTree a = Tip a | Fork (LTree a) (LTree a)

lt :: Num a => LTree a 
lt =  Fork (Fork (Tip 7) (Tip 1)) (Tip 2)

ltt :: Num a => LTree a 
ltt =Fork (Fork (Fork (Tip 7) (Tip 1)) (Tip 2)) (Tip 5)

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork a b) = listaLT a ++ listaLT b 

instance (Show a) => Show (LTree a) where 
 show (Tip x) = show x ++ ['\n']
 show (Fork a b) = "." ++ show a ++ "." ++ show b

 
--4
maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l1 = acumulador2 (inits l1) 0
 where acumulador2 :: (Num a, Ord a) => [[a]] -> a -> a 
       acumulador2 [] a = a       
       acumulador2 (x:xs) a | (sum x) > a = acumulador2 xs (sum x) 
                            | otherwise = acumulador2 xs a 

--5
type RelP a = [(a,a)]
type RelL a = [(a,[a])]
type RelF a = ([a], a->[a])

convPL :: (Eq a) => RelP a -> RelL a
convPL [] = []
convPL [(a,b)] = [(a,[b])]
convPL (x:xs) = [(fst x, map snd (filter (\(a,b) -> a == (fst x)) (x:xs)))] ++ convPL (filter (\(a,b) -> a /= (fst x)) (x:xs)) 

--convFP :: (Eq a) => RelF a -> RelP a
--convFP 








