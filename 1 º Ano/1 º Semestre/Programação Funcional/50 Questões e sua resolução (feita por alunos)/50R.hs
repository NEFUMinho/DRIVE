import Data.List


-- exemplos para usar na manipulaçao de listas

a :: [Int]
a = [10,20,30,40]

b :: [Int]
b = [1,2,3]

--c :: [[a]]
c = [[2,3,4],[1,7],[],[8,5,3]]


-- 1) controi a lista dos numeros inteiros compreendidos entre dois limites

enumfromto :: Int -> Int -> [Int] 
enumfromto x y
    | x < y = x: enumfromto (x+1) y
    | otherwise = [y]

-- enumfromto 1 5
-- 1 < 5 -> 1: enumfromto (1+1) 5
-- 1: enumfromto 2 5
-- 2 < 5 -> 1: 2: enumfromto (2+1) 5
-- 1: 2: enumfromto 3 5
-- 3 < 5 -> 1: 2: 3: enumfromto (3+1) 5
-- 1: 2: 3: enumfromto 4 5
-- 4 < 5 -> 1: 2: 3: 4: enumfromto (4+1) 5
-- 1: 2: 3: 4: enumfromto 5 5
-- 1: 2: 3: 4: [5]
-- [1,2,3,4,5]

-- 2) constroi a lista dos numeros inteiros compreendidos entre dois limites e espaçados
--   de um valor constante

enumfromthento :: Int -> Int -> Int -> [Int]
enumfromthento x y z
    | x <= z = x: enumfromthento (x+y-1) y z
    | otherwise = []

-- enumfromthento 1 3 10
-- 1 < 10 -> 1: enumfromthento (1+3-1) 3 10
-- 1: enumfromthento 3 3 10
-- 3 < 10 -> 1: 3: enumfromthento (3+3-1) 3 10
-- 1: 3: enumfromthento 5 3 10
-- 5 < 10 -> 1: 3: 5: enumfromthento (5+3-1) 3 10
-- 1: 3: 5: enumfromthento 7 3 10
-- 7 < 10 -> 1: 3: 5: 7: enumfromthento (7+3-1) 3 10
-- 1: 3: 5: 7: enumfromthento 9 3 10
-- 9 < 10 -> 1: 3: 5: 7: 9: enumfromthento (9+3-1) 3 10
-- 1: 3: 5: 7: 9: enumfromthento 11 3 10
-- 1: 3: 5: 7: 9: []
-- [1,3,5,7,9]

-- 3) concatenar listas

maismais :: [a] -> [a] -> [a]
maismais l [] = l
maismais [] l = l
maismais (h:t) (a:b) = h: maismais t (a:b)

-- maismais [1,2,3] [10,20,30]
-- 1: maismais [2,3] [10,20,30]
-- 1: 2: maismais [3] [10,20,30]
-- 1: 2: 3: maismais [] [10,20,30]
-- 1: 2: 3: [10,20,30]
-- [1,2,3,10,20,30]

-- 4) dada uma lista e um inteiro, calcula o elemento da lista que se encontra nessa 
--   posiçao. assume-se que o primeiro elemento se encontra na posição 0

encontra :: [a] -> Int -> a
encontra (h:t) x
    | x == 0 = h
    | otherwise = encontra t (x-1)

-- encontra [10,20,30] 2
-- encontra [20,30] (2-1)
-- encontra [20,30] 1
-- encontra [30] (1-1)
-- encontra [30] 0
-- 30

-- 5) dada uma lista calcula uma lista com os elementos dessa lista pela ordem inversa

revers :: [a] -> [a]
revers [] = []
revers (h:t) = revers t ++ [h]

-- revers [1,2,3]
-- revers [2,3] ++ [1]
-- (revers [3] ++ [2]) ++ [1]
-- ((revers [] ++ [3]) ++ [2]) ++ [1]
-- ((( [] ) ++ [3]) ++ [2]) ++ [1]

-- 6) dado um inteiro n e uma lista calcula a lista com os (no max) n primeiros 
--   elementos da lista

retira :: Int -> [a] -> [a]
retira x [] = []
retira x (h:t)
    | x == 1 = [h]
    | otherwise = h: retira (x-1) t

-- retira 2 [10,20,30]
-- 10: retira (2-1) [20,30]
-- 10: retira 1 [20,30]
-- 10: [20]
-- [10,20]

-- 7) dado um inteiro n e uma lista calcula a lista sem os (no max) n primeiros
--   elementos da lista

deitaf :: Int -> [a] -> [a]
deitaf x [] = []
deitaf x (h:t)
    | x == 1 = t
    | otherwise = deitaf (x-1) t

-- deitaf 2 [10,20,30]
-- deitaf (2-1) [20,30]
-- deitaf 1 [20,30]
-- [30]

-- 8) constroi uma lista de pares a partir de duas listas

zipa :: [a] -> [b] -> [(a,b)]
zipa _ [] = []
zipa [] _ = []
zipa (h:t) (a:b) = (h,a): zipa t b

-- zipa [1,2,3] [10,20,30,40]
-- (1,10): zipa [2,3] [20,30,40]
-- (1,10): (2,20): zipa [3] [30,40]
-- (1,10): (2,20): (3,30): zipa [] [40]
-- (1,10): (2,20): (3,30): []
-- [(1,10),(2,20),(3,30)]

-- 9) dado um inteiro n e um elemento x, controi uma lista com n elemntos, todos iguais
--    a x

replica :: Int -> a -> [a]
replica x n
    | x == 1 = [n]
    | otherwise = n: replica (x-1) n

-- replica 3 10
-- 10: replica (3-1) 10
-- 10: replica 2 10
-- 10: 10: replica (2-1) 10
-- 10: 10: replica 1 10
-- 10: 10: 10
-- [10,10,10]

-- 10) dado um elemento e uma lista, controi uma lista em que o elemento fornecido é
--     intercalado entre os elementos da lista fornecida

intercala :: a -> [a] -> [a] 
intercala x [a] = [a]
intercala x (h:t) = h:x: intercala x t

-- intercala 1 [10,20,30]
-- 10: 1: intercala 1 [20,30]
-- 10: 1: 20: 1: intercala 1 [30]
-- 10: 1: 20: 1: [30]
-- [10,1,20,1,30]

-- 11) agrupa elementos iguais e consecutivos de uma lista

agrupa :: Eq a => [a] -> [[a]]
agrupa [] = []
agrupa (h:t) = insere h (agrupa t)
    where insere x [] = [[x]]
          insere x (h:t)
              | elem x h = (x:h):t
              | otherwise = [x]:(h:t)

-- agrupa [1,2,2,3]
-- insere 1 (agrupa [2,2,3])
-- insere 1 (insere 2 (agrupa [2,3]))
-- insere 1 (insere 2 (insere 2 (agrupa [3])))
-- insere 1 (insere 2 (insere 2 (insere 3 [])))
-- insere 1 (insere 2 (insere 2 ([[3]])))
-- insere 1 (insere 2 ([[2]:[3]]))
-- insere 1 ([[2:2]:[3]])
-- [[1]:[2:2]:[3]]
-- [[1],[2,2],[3]]

-- 12) concatena as listas de uma lista

concatena :: [[a]] -> [a]
concatena [] = []
concatena (h:t) = h ++ concatena t

-- concatena [[1],[2,2],[3]]
-- [1] ++ (concatena [[2,2],[3]])
-- [1] ++ ([2,2] ++ (concatena [[3]]))
-- [1] ++ ([2,2] ++ ([3] ++ (concatena [])))
-- [1] ++ ([2,2] ++ ([3] ++ ([])))
-- [1:2:2:3:[]]
-- [1,2,2,3]

-- 13) calcula a lista dos prefixos de uma lista

prefixos :: [a] -> [[a]]
prefixos [] = [[]]
prefixos l = prefixos (init l) ++ [l]

-- prefixos [1,2,3]
-- prefixos (init [1,2,3]) ++ [1,2,3]
-- prefixos ([1,2]) ++ [1,2,3]
-- prefixos (init [1,2]) ++ [1,2] ++ [1,2,3]
-- prefixos ([1]) ++ [1,2] ++ [1,2,3]
-- prefixos (init [1]) ++ [1] ++ [1,2] ++ [1,2,3]
-- prefixos ([]) ++ [1] ++ [1,2] ++ [1,2,3]
-- [[]] ++ [1] ++ [1,2] ++ [1,2,3]
-- [[],[1],[1,2],[1,2,3]]

-- 14) calcula a lista dos sufixos de uma lista

sufixos :: [a] -> [[a]]
sufixos [] = [[]]
sufixos l = [l] ++ sufixos (tail l)

-- sufixos [1,2,3]
-- [[1,2,3]] ++ sufixos (tail [1,2,3])
-- [[1,2,3]] ++ sufixos ([2,3])
-- [[1,2,3]] ++ [[2,3]] ++ sufixos (tail [2,3])
-- [[1,2,3]] ++ [[2,3]] ++ sufixos ([3])
-- [[1,2,3]] ++ [[2,3]] ++ [[3]] ++ sufixos (tail [3])
-- [[1,2,3]] ++ [[2,3]] ++ [[3]] ++ sufixos ([])
-- [[1,2,3]] ++ [[2,3]] ++ [[3]] ++ [[]]

-- 15) recebe uma lista de listas e produz a lista com o primeiro elemento de cada lista

heads :: [[a]] -> [a]
heads [] = []
heads ([]:t) = heads t
heads (h:t) = (head h): heads t

-- heads [[2,3,4],[1,7],[],[8,5,3]]
-- (head [2,3,4]): heads ([[1,7],[],[8,5,3]])
-- 2: (head [1,7]): heads ([[],[8,5,3]])
-- 2: 1: heads ([[8,5,3]])
-- 2: 1: (head [8,5,3]): heads []
-- 2: 1: 8: []
-- [2,1,8]

-- 16) recebe uma lista de listas e conta o total de elementos (de todas as listas)

total :: [[a]] -> Int
total [] = 0
total (h:t) = (length h) + total t

-- total [[2,3,4],[1,7],[],[8,5,3]]
-- (length [2,3,4]) + total [[1,7],[],[8,5,3]]
-- 3 + (length [1,7]) + total [[],[8,5,3]]
-- 3 + 2 + (length []) + total [[8,5,3]]
-- 3 + 2 + 0 + (length [8,5,3]) + total []
-- 3 + 2 + 0 + 3 + 0
-- 8

-- 17) recebe uma lista de triplos e produz a lista de pares com o primeiro e terceiro
--     elemento de cada triplo

--f :: [(a,b,c)]
f = [("rui",3,2), ("maria",5,2), ("ana",43,7)]

fun :: [(a,b,c)] -> [(a,c)]
fun [] = []
fun ((a,_,c):t) = (a,c): fun t

-- fun [("rui",3,2), ("maria",5,2), ("ana",43,7)]
-- ("rui",2): fun [("maria",5,2), ("ana",43,7)]
-- ("rui",2): ("maria",2): fun [("ana",43,7)]
-- ("rui",2): ("maria",2): ("ana",7): fun []
-- ("rui",2): ("maria",2): ("ana",7): []
-- [("rui",2),("maria",2),("ana",7)]

-- 18) recebe uma lista de triplos e concatena as strings que estão na primeira componente
--     dos triplos

cola :: [(String,b,c)] -> String
cola [] = []
cola ((a,_,_):t) = a ++ cola t

-- cola [("rui",3,2), ("maria",5,2), ("ana",43,7)]
-- "rui" ++ cola [("maria",5,2), ("ana",43,7)]
-- "rui" ++ "maria" ++ cola [("ana",43,7)]
-- "rui" ++ "maria" ++ "ana" ++ cola []
-- "rui" ++ "maria" ++ "ana" ++ []

-- 19) recebe o ano, a idade e uma lista de pares com o nome e o ano de nascimento de cada
--     pessoa, e devolve a lista de nomes das pessoas que nesse ano atingirão ou já
--     ultrapassaram a idade indicada

d :: [(String, Int)]
d = [("rui",1995), ("maria",2009), ("ana",1947)] 

idade :: Int -> Int -> [(String, Int)] -> [String]
idade _ _ [] = []
idade ano idad ((nome, nascimento):t)
    | (ano - nascimento) >= idad = nome: idade ano idad t
    | otherwise = idade ano idad t

-- idade 2021 26 [("rui",1995), ("maria",2009), ("ana",1947)] 
-- (2021-1995) = 26 >= 26 -> "rui": idade 2021 26 [("maria",2009), ("ana",1947)] 
-- "rui": (2021-2009) = 12 >= 26 -> idade 2021 26 [("ana",1947)] 
-- "rui": (2021-1947) = 74 >= 26 -> "rui": "ana": idade 2021 26 []
-- "rui": "ana": []
-- ["rui","ana"]

-- 20) dado um valor n e um valor m constroi a lista [n^0, ..., n^m-1]

powerenumfrom :: Integer -> Integer -> [Integer]
powerenumfrom n 0 = [1]
powerenumfrom n e = powerenumfrom n (e-1) ++ [n^e]

-- powerenumfrom 2 4
-- powerenumfrom 2 (4-1) ++ [16]
-- powerenumfrom 2 (3) ++ [16]
-- powerenumfrom 2 (3-1) ++ [8] ++ [16]
-- powerenumfrom 2 (2) ++ [8] ++ [16]
-- powerenumfrom 2 (2-1) ++ [4] ++ [8] ++ [16]
-- powerenumfrom 2 (1) ++ [4] ++ [8] ++ [16]
-- powerenumfrom 2 (1-1) ++ [2] ++ [4] ++ [8] ++ [16]
-- powerenumfrom 2 (0) ++ [2] ++ [4] ++ [8] ++ [16]
-- [1] ++ [2] ++ [4] ++ [8] ++ [16]
-- [1,2,4,8,16]

-- 21) que dado um nº inteiro maior ou igual a 2 determina se esse nº é primo. Para determinar
--     se um nº é primo, descubra se existe algum nº inteiro m tal que 2 <= m <= √n e mod n m = 0.
--     se tal nº não existir então n é primo, e se existir então n não é primo

isprime :: Int -> Bool
isprime x 
    | x >= 2 = primo x 2
    | otherwise = False
    where primo x m
            | m*m > x = True
            | mod x m == 0 = False
            | otherwise = primo x (m+1)

-- isprime 21
-- 21 >= 2 -> primo 21 2
-- primo 21 2
-- 2*2 = 4 > 21 -> mod 21 2 = 1 -> primo 21 (2+1)
-- primo 21 3
-- 3*3 = 9 > 21 -> mod 21 3 == 0 -> False
-- False

-- isprime 11
-- 11 >= 2 -> primo 11 2
-- primo 11 2
-- 2*2 = 4 > 11 -> mod 11 2 = 1 -> primo 11 (2+1)
-- primo 11 3
-- 3*3 = 9 > 11 -> mod 11 3 == 2 -> primo 11 (3+1)
-- primo 11 4
-- 4*4 = 16 > 11 -> True
-- True

-- 22) testa de uma lista é prefixo de outra

isprefixof :: Eq a => [a] -> [a] -> Bool
isprefixof [] _  = True
isprefixof _ [] = False
isprefixof (h:t) (a:b) = h == a && isprefixof t b

-- isprefixof [10,20] [10,20,30]
-- 10 == 10 && isprefixof [20] [20,30]
-- 10 == 10 && 20 == 20 && isprefixof [] [30]
-- 10 == 10 && 20 == 20 && True 
-- True

-- isprefixof [10,20,40] [10,20,30]
-- 10 == 10 && isprefixof [20,40] [20,30]
-- 10 == 10 && 20 == 20 && isprefixof [40] [30]
-- 10 == 10 && 20 == 20 && 40 == 30 -> False
-- False

-- isprefixof [10,20,30] [10,20]
-- 10 == 10 && isprefixof [20,30] [20]
-- 10 == 10 && 20 == 20 && isprefixof [30] []
-- 10 == 10 && 20 == 20 && False
-- False

-- 23) testa se uma lista é sufixo de outra

issufixof :: Eq a => [a] -> [a] -> Bool
issufixof [] _ = True
issufixof _ [] = False
issufixof (h:t) (a:b) = (h:t) == (a:b) || issufixof (h:t) b

-- issufixof [20,30] [10,20,30]
-- [20,30] /= [10,20,30] -> issufixof [20,30] [20,30]
-- [20,30] == [20,30] -> True
-- True

-- issufixof [10,30] [10,20,30]
-- [10,30] /= [10,20,30] -> issufixof [10,30] [20,30]
-- [10,30] /= [20,30] -> issufixof [10,30] [30]
-- [10,30] /= [30] -> issufixof [10,30] []
-- False

-- 24) testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa

issubsequenceof :: Eq a => [a] -> [a] -> Bool
issubsequenceof [] _ = True
issubsequenceof _ [] = False
issubsequenceof (h:t) (a:b)
    | h == a = issubsequenceof t b
    | otherwise = issubsequenceof (h:t) b

-- issubsequenceof [20,40] [10,20,30,40]
-- 20 /= 10 -> issubsequenceof [20,40] [20,30,40]
-- 20 == 20 -> issubsequenceof [40] [30,40]
-- 40 /= 30 -> issubsequenceof [40] [40]
-- 40 == 40 -> issubsequenceof [] []
-- True

-- issubsequenceof [40,20] [10,20,30,40]
-- 40 /= 10 -> issubsequenceof [40,20] [20,30,40]
-- 40 /= 20 -> issubsequenceof [40,20] [30,40]
-- 40 /= 30 -> issubsequenceof [40,20] [40]
-- 40 == 40 -> issubsequenceof [20] []
-- False

-- 25) calcula a lista de posiçoes em que um dado elemento ocorre numa lista

elemindices :: Eq a => a -> [a] -> [Int]
elemindices _ [] = []
elemindices x (h:t) = aux x (h:t) 0 []
    where aux x [] y l = l
          aux x (h:t) y l
              | x == h = aux x t (y+1) (l++[y])
              | otherwise = aux x t (y+1) l

-- elemindices 3 [1,2,3,4,3,2,3,4,5]
-- aux 3 [1,2,3,4,3,2,3,4,5] (0) ([])
-- 3 /= 1 -> aux 3 [2,3,4,3,2,3,4,5] (0+1) ([])
-- 3 /= 2 -> aux 3 [3,4,3,2,3,4,5] (1+1) ([])
-- 3 == 3 -> aux 3 [4,3,2,3,4,5] (2+1) ([]++[2])
-- 3 /= 4 -> aux 3 [3,2,3,4,5] (3+1) ([2])
-- 3 == 3 -> aux 3 [2,3,4,5] (4+1) ([2]++[4])
-- 3 /= 2 -> aux 3 [3,4,5] (5+1) ([2,4])
-- 3 == 3 -> aux 3 [4,5] (6+1) ([2,4]++[6])
-- 3 /= 4 -> aux 3 [5] (7+1) ([2,4,6])
-- 3 /= 5 -> aux 3 [] (8+1) ([2,4,6])
-- [2,4,6]

-- 26) calcula uma lista com os mesmos elementos da recebida, sem repetiçoes

nubb :: Eq a => [a] -> [a]
nubb [] = []
nubb (h:t)
    | elem h t == False = h: nubb t
    | otherwise = nubb t

nuub :: Eq a => [a] -> [a]
nuub [] = []
nuub a = if elem l i then nuub i else nuub i ++ [l]
    where i = init a
          l = last a

-- inicio para o final
-- nubb [1,2,1,2,3,1,2] 
-- elem 1 [2,1,2,3,1,2] = True -> nubb [2,1,2,3,1,2]
-- elem 2 [1,2,3,1,2] = True -> nubb [1,2,3,1,2]
-- elem 1 [1,2,3,1,2] = True -> nubb [2,3,1,2]
-- elem 2 [3,1,2] = True -> nubb [3,1,2]
-- elem 3 [1,2] = False -> 3: nubb [1,2]
-- elem 1 [2] = False -> 3: 1: nubb [2]
-- elem 2 [] = False -> 3: 1: 2: nubb []
-- 3: 1: 2: []
-- [3,1,2]


-- final para o inicio
-- nuub [1,2,1,2,3,1,2] 
-- elem 2 [1,2,1,2,3,1] = True -> nuub [1,2,1,2,3,1]
-- elem 1 [1,2,1,2,3] = True -> nuub [1,2,1,2,3]
-- elem 3 [1,2,1,2] = False -> nuub [1,2,1,2] ++ [3]
-- elem 2 [1,2,1] = True -> nuub [1,2,1] ++ [3]
-- elem 1 [1,2] = True -> nuub [1,2] ++ [3]
-- elem 2 [1] = False -> nuub [1] ++ [2] ++ [3]
-- elem 1 [] = False -> nuub [] ++ [1] ++ [2] ++ [3]
-- [] ++ [1] ++ [2] ++ [3]
-- [1,2,3]

-- 27) retorna a lista resultante de remover (1º ocorrencia de) um dado elemento de uma lista

delet :: Eq a => a -> [a] -> [a]
delet x [] = []
delet x (h:t)
    | x == h = t
    | otherwise = h: delete x t

-- delete 4 [2,4,5]
-- 4 /= 2 -> 2: delete 4 [4,5]
-- 4 == 4 -> 2: [5]
-- [2,5]

-- delete 4 [2,3,5]
-- 4 /= 2 -> 2: delete 4 [3,5]
-- 4 /= 3 -> 2: 3: delete 4 [5]
-- 4 /= 5 -> 2: 3: 5: delete 4 []
-- 2: 3: 5: []
-- [2,3,5]

-- delete 4 [2,4,5,4]
-- 4 /= 2 -> 2: delete 4 [4,5,4]
-- 4 == 4 -> 2: [5,4]
-- 2: [5,4] 
-- [2,5,4]

-- 28) retorna a lista resultante de remover (as 1º ocorrencias) dos elementos da 
--     2º lista da 1º

delete2 :: Eq a => [a] -> [a] -> [a]
delete2 [] _ = []
delete2 l [] = l
delete2 (h:t) (a:b) 
    | h == a = delete2 t b
    | otherwise = h: delete2 t (a:b)

-- delete2 [1,2,3,4,5,1] [1,5]
-- 1 == 1 -> delete2 [2,3,4,5,1] [5]
-- 2 /= 5 -> 2: delete2 [3,4,5,1] [5]
-- 3 /= 5 -> 2: 3: delete2 [4,5,1] [5]
-- 4 /= 5 -> 2: 3: 4: delete2 [5,1] [5]
-- 5 == 5 -> 2: 3: 4: delete2 [1] []
-- 2: 3: 4: [1]
-- [2,3,4,1]

-- 29) retorna a lista resultante de acrescentar à 1º lista os elementos da 2º que não
--     ocorrem na primeira

uniao :: Eq a => [a] -> [a] -> [a]
uniao l [] = l
uniao [] l = l
uniao l (h:t) = if elem h l then uniao l t else uniao (l++[h]) t

-- uniao [1,1,2,3,4] [1,5]
-- elem 1 [1,1,2,3,4] = True -> uniao [1,1,2,3,4] [5]
-- elem 5 [1,1,2,3,4] = False -> uniao ([1,1,2,3,4]++[5]) []
-- uniao [1,1,2,3,4,5] []
-- [1,1,2,3,4,5]

-- 30) retorna a lista resultante de remover da 1º lista os elementos que não pertencem à 2º.

interset :: Eq a => [a] -> [a] -> [a]
interset [] _ = []
interset (h:t) l = if elem h l then h: interset t l else interset t l

-- interset [1,1,2,3,4] [1,3,5]
-- elem 1 [1,3,5] = True -> 1: interset [1,2,3,4] [1,3,5]
-- elem 1 [1,3,5] = True -> 1: 1: interset [2,3,4] [1,3,5]
-- elem 2 [1,3,5] = False -> 1: 1: interset [3,4] [1,3,5]
-- elem 3 [1,3,5] = True -> 1: 1: 3: interset [4] [1,3,5]
-- elem 4 [1,3,5] = False -> 1: 1: 3: interset [] [1,3,5]
-- 1: 1: 3: []
-- [1,1,3]

-- 31) dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente
--     esse elemento na lista

insere :: Ord a => a -> [a] -> [a]
insere x [] = [x]
insere x (h:t) = if x <= h then x:h:t else h:insere x t

-- insere 7 [1,3,9]
-- 7 <= 1 = False -> 1: insere 7 [3,9]
-- 7 <= 3 = False -> 1: 3: insere 7 [9]
-- 7 <= 9 = True -> 1: 3: 7: [9]
-- [1,3,7,9]

-- 32) junta todas as strings da lista numa só, separando-as por um espaço

unword :: [String] -> String
unword [] = ""
unword (h:t) = h ++ (if vazia t then "" else " ") ++ unword t
    where vazia [] = True
          vazia _ = False

-- unword ["Programacao", "Funcional"]
-- "Programacao" ++ (vazia "Funcional") ++ unword "Funcional"
-- "Programacao" ++ " " ++ unword "Funcional"
-- "Programacao" ++ " " ++ "Funcional" ++ (vazia []) ++ unword []
-- "Programacao" ++ " " ++ "Funcional" ++ "" ++ ""
-- "Programacao Funcional"

-- 33) junta todas as strings da lista numa só, separando-as pelo caracter '\n'

unline :: [String] -> String
unline [] = ""
unline (h:t) = h ++ "\n"++ unline t

-- unline ["Prog", "Func"] 
-- "Prog" ++ "\n" ++ unline "Func"
-- "Prog" ++ "\n" ++ "Func" ++ "\n" ++ unline []
-- "Prog" ++ "\n" ++ "Func" ++ "\n" ++ ""

-- 34) dada uma lista não vazia, retorna a posição onde se encontra o maior elemento da lista
--     as posiçoes da lista começam em 0, a funçao deve retornar 0 se o 1º elemento da lista
--     for o maior

pmaior :: Ord a => [a] -> Int
pmaior l = pos (mx l) l
    where mx (h:t) = aux h t
              where aux x [] = x
                    aux x (h:t)
                         | x < h = aux h t
                         | otherwise = aux x t
          pos x (h:t) = aux 0 x (h:t)
              where aux y x [] = y
                    aux y x (h:t)
                         | x == h = aux y x []
                         | otherwise = aux (y+1) x t

-- convem dividir este problema em 2:
-- 1 -> saber qual é o elemento maior da lista (mx)
-- 2 -> calcular a posiçao desse elemento na lista (pos)
-- a junçao dos 2 realiza a tarefa do pmaior
-- assumindo que a lista não está ordenada e que pode não tem elementos repetidos
-- caso isso se verifique, a função só retorna o valor da 1 posição, caso o valor max seja repetido.

-- pmaior [10,2,50,3] -> pos (mx [10,20,50,3]) [10,2,50,3]
-- por partes
-- calcular o max
-- mx [10,2,50,3]
-- aux 10 [2,50,3]
-- 10 < 2 = False -> aux 10 [50,3]
-- 10 < 50 = True -> aux 50 [3]
-- 50 < 3 = False -> aux 50 []
-- 50
-- calcular a posiçao
-- pos 50 [10,2,50,3]
-- aux 0 50 [10,2,50,3]
-- 50 /= 10 -> aux (0+1) 50 [2,50,3]
-- 50 /= 2 -> aux (1+1) 50 [50,3]
-- 50 == 50 -> aux (2) 50 []
-- 2

-- 35) retorna uma lista construida a partir de elementos de uma lista (o 2º argumento)
--     atendendo a uma condição dada pelo 1º argumento.


g = [('a',1),('b',4),('c',5)]


lookupp :: Eq a => a -> [(a,b)] -> Maybe b
lookupp x [] = Nothing
lookupp x ((a,b):t)
    | x == a = Just b
    | otherwise = lookupp x t

-- lookupp 'b' [('a',1),('b',4),('c',5)]
-- 'b' /= 'a' -> lookupp 'b' [('b',4),('c',5)]
-- 'b' == 'b' -> Just 4
-- Just 4

-- lookupp 'b' [('a',1),('d',4),('c',5)]
-- 'b' /= 'a' -> lookupp 'b' [('d',4),('c',5)]
-- 'b' /= 'd' -> lookupp 'b' [('c',5)]
-- 'b' /= 'c' -> lookupp 'b' []
-- Nothing

-- 36) calcula o maior prefixo crescente de uma lista

precrescente :: Ord a => [a] -> [a]
precrescente (h:t) = aux h t []
    where aux x [] l = l
          aux x (h:t) l
              | x <= h = aux h t (l ++ [x])
              | otherwise = (l ++ [x])


-- precrescente [3,7,9,6,10,22]
-- aux 3 [7,9,6,10,22] []
-- 3 <= 7 = True -> aux 7 [9,6,10,22] ([]++[3])
-- 7 <= 9 = True -> aux 9 [6,10,22] ([3]++[7])
-- 9 <= 6 = False -> ([3,7]++[9])
-- [3,7,9]

-- 37) calcula o resultado de ordenar uma lista. Assuma, se precisar que existe a função insert
--     que dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente
--     esse elemento na lista

isort :: Ord a => [a] -> [a]
isort [] = []
isort (h:t) = insere h (isort t)
    where insere x [] = [x]
          insere x (h:t)
              | x <= h = x:h:t
              | otherwise = h:insere x t

-- isort [2,5,3,1,7,9,6]
-- insere 2 (isort [5,3,1,7,9,6])
-- insere 2 (insere 5 (isort [3,1,7,9,6]))
-- insere 2 (insere 5 (insere 3 (isort [1,7,9,6])))
-- insere 2 (insere 5 (insere 3 (insere 1 (isort [7,9,6]))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 (isort [9,6])))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 (insere 9 (isort [6]))))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 (insere 9 (insere 6 (isort [])))))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 (insere 9 (insere 6 []))))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 (insere 9 [6])))))
-- insere 2 (insere 5 (insere 3 (insere 1 (insere 7 [6,9]))))
-- insere 2 (insere 5 (insere 3 (insere 1 [6,7,9])))
-- insere 2 (insere 5 (insere 3 [1,6,7,9]))
-- insere 2 (insere 5 [1,3,6,7,9])
-- insere 2 [1,3,5,6,7,9]
-- [1,2,3,5,6,7,9]

-- exemplo do insere
-- insere 3 [1,6,7,9]
-- 3 <= 1 = False -> 1: insere 3 [6,7,9]
-- 3 <= 6 = True -> 1: 3: [6,7,9]
-- [1,3,6,7,9]

-- 38) que dadas duas strings, retorna True se e só se a 1º for menor do que a 2º,
--     segundo a ordem lexicográfica.

menor :: String -> String -> Bool
menor _ "" = False
menor "" _ = True
menor (h:t) (a:b)
    | h < a = True
    | h == a = menor t b
    | otherwise = False

-- menor "saa" "saiu"
-- 's' == 's' = True -> menor "aa" "aiu"
-- 'a' == 'a' = True -> menor "a" "iu"
-- 'a' < 'i' = True
-- True

-- menor "sba" "saiu"
-- 's' == 's' = True -> menor "ba" "aiu"
-- 'b' > 'a' = False
-- False

-- 39) testa se um elemento pertence a um multi-conjunto

elemmset :: Eq a => a -> [(a,Int)] -> Bool
elemmset x [] = False
elemmset x ((a,b):t) = if x == a then True else elemmset x t

-- elemmset 'a' [('b',2), ('a',4), ('c',1)]
-- 'a' == 'b' = False -> elemmset 'a' [('a',4), ('c',1)]
-- 'a' == 'a' = True
-- True

-- elemmset 'a' [('b',2), ('c',4)]
-- 'a' == 'b' = False -> elemmset 'a' [('c',4)]
-- 'a' == 'c' = False -> elemmset 'a' []
-- False

-- 40) converte um multi-conjunto na lista dos seus elementos

convertmset :: [(a,Int)] -> [a]
convertmset [] = []
convertmset ((a,b):t)
    | b > 0 = a: convertmset ((a,(b-1)):t)
    | b == 0 = convertmset t

-- convertmset [('b',2), ('a',4), ('c',1)]
-- b: convertmset [('b',1), ('a',4), ('c',1)]
-- b: b: convertmset [('b',0), ('a',4), ('c',1)]
-- b: b: convertmset [('a',4), ('c',1)]
-- b: b: a: convertmset [('a',3), ('c',1)]
-- b: b: a: a: convertmset [('a',2), ('c',1)]
-- b: b: a: a: a: convertmset [('a',1), ('c',1)]
-- b: b: a: a: a: a: convertmset [('a',0), ('c',1)]
-- b: b: a: a: a: a: convertmset [('c',1)]
-- b: b: a: a: a: a: c: convertmset [('c',0)]
-- b: b: a: a: a: a: c: convertmset []
-- b: b: a: a: a: a: c: []
-- "bbaaaac"

-- 41) acrescenta um elemento a um multi-conjunto

inseremset :: Eq a => a -> [(a,Int)] -> [(a,Int)]
inseremset x [] = [(x,1)]
inseremset x ((a,b):t)
    | x == a = ((a,(b+1)):t)
    | otherwise = (a,b): inseremset x t


-- inseremset 'a' [('b',2), ('a',4), ('c',1)]
-- 'a' /= 'b' -> ('b',2): inseremset 'a' [('a',4), ('c',1)]
-- 'a' == 'a' -> ('b',2): ('a',4+1): ('c',1)
-- [('b',2), ('a',5), ('c',1)]

-- inseremset 'a' [('b',2)]
-- 'a' /= 'b' -> ('b',2): inseremset 'a' []
-- ('b',2): ('a',1)
-- [('b',2), ('a',1)]

-- 42) remove um elemento a um multi-conjunto. Se o elemento nao existir deve ser
--     retornado o multi-conjunto recebido

removemset :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removemset x [] = []
removemset x ((a,b):t)
    | x == a && b > 1 = (a,(b-1)):t
    | x == a && b == 1 = t
    | otherwise = (a,b): removemset x t

-- removemset 'a' [('b',2), ('a',4), ('c',1)]
-- 'a' /= 'b' -> ('b',2): removemset 'a' [('a',4), ('c',1)]
-- 'a' == 'a' && 4 > 1 -> ('b',2): ('a',(4-1)): ('c',1)
-- [('b',2), ('a',3), ('c',1)]

-- removemset 'c' [('b',2), ('c',1)]
-- 'c' /= 'b' -> ('b',2): removemset 'c' [('c',1)]
-- 'c' == 'c' && 1 == 1 -> ('b',2): removemset 'c' []
-- [('b',2)]

-- 43) dada ums lista ordenada por ordem crescente, calcula o multi-conjunto dos seus elementos.

constroimset :: Ord a => [a] -> [(a,Int)]
constroimset [] = []
constroimset l@(h:t) = (h, conta h l): constroimset (deletex h l)
    where conta x [] = 0
          conta x (h:t) = if x == h then 1+ conta x t else conta x t
          deletex x [] = []
          deletex x (h:t) = if x == h then deletex x t else h: deletex x t

-- constroimset "aaabccc"
-- ('a', conta 'a' "aaabccc"): constroimset (deletex 'a' "aaabccc")
-- ('a', 3): controimset ("bccc")
-- ('a', 3): ('b', conta 'b' "bccc"): constroimset (deletx 'b' "bccc")
-- ('a', 3): ('b', 1): constroimset ("ccc")
-- ('a', 3): ('b', 1): ('c', conta 'c' "ccc"): constroimset (deletex 'c' "ccc")
-- ('a', 3): ('b', 1): ('c', 3): constroimset ([])
-- ('a', 3): ('b', 1): ('c', 3): []
-- [('a',3),('b',1),('c',3)]

-- 44) divide uma lista de Eithers em duas listas

partitioneithers :: [Either a b] -> ([a],[b])
partitioneithers l = (partl l , partr l)
    where partl ((Left x):t) = x: partl t
          partl ((Right x):t) = partl t
          partl [] = []
          partr ((Right x):t) = x: partr t
          partr ((Left x):t) = partr t
          partr [] = []

-- partitioneithers [Left 1, Right 2, Left 3, Right 4, Left 5]
-- ((partl [Left 1, Right 2, Left 3, Right 4, Left 5]), (partr [Left 1, Right 2, Left 3, Right 4, Left 5])
-- ((1: partl [Right 2, Left 3, Right 4, Left 5]), (partr [Right 2, Left 3, Right 4, Left 5]))
-- ((1: partl [Left 3, Right 4, Left 5]), (2: partr [Left 3, Right 4, Left 5]))
-- ((1: 3: partl [Right 4, Left 5]), (2: partr [Right 4, Left 5]))
-- ((1: 3: partl [Left 5]), (2: 4: partr [Left 5]))
-- ((1: 3: 5: partl []), (2: 4: partr []))
-- ((1: 3: 5: []), (2: 4: []))
-- ([1,3,5], [2,4])

-- 45) coleciona os elementos do tipo a de uma lista

catmaybes :: [Maybe a] -> [a]
catmaybes [] = []
catmaybes ((Nothing):t) = catmaybes t
catmaybes ((Just x):t) = x: catmaybes t

-- catmaybes [Just 1, Just 2, Nothing, Just 3, Nothing, Just 4, Just 5, Nothing]
-- 1: catmaybes [Just 2, Nothing, Just 3, Nothing, Just 4, Just 5, Nothing]
-- 1: 2: catmaybes [Nothing, Just 3, Nothing, Just 4, Just 5, Nothing]
-- 1: 2: catmaybes [Just 3, Nothing, Just 4, Just 5, Nothing]
-- 1: 2: 3: catmaybes [Nothing, Just 4, Just 5, Nothing]
-- 1: 2: 3: catmaybes [Just 4, Just 5, Nothing]
-- 1: 2: 3: 4: catmaybes [Just 5, Nothing]
-- 1: 2: 3: 4: 5: catmaybes [Nothing]
-- 1: 2: 3: 4: 5: catmaybes []
-- 1: 2: 3: 4: 5: []
-- [1,2,3,4,5]

-- 46) dadas as posiçoes inicial e final (coordenadas) do robot, produz uma lista de
--     movimentos suficientes para que o robot passe de uma posiçao para a outra

data Movimento = Norte
               | Sul
               | Este
               | Oeste deriving Show

caminho :: (Int, Int) -> (Int, Int) -> [Movimento]
caminho (x,y) (a,b)
    | x < a = Este : caminho (x+1,y) (a,b)
    | x > a = Oeste: caminho (x-1,y) (a,b)
    | y < b = Norte: caminho (x,y+1) (a,b)
    | y > b = Sul: caminho (x,y-1) (a,b)
    | x == a && y == b = []

-- caminho (1,2) (2,0)
-- 1 < 2 -> Este: caminho (1+1,2) (2,0)
-- Este: caminho (2,2) (2,0)
-- 2 > 0 -> Este: Sul: caminho (2,2-1) (2,0)
-- Este: Sul: caminho (2,1) (2,0)
-- 1 > 0 -> Este: Sul: Sul: caminho (2,1-1) (2,0)
-- Este: Sul: Sul: caminho (2,0) (2,0)
-- 2 == 2 && 0 == 0 -> Este: Sul: Sul: []
-- [Este, Sul, Sul]


-- 47) dada uma posição inicial e uma lista de movimentos (correspondentes a um percurso)
--     verifica se o robot alguma vez volta a passar pela posição inicial ao longo
--     do percurso correspondente.

hasloops :: (Int,Int) -> [Movimento] -> Bool
hasloops _ [] = False
hasloops (x,y) (h:t) = loops (x,y) (x,y) (h:t)
    where loops (x,y) (a,b) []
              | x == a && y == b = True
              | otherwise = False
          loops (x,y) (a,b) (Norte:t) = if (x == (a+1) && y == b) then True else loops (x,y) ((a+1),b) t
          loops (x,y) (a,b) (Sul:t) = if (x == (a-1) && y == b) then True else loops (x,y) ((a-1),b) t 
          loops (x,y) (a,b) (Este:t) = if (x == a && y == (b+1)) then True else loops (x,y) (a,(b+1)) t 
          loops (x,y) (a,b) (Oeste:t) = if (x == a && y == (b-1)) then True else loops (x,y) (a,(b-1)) t

-- hasLoops (0,0) [Norte, Norte, Este, Sul, Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (0,0) [Norte, Norte, Este, Sul, Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (0+1,0) [Norte, Este, Sul, Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (1+1,0) [Este, Sul, Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (2,0+1) [Sul, Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (2-1,1) [Oeste, Sul, Este, Norte, Este]
-- loops (0,0) (1,1-1) [Sul, Este, Norte, Este]
-- loops (0,0) (1-1,0) [Este, Norte, Este]
-- loops (0,0) (0,0) [Este, Norte, Este] -> (x == (a-1) && y == b) then True (linha 919)
-- True 

-- hasLoops (2,1) [Sul, Este, Sul, Oeste, Norte, Este, Sul]
-- loops (2,1) (2,1) [Sul, Este, Sul, Oeste, Norte, Este, Sul]
-- loops (2,1) (2-1,1) [Este, Sul, Oeste, Norte, Este, Sul]
-- loops (2,1) (1,1+1) [Sul, Oeste, Norte, Este, Sul]
-- loops (2,1) (1-1,2) [Oeste, Norte, Este, Sul]
-- loops (2,1) (0,2-1) [Norte, Este, Sul]
-- loops (2,1) (0+1,1) [Este, Sul]
-- loops (2,1) (1,1+1) [Sul]
-- loops (2,1) (1-1,2) []
-- loops (2,1) (0,2) [] 
-- (2,1) /= (0,2) -> False
-- False

-- 48) dada uma lista com retangulos, conta quantos deles são quadrados.

type Ponto = (Float,Float)
data Rectangulo = Rect Ponto Ponto

contaquadrados :: [Rectangulo] -> Int
contaquadrados [] = 0
contaquadrados (h:t)
    | equad h == True = 1 + contaquadrados t
    | otherwise = contaquadrados t
        where equad :: Rectangulo -> Bool
              equad (Rect (x,y) (a,b))
                  | abs (x-a) == abs (y-b) = True
                  | otherwise = False

-- contaquadrados [Rect (0,0) (2,2), Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)]
-- equad (Rect (0,0) (2,2))
-- abs (0-2) == abs (0-2) -> 2 == 2 -> True
-- 1 + (contaquadrados [Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)])
-- equad (Rect (1,3) (7,4))
-- abs (1-7) == abs (3-4) -> 6 == 1 -> False
-- 1 + (contaquadrados [Rect (5,2) (8,5), Rect (1,2) (2,4)])
-- equad (Rect (5,2) (8,5))
-- abs (5-8) == abs (2-5) -> 3 == 3 -> True
-- 1 + (1 + (contaquadrados [Rect (1,2) (2,4)]))
-- equad (Rect (1,2) (2,4))
-- abs (1-2) == abs (2-4) -> 1 == 2 -> False
-- 1 + (1 + (contaquadrados []))
-- 1 + (1 + (0))
-- 2

-- 49) dada uma lista com retangulos, determina a área total que eles ocupam

areatotal :: [Rectangulo] -> Float
areatotal [] = 0
areatotal (h:t) = area h + areatotal t
    where area (Rect (x,y) (a,b)) = (abs (a-x))*(abs(b-y))

-- areatotal [Rect (0,0) (2,2), Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)]
-- area (Rect (0,0) (2,2))
-- (abs (2-0))*(abs (2-0)) -> 2 * 2 = 4
-- 4 + (areatotal [Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)])
-- area (Rect (1,3) (7,4))
-- (abs (7-1))*(abs (4-3)) -> 6 * 1 = 6
-- 4 + (6 + (areatotal [Rect (5,2) (8,5), Rect (1,2) (2,4)]))
-- area (Rect (5,2) (8,5))
-- (abs (8-5))*(abs (5-2)) -> 3 * 3 = 9
-- 4 + (6 + (9 + (areatotal [Rect (1,2) (2,4)])))
-- area (Rect (1,2) (2,4))
-- (abs (2-1))*(abs (4-2)) -> 1 * 2 = 2
-- 4 + (6 + (9 + (2 + (areatotal []))))
-- 4 + (6 + (9 + (2 + (0))))
-- 21.0

-- 50) determina a quantidade de equipamentos que não estao avariados

data Equipamento = Bom
                 | Razoavel
                 | Avariado deriving Show

naoreparar :: [Equipamento] -> Int
naoreparar [] = 0
naoreparar (Bom:t) = 1 + naoreparar t
naoreparar (Razoavel:t) = 1 + naoreparar t
naoreparar (Avariado:t) = naoreparar t

-- naoreparar [Bom, Avariado, Bom, Razoavel, Avariado]
-- 1 + (naoreparar [Avariado, Bom, Razoavel, Avariado])
-- 1 + (naoreparar [Bom, Razoavel, Avariado])
-- 1 + (1 + (naoreparar [Razoavel, Avariado]))
-- 1 + (1 + (1 + (naoreparar [Avariado])))
-- 1 + (1 + (1 + (naoreparar [])))
-- 1 + (1 + (1 + (0)))
-- 3