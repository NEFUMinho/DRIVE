{- 														AULA 2
 Programa } coisa que introduz inputs e produz outputs. Em programação funcional chamamos de função!

 Enunciado 1: um programa (uma função) que recebe um número inteiro e calcula o dobro desse número
 Resolução 1:
 	1) escolher um nome e um tipo para a função.Temos que definir que género de coisas esta função faz (descobrir qual 
o domínio de aplicação).
 	2) definir a função (i.e., dizer qual a relação que existe entre os argumentos e o resultado, como a função se comporta).
Vamos usar equações que descrevem o que a função calcula.

TIPOS: caracterizam os dados. Cada expressão que escrevemos vai ter um tipo.
Quando escolhemos o nome da função, também costumamos dizer qual é o tipo da função (significa dizer que género de coisas que a 
função recebe e que género de coisas que ela produz)
Em Haskell temos os seguintes tipos atómicos (não dependem de mais nada,são as peças mais básicas):
	- Int : para representar inteiros
	- Float: para representar números com vírgula (parte decimal)
	- Bool: para representar valores lógicos (True ou False)
	- Char: para representar caracteres (para escrever um caracter tem que o colocar entre aspas '')
Sempre que quero escrever um caracter especial, como as aspas, tenho que usar a barra. '\''} para representar as aspas
	-Integer: para representar inteiros com maior precisão (tem uma gama de valores maior que o Int, não têm limite) 
	-Double: para representar números com vírgula com maior precisão 

Enunciado 2: uma função que recebe um par de inteiros e calcula o maior deles.
   Resolução 2:
	1) escolher um nome e um tipo para a função
	2) definir a função

TIPOS NÃO ATÓMICOS:
	-Pares : (A,B) é o tipo dos pares ordenados em que a primeira componente é do tipo A e a segunda componente é do tipo B
	-Tuplos (ou Enúplos): 

-}

--Enunciado 1:

dobro :: Int -> Int
dobro 0 = 0
dobro 1 = 2
dobro 2 = 4
dobro x = 2 * x


-- Enunciado 2:

maior :: (Int,Int) -> Int
maior (x,y) = if x>y then x else y

{-																AULA 3

Na aula 2, em vez de definir a função maior daquela maneira podiamos fazer da seguinte forma:
		maior :: Int -> Int -> Int
		maior x y = if x>y then x else y
Portanto, existe esta possibilidade de termos funções com vários argumentos, sem que eles estejam englobados num par ou lista ou
tuplo. Estes argumentos serão na mesma separados por uma seta ->, a última seta é única que indica o resultado.


TIPOS NÃO ATÓMICOS (continuação):
	- Tuplos(ou enuplos): 


	- Funções: A -> B } é o tipo das funções com argumento do tipo A e resultado do tipo B;
	- Listas ou sequências: são formas que temos de guardar várias coisas na mesma expressão. São representados por [ A ], e 
por dentro escrevemos o tipo dos elementos que pertecem à lista. [ A ]} são listas em que todos os elementos são do tipo A.
	Ter em atenção que numa lista interessa, ao contrário dos conjuntos, é a ordem e a multicidade dos elementos (mas podem 
ter o mesmo tipo).
				exemplos:
							[1,2,3]						:: [Int]
							[1,3,2]
							[1,1,1,1,1,2,2,3]
							[1]
							[]

							[True]						:: [Bool]
							[True,True,True]
							[]

esta lista tem um elemento  [[1,1,1,1,1,2,2,3]]			:: [[Int]]
esta lista tem 2 elementos  [[1,1,1,1,1],[2,2,3]]

							['o','l','a']				:: [Char]

No caso de listas de Char, também podem ser escritas da seguinte forma : "ola" :: [Char] (são aspas duplas).
																		 "123" == ['1','2','3']
	lenght l } calcula o comprimento da lista l
	reverse l } inverta a ordem dos elementos da lista l
	head l } dá o primeiro elemento da lista l
	tail l } dá uma lista com todos os elementos da lista l exceto o primeiro, que é a cabeça da lista. Não pode ser aplicado a uma
lista vazia!


-}


-- Enunciado 1: calcula o número de elementos de uma lista (função comprimento ou lenght, como é conhecida):

comprimento :: [a] -> Int
comprimento [] = 0
comprimento l = (comprimento (tail l)) + 1

{- esta função está a ser definida com ela própria (é praticamente um ciclo), isto é, temos aqui uma função recursiva

comprimento [1,2,3]
	= comprimento (tail [1,2,3]) 			+ 1
	= comprimento ([2,3])					+ 1
	= (comprimento (tail [2,3])				+ 1) + 1
	= (comprimento ([3]) 					+ 1) + 1
	= (comprimento (tail [3]) +1)			+ 1) + 1
	= (comprimento ([])		  +1)			+ 1) + 1

Esta função não está completamente certa pois quando chegamos a tail [] dá-nos erro, ou seja, a função que nós definimos
não chega, temos de definir também o comprimento da lista vazia. Temos de acrescentar comprimento [] = 0.
Portanto, acabamos assim:

	= ( 0 +1  +1 ) +1
	= 3

Mais exemplos de funções recursivas é a função fatorial
	3! = 3*2*1
	n! = 1 			se n == 0
	   = n * (n-1)! se n > 0

-}


fatorial :: Integer -> Integer
fatorial n = if n == 0 then 1 else n * fatorial (n-1)

{- o que diz nesta última frase da função é exatamente igual ao de cima 

fatorial 200 vai aparecer igual a 0 pois dá um número muito grande, que não faz parte da classe do Int, e por isso temos
de usar o Integer.

-}

-- Vamos escrever o fatorial sem ser com o if e sim com duas equações

fatorial :: Integer -> Integer
fatorial 0 = 1
fatorial n = n * fatorial (n-1)

{- 

Em Haskell:
		a = b } a define-se como b (não é comutativo)
		a == b } os valores de a e b são os mesmos (este já é comutativo)

-}

{-															AULA 4

	Definições Recursivas } são definições (tem que aparecer um = para ser uma definição) em que aquilo que está no lado direito 
volta a aparecer onde nós estámos a definir (lado esquerdo). Parece com um ciclo, é como uma definição ciclica ou recursiva.

-}

-- Função fatorial:

fatorial2 :: Integer -> Integer
fatorial2 n = if n == 0 then 1 else n * fatorial2 (n-1)        -- temos aqui só uma equação

-- ou em alternativa temos:

fatorial :: Integer -> Integer
fatorial 0 = 1                   -- a equação nesta linha só pode ser usada quando usamos fatorial de 0
fatorial n = n * fatorial (n-1)                               

{-

	Nas definições de funções iremos sempre utilizar a símbolo de =. Para definirmos uma função teremos que utilizar equações. Na
linha 11, só usamos uma equação para definir a função fatorial. Mas o Haskell permite utilizar mais do que uma função, ou seja,
podemos definir a função com vários casos.

	No ghci, quando fazemos fatorial2 3, não existe muitas dúvidas pois ele só tem aquela equação para executar. Quando fazemos
no ghci fatorial 3, como na primeira equação não é do caso 3 ele vai apenas executar a segunda equação. Mas se fizermos
fatorial 0 já vai dar problemas pois já tem 2 equações (linhas 16 e 17) onde isso pode ser executado, e que as duas dão resultados
muito diferentes.

	No ghci, podemos usar várias equações para definir uma função, mas temos que estar sempre atentos às equações que vão ser
usadas com prioridade (por exemplo, só iremos usar a linha 17 se não podermos usar o que está na linha 16). Logo, não podemos 
mudar a ordem das equações!

	CONCLUSÃO: Nós quando definimos funções com mais de uma equação temos de ter em consideração que as equações vão ser usadas de 
cima para baixo, e por isso temos de ter muito cuidado ao alterar a ordem das mesmas, pois o resultado pode não ser o mesmo, 
podendo até dar erro.

-}

-- Exercício 1: função dada uma lista de inteiros calcula a soma dos elementos:

somal :: [Int] -> Int          -- nome e tipo da função
somal [] = 0
--somal [x] = x
--somal [x,y] = x + y       -- podiamos continuar sempre e não estava errado mas não estava completo pois não para todos os casos
somal l = (head l) + somal (tail l)


{-

	Na linha 42, [Int] significa uma lista onde os elementos são inteiros. Já na linha 44, aparece [x] que significa uma lista
com um elemento x. Na linha 45, aparece [x,y] que significa uma lista com 2 elementos, o x e o y. 

	CONCLUSÃO: Se tivermos a falar de tipos, então quando aparecer os parentesis [] significa que estamos a falar de uma lista onde
todos os elementos são daquele tipo (linha 42). Mas, por exemplo, nas linhas 43, 44 e 45 já temos a enumeração de elementos dessas
listas.

	Se mudarmos a ordem das 3 primeiras equações, não existe nenhuma alteração no resultado pois não conseguimos encontrar nenhum 
caso particular que satisfaça essas 3 equações, e por isso não é possível que o ghci se confunda (ele nunca tem dúvidas).

	NOTA: a terceira linha não é necessária, não necessita de ser escrita.

								O que vai acontecer se eu fizer a somal [10,20,30,40]:

	somal [10,20,30,40]
	 = (head [10,20,30,40]) + somal (tail [10,20,30,40])
	 = 10 + somal ([20,30,40])
	 = 10 + (head [20,30,40]) + somal (tail [20,30,40])
	 = 10 + 20 + somal ([30,40]) 
	 = 10 + 20 + (head [30,40]) + somal (tail [30,40])
	 = 10 + 20 + 30 + somal ([40]) 
	 = 10 + 20 + 30 + 40                          ou            = 10 + 20 + 30 + (head [40]) + somal (tail [40])
	 = 100                                                      = 10 + 20 + 30 + 40 + somal ([])
	 															= 10 + 20 + 30 + 40 + 0
	 															= 100

	Listas em Haskell:
		a) [] } lista vazia 
		b) (h:t) } lista cujo o primeiro elemento (cabeça) é h e os restantes são t (cauda da lista) (isto vai ser usado
como padrão)

				: } é usado para descrever padrões

	(1:[]) } é uma lista com só um elemento. É igual a escrever [1]
-}

-- Rescrevendo a função somal:

somal :: [Int] -> Int
somal [] = 0
somal (h:t) = h + somal t

{-															AULA 5

	NOTA: Na maioria dos casos quando nós estamos a escrever funções que envolvem listas, nós usamos os seguintes casos: [] (lista
vazia) e (h:t), que é a lista onde h é a sua cabeça e t a sua cauda. Usamos estes dois casos pois as listas são escritas
exaustivamente com estes 2 casos. Sempre que isto acontece estamos perante TIPOS INDUTIVOS.

TIPOS INDUTIVOS: são tipos que em Haskell se definem com data. Escrevemos: (a seguir de data tem de começar sempre de letra 
maiúscula, pois é um tipo)

		data Xpto 													-- significa que vamos dar uma definição exaustiva
																			a todos os padrões que existem neste tipo Xpto.

	Ou seja, ao escrever isto em cima temos quase um guião para escrever funções do tipo apresentado (neste caso, são do
tipo Xpto).

	Construtores -> começam sempre por letra maiúscula e separam-se sempre por uma barra: |

	ATENÇÃO : Just sozinho não pode acontecer!!!

	O tipo Maybe a serve para representar coisas que são do tipo a ou não são nada.

	Maybe -> é do gênero uma função de tipos


data Maybe a = Nothing | Just a 									-- Nothing e Just chamam-se os construtores do tipo

--	a :: Maybe Int  isto está errado pois para ser do tipo Maybe tem que ter Nothing ou Just

		Nothing :: Maybe Int
		Just 2  :: Maybe Int

		[Nothing] 		  :: [Maybe Int]
		[Just 2, Nothing] :: [Maybe Int]

		Nothing    :: Maybe [Int]
		Just [2,3] :: Maybe [Int]

data Bool = False | True

	head [] = não é igual a 0 e não faz sentido calcular head de lista vazia. Logo, dizemos que head é uma função parcial (existe
 um elemento da função head para o qual não tem nada definido).

	ultimo [] -> não está definido
-}

-- Calcula a cabeça de uma lista (chama-se head):

cabeça :: [a] -> a
cabeça (h:t) = h

-- último elemento de uma lista (chama-se last):

ultimo :: [a] -> a
ultimo (h:[]) = h
ultimo (h:[x]) = x
ultimo (h:(x:xs)) = ultimo (x:xs) 

-- testa se um elemento pertence a uma lista (chama-se elem):

pertence :: Eq a => a -> [a] -> Bool
pertence x [] = False
pertence x (h:t) = if x==h then True else pertence x t                     -- ou x==h || pertence x t


{-														AULA 6
	
	(++) -> só faz sentido quando junta 2 funções do mesmo tipo

	_ } usa-se quando não é necessário referir qual é a variável em questão, pois não iremos usá-lo no lado direito.

	fst -> devolve o primeiro elemento de um par
	snd -> devolve o segundo elemento de um par
	
-}

-- Função que junta duas listas (chama-se (++)):

junta :: [a] -> [a] -> [a]
junta [] l2 = l2
junta l1 [] = l1
junta (x:xs) l2 = x : junta xs l2

 -- zip e unzip

zip1 :: [a] -> [b] -> [(a,b)]
zip1 [] [] = []
zip1 [] l2 = []
zip1 l1 [] = []
zip1 (x:xs) (y:ys) = (x,y) : zip xs ys


unzip1 :: [(a,b)] -> ([a],[b])
unzip1 [] = ([],[])
unzip1 ((x,y):t) = ( x : fst (unzip1 t) , y : snd (unzip1 t) )

{-															AULA 7

fst -> calcula o primeiro elemento de um par
snd -> calcula o segundo elemento de um par

Faça a função unzip:

unzip1 :: [(a,b)] -> ([a],[b])
unzip1 [] = ([],[])
unzip1 ((x,y):t) = ( x : fst (unzip1 t) , y : snd (unzip1 t) )
					Aqui vemos que esta função é chamada duas vezes. Logo a mesma vai ser revista várias vezes.
Para evitar isso iremos fazer o seguinte:
unzip1 :: [(a,b)] -> ([a],[b])
unzip1 [] = ([],[])
unzip1 ((x,y):t) = ( x : fst (t1) , y : snd (t1) )
	where t1 = unzip1 t                                   Portanto, o calculo irá ser guardado nesta variável t1.
															Isto irá evitar uma redundância de cálculos.

-> Usamos esta técnica apenas para garantir que os nossos programas ficam um pouco mais eficientes.

Nos tipos, quando aparece => é porque temos o seguinte:
				restrições => tipo
Quando uso Ord, quer dizer que posso usar >, <, >= , <=

-}

-- Função unzip (outra maneira diferente da última aula):

unzip1 :: [(a,b)] -> ([a],[b])
unzip1 [] = ([],[])
unzip1 ((x,y):t) = ( x : fst (t1) , y : snd (t1) )
	where t1 = unzip1 t

-- Outra maneira pode ser:

unzip2 :: [(a,b)] -> ([a],[b])
unzip2 [] = ([],[])
unzip2 ((x,y):t) = ( x : xs , y : ys )             -- isto evita de chamar as funções fst e snd.
	where (xs,ys) = unzip2 t


-- Função pmaior:

pmaior1 :: Ord a => [a] -> Int
pmaior1 [x] = 0											-- não faz sentido calcular o pmaior1 de lista vazia, []
pmaior1 (h:t) = if h > sel t p then 0 else (p + 1)
	where p = pmaior1 t

-- Função auxiliar que dado uma lista e um inteiro, diz-nos qual é o número que está na posição do inteiro que eu dei (chama-se !!)

sel :: [a] -> Int -> a 
sel (h:t) p = if p == 0 then h else sel t (p-1)    -- é (p-1) porque retirei um elemento à lista 

-- Para tornar a função pmaior mais eficiente do que em cima é:

pmaior2 :: Ord a => [a] -> Int
pmaior2 l = snd (pmaiorAux l)


-- Para melhorar a função em cima iremos usar uma função que não calcula apenas a posição que nós queremos, mas também o número nessa posição

pmaiorAux :: Ord a => [a] -> ( a , Int )
pmaiorAux [x] = ( x , 0)
pmaiorAux (h:t) = if h > m then (h,0) else (m,p+1) 
	where (m,p) = pmaiorAux t


--															AULA 8

-- Quero fazer uma função que ordena uma lista por sucessivas inserções (Chama-se iSort):

ordena1 :: Ord a => [a] -> [a]
ordena1 [] = []
ordena1 (h:t) = insere h t1
   where t1 = ordena t

-- a função insere recebe um número e uma lista ordenada e dá como resultado uma lista com o número e essa lista está ordenada.

insere1 :: Ord a => a -> [a] -> [a]
insere1 x [] = [x]
insere1 x (h:t) = if x <= h then x:h:t else h: insere1 x t

-- Outra função que ordena uma lista (chama-se minSort):

ordena2 :: Ord a => [a] -> [a]
ordena2 [] = []
ordena2 l = h : ordena x
  where h = minimo l
        x = remove h l

-- Função auxiliar para calcular o h (calcular o minimo de uma lista)

minimo :: Ord a => [a] -> a
minimo [x] = x
minimo (h:t) = min h (minimo t)

-- Função auxiliar para calcular o t (dá-me uma lista,t, sem o h) -> sabe que o elemento pertence à lista
-- Remove um elemento que EXISTE na lista

remove :: Eq a => a -> [a] -> [a]
remove x [y] = []
remove x (h:t) = if x==h then t else h : remove x t


-- Função que recebe uma lista e dá como resultado Bool (vê-se o elemento se repete mais de uma vez na lista)

xpto :: Ord a => [a] -> Bool
xpto (h:t) = elem h t 

{-                                        AULA 9

 conjuntos por compreensão:

exemplo: {x | x in N && x<10 } = {1,2,3,4,5,6,7,8,9}

No lado esquerdo da igualdade temos um conjunto definido por compreensão e no lado direito temos um conjunto definido por extensão


Em haskell, temos uma definição de listas por compreensão. Aqui o && faz-se com uma vírgula.


-}
-- Outra função de ordenação (TPC). Esta função é conhecida como quickSort (é uma ordenação muito rápida):

ordena3 :: Ord a => [a] -> [a]
ordena3 [] = []
ordena3 (h:t) = (ordena3 men) ++ (h: (ordena3 mai))
   where men = menores h t            -- lista dos elementos de t que são <= a h
         mai = maiores h t            -- lista dos elementos de t que são > a h


menores :: Ord a => a -> [a] -> [a]
menores a [] = []
menores x (a:t)
	| a <= x = a : menores x t
	| otherwise = menores x t 


maiores :: Ord a => a -> [a] -> [a]
maiores a [] = []
maiores x (a:t)
	| a > x = a : maiores x t
	| otherwise = maiores x t

-- Agora escrevendo esta função usando os conjuntos definidos por compreensão:

ordena3 :: Ord a => [a] -> [a]
ordena3 [] = []
ordena3 (h:t) = (ordena3 men) ++ (h: (ordena3 mai))
   where men = [x | x <- t, x <= h]
         mai = [x | x <- t, x > h]

-- se fizermos esta nova definição vamos percorrer duas vezes a lista t. Por isso, vamos escrever uma função que só percorra uma vez 
-- e nos dê um par:

menMai :: Ord a => a -> [a] -> ([a],[a])
menMai x l = (menores x l, maiores x l)        -- estou a percorrer duas vezes a lista na mesma 

-- Logo, vamos fazer de forma a percorrer apenas uma vez a lista

menMai x [] = ([],[])
menMai x (a:as) = if a>x then (p,a:q) else (a:p,q)
    where (p,q) = menMai x as

--Logo, a quickSort fica mais eficiente da seguinte forma:

ordena3 :: Ord a => [a] -> [a]
ordena3 [] = []
ordena3 (h:t) = (ordena3 men) ++ (h: (ordena3 mai))
   where (men,mai) = menMai h t

 --                                                              AULA 10

-- Existe um função de ordenação ainda melhor que o quickSort: o mergeSort (significa fundir):

mergeSort [] = []
mergeSort [x] = [x]                                     -- Tem que se juntar este caso porque se não não iriamos obdecer ao princípio básico das definições recursivas
mergeSort l = juntalistasOrdenadas l1' l2'
     where l1 = take (div (length l) 2) l                                   -- é uma sublista de l com aproximadamente 1/2 elementos 
           l2 = drop (div (length l) 2) l                                   -- é uma sublista de l com os restantes
           l1' = mergeSort l1
           l2' = mergeSort l2
           juntalistasOrdenadas :: Ord a => [a] -> [a] -> [a]
           juntalistasOrdenadas [] b = b
           juntalistasOrdenadas a [] = a
           juntalistasOrdenadas (a:as) (b:bs) = if a<b then a: juntalistasOrdenadas as (b:bs) else b: juntalistasOrdenadas (a:as) bs

-- A função juntalistasOrdenadas é a função merge:
merge :: Ord a => [a] -> [a] -> [a]
merge [] b = b
merge a [] = a
merge (a:as) (b:bs) = if a<b then a: merge as (b:bs) else b: merge (a:as) bs


-- take n l constrói uma lista com os n primeiros elementos de l 
-- drop n l constrói uma lista sem os n primeiros elementos de l 

-- princípio básico das definições recursivas: quando chamava recursivamente tinhamos que ter a certeza que o argumento que estavamos a passar era sempre menor que o argumento original

-- splitAt faz exatamente que o mesmo que o take e o drop ao mesmo tempo (devolve um par de listas em que o primeiro é do take e o segundo é do drop)

-- Para tornarste função mergeSort mais eficiente, ou seja, de forma a só percorrer uma vez a lista l, iremos usar usar um função que faz o take e o drop das listas l1 e l2 ao mesmo tempo:

mergeSort [] = []
mergeSort [x] = [x]                                     
mergeSort l = merge l1' l2'
     where (l1,l2) = parte l         -- desta forma só percorre uma vez a lista, enquanto se usarmos o splitAt percorria várias vezes a lista l                        
           l1' = mergeSort l1
           l2' = mergeSort l2
           merge :: Ord a => [a] -> [a] -> [a]
           merge [] b = b
           merge a [] = a
           merge (a:as) (b:bs) = if a<b then a: merge as (b:bs) else b: merge (a:as) bs


-- Escrevendo a função parte, que devide a lista l e dá um par de listas como resultado:

parte :: [a] -> ([a],[a])
parte [] = ([],[])
parte [x] = ([x],[])
parte (x1:x2:xs) = (x1:xs1,x2:xs2)
        where (xs1,xs2) = parte xs


-- Exercício 35 das 50 questões:

menor :: String -> String -> Bool
menor [] [] = False 
menor [] (y:ys) = True
menor (x:xs) [] = False
menor (x:xs) (y:ys) | x>y = False
                    | x<y = True
                    | x==y = menor xs ys 

--                                                    AULA 11
-- Exercicio das 50 questões : elemIndices

elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices x l = xpto 0 x l 

xpto :: Eq a => Int -> a -> [a] -> [Int]
xpto p x [] = []
xpto p x (h:t) | x==h = p : xpto (p+1) x t
	           | x/=h = xpto (p+1) x t 


-- Outro exemplo de uso de acumuladores:

soma :: Num a => [a] -> a
soma l = somaxpto 0 l          


somaxpto :: Num a => a -> [a] -> a
somaxpto ac [] = ac
somaxpto ac (h:t) = somaxpto (ac+h) t


-- Escrevendo a função reverse de outra maneira, mais eficiente, usando acumuladores:

reverse :: [a] -> [a]
reverse l = fxpto [] l

fxpto :: [a] -> [a] -> [a]
fxpto ac [] = ac
fxpto ac (h:t) = fxpto (h:ac) t

--														AULA 12

-- Exercício 50 das 50 questões:

data Semaforo = Verde | Amarelo | Vermelho
deriving Show

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK l = (contanaovermelhos l) <= 1
	where contanaovermelhos :: [Semaforo] -> Int
	      contanaovermelhos [] = 0
	      contanaovermelhos (Vermelho:t) = contanaovermelhos t
	      contanaovermelhos (_:t) = 1 + contanaovermelhos t


--Função que multiplica todos os elementos da lista por 2

dobros :: [Int] -> [Int]
dobros [] = []
dobros (x:xs) = (2*h):dobros t

--Função que multiplica todos os elementos da lista por 3

triplos :: [Int] -> [Int]
triplos [] = []
triplos (x:xs) = (3*h):triplos t

--Função que soma a todos os elementos da lista, um

maisUm :: [Int] -> [Int]
maisUm [] = []
maisUm (x:xs) = (h+1):maisUm t

-- No fundo, estas 3 últimas funções são da seguinte forma:

xxxxxx :: (a -> b) -> [a] -> [b]
xxxxxx muda [] = []
xxxxxx muda (h:t) = (muda h): (xxxxxx muda t)

-- Também posso escrever por compreensão

xxxxxx muda l = [muda x | x <- l]

-- Logo, vamos ter que:

dobros l = xxxxxx f l
	where f x = 2*x

triplos l = xxxxxx f l
	where f x = 3*x

maisUm l = xxxxxx f l
	where f x = 1+x

-- Isto são funções que recebem funções como argumento -> função de ordem superior

-- A função xxxxxx é a função map:

map :: (a->b) -> [a] -> [b]

-- Por isso, ficamos com :

dobros l = map f l
	where f x = 2*x

triplos l = map f l
	where f x = 3*x

maisUm l = map f l
	where f x = 1+x

{- 

Igualdade de funções : 
		f==g acontece se f x == g x

-}

--                                                        AULA 13

-- Outra maneira de escrever a função dobros, onde f é representada por *2 pois temos que:

f x = 2*x
    = (2*) x                  -- aqui o 2* é uma função também, daí termos que f = *2


dobros l = map (*2) l

-- Escrevendo de outra forma:

f x y = (f x) y

dobros l = (map (*2)) l 

-- Logo vamos ter que:
			
dobros :: [Int] -> [Int]
dobros = map (2*)

-- Função filter -> dada uma lista, seleciona apenas uns elementos dessa lista

filter :: (a->Bool) -> [a] -> [a]
filter teste [] = []
filter teste (h:t) = if (teste h) then h: filter teste t
								  else filter teste t 

-- odd -> seleciona todos os elementos que são ímpares

-- Função takeWhile -> faz quase o mesmo que a filter, seleciona apenas um prefixo

takeWhile :: (a->Bool) -> [a] -> [a]
takeWhile teste [] = []
takeWhile teste (h:t) = if teste h then h:takeWhile teste t
                                   else []

--                                                         AULA 14

-- Função que, ao contrário do takeWhile, vai retirar o prefixo da lista:

dropWhile :: (a->Bool) -> [a] -> [a]
dropWhile teste [] = []
dropWhile teste (h:t) = if teste h then dropWhile teste t
	                               else (h:t)


-- Função parecida com o zip:

zipWith :: (a->b->c) -> [a] -> [b] -> [c]
zipWith f [] _ = []
zipWith f _ [] = []
zipWith f (x:xs) (y:ys) = (f x y): zipWith f xs ys

-- 					Matrizes e assim:

type Matriz = [Linha]
type Linha = [Int]

-- para fazer a soma de duas matrizes:

somaM :: Matriz -> Matriz -> Matriz
somaM [] [] = []
somaM l1 l2 = zipWith (somaLinhas) l1 l2                        --somaM (l:ls) (k:ks) = (somaLinhas l k): somaM ls ks

somaLinhas :: Linha -> Linha -> Linha
somaLinhas [] []= []
somaLinhas l1 l2 = zipWith (+) l1 l2                            --somaLinhas (x:xs) (y:ys) = (x+y):somaLinhas xs ys

-- Esta linha é igual a :

(somaLinhas l1) l2 = ((zipWith (+)) l1) l2
(somaLinhas l1) = ((zipWith (+)) l1) 
 somaLinhas = zipWith (+)

-- Logo a linha de 341 temos que:

somaM = zipWith (zipWith (+))

--                                                          AULA 15

-- Função para somar uma lista de inteiros:

soma :: [Int] -> Int
soma [] = 0 
soma (h:t) = (+) h (soma t)

concatena :: [[a]] -> [a]
concatena [] = []
concatena (h:t) = (++) h (concatena t)

iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = insert h (iSort t)
	where insert x [] = [x]
	      insert x (y:ys) | x <= y = x:y:ys
	                      | otherwise = y:(insert x ys)

{-

	Funções infixas -> operador "entre" os operandos: *, +, /, !!
podem ser usadas em mod prefixo, englobando-as em ()

	Funções prefixas -> operador aparece "antes" dos operandos: div, mod, elem
podem ser usadas em modo infixo englobando-as entre ''


-}

-- Verificamos que as três funções anteriores percorrem sempre a lista e produzem alguma coisas. Por isso, podemos fazer:

precorre :: (a -> b -> b) -> b -> [a] -> b
precorre juntar v [] = v
precorre juntar v (h:t) = juntar h (precorre juntar v t)

-- Logo substituindo nas funções em cima:

soma l = precorre (+) 0 l 
soma = precorre (+) 0

concatena l = precorre (++) [] l
concatena = precorre (++) []

iSort l = precorre insert [] l 
iSort = precorre insert []

-- Em Haskell, esta função percorre chama-se foldr

func l = foldr (:) [] l                        -- Função identidade

func [] = []
func (h:t) = (:) h (func t)              -- ou escrever h:(func t)


-- o foldr ( o r vem de right, ou sej, direita)

-- soma' de tal forma que soma' [1,2,3,4] = (((0+1)+2)+3)+4, para isto usamos um acumulador:

soma' l = somaAc 0 l
	somaAc ac [] = ac
	somaAc ac (h:t) = somaAc (ac+h) t

-- Iremos fazer um precorre que sirva para soma':

precorrel :: 
precorrel junta v [] = v
precorrel junta v (h:t) = precorrel junta (junta v h) t


--                                                           AULA 16

map :: (a->b) -> [a] -> [b]
map f [] = []
map f (h:t) = (f h) : map f t

-- Fazendo o nosso tipo de listas:

data Lista a = Vazia | N a (Lista a)

-- Fazendo a função comprimento seguindo a nossa definição em cima:

comp :: [a] -> [a]
comp [] = 0
com (N x xs) = 1 + comp xs

-- Escrevendo [1,2,3] da forma de cima: N 1 (N 2 (N 3 Vazia)) :: Lista Int

-- Generalizando,em vez de ter tudo em fila, iremos ter tudo em 2 blocos:

data ListaX a = Vazia
              | N a (ListaX a) (ListaX a)

-- Exemplos do tipo apresentado:

a1 , a2, a3, a4 :: ListaX Int

a1 = Vazia
a2 = N 0 Vazia Vazia
a3 = N 5 (N 6 Vazia Vazia) 
         (N 7 Vazia Vazia)
a4 = N 5 Vazia 
         (N 4 (N 1 Vazia Vazia) 
         	  (N 3 Vazia Vazia))

-- Normalmente a ListaX é conhecida por árvore binária, ou seja, ABin !

data ABin a = Vazia
              | N a (ABin a) (ABin a) deriving Show

-- Generalizando a função comprimento para as árvores binárias vou ter que:

comp :: ABin a -> Int
comp Vazia = 0
comp N x y z = 1 + (comp y) + (comp z)

-- Altura da árvore (caminho mais longo):

altura :: ABin a -> Int
altura Vazia = 0
altura N x y z = 1 + max (altura y) (altura z)

-- Generalizando a função map para Abin:

mapAbin :: (a -> b) -> (ABin a) -> (ABin b)
mapAbin f Vazia = Vazia
mapAbin f (N r e d) = N (f r) (mapAbin f e) (mapAbin f d)

--                                                          AULA 17

elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem x (h:t) | x == h = True
             | otherwise = elem x t

-- Função elem0 que vai assumir que a lista está ordenada por ordem crescente:

elem0 :: Ord a => a -> [a] -> Bool
elem0 _ [] = False
elem0 x (h:t) | x==h = True
              | x < h = False
              | otherwise = elem0 x t 

-- Generalizando a função elem para as árvores:

elemA :: Eq a => a -> ABin a -> Bool
elemA _ Vazia = False
elemA x (N r e d) | x==r = True
                  | otherwise = (elemA x e) || (elemA x d) 


{- 

-> Árvores binárias ordenadas são chamadas de árvores binárias de procura. 

		Os seus elementos da esquerda são todos menores ou iguais à raiz.
		Os seus elementos da direita são todos maiores ou iguais à raiz.

Por isso, os elementos à esquerda são todos menores ou iguais aos elementos da direita! -> esta propriedade tem que acontecer sempre ao longo da árvore

-}

-- Generalizando a função elem0 para as árvores de procura (muito mais eficiente que a elemA):

procura :: Ord a => a -> ABin a -> Bool
procura _ Vazia = False
procura x (N r e d) | x==h = True
                    | x < r = procura x e
                    | otherwise = procura x d 


-- Função que acrescenta um elemento a uma árvore de procura:

acrescenta :: Ord a => a -> ABin a -> ABin a 
acrescenta x Vazia = N x Vazia Vazia
acrescenta x (N r e d) | x <= r = N r (acrescenta x e) d
                       | otherwise = N r e (acrescenta x d)

-- Dada uma lista, organizar os elementos numa árvore de procura:

fromList :: Ord a => [a] -> ABin a
fromList [] = Empty
fromList (h:t) = acrescenta h (fromList t)

-- Como estamos aqui a percorrer uma lista, vamos ter que:

fromList l = foldr acrescenta Empty l 


-- Função, que dada uma árvore de procura não vazia, dá o maior elemento da árvore:

maior :: ABin a -> a 
maior (N r e Empty) = r 
maior (N r e d) = maior d 


--                                                          AULA 18

(+) :: Int -> Int -> Int       -- muito restritiva

-- Outra alternativa seria:

(+) :: a -> a -> a                -- continua a permitir que eu some coisas que não dá

-- Eu só quero a soma para alguns a, e para isso usamos classes:

(+) :: Num a => a -> a -> a
--     (tipo da função) a -> a -> a
--     (tipo da função a) a é uma instância da classe Num

-- Classes -> tipos dos tipos 

--Classes em Haskell:
	--Podemos ver isto de duas formas:
		--1) definir uma classe -> vou criar uma categoria e os elementos dessa categoria são tipos

class (Nome da classe) a where         -- isto significa a classe (Nome da classe, letra maiúscula) é constituída pelos tipos em que ....
	 restrições                              -- enumerar funções que têm que existir 

-- Classe mais pequena:

class Eq a where                   -- a classe Eq é constituída pelos tipos a em que ...
	(==) :: a -> a -> Bool
	(/=) :: a -> a -> Bool

		--2) definir instâncias

instance CLASSE Tipo where     -- definir tipo como um elemento de CLASSE
	
-- Exemplo:

data BTRee a = Empty | Node a (BTRee a) (BTRee b)

-- fazer com que BTRee a seja uma instância de Eq

instance Eq a => Eq (BTRee a) where
	 -- definir as funções == e /= com os tipos respetivos
	 --- (==) :: BTRee a -> BTRee a -> Bool
	 Empty = Empty = True
	 (Node x y z) == (Node p q r) =  (x==p)
	                              && (y==p)
	                              && (z==r)
     _ == _ = False

	 -- (/=) :: BTRee a -> BTRee a -> Bool
	 a1 /= a2 = not (a1 == a2)


x, y :: BTRee Int 
x = Empty
y = Node 3 Empty Empty

-- Mas em vez de isto tudo bastava escrever :

data BTRee a = Empty | Node a (BTRee a) (BTRee b)
	deriving Eq                                           -- Faz com haja comparação entre as coisas textuais

-- Mas se agora quisessemos comparar duas BTRee que tem a mesma forma mas o conteúdo diferente tínhamos que fazer:

instance Eq (BTRee a) where
	 -- definir as funções == e /= com os tipos respetivos
	 --- (==) :: BTRee a -> BTRee a -> Bool
	 Empty = Empty = True
	 (Node x y z) == (Node p q r) = (y==p) && (z==r)
     _ == _ = False

	 -- (/=) :: BTRee a -> BTRee a -> Bool
	 a1 /= a2 = not (a1 == a2)


--                                                        AULA 19

-- Para haver interação com o utilizador, temos que criar um programa:

dialogo :: IO ()
dialogo =  do putStr ("Digite o seu nome: ")
			  n <- getLine
              putStr ("Olá " ++ x ++ "\n")


-- Para gerar um número aleatório tinhamos que usar:

random :: Int -> Int -> IO Int                  -- porque mesmo estando sempre a dar os mesmo números, o resultado irá sempre ser diferente

-- Programa que gera uma lista:

randomList :: Int -> (Int,Int) -> IO [Int]
	-- randomList n (i,s) produz uma lista com n números entre i e s
randomList 0 (i,s) = return []                      -- return quando quero dar bastatas e só tenho uma batata
randomList n (i,s) = do x <- randomRIO (i,s)
                        xs <- randoList (n-1) (i,s) 
                        return (x:xs)


--                                                             AULA 20

-- Permutação:

permutacao :: [a] -> IO [a]
permutacao [] = return []
permutacao (x:xs) = do x <- permutacao t  
	                   insereASorte h x


insereASorte :: a -> [a] -> IO [a]
insereASorte x [] = return [x]
insereASorte x l = do p <- randomRIO (0, length l - 1)
                      let (a,b) = splitAt p l
                      return (a ++ (x:b))


-- wc

wordCount :: String -> IO (Int, Int, Int)
wordCount nome = do conteudo <- readFile nome 
					let linhas = length (lines conteudo)
					let palavras = length (words conteudo)
					let caracteres = length conteudo 
					return (linhas, palavras, caracteres)


