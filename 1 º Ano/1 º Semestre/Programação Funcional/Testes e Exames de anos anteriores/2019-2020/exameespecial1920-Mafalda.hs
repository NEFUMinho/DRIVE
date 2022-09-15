import Data.String
--1
--subst :: Eq a => (a,a) -> [a] -> [a]
--subst _ [] = []
--subst (a,b) (x:xs) | x==a = b : subst (a,b) xs
--                   | otherwise = x : subst (a,b) xs 

subst :: Eq a => (a,a) -> [a] -> [a]
subst _ [] = []
subst (a,b) l = acumulador (a,b) l []
 where acumulador :: Eq a => (a,a) -> [a] -> [a] -> [a]
       acumulador (a,b) [] c = c 
       acumulador (a,b) (x:xs) c | a==x = acumulador (a,b) xs (c ++ [b])
                                 | otherwise = acumulador (a,b) xs (c ++ [x]) 

posicoes:: [a] -> [Int] -> [a] 
posicoes [] l2 = []
posicoes l1 [] = []
posicoes l1 l2 = (acumulador1 l1 (head l2) 1) ++ (posicoes l1 (tail l2))
 where acumulador1 :: [a] -> Int -> Int -> [a]
       acumulador1 [] d n = []
       acumulador1 (x:xs) y n | y==n = [x]
                                   | otherwise = acumulador1 xs y (n+1)

--posicoes l1 l2 = (head (drop ((head l2) -1)l1)) ++ posicoes l1 (tail l2)

--2
data Tree a b = Leaf b | Node a (Tree a b) (Tree a b)

ex :: (Num a, Num b) => Tree a b 
ex = Node 7 (Node 2 (Leaf 4) (Leaf 2))
           (Node 3 (Node 1 (Leaf 1) (Leaf 3))
                   (Node 10 (Leaf 2) (Leaf 8)))

folhas :: Tree a b -> [b]
folhas (Leaf x) = [x]
folhas (Node a l1 l2) = folhas l1 ++ folhas l2


--somas :: Tree Float Int -> (Float,Int)
--somas (Leaf x) = (0,x)
--somas lt = foldl aux (0,0) lt
-- where aux :: (Float, Int) -> Tree Float Int -> (Float, Int)
--       aux (a,b) (Leaf x) = (a, b+x)
--       aux (a,b) (Node y e d) = aux2 ((aux (a+y,b) e) (aux (a+y,b) d))
--              where aux2 :: (Float,Int) -> (Float, Int) -> (Float,Int)
--                    aux2 (a,b) (c,d) = (a+c, b+d)

--3

--4
type Filme = (Titulo,Realizador,[Actor],Genero,Ano)
type Titulo = String
type Realizador = String
type Actor = String
type Ano = Int

data Genero = Comedia | Drama | Ficcao | Accao | Animacao | Documentario
                            deriving Eq
type Filmes = [Filme]

filmes :: Filmes 
filmes = [("Cinderela","Mickey",["Principe", "Madrasta"],Animacao,97),
          ("KingsMan","Homem",["Principe", "Alfaiate"],Accao,97),
          ("Mulan","Mickey",["Chinesa", "Dragao"],Animacao,98)]

doRealizador :: Filmes -> Realizador -> [Titulo]
doRealizador [] _ = []
doRealizador ((t, r, a, g, y):xs) n | r == n = t: doRealizador xs n 
                                    | otherwise = doRealizador xs n 

doActor :: Filmes -> Actor -> [Titulo]
doActor [] _ = []
doActor ((t,r,[],g,y):xs) c = doActor xs c 
doActor ((t, r, (a:b), g, y):xs) c 
 | a==c  = t : doActor xs c
 | otherwise = doActor ((t,r,b,g,y):xs) c 
 
consulta :: Filmes -> Genero -> Realizador -> [(Ano, Titulo)]
consulta bd gen rea = map aux (filter (teste gen rea) bd)
 where teste :: Genero -> Realizador -> Filme -> Bool
       teste g r (_,x,_,y,_) = g==y && r==x
       aux :: Filme -> (Ano, Titulo)
       aux (t, r, a, g, y) = (y,t)

--5
data Avaliacao = NaoVi
                 | Pontos Int        -- pontuação entre 1 e 5
                 
type FilmesAval = [(Filme,[Avaliacao])]

--avalia :: FilmesAval -> IO FilmesAval
--avalia fa = do putStr "Escreva o nome do filme assistido:"
--               nome <- getLine 
--               putStr "Quantos pontos quer atribuir a este filme de 1 a 5?"
--               y <- getChar 
--               aval -> read y :: Int
--               return (aux nome y fa) 

aux :: String -> Int -> FilmesAval -> FilmesAval
aux n a [] = []
aux n x (((t,r,a,g,y),l):xs) | n==t = (((t,r,a,g,y),([x]++l)):xs)
                             | otherwise = aux n x xs
                             

--listaPorGeneros :: FilmesAval -> [(Genero,[(Titulo,Avaliacao)])]
--listaPorGeneros [] = []
--listaPorGeneros 




