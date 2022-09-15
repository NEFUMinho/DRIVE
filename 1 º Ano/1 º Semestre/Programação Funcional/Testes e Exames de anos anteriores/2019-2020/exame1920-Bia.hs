-- Exame de programação funcional 25/01/2020

-- Exercício 1

	-- Alínea a)

inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (init l) ++ [l]

	-- Alínea b)

isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] [] = True
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (h:t) (x:xs)
	| h==x = isPrefixOf t xs
	| otherwise = False

-- Exercício 2

data BTree a = Empty 
			 | Node a (BTree a) (BTree a)
			 deriving Show

	-- Alínea a)

folhas :: BTree a -> Int
folhas Empty = 1
folhas (Node r e d) = (folhas e) + (folhas d)

	-- Alínea b)

path :: [Bool] -> BTree a -> [a]
path [] _ = []
path _ Empty = []
path (h:t) (Node r e d)
	| h==False = r:path t e
	| otherwise = r:path t d

-- Exercício 3

type Polinomio = [Coeficiente]
type Coeficiente = Float

	-- Alínea a)

valor :: Polinomio -> Float -> Float
valor [] _ = 0
valor l n = auxiliar l n p
	where p = xpto l

xpto :: Polinomio -> [Float]
xpto [x] = 0
xpto l = [ x | x <- [0..(length l -1)]]

auxiliar :: Polinomio -> Float -> [Float] -> Float
auxiliar [] _ _ = 0
auxiliar (y:ys) n (x:xs) = (y*n^(fromInteger x)) + (auxiliar ys n xs)

	-- Alínea b)

deriv :: Polinomio -> Polinomio
deriv [] = []
deriv l = tail (zipWith (*) l (xpto l))

	-- Alínea c)

soma :: Polinomio -> Polinomio -> Polinomio
soma [] [] = []
soma [] p = p
soma p [] = p
soma p1 p2 = zipWith (+) p1 p2 

-- Exercício 4

	-- Alínea a)

quebraLinha :: [Int] -> [a] -> [[a]]
quebraLinha [] l = l
quebraLinha _ [] = []
quebraLinha (a:as) (x:xs) = (take a (x:xs)) : quebraLinha as (drop a (x:xs))