import Data.Char 
--1
--a)
any' :: (a->Bool) -> [a] -> Bool 
any'p []     = False 
any' p (h:t) | p h = True 
             | otherwise = any' p t 

--b
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] _ = [] 
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith f xs ys 
-- > *Main> zipWith' (+) [1,2,3] [1,2,3]
-- [2,4,6]
--Main>  zipWith' (++) ["aa" , "bb"] ["cc","dd"]
-- ["aacc","bbdd"]

--c)
takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' _ []    = []
takeWhile' p (h:t) = if p h then h : takeWhile' p t 
                     else []
-- *Main> takeWhile (>0) [1,-2,1,3,4-5]
-- [1]
-- *Main> takeWhile (>0) [-1,-2,-3]
-- []
-- *Main> takeWhile (>0) [-1,-2,3,4]
-- []
-- *Main> takeWhile' (>0) [1,2,3,-1]
-- [1,2,3]

--d)
dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' p [] = []
dropWhile' p (h:t) | p h       = dropWhile' p t 
                   | otherwise = h:t

--e)
span' :: (a->Bool) -> [a] -> ([a] , [a])
span' p l = (takeWhile' p l , dropWhile' p l ) 

span'' p []    = ([],[])
span'' p (h:t) | p h = (h: lt,lp)
               | otherwise = ([],h:t)
  where (lt,lp) = span'' p t 

--f)
deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy _ _ [] = []
deleteBy f v (h:t) = if f v h then t 
                     else h : deleteBy f v t 
-- pedir ao rafa o f
-- ex 3

type Mat a = [[a]]

m :: Mat Int
m = [ [1,2,3]
    , [0,4,5]
    , [0,0,6]
    ]
--a)
dimOk :: Mat a -> Bool 
dimOk m = let ncls = length (head m)
          in dimOk' m ncls 
-- ncls -> nº de colunas
dimOk' m cls = and (map f m) 
   where f l = length l == cls 

-- *Main> dimOk m
-- True
-- *Main> dimOk ([1,2,3,4]:m)
-- False

--b (x,y)
dimMat :: Mat a -> (Int,Int)
dimMat [] = (0,0)
dimMat (l:ls) = (length l, length (l:ls))

-- *Main> dimMat m
-- (3,3)
-- *Main> dimMat ([1,2,3]:m)
-- (3,4)

--c
addMat :: Num a => Mat a -> Mat a -> Mat a
addMat [] [] = []
addMat (l1:l1s) (l2:l2s) = zipWith' (+) l1 l2 
                            : addMat l1s l2s 
-- m+m
-- l1 == [1,2,3]
-- l2 == [1,2,3]
-- res == [2,4,6]
-- *Main> zipWith' (+) [1,2,3] [1,2,3]
-- [2,4,6]
-- *Main> addMat m m
-- [[2,4,6],[0,8,10],[0,0,12]]
-- *Main> addMat m [[1,1,1], [2,2,2] , [3,3,3]]
-- [[2,3,4],[2,6,7],[3,3,9]]

--d
transpose' :: Mat a -> Mat a
transpose' [] = []
transpose' m | null (head m) = []
             | otherwise = primeiraColuna m :
                ( transpose' (restantesColunas m ))

{-- m' = [[2,3]
       , [4,5]
       , [0,6]
       ] --}

primeiraColuna :: Mat a -> [a]
primeiraColuna m = map head m 

-- *Main> primeiraColuna m
-- [1,0,0]

restantesColunas m = map tail m 

-- *Main> transpose' m
-- [[1,0,0],[2,4,0],[3,5,6]]

--e
multMat :: Num a => Mat a -> Mat a -> Mat a
multMat m n = mulMat' m (transpose' n)

mulMat' [] _ = []
mulMat' _ [] = []
mulMat' (l1:l1s) nt =  multlinha l1 nt 
                         : mulMat' l1s nt 
multlinha l [] = []
multlinha l (h:t) = (sum (zipWith (*) l h))
                     : multlinha l t                        

{-
m = [ [1,2,3]   [1,2,3]
    , [0,4,5]   [0,4,5]
    , [0,0,6]   [0,0,6]
    ]
m * m

[1,2,3] * [1,0,0] = sum (zipWith (*) [1,2,3] [1,0,0]) 
[1,2,3] * [2,4,0] = 10 

mm = [[1,10,...]] -}

