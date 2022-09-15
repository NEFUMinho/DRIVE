--1
data Hora = H Int Int deriving Show
type Etapa = (Hora,Hora) 
type Viagem = [Etapa]
a=[(H 9 30, H 10 25), (H 11 20, H 12 45), (H 13 30, H 14 45)]
--a
eEtapa :: Etapa -> Bool
eEtapa (H h1 m1,H h2 m2) 
 | h2>h1 = True
 | h1==h2 && m2>m1 = True
 | otherwise = False
--b
eViagem :: Viagem -> Bool
eViagem [] = True
eViagem [x] = eEtapa x
eViagem ((H h1 m1,H h2 m2):(H h3 m3,H h4 m4):t) = eEtapa (H h1 m1,H h2 m2) && eEtapa (H h2 m2,H h3 m3) && eViagem ((H h3 m3,H h4 m4):t)
--c
horas :: Viagem -> Etapa
horas [] = (H 0 0,H 0 0)
horas v = (fst(head v),snd(last v))
--d
diferença :: Hora -> Hora -> Int
diferença (H h1 m1) (H h2 m2) = (h1-h2)*60+(m1-m2)

viageme :: Viagem -> Int 
viageme [] = 0
viageme ((h1,h2):t) = (diferença h2 h1)+viageme t
--e
espera :: Viagem -> Int 
espera [] = 0
espera [h] = 0
espera ((h1,h2):(h3,h4):t) = (diferença h3 h2)+ espera ((h3,h4):t)
--f
viagemt :: Viagem -> Int
viagemt v = let (h1,h2) = horas v
 in diferença h2 h1
--2
type Poligonal = [Ponto]
data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)
data Figura = Circulo Ponto Double | Retangulo Ponto Ponto | Triangulo Ponto Ponto Ponto deriving (Show,Eq)
--a
dist :: Ponto -> Ponto -> Double 
dist (Cartesiano x y) (Cartesiano a b) = sqrt((x-a)^2+(y-b)^2)
dist (Polar x y) (Polar a b) = 
 let x'=x*(cos y)
     y'=x*(sin y)
     a'=a*(cos b)
     b'=a*(sin b)
 in sqrt((x'-a')^2+(y'-b')^2)
comp :: Poligonal -> Double
comp [] = 0
comp [x] = 0
comp (h:x:t) = (dist x h)+comp (x:t)
--b
efechada :: Poligonal -> Bool
efechada l = (head l)==(last l)
--c
triangula :: Poligonal -> [Figura]
triangula [p1,p2,p3] = [(Triangulo p1 p2 p3)]
triangula (p1:p2:p3:ps) = (Triangulo p1 p2 p3):triangula (p1:p3:ps)
--d
areaPol :: Poligonal -> Double
areaPol p = sum(map area (triangula p))

posx :: Ponto -> Double 
posx (Cartesiano x y) = sqrt(x^2)
posx (Polar x y) = sqrt((x*(cos y))^2)

posy :: Ponto -> Double
posy (Cartesiano x y) = sqrt(y^2) 
posy (Polar x y) = sqrt((x*(sin y))^2)

area :: Figura -> Double
area (Circulo p r) =  pi*r
area (Retangulo p1 p2) = 
 let b= (posx p2)-(posx p1)
     h= (posy p2)-(posy p1) 
 in (abs b)*(abs h)
area (Triangulo p1 p2 p3) = 
 let a = dist p1 p2 
     b = dist p2 p3 
     c = dist p3 p1 
     s = (a+b+c) / 2 -- semi-perimetro 
 in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron 
--e
mover :: [(Double,Double)] -> (Double,Double) -> [(Double,Double)]
mover [] _ = [] 
mover (h:t) p = let v= dif p h 
 in p:[soma g v|g<-t] 

dif :: (Double,Double) -> (Double,Double) -> (Double,Double)
dif (x,y) (a,b) = (x-a,y-b)

soma :: (Double,Double) -> (Double,Double) -> (Double,Double)
soma (x,y) (a,b) = (x+a,y+b)
--3
data Contacto = Casa Integer | Trab Integer | Tlm Integer | Email String deriving Show
type Nome = String 
type Agenda = [(Nome, [Contacto])]
--a
acrescEmail :: Nome -> String -> Agenda -> Agenda 
acrescEmail n e [] = [(n,[Email e])]
acrescEmail n e ((h,c):t) = if n==h then ((h,c++[Email e]):t) else (h,c):(acrescEmail n e t)
--b
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((n',c):t)= if n==n' then Just (emails c) else verEmails n t
 where emails :: [Contacto] -> [String]
       emails [] = []
       emails ((Email e):t) = e:emails t
       emails (h:t) = emails t
--c
consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs ((Casa n):t) = n:consTelefs t
consTelefs ((Trab n):t) = n:consTelefs t
consTelefs ((Tlm n):t) = n:consTelefs t
consTelefs (h:t) = consTelefs t
--d
casa :: Nome -> Agenda -> Maybe Integer 
casa n [] = Nothing
casa n ((n',c):t) = if n==n' then casas n c else casa n t
 where casas n ((Casa x):t) = Just x 
       casas n _ = Nothing
--4
type Dia = Int 
type Mes = Int 
type Ano = Int 
data Data = D Dia Mes Ano deriving Show
type TabDN = [(Nome,Data)]
--a
procura :: Nome -> TabDN -> Maybe Data
procura n [] = Nothing
procura n ((n',d):t) = if n==n' then Just d else procura n t
--b
idade :: Data -> Nome -> TabDN -> Maybe Int
idade (D d1 m1 a2) n t 
 | a1==a2 = Nothing
 | m1>m2 = Just (a2-a1) 
 | m1==m2 && d1>d2 = Just (a2-a1)
 | otherwise = Just (a2-a1-1)
 where Just (D d2 m2 a1) = procura n t 
--c
anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) = a1<a2 || (a1==a2 && m1<m2) || (a1==a2 && m1==m2 && d1<d2)
--d
ordena :: TabDN -> TabDN
ordena [] = []
ordena (d:t) = insert d (ordena t)
 where insert d [] = [d] 
       insert (n,d) ((n',d'):t) =  if anterior d d' then (n,d):(n',d'):t else (n',d'):insert (n,d) t
--e
porIdade:: Data -> TabDN -> [(Nome,Int)]
porIdade _ [] = []
porIdade h tb = let ((n,d):t) = ordena tb
                    Just i = idade h n [(n,d)] 
 in (porIdade h t)++[(n,i)]
--5
data Movimento = Credito Float | Debito Float deriving Show
data Extracto = Ext Float [(Data, String, Movimento)] deriving Show
--a
extValor :: Extracto -> Float -> [Movimento]
extValor (Ext e []) _ = []
extValor (Ext e ((d,s,Credito v):t)) v' = if v>v' then (Credito v):extValor (Ext e t) v' else extValor (Ext e t) v'
extValor (Ext e ((d,s,Debito v):t)) v' = if v>v' then (Debito v):extValor (Ext e t) v' else extValor (Ext e t) v'
extValor (Ext e (h:t)) v = (extValor (Ext e t) v)
--b
filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext _ []) _ = []
filtro e [] = []
filtro e (h:t) = (one (e) h )++(filtro (e) t)

one :: Extracto -> String -> [(Data,Movimento)]
one (Ext _ []) _ = []
one (Ext v ((d,f,m):t)) s = if f==s then (d,m):(one (Ext v t) s) else one (Ext v t) s
--c
creDeb :: Extracto -> (Float,Float)
creDeb (Ext _ []) = (0,0)
creDeb (Ext _ l) = aux l (0,0)
 where aux [] (c,d) = (c,d) 
       aux ((_,s,Credito v):t) (c,d) = aux t (c+v,d)
       aux ((_,_,Debito v):t) (c,d) = aux t (c,d+v)
--d
saldo :: Extracto -> Float 
saldo (Ext e []) = e
saldo (Ext e ((d,s,m):t)) = aux ((d,s,m):t) e
 where aux [] e = e 
       aux ((d,s,Debito v):t) e = aux t e-v
       aux ((d,s,Credito v):t) e = aux t e+v





















