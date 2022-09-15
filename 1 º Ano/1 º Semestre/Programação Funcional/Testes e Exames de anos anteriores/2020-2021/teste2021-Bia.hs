-- Teste de programação funcional 20/01/2021

-- Exercício 1

(\\) :: Eq a => [a] -> [a] -> [a]
(\\) [] _ = []
(\\) l [] = l
(\\) (h:t) (x:xs)
	| h==x = (\\) t (x:xs)
	| otherwise = h : (\\) t (x:xs)

-- Exercício 2

type MSet a = [(a,Int)]

	-- Alínea a)

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet a ((x,y):t)
	| (a==x) && (y>1) = ((x,y-1):t)
	| (a==x) && (y==1) = t
	| otherwise = (x,y) : removeMSet a t

	-- Alínea b)

calcula :: MSet a -> ([a],Int)
calcula [] = ([],0)
calcula l = foldr (\(x,y) -> (x++(first l),y + sum (second l))) ([],0) l
	where first :: MSet a -> [a]
		  first [] = []
		  first ((a,x):t) = a:first t
		  second :: MSet a -> [Int]
		  second [] = []
		  second ((a,x):t) = x:second t 

-- Exercício 3

partes :: String -> Char -> [String]
partes [] _ = []
partes l x = (takeWhile (/= x) ls) : partes (dropWhile (/= x) ls) x
	where ls = dropWhile (==x) l

-- Exercício 4

data BTree a = Empty | Node a (BTree a) (BTree a)

	-- Alínea a)

remove :: Ord a => a -> BTree a -> BTree a 
remove _ Empty = Empty
remove x (Node r e d)
	| x==r = Empty
	| x>r = remove x d
	| otherwise = remove x e

	-- Alínea b)

instance Show BTree where
	show Empty = "*"
	show (Node r e d) = "(" ++ show e ++ "<-" ++ show r ++ "->" ++ show d ++ ")"

-- Exercício 5

sortOn :: Ord b => (a->b) -> [a] -> [a]
sortOn f [] = []
sortOn f (h:t) = insere f h (sortOn f t)
	where insere f x [] = [x]
		  insere f x (h:t)
	  			| f x > f h = h : insere f x t
	  			| otherwise = x:h:t

-- Exercício 6

data FileSystem = File Nome | Dir Nome [FileSystem]
type Nome = String

	-- Alínea a)

fichs :: FileSystem -> [Nome]
fichs (File x) = [x]
fichs (Dir n l) = [n] ++ concat (map (fichs) l)


