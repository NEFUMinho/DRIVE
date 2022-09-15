-- Teste de programação funcional 09/01/2017

-- Exercício 1

type MSet a = [(a,Int)]

	-- Alínea a)

cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((x,y):t) = y + cardMSet t

	-- Alínea b) 

moda :: MSet a -> [a]
moda [] = []
moda l = aux l x
	where x = maximum (map snd l)

aux :: MSet a -> Int -> [a]
aux [] _ = []
aux ((x,y):t) a 
	| y==a = x:aux t a
	| otherwise = aux t a

	-- Alínea c)

converteMSet :: MSet a -> [a]
converteMSet [] = []
converteMSet ((X,y):t) = (replicate y x) : converteMSet t

	-- Alínea d)

addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
addNcopies [] x y = [(x,y)]
addNcopies l x y = insereMSet (x,y+num x l) (removeMSet x l)

num :: a -> MSet a -> Int
num _ [] = 0
num x ((a,b):t)
	| x==a = b
	| otherwise = num x t

removeMSet :: a -> MSet a -> MSet a
removeMSet _ [] = []
removeMSet x ((a,b):t)
	| x==a && b>1 = ((a,b-1):t)
	| x==a && b==1 = t
	| otherwise = ((a,b):removeMSet x t)

insereMSet :: (a,Int) -> MSet a -> MSet a 
insereMSet (x,y) [] = [(x,y)]
insereMSet (x,y) ((a,b):t)
	| (elemMSet (x,y) ((a,b):t))==True && x==a = ((a,b+y):t)
	| (elemMSet (x,y) ((a,b):t))==True && x/=a = (a,b):insereMSet (x,y) t
	| (elemMSet (x,y) ((a,b):t))==False && y>=b = (x,y) : (a,b) : t
	| (elemMSet (x,y) ((a,b):t))==False && y<b = (a,b) : insereMSet (x,y) t

-- Exercício 3

data RTree a = R a [RTree a]

	-- Alínea b)

procura :: Eq a => a -> RTree a -> Maybe [Int]
procura x t
	| (elemt x t)==True = Just t
	| otherwise = Nothing
  where z = aux1 x t

aux1 :: Eq a => a -> RTree a -> [Int]
aux1 x (R a (y:ys))
	| (elemt x y)==True = procura x y
	| otherwise = procura x (R a ys)

elemt :: Eq a => a -> RTree a -> Bool
elemt x (R a [])
	| x==a = True
	| otherwise = False
elemt x (R a (y:ys))
	| x==a = True
	| otherwise = elemt x y || elemt x ys

