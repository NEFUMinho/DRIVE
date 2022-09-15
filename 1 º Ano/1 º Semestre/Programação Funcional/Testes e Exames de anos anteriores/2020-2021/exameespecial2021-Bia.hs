-- Exame de época especial de programação funcional 23/06/2021

-- Exercício 1

	-- Alínea a)

posImpares :: [a] -> [a]
posImpares [] = []
posImpares [x] = []
posImpares (h:x:t) = x : posImpares t

	-- Alínea b)

isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (h:t) (x:xs)
	| h==x = isPrefixOf t xs
	| otherwise = False

-- Exercício 2

type Mat a = [[a]]

	-- Alínea a)

zeros :: Num a => Mat a -> Int
zeros [] = 0
zeros (h:t) = (aux 0 h) + sum (map aux t)
	where aux z [] = z
		  aux z (x:xs)
		  	| x==0 = aux (z+1) xs
		  	| otherwise = aux z xs

	-- Alínea b)

addMat :: Num a => Mat a -> Mat a -> Mat a
addMat [] [] = []
addMat m1 [] = m1
addMat [] m2 = m2
addMat (h:t) (x:xs) = (zipWith (+) h x) : addMat t xs

	-- Alínea c)

transpose :: Mat a -> Mat a
transpose [] = []
transpose l = (map head l) : transpose (map tail l)

-- Exercício 3

data BTree a = Empty | Node a (BTree a) (BTree a)

	-- Alínea a)

replace :: Eq a => BTree a -> a -> a -> BTree a
replace Empty _ _ = Empty
replace (Node r e d) x y
	| r==x = Node y (replace e x y) (replace d x y)
	| otherwise = Node r (replace e x y) (replace d x y)

	-- Alínea b)

insere :: Integer -> String -> BTree (Int,String) -> BTree (Int,String)
insere x n Empty = Node (x,n) Empty Empty
insere x n (Node (a,b) e d)
	| x==a = Node (a,n) e d
	| x<a = Node (a,b) (insere x n e) d
	| otherwise = Node (a,b) e (insere x n d)

