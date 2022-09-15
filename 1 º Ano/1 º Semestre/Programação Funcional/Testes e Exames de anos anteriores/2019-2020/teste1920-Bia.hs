-- Teste final de programação funcional 11/01/2020

-- Exercício 1

	-- Alínea a)

intersect :: Eq a => [a] -> [a] -> [a]
intersect [] _ = []
intersect _ [] = []
intersect (h:t) (x:xs)
	| elem h (x:xs)==True = h:intersect t (x:xs)
	| otherwise = intersect t (x:xs)

	-- Alínea b)

tails :: [a] -> [[a]]
tails [] = [[]]
tails (h:t) = (h:t) : tails t

-- Exercício 2

type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

	-- Alínea a)

elems :: ConjInt -> [Int]
elems [] = []
elems ((x,y):t) = (enumFromTo x y) ++ elems t
	where enumFromTo :: Int -> Int -> [Int]
	      enumFromTo x y
	      	| x==y = [x]
	      	| otherwise = x:enumFromTo (x+1) y

  	-- Alínea b)

geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj (h:x:t)
	| x==h+1 = (h,geraconj (x:t)):geraconj t
	| otherwise = (h,h) : geraconj (x:t)

-- Exercício 3

data Contacto = Casa Integer
			  | Trab Integer
			  | Tlm Integer
			  | Email String
		  deriving Show

type Nome = String
type Agenda = [(Nome,[Contacto])]

	-- Alínea a) 

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n e [] = [(n,[Email e])]
acrescEmail n e ((x,y):t)
	| n==x = (x,y++[Email e]):t
	| otherwise = (x,y):acrescEmail n e t

	-- Alínea b)

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((x,y):t)
	| n==x = Just (emails y)
	| otherwise = verEmails n t
  where emails :: [Contacto] -> [String]
        emails [] = []
        emails (h:t)
        	| h==Email e = e:emails t
        	| otherwise = emails t

	-- Alínea c)

consulta :: [Contacto] -> ([Integer],[String])
consulta [] = ([],[])
consulta l = aux l ([],[])
	where aux [] (x,y) = (x,y)
	      aux (h:t) (x,y)
	      	| h==Casa c = aux t (x++[c],y)
	      	| h==Tlm n = aux t (x++[n],y)
	      	| h==Email e = aux t (x,y++[e])
	      	| otherwise = aux t (x,y)

-- Exercício 4

data RTree a = R a [RTree a]
     deriving (Show,Eq)

	-- Alínea a)

paths :: RTree a -> [[a]]
paths R a [] = [a]
paths R r t = r : map (paths) t


