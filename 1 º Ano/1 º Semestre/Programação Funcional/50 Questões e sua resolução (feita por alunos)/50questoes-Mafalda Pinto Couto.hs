import Data.Char






exc1 :: Int -> Int -> [Int]
exc1 a b = if a /= b then (a : exc1 (a + 1) b)
         else [b]  









exc2 :: Int -> Int -> Int -> [Int]

exc2 a b c = if a <= c then a : exc2 b (b + (b - a)) c else []









exc3 :: [a] -> [a] -> [a]
exc3 a [] = a
exc3 [] b = b
exc3 a b = head a : exc3 (tail a) b

-- OU
exc3s :: [a] -> [a] -> [a]

exc3s [] b = b
exc3s a [] = a
exc3s (a1: a2) b = (a1 : exc3s a2 b) 









exc4 :: [a] -> Int -> a


exc4 a b = if length a == ((length a) - b) then head a else exc4 (tail a)  (b-1)









exc5 :: [a] -> [a]
exc5o :: [a] -> [a]

exc5 (a : b) = if length b == 0 then [a]
              else exc5 (head b : tail b) ++ [a]


exc5o (a : b) = if length b == 0 then [a] 
                else exc5o (b) ++ [a]

exc5os :: [a] -> [a]

exc5os [a] = [a]

exc5os (a: b) = exc5os b ++ [a]








exc6 :: Int -> [a] -> [a]
--take 2 [10,20,30] = [10,20]
exc6 0 _ = []
exc6 _ [] = []
exc6 a b = if length b <= a then b else exc6 a (reverse (tail (reverse b)))









exc7 ::  Int -> [a] -> [a]

exc7o :: Int -> [a] -> [a]

exc7 a b = if length b == (length b - a) then b else exc7 (a-1) (tail b)
 
exc7o a b = if a == 0 then b else exc7o (a-1) (tail b)









exc8 :: [a] -> [b] -> [(a,b)]

-- zip [1,2,3] [10,20,30,40] = [(1,10),(2,20),(3,30)]


   
exc8 _ [] = []
exc8 [] _ = []  
exc8 (a: b) (c: d) = if length (c: d) == 1 then [(a, c)]
                     else
                     if length (a: b) == 1 then [(a, c)]
                     else (a, c) : (exc8 b d)


exc8s :: [a] -> [b] -> [(a,b)]

exc8s [] _ = []
exc8s (_: _) [] = []
exc8s (a: b) (c: d) = (a, c): (exc8s b d)  







exc9 ::  Eq a => a -> [a] -> Bool 

exc9 a [] = False
exc9 a (b: c) = if a == b then True
                else exc9 a c









exc10 :: Int -> a -> [a]

--replicate 3 10 = [10,10,10]

exc10 0 _ = []
exc10 a b = if a == 1 then [b]
            else (b : exc10 (a-1) b)









exc11 :: a -> [a] -> [a]

--intersperce 1 [10,20,30] = [10,1,20,1,30]

exc11 a [] = []
exc11 a (b: c) = if length c == 0 then [b]
                 else b : a : exc11 a c









exc12 :: Eq a => [a] -> [[a]]
--
---- group [1,2,2,3,4,4,4,5,4] = [[1],[2,2],[3],[4,4,4],[5],[4]]
--
--exc12 [] = []
--exc12 (a: []) = [[a]]
--exc12 (a: b: c) | a == b = [(a: exc12 (b: c))]
--                | a /= b = ([a]: exc12(b: c)) 


exc12 [] = []
exc12 (a: []) = [[a]]
exc12 (a: b) = if a == (head b) then [(a: r)] ++ rs
               else ([a]: (exc12 b)) 
               where (r:rs) = exc12 (b)

exc12o :: Eq a => [a] -> [[a]]

exc12o [] = []
exc12o (a: []) = [[a]]

exc12o (a: b) = if a == (head b) then [(a: head (exc12o b))] ++ (tail (exc12o b))
                else ([a]: (exc12o b)) 
              

funcao :: Eq a => [a] -> [[a]]

--[1, 2, 3, 3, 4, 5, 4, 4, 4, 2, 31]

funcao [] = [[]]
funcao [a] = [[a]]
funcao (x: xs: t) | x == xs = [(x: r)] ++ rs
                  | otherwise = [x] : (r: rs)
                    where (r:rs) = funcao (xs: t)  

--(4: 4: [4])
--(3: [3]) = (3, 3)
--[[1], [2], [3, 3], [4], [5], [4, 4, 4], [2], [31] ]









exc13 :: [[a]] -> [a]

--[[1],[2,2],[3],[4,4,4],[5],[4]] = [1,2,2,3,4,4,4,5,4]

--exc13 [[]] = [] 
--exc13 [[a]]= [a]
--exc13 ((a: b): [[c]]) = if (length (a: b)) == 1 then (a: (exc13 [[c]])) else (a: exc13 (b: [[c]]))

exc13 [] = []
exc13 (a: b) = a ++ exc13 b









exc14 :: [a] -> [[a]]

-- [11,21,13] = [[],[11],[11,21],[11,21,13]]

--exc14 (a: b) = if (length b) == 0 then [[a]] else ([]: [a]: [(a : head (exc14 b))]) ++ (tail (exc14 b))
exc14 [] = []
exc14 (a: b) = if (length b) == 0 then ([]: [[a]]) 
               else ( reverse((a:b): reverse(exc14 (a: reverse(tail(reverse b))))))  

----[1, 2, 3, 45]
-- reverse ([1, 2, 3, 45]: reverse (exc14 (1: (2,3))))
-- reverse ([1, 2, 3, 45]: reverse (reverse [1, 2, 3]: reverse (exc14 (1:2)))
-- reverse ([1, 2, 3, 45]: reverse (reverse [1, 2, 3]: reverse (reverse [1, 2]) : reverse(exc14 (1:[]))))
-- reverse ([1, 2, 3, 45]: [1, 2, 3]: [1, 2] : reverse ([]: [[1]]) 
--
--[[],[1],[1,2],[1,2,3], [1, 2, 3, 45]]


--Extras

primeiros :: [a] -> [a]

primeiros a = reverse (tail (reverse a))

auxexc14o :: [a] -> [[a]]

auxexc14o []  = []
auxexc14o [h] = [[h]]
auxexc14o a = [a] ++ (auxexc14o (primeiros a))


--Fim de extras


exc14o :: [a] -> [[a]]

exc14o [ ] = [ ]
exc14o [h] = [[h]]
exc14o (h:t) = [[]] ++ (reverse (auxexc14o (h:t)))




















exc15 :: [a] -> [[a]]

--[1,2,3] = [[1,2,3],[2,3],[3],[]]

exc15 [] = [[]]
exc15 (a: b) = if length (a: b) == 0 then [] else ((a:b): exc15 b) 









exc16 :: Eq a => [a] -> [a] -> Bool

-- [10,20] [10,20,30] = True e [10,30] [10,20,30] = False.

exc16 [] _ = False
exc16 a [] = False
exc16 a b = if a == b then True else exc16 a (reverse (tail (reverse b)))









exc17 :: Eq a => [a] -> [a] -> Bool

-- [20,30] [10,20,30] = True e [10,30] [10,20,30] = False

exc17 a [] = False 
exc17 [] _ = False 
exc17 a b = if a == b then True else exc17 a (tail b)



esuf:: Eq a => [a] -> [a] -> Bool
esuf _ [] = False
esuf [] _ = True
esuf l1 l2 = if (head rev1) == (head rev2) then esuf (reverse (tail rev1)) (reverse (tail rev2))  else False
            where rev1 = reverse l1
                  rev2 = reverse l2









exc18 :: Eq a => [a] -> [a] -> Bool

-- [20,40] [10,20,30,40] = True e [40,20] [10,20,30,40] = False
exc18 a [] = False 
exc18 [] b = False
exc18 a b = if (length a) == 1 && head a == head b then True 
            else 
            if head a == head b then exc18 (tail a) b 
            else exc18 a (tail b) 








ultimo :: [a] -> [a]
ultimo [] = []
ultimo a = reverse (tail(reverse a))

exc19 :: Eq a => a -> [a] -> [Int]

 -- 3 [1,2,3,4,3,2,3,4,5] = [2,4,6]

exc19 a [] = []

exc19 a b = if a == head (reverse b) then (exc19 a (ultimo b)) ++ [length b - 1] 
                 else exc19 a (ultimo b)
 
 







tirar :: Eq a => a -> [a] -> [a]

tirar _ [] = []

tirar a (b:c) = if a == b then tirar a c
                else b: tirar a c

exc20 :: Eq a => [a] -> [a]

--[1,2,1,2,3,1,2] = [1,2,3]

exc20 [] = []
exc20 (a: b) = if exc9 a b == True then (a: tirar a (exc20 b)) 
               else a: exc20 b









exc21 :: Eq a => a -> [a] -> [a]

-- 2 [1,2,1,2,3,1,2] corresponde a [1,1,2,3,1,2]

exc21 a [] = []
exc21 a (b:c) = if a == b then c
                else b: exc21 a c 









exc22 :: Eq a => [a] -> [a] -> [a]

--)[1,2,3,4,5,1] [1,5] = [2,3,4,1]

exc22 [] _ = []
exc22 (a:b) [] = (a:b)
exc22 (a: b) (c: d) = if a == c then exc22 b d 
                      else a: exc22 b (c:d)









verificar :: Eq a => a -> [a] -> Bool

--verificar 1 [2, 4, 1] = True e verificar 3 [2, 4, 1] = False
--(exc 9)

verificar c [] = False
verificar c (a:b) = if c == a then True 
                    else verificar c b


verificar2 :: Eq a => [a] -> [a] -> [a] 

verificar2 c [] = []
verificar2 c (a: b) = if verificar a c == True then verificar2 c b  
                      else a: (verificar2 c b)



exc23 :: Eq a => [a] -> [a] -> [a]

-- [1,1,2,3,4] [1,5] = [1,1,2,3,4,5]

exc23 c [] = c
exc23 c (a: b) = c ++ verificar2 c (a: b)











--verificar a [] = False
--verificar a (b:c) = if a == b then True 
--                    else verificar a c


exc24 :: Eq a => [a] -> [a] -> [a]

-- [1,1,2,3,4] [1,3,5] = [1,1,3]

exc24 [] c = []
exc24 (a: b) c = if verificar a c == True then a: exc24 b c 
                 else exc24 b c









exc25 ::  Ord a => a -> [a] -> [a] 

--25 [1,20,30,40] = [1,20,25,30,40]

exc25 a [] = [a]
exc25 a (b: c) = if a < b then a: (b: c)
                 else b: exc25 a c









exc26 :: [String] -> String

 --["Programacao", "Funcional"] = "Programacao Funcional"

exc26 [b] = b
exc26 (a: b) = a ++ " " ++ exc26 b









exc27 :: [String] -> String

-- ["Prog", "Func"] = "Prog\nFunc\n"

exc27 [] = []
exc27 (a: b) = a ++ "\n" ++ exc27 b 









maior :: Ord a => [a] -> a
-- [1, 2, 4, 2, 6] = 6

maior [a] = a
maior (a: b: c) = if a > b then maior (a: c) else maior (b: c)


exc28 :: Ord a => [a] -> Int 

-- [1, 4, 5, 2, 4, 8, 2, 4, 5, 1, 0] = 5
-- (0  1  2  3  4  5  6  7  8  9  10)

exc28 (a: b) = if maior (a: b) == a then 0 else 1 + exc28 b









comparar :: Eq a => a -> [a] ->  Bool

comparar a [] = False
comparar a (b: c) = if a == b then True else comparar a c

exc29 :: Eq a => [a] -> Bool

-- [11,21,31,21] = True e [11,2,31,4] = False

exc29 [] = False
exc29 [a] = False
exc29 (a: b: c) = if comparar a (b: c) == True then True else exc29 (b: c)


















exc30 :: [Char] -> [Char]

-- "123xp5" = "1235"

exc30 [] = []
exc30 (a: b) = if  (ord a) <= 57 && (ord a) >= 48  then a: exc30 b else exc30 b









exc31 :: [a] -> [a]

--[10,11,7,5] = [11,5]
exc31 [] = []
exc31 [a] = []
exc31 (a: b) = (head b: exc31 (tail b))









exc32  :: [a] -> [a]

-- [10,11,7,5] = [10,7]

exc32 [] = []
exc32 [a] = [a]
exc32 (a: b) = (a: exc32 (tail b))









exc33 :: Ord a => [a] -> Bool

-- [1,2,2,3,4,5] = True e [1,2,4,3,4,5] = False

exc33 [] = False 
exc33 [a] = True 
exc33 (a: b) = if a <= (head b) then exc33 b else False 







insert :: Ord a => a -> [a] -> [a]

insert a [] = [a]
insert a (b: c) = if a <= b then (a: (b: c)) else (b: insert a c)


exc34 ::  Ord a => [a] -> [a]

exc34 []     = []
exc34 (a: b) =  insert a (exc34 b) 










exc35 :: String -> String -> Bool

--"sai" "saiu" = True e "programacao" "funcional" = False

exc35 _ [] = False 
exc35 [] _ = True 
exc35 (a:b) (c:d) | a == c = exc35 b d
                  | a >  c = False 
                  | a <  c = True
  



  
   
   
--É suposto definir a função tal que "n˜ao haja pares cuja primeira componente coincida,
--nem cuja segunda componente seja menor ou igual a zero" ou é so para considerar isso?
 
exc36 ::  Eq a => a -> [(a,Int)] -> Bool

exc36 a [] = False 
exc36 a ((b, c): d) = if a == b then True else exc36 a d









exc37 ::  [(a,Int)] -> Int 

exc37 []= 0
exc37 [(a, b)] = b 
exc37 ((a,b):c) = b + exc37 c 








exc38 :: [(a,Int)] -> [a]
-- [(’b’,2), (’a’,4), (’c’,1)] = "bbaaaac"

exc38 [] = []
exc38 ((a, b): c) = if b == 0 then exc38 c else [a] ++ exc38 ((a, b-1): c)









exc39 :: Eq a => a -> [(a,Int)] -> [(a,Int)]

-- 'c' [('b',2), ('a',4), ('c',1)] = [('b',2), ('a',4), ('c',2)]

exc39 a [] = [(a, 1)]
exc39 a ((b, c): d) = if a == b then ((b, c+1): d) else (b,c): exc39 a d 









exc40 :: Eq a => a -> [(a,Int)] -> [(a,Int)]

-- 'c' [('b',2), ('a',4), ('c',1)] corresponde a [('b',2),('a',4)]

exc40 a [] = []
exc40 a ((b, c): d) | a == b && c == 1 =           exc40 a d
                    | a == b           = (b, c-1): exc40 a d
                    | otherwise        = (b, c  ): exc40 a d








--Extras

seguidos :: Ord a => [a] -> Int

seguidos []     = 0
seguidos [a]    = 1
seguidos (a: b: c) = if a == b then 1 + seguidos (b:c) else 1 


diferentes :: Ord a => [a] -> [a]

diferentes []        = []
diferentes [a]       = []
diferentes (a: b: c) = if a == b then diferentes (b: c) else (b: c)

--Terminam os extras

exc41 :: Ord a => [a] -> [(a,Int)]

--"aaabccc" = [('a',3), ('b',1), ('c',3)]

exc41 []     = []
exc41 [c]    = [(c, 1)]
exc41 (a: b: c) = if a == b then (a, seguidos (a: b: c)): (exc41 (diferentes (a: b: c)))
                  else (a, 1): exc41 (b: c) 





-- ????????????????????????

exc42 :: [Either a b] -> ([a],[b])

exc42 [] = ([], [])
exc42 l = (esquerda l, direita l)
          where esquerda [] = [] 
                esquerda ((Left a): b) = a: esquerda b
                esquerda ((Right _): b) = esquerda b
                direita [] = []
                direita ((Right a): b) = a: direita b 
                direita ((Left _): b) = direita b 





-- Exercício 42 sem os eithers 

exc42s :: [a] -> ([a],[a])
exc42s [] = ([], [])
exc42s l = (pmetade l [], rmetade l [])
          where  pmetade [] ccc = ccc
                 pmetade (x:xs) ccc = if length (x: xs) <= length ccc then reverse ccc
                                      else pmetade xs (x:ccc)
 
                 rmetade :: [a] -> [a] -> [a]
                 rmetade [] ccc = ccc
                 rmetade (x:xs) ccc = if length (x: xs) <= length ccc then (x:xs)
                                      else rmetade xs (x:ccc)






-- ????????????????????????


exc43 :: [Maybe a] -> [a]

exc43 [] = []
exc43 ((Just h):t) = h: exc43 t
exc43 ((Nothing): t) = exc43 t









data Movs = Norte | Sul | Este | Oeste
                deriving Show 

exc44 :: (Int,Int) -> [Movs] -> (Int,Int)

exc44 p [] = p
exc44 (a, b) (Norte: h) = exc44 (a, b+1) h
exc44 (a, b) (Sul:   h) = exc44 (a, b-1) h
exc44 (a, b) (Este:  h) = exc44 (a+1, b) h
exc44 (a, b) (Oeste: h) = exc44 (a-1, b) h










exc45 ::  (Int,Int) -> (Int,Int) -> [Movs] 

exc45 (a, b) (c, d) | a == c  && b == d = []
                    | a < c = Este:  exc45 (a+1, b) (c, d)
                    | a > c = Oeste: exc45 (a-1, b) (c, d)
                    | b < d = Norte: exc45 (a, b+1) (c, d)
                    | b > d = Sul:   exc45 (a, b-1) (c, d)



exc46 ::  [Movs] -> Bool

exc46 []         = True
exc46 (Norte: t) = exc46 t
exc46 (Sul:   t) = exc46 t
exc46 (Oeste: t) = False
exc46 (Este:  t) = False
 








data Posicao = Pos Int Int
               deriving Show


exc47 :: [Posicao] -> Posicao 

exc47 [] = Pos 0 0
exc47 [x] = x
exc47 ((Pos a b):(Pos h t): n) = if (a^2+b^2) >= (h^2+t^2) then exc47 ((Pos h t): n)
                                 else exc47 ((Pos a b): n) 









exc48 :: Posicao -> [Posicao] -> [Posicao]

exc48 (Pos a b) [] = []
exc48 (Pos a b) (Pos h t: n) | a == h && (b - t == 1 || b - t == -1) = (Pos h t): exc48 (Pos a b) n
                             | b == t && (a - h == 1 || a - h == -1) = (Pos h t): exc48 (Pos a b) n
                             | otherwise = exc48 (Pos a b) n



exc49 :: [Posicao] -> Bool 

exc49 []                        = True 
exc49 [Pos a b]                 = True
exc49 ((Pos a b): (Pos h t): n) = if b == t then exc49 ((Pos h t): n) 
                                  else False









data Semaforo = Verde | Amarelo | Vermelho
              deriving Show

exc50 :: [Semaforo] -> Bool 
exc50 []     = True
exc50 (a: b) = if contar (a: b) > 1 then False else True
               where contar []            = 0
                     contar (Verde : b)   = 1 + contar b
                     contar (Amarelo : b) = 1 + contar b
                     contar (Vermelho: b) = 0 + contar b