-- Teste de programação funcional 10/01/2018

-- Exercício 1

insert :: Ord a => a -> [a] -> [a]
insert a [] = [a]
insert x (h:t)
	| x<=h = x:h:t
	| otherwise = h:insert x t

-- Exercício 2

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes ((Just x):t) = x:catMaybes t
catMaybes ((Nothing):t) = catMaybes t

-- Exercício 3

data Exp a = Const a
		   | Var String
		   | Mais (Exp a) (Exp a)
		   | Mult (Exp a) (Exp a)

instance Show Exp where
	show (Const a) = show a
	show (Var a) = a
	show (Mais x y) = "(" ++ show x ++ "+" ++ show y ++ ")"
	show (Mult x y) = "(" ++ show x ++ "*" ++ show y ++ ")"

-- Exercício 4

sortOn :: Ord b => (a->b) -> [a] -> [a]
sortOn f [] = []
sortOn f (h:t) = (insere f h) : (sortOn f t)
	where insere f x [] = [x]
		  insere f x (h:t)
		  		| f x > f h = h : insere f x t
		  		| otherwise = x : h : t

-- Exercício 5

	-- Alínea a)

		-- Versão 1

amplitude1 :: [Int] -> Int
amplitude1 [] = 0
amplitude1 l = max - min
	where (max,min) = foldr (\(a,b) n -> (if n>a then n else a, if n<b then n else b)) (head l, head l) l 

		-- Versão 2

amplitude2 :: [Int] -> Int
amplitude2 [] = 0
amplitude2 l = max l - min l
	where (max,min) = aux (0,0) l
		  aux (x,y) [] = (x,y)
		  aux (x,y) (h:t)
		  	| h>x = aux (h,y) t
		  	| h<y = aux (x,h) t
		  	| otherwise = aux (x,y) t

-- Exercício 6

data Imagem = Quadrado Int
			| Mover (Int,Int) Imagem 
			| Juntar [Imagem]

	-- Alínea a)

conta :: Imagem -> Int
conta (Quadrado _ ) = 1
conta (Mover (_,_) i) = conta i
conta (Juntar l) = sum (map (conta) l)

