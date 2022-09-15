-- Exame de programação funcional 25/01/2019

-- Exercício 1

	-- Alínea a)

isSorted :: Ord a => [a] -> Bool
isSorted [x] = True
isSorted (h:x:t)
	| h<x = isSorted (x:t)
	| otherwise = False

	-- Alínea b)

inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (init l) ++ [l]

-- Exercício 2

maximumMB :: Ord a => [Maybe a] -> Maybe a
maximumMB l = Just (maximum (catMaybes l))
	where catMaybes :: [Maybe a] -> [a]
	      catMaybes [] = []
	      catMaybes ((Just a):t) = a : catMaybes t
	      catMaybes ((Nothing):t) = catMaybes t

-- Exercício 3

data LTree a = Tip a | Fork (LTree a) (LTree a)

	-- Alínea a)

listaLT :: LTree a -> [a]
listaLT Tip x = [x]
listaLT (Fork x y) = (listaLT x) ++ (listaLT y)

	-- Alínea b)

instance Show LTree where
	show (Tip x) = show x
	show (Fork e d) = "." ++ show e ++ "\n" ++ "." ++ show d

-- Exercício 4

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit [] = 0
maxSumInit l = aux l 0
	where aux [] s = s
		  aux (h:t) s = aux t (s+h)

-- Exercício 5

type RelP a = [(a,a)]
type RelL a = [(a,[a])]
type RelF a = ([a],a->[a])

	-- Alínea a)

convPL :: (Eq a) => RelP a -> RelP a
convPL [] = []
convPL [(x,y)] = [(x,[y])]
convPL (h:t) = junta h (convPL t)
	where junta (a,b) l
		 	| elem a (map (fst) l) = map (\(c,d)->if c==a then (c,b:d) else (c,d)) l

 	-- Alínea c)

 		-- i)

convFP :: Eq a => RelF a -> RelP a
convFP (l,f) = convLP (map (\x->(x, f x)) l)

		-- ii)

convPF :: Eq a => RelP a -> RelF a
convPF l = (map (fst y) f)
	where y = convPL l
		  f a = foldl (\acc (b,c) -> if a==b then c else acc) [] y

		  