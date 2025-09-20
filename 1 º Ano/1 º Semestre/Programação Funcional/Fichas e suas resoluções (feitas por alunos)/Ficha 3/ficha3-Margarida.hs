--ex1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# HLINT ignore "Use infix" #-}
data Hora = H Int Int
    deriving Show
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

v1 :: [Etapa]
v1 = [(H 9 30, H 10 25), (H 11 20, H 12 45), (H 13 30, H 14 45)]

alinea_a :: Etapa -> Bool
alinea_a (H h1 m1,H h2 m2)
    | h2 < h1 = False
    | h2 == h1 && m2 < m1 = False
    | h1 < 0 || h2 < 0 || h1 > 23 || h2 > 23 = False
    | m1 < 0 || m2 < 0 || m1 > 59 || m2 > 59 = False
    | otherwise = True

alinea_b :: Viagem -> Bool
alinea_b [x] = True
alinea_b ((h, H h1 m1):t) = (h2 > h1 || h2 == h1 && m2 > m1 ) && alinea_b t
    where (H h2 m2, h3) = head t

alinea_c :: Viagem -> (Hora, Hora)
alinea_c v = (H h1 m1, H h4 m4)
    where (H h1 m1, H h2 m2) = head v
          (H h3 m3, H h4 m4) = last v

alinea_d :: Viagem -> Hora
alinea_d [] = H 0 0
alinea_d v = H (div (soma_tempo v) 60) ( mod (soma_tempo v) 60)

tempo :: Etapa -> Int
tempo (H h1 m1,H h2 m2)
    | h1 == h2 = m2 - m1
    | otherwise = (h2-h1)*60 + (m2-m1)

soma_tempo :: Viagem -> Int
soma_tempo [] = 0
soma_tempo [etapa] = tempo etapa
soma_tempo (e:es) = tempo e + soma_tempo es

alinea_e :: Viagem -> Hora
alinea_e v = sub_horas (horas_gastas v) (alinea_d v)

tempo_total :: Viagem -> Int
tempo_total [] = 0
tempo_total v
    | h1 == h4 = m4 - m1
    | otherwise = (h4-h1)*60 + (m4-m1)
    where (H h1 m1, H h2 m2) = head v
          (H h3 m3, H h4 m4) = last v

horas_gastas :: Viagem -> Hora
horas_gastas v = H (div (tempo_total v ) 60) ( mod (tempo_total v) 60)

sub_horas :: Hora -> Hora -> Hora
sub_horas (H h1 m1) (H h2 m2)
    | h2 == h1 = H 0 (m1-m2)
    | otherwise = H (div x 60) (mod x 60)
    where x = (h1-h2)*60 + (m1-m2)

alinea_f :: Viagem -> Hora
alinea_f = horas_gastas

--ex2
data Ponto = Cartesiano Double Double | Polar Double Double
    deriving (Show,Eq)
type Poligonal = [Ponto]

posx1 :: Ponto -> Double
posx1 (Cartesiano x y) = x
posx1 (Polar d a) = d * cos a --retirado da ficha1, ex6

posy1 :: Ponto -> Double
posy1 (Cartesiano x y) = y
posy1 (Polar d a) = d * sin a --retirado da ficha1, ex6

dist1' :: Ponto -> Ponto -> Double
dist1' p1 p2 = sqrt ((posx1 p1 -posx1 p2)^2 + (posy1 p1 - posy1 p2)^2) --retirado da ficha1, ex6

comprimento :: Poligonal -> Double
comprimento [] = 0
comprimento [p] = 0
comprimento (h:t) = dist1' h (head t) + comprimento t

linhaFechada :: Poligonal -> Bool
linhaFechada [] = True
linhaFechada l = head l == last l

data Figura = Circulo Ponto Double
    | Rectangulo Ponto Ponto
    | Triangulo Ponto Ponto Ponto
    deriving (Show,Eq)

triangula1 :: Poligonal -> [Figura]
triangula1 [] = []
triangula1 [p1] = [] 
triangula1 [p1,p2] = []
triangula1 [p1,p2,p3] = [Triangulo p1 p2 p3] 
triangula1 (h:t) = auxTriangula h t
                            
auxTriangula :: Ponto -> [Ponto] -> [Figura]
auxTriangula x [] = []
auxTriangula x [h] = []
auxTriangula x (h:t) = Triangulo x h (head t) : auxTriangula x t

--pontoMedio :: Ponto -> Ponto -> Ponto
--pontoMedio (Cartesiano x1 y1) (Cartesiano x2 y2) = Cartesiano ((x1+x2)/2) ((y1+y2)/2)

area1 :: Figura -> Double
area1 (Triangulo p1 p2 p3) =
    let a = dist1' p1 p2
        b = dist1' p2 p3
        c = dist1' p3 p1
        s = (a+b+c) / 2 
    in sqrt (s*(s-a)*(s-b)*(s-c))
area1 (Rectangulo p1 p2) = abs (posx1 p1 - posx1 p2)* abs (posy1 p1 - posy1 p2)
area1 (Circulo p r) = pi * r^2 --retirado da ficha1, ex7

areaLinhaPoligonal :: Poligonal -> Double
areaLinhaPoligonal l = sum (map area1 (triangula1 l))
                --esta função 1) divide a linha poligonal em triangulos
                --            2) calcula a area de cada um desses triangulos
                --            3) soma as areas calculadas

mover1 :: Poligonal -> Ponto -> Poligonal
mover1 [] p = []
mover1 [p1] p2 = [p2]
mover1 (h:t) p2 = Cartesiano (x1+x2) (y1+y2) : mover1 t p2
    where (Cartesiano x1 y1) = polarToCartesiano h
          (Cartesiano x2 y2) = polarToCartesiano p2   

vetorAssociado :: Ponto -> Ponto -> Ponto
vetorAssociado (Cartesiano x1 y1) (Cartesiano x2 y2) = Cartesiano (x2-x1) (y2-y1)
vetorAssociado (Polar d1 a1) (Polar d2 a2) = vetorAssociado (polarToCartesiano (Polar d1 a1)) (polarToCartesiano (Polar d2 a2))
vetorAssociado (Polar d1 a1) (Cartesiano x1 y1) = vetorAssociado (polarToCartesiano (Polar d1 a1))(Cartesiano x1 y1)
vetorAssociado (Cartesiano x1 y1) (Polar d1 a1) = vetorAssociado (Cartesiano x1 y1) (polarToCartesiano (Polar d1 a1))


polarToCartesiano :: Ponto -> Ponto
polarToCartesiano (Cartesiano x y) = Cartesiano x y
polarToCartesiano (Polar d a) = Cartesiano (d * cos a) (d* sin a)


zoom1 :: Double -> Poligonal -> Poligonal
zoom1 _ [] = []
zoom1 0 l = []
zoom1 n [p] = [p]
zoom1 n (h:t) = h : auxZoom n h t

auxZoom :: Double -> Ponto -> Poligonal -> Poligonal
auxZoom n h [] = []
auxZoom n x (h:t) = Cartesiano (x1 + n*x2) (y1 + n*y2) : auxZoom n x t
    where Cartesiano x1 y1 = polarToCartesiano h
          Cartesiano x2 y2 = vetorAssociado x h

--ex3
data Contacto = Casa Integer
    | Trab Integer
    | Tlm Integer
    | Email String
    deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]

acrescEmail1 :: Nome -> String -> Agenda -> Agenda
acrescEmail1 nome email [] = [(nome,[Email email])]
acrescEmail1 nome email ((nome2, info) :t)
    | nome == nome2 = (nome, info++ [Email email]):t
    | otherwise = acrescEmail1 nome email t

verEmails1 :: Nome -> Agenda -> Maybe [String]
verEmails1 nome [] = Nothing
verEmails1 nome ((nome2, info) :t)
    | nome == nome2 = aux_email info [""]
    | otherwise = verEmails1 nome t

aux_email :: [Contacto] -> [String] -> Maybe [String]
aux_email [] s = Just s
aux_email (Email email :t) s = aux_email t (s ++ [email])
aux_email (_:t) s = aux_email t s

consTelefs1 :: [Contacto] -> [Integer]
consTelefs1 [] = []
consTelefs1 ((Casa n):t) = n : consTelefs1 t
consTelefs1 ((Trab n):t) = n : consTelefs1 t
consTelefs1 ((Tlm n):t) = n : consTelefs1 t
consTelefs1 ((Email n):t) = consTelefs1 t

casa1 :: Nome -> Agenda -> Maybe Integer
casa1 nome [] = Nothing
casa1 nome ((nome2, info) :t)
    | nome == nome2 = aux_casa info
    | otherwise = casa1 nome t

aux_casa :: [Contacto] -> Maybe Integer
aux_casa [] = Nothing
aux_casa (Casa n :t) = Just n
aux_casa (_:t) = aux_casa t

--ex4
type Dia = Int
type Mes = Int
type Ano = Int
type Nomes = String --mudei o nome do tipo de "Nome" para "Nomes" para não ser igual ao do ex anterior e dar erro

data Data = D Dia Mes Ano
    deriving Show
type TabDN = [(Nome,Data)]

procura1 :: Nomes -> TabDN -> Maybe Data
procura1 nome [] = Nothing
procura1 nome ((nome2,D d m a):t)
    | nome == nome2 = Just (D d m a)
    | otherwise = procura1 nome t

idade1 :: Data -> Nomes -> TabDN -> Maybe Int
idade1 (D d1 m1 a1) nome [] = Nothing
idade1 (D d1 m1 a1) nome ((nome2,D d2 m2 a2):t)
    | m1 > m2 || m1 == m2 && d1 > d2 = Just (a1-a2)
    | otherwise = Just (a1-a2-1)

anterior1 :: Data -> Data -> Bool
anterior1 (D d1 m1 a1) (D d2 m2 a2)
    | a2 > a1 = True
    | a2 == a1 && m2 > m1 = True
    | a2 == a1 && m2 == m1 && d2 > d1 = True
    | otherwise = False

ordena1 :: TabDN -> TabDN
ordena1 [] = []
ordena1 [(n,d)] = [(n,d)]
ordena1 ((nome1,data1):t) = if anterior1 data1 data2
                            then (nome1,data1) : t2
                            else (nome2,data2) : ordena1 ((nome1,data1):t2)
                                where (nome2,data2):t2 = ordena1 t

porIdade1 :: Data -> TabDN -> [(Nomes,Int)]
porIdade1 d [] = []
porIdade1 d nomes = ordena2 (aux_idade d nomes)

aux_idade :: Data -> TabDN -> [(Nomes,Int)]
aux_idade (D d1 m1 a1) ((nome1,D d2 m2 a2):t)
    | m1 > m2 || m1 == m2 && d1 > d2 = (nome1,a1-a2): aux_idade (D d1 m1 a1) t
    | otherwise = (nome1,a1-a2-1): aux_idade (D d1 m1 a1) t

ordena2 :: Ord Int => [(String, Int)] -> [(String, Int)]
ordena2 [] = []
ordena2 [(n,i)] = [(n,i)]
ordena2 ((n,i):t) = if i <= i2
                    then (n,i):(n2,i2):t2
                    else (n2,i2): ordena2 ((n,i):t2)
                        where (n2,i2):t2 = ordena2 t

--extra
dataDepois :: Ord Data => Data -> Data -> Ordering
dataDepois (D d1 m1 a1) (D d2 m2 a2)
    | a2 > a1 = GT
    | a2 == a1 && m2 > m1 = GT
    | a2 == a1 && m2 == m1 && d2 > d1 = GT
    | a2 == a1 && m2 == m1 && d2 == d1 = EQ
    | otherwise = LT

--ex5

data Movimento = Credito Float | Debito Float
    deriving Show
data Datas = Ds Int Int Int --mudei o tipo para nao interferir no outro
    deriving Show
data Extracto = Ext Float [(Datas, String, Movimento)]
    deriving Show

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext saldo []) valor = []
extValor (Ext saldo ((date, descricao, Credito x):t)) valor = if x > valor
                                                              then Credito x: extValor (Ext saldo t) valor
                                                              else extValor (Ext saldo t) valor
extValor (Ext saldo ((date, descricao, Debito x):t)) valor = if x > valor
                                                             then Debito x: extValor (Ext saldo t) valor
                                                             else extValor (Ext saldo t) valor

filtro1 :: Extracto -> [String] -> [(Datas,Movimento)]
filtro1 (Ext saldo []) s = []
filtro1 (Ext saldo ((date, descricao, mov):t)) s
    | elem descricao s = (date,mov) : filtro1 (Ext saldo t) s
    | otherwise = filtro1 (Ext saldo t) s

creDeb1 :: Extracto -> (Float,Float)
creDeb1 (Ext saldo []) = (0,0)
creDeb1 (Ext saldo ((date, descricao, Credito x):t)) = (x+c,d)
    where (c,d) = creDeb1 (Ext saldo t)
creDeb1 (Ext saldo ((date, descricao, Debito x):t)) = (c,x+d)
    where (c,d) = creDeb1 (Ext saldo t)

saldo1 :: Extracto -> Float
saldo1 (Ext saldo []) = saldo
saldo1 (Ext s x) = s + c - d
    where (c,d) = creDeb1 (Ext s x)




