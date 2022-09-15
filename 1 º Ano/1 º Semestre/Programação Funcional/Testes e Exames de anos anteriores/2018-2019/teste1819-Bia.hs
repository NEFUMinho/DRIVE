-- Teste de programação funcional 05/01/2019

-- Exercício 1

	-- Alínea a)

		-- Versão 1

elemIndices1 :: Eq a => a -> [a] -> [Int]
elemIndices1 _ [] = []
elemIndices1 a (x:t)
	| a==x = 0 : map (+1) (elemIndices1 a t)
	| otherwise = map (+1) (elemIndices1 a t)

		-- Versão 2

elemIndices2 :: Eq a => a -> [a] -> [Int]
elemIndices2 _ [] = []
elemIndices2 n l = aux n l []

aux :: Eq a => a -> [a] -> [a] -> [Int]
aux _ [] l = l
aux n (h:t) ac
	| n==h = ac : aux n t (ac+1)
	| otherwise = aux n t (ac+1)

	-- Alínea b)

isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (h:t) (x:xs)
	| h==x = isSubsequenceOf t xs
	| otherwise = isSubsequenceOf (h:t) xs

-- Exercício 2

data BTree a = Empty | Node a (BTree a) (BTree a)

	-- Alínea a)

lookupAP :: Ord a => a -> BTree (a,b) -> Maybe b
lookupAP _ Empty = Nothing
lookupAP a (Node (x,y) e d)
	| a==x = Just y
	| a<x = lookupAP a e
	| otherwise = lookupAP a d

	-- Alínea b)

zipWithBT :: (a->b->c) -> BTree a -> BTree b -> BTree c
zipWithBT f Empty _ = Empty
zipWithBT f _ Empty = Empty
zipWithBT f (Node r1 e1 d1) (Node r2 e2 d2) = Node (f r1 r2) (zipWithBT f e1 e2) (zipWithBT f d1 d2)

-- Exercício 3

digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha l = aux1 l ([],[])
	where aux1 [] (x,y) = (x,y)
		  aux1 (h:t) (x,y)
		  	| (isAlpha h)==True = aux1 t (x++[h],y)
		  	| otherwise = aux1 t (x,y++[h])

-- Exercício 4

data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)

	-- Alínea a)  

firstSeq :: Seq a -> a
firstSeq (Cons a _ ) = a
firstSeq (App Seq x Seq y) = firstSeq x
firstSeq (App Nil Seq y) = firstSeq y

