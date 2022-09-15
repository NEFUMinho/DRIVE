-- Exame de programação funcional 30/01/2017

-- Exercício 1

	-- Alínea a)

unlines :: [String] -> String
unlines (h:t) = h ++ "\n" ++ unlines t

	-- Alínea b)

(\\) :: Eq a => [a] -> [a] -> [a]
(\\) [] _ = []
(\\) l [] = l
(\\) (h:t) (x:xs)
	| elem h (x:xs)==True = (\\) t (x:xs)
	| otherwise = h : (\\) t (x:xs)

-- Exercício 2

 data Seq a = Nil | Inicio a (Seq a) | Fim (Seq a) a 

 	-- Alínea a)

primeiro :: Seq a -> a
primeiro (Inicio x n) = x
primeiro (Fim Nil a ) = a
primeiro (Fim s a) = primeiro s

	-- Alínea b) 

semUltimo :: Seq a -> Seq a
semUltimo Inicio a Nil = Nil
semUltimo Inicio a s = Inicio a (semUltimo s)
semUltimo FIm s a = s

-- Exercício 3

data BTree a = Empty | Node a (BTree a) (BTree a)

	-- Alínea a)

prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 (Node a _ _) = Empty
prune n (Node r e d) = Node r (prune (n-1) e) (prune (n-1) d)

	-- Alínea b)

semMinimo :: Ord a => BTree a -> BTree a 
semMinimo (Node r e d) = Node r (semMinimo e) d

