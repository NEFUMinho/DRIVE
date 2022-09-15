module Ficha5 where

--1
--a
any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (h:t) = if f h then True else any' f t
--b
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (h:t) (x:y) = (f h x):zipWith' f t y
--c
takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (h:t) = if f h then h:takeWhile' f t else []
--d
dropWhile' :: (a->Bool) -> [a] -> [a] 
dropWhile' f [] = []
dropWhile' f (h:t) = if f h then dropWhile' f t else (h:t)
--e
span' :: (a-> Bool) -> [a] -> ([a],[a])
span' f [] = ([],[])
span' f l = aux f l ([],[])
 where aux f [] x = x
       aux f (h:t) (x,y) = if f h then aux f t (x++[h],y) else (x,(h:t)) 
--f????????????????????????????????????????????????????????????
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f n [] = []
deleteBy' f n (h:t) = if f n h then t else h:deleteBy' f n t
--g
sortOn :: Ord b => (a -> b) -> [a] -> [a]
sortOn f [] = []
sortOn f (h:t) = insert f h (sortOn f t)
 where insert f h [] = [h]
       insert f h (x:t) = if (f h)>(f x) then x:(insert f h t) else h:x:t 
--2
type Polinomio = [Monomio] 
type Monomio = (Float,Int)
p=[(2.0,3), (3.0,4), (5.0,3), (4.0,5)]
--a
selgrau :: Int -> Polinomio -> Polinomio
selgrau n l = filter (\x -> snd x==n) l
--b
conta :: Int -> Polinomio -> Int
conta n l = length(selgrau n l)
--c
grau :: Polinomio -> Int 
grau [] = 0
grau l = maximum [snd x|x<-l]
--d
deriv :: Polinomio -> Polinomio
deriv p = [(x*fromIntegral y,y-1)|(x,y)<-p]
--e
calcula :: Float -> Polinomio -> Float 
calcula n p = sum [x*n^y|(x,y)<-p]
--f
simp :: Polinomio -> Polinomio 
simp p = [(x,y)|(x,y)<-p,y/=0]
--g
mult :: Monomio -> Polinomio -> Polinomio 
mult m [] = []
mult (x,y) l = map (\(b,e)->(b*x,y+e)) l
--h
ordena :: Polinomio -> Polinomio
ordena p = sortOn snd p
--3
type Mat a = [[a]] 
--a
dimOK :: Mat a -> Bool 
dimOK [] = True
dimOK [x,y] = length x == length y
dimOK (h:x:t) = length h == length x && dimOK (x:t)
--b
dimMat :: Mat a -> (Int,Int) 
dimMat [] = (0,0)
dimMat (h:t) = (length (h:t),length h)
--c
addMat :: Num a => Mat a -> Mat a -> Mat a 
addMat [] _ = []
addMat _ [] = []
addMat (p1:r) (p2:t) = (zipWith (+) p1 p2):addMat r t
--d
{-transpose :: Mat a -> Mat a
transpose ([x]:t) = [[x]++[transpose t]]
transpose l = [head x|x<-l]:transpose [tail x|x<-l]-}
--e
multMat :: Num a => Mat a -> Mat a -> Mat a 
multMat [] _ = []
multMat _ [] = []
multMat (h:t) (x:y) = sum(zipWith (*) h x)++(multMat t y)