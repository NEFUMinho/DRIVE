-- Exame de época especial de programação funcional 11/09/2020

-- Exercício 1

	-- Alínea a)

subst :: Eq a => (a,a) -> [a] -> [a]
subst ( _ , _ ) [] = []
subst (x,y) (h:t)
	| x==h = y : subst (x,y) t
	| otherwise = h : subst (x,y) t

	-- Alínea b)

posicoes :: [a] -> [Int] -> [a]
posicoes [] _ = []
posicoes _ [] = []
posicoes (h:t) (x:xs) = (aux1 (h:t) x) : (posicoes (h:t) xs)

aux1 :: [a] -> Int -> a
aux1 (h:t) x 
	| x==1 = h
	| otherwise = aux1 t (x-1)

-- Exercício 2

data Tree a b = Leaf b | Node a (Tree a b) (Tree a b)

	-- Alínea a)

folhas :: Tree a b -> [b]
folhas (Leaf x) = [x]
folhas (Node r e d) = (folhas e) ++ (folhas d)

	-- Alínea b)

somas :: Tree Float Int -> (Float,Int)
somas (Leaf b) = (0,b)
somas b = foldr (\(x,y) -> (contaNodos b, sum (folhas b))) (0,0) b
	where contaNodos (Leaf _ ) = 0
		  contaNodos (Node r e d) = r + contaNodos e + contaNodos d

-- Exercício 3

type Mat a = [[a]]

		-- Versão 1

rotateLeft1 :: Mat a -> Mat a
rotateLeft1 [] = []
rotateLeft1 l = (rotateLeft1 (map tail l)) ++ [map head l]

		-- Versão 2

rotateLeft2 :: Mat a -> Mat a
rotateLeft2 [] = []
rotateLeft2 m = reverse (transpose m)
	where transpose :: Mat a -> Mat a
		  transpose [] = []
		  transpose l = (map head l) : transpose (map tail l)

-- Exercício 4

type Filme = (Titulo,Realizador,[Actor],Genero,Ano)
type Titulo = String
type Realizador = String
type Actor = String
type Ano = Int

data Genero = Comedia | Drama | Ficcao | Accao | Animacao | Documentario
	deriving Eq

type Filmes = [Filme]

	-- Alínea a)

doRealizador :: Filmes -> Realizador -> [Titulo]
doRealizador [] _ = []
doRealizador ((t,r,_,_,_):t) n
	| n==r = t : doRealizador t n
	| otherwise = doRealizador t n

	-- Alínea b)

doActor :: Filmes -> Actor -> [Titulo]
doActor [] _ = []
doActor ((t,_,l,_,_):t) n
	| elem n l == True = t : doActor t n
	| otherwise = doActor t n

	-- Alínea c)

aux :: Filme -> (Ano,Titulo)
aux (t,_,_,_,a) = (a,t)
aux ((t,_,_,_,a):t) = (a,t) : aux t


