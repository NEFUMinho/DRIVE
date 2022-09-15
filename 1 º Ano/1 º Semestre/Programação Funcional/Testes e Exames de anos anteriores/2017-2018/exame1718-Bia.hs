-- Exame de programação funcional 30/01/2018

-- Exercício 1

(!!) :: [a] -> Int -> a
(!!) (h:t) n
	| n==0 = h
	| otherwise = (!!) t (n-1)

-- Exercício 2

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (h:t)
	| h==Norte = posicao (x,y+1) t
	| h==Sul = posicao (x,y-1) t
	| h==Este = posicao (x+1,y) t
	| h==Oeste = posicao (x-1,y) t

-- Exercício 3

any :: (a->Bool) -> [a] -> Bool
any f [] = False
any f (h:t) | f h == True = True
            | otherwise = any f t 

-- Exercício 4

type Mat a = [[a]]

triSup :: Num a => Mat a -> Bool
triSup [] = False
triSup l = aux l 0
	where aux [] ac = True
	      aux (h:t) ac
	      	| contazeros h >= ac = aux t (ac+1)
	      	| otherwise = False

-- Exercício 6

data Imagem = Quadrado Int
            | Mover (Int,Int) Imagem
            | Juntar [Imagem]

    -- Alínea a)

vazia :: Imagem -> Bool 
vazia Quadrado _ = False
vazia Mover (_,_) i = vazia i
vazia Juntar l
	| l==[] =True
	| otherwise = if (any (==False) (map vazia l)) then False else True

	-- Alínea b)

maior :: Imagem -> Maybe Int
maior i = Just (maximum (largura i))

largura :: Imagem -> [Int]
largura Quadrado x = [x]
largura Mover (_,_) i = largura i
largura Juntar (h:t)
	| null (h:t) = []
	| otherwise = largura h ++ largura (Juntar t)

