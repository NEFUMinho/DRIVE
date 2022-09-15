  module Ficha3 where
  
  import Ficha1 as F1
--ex.1

  data Hora = H Int Int
     deriving Show
  type Etapa = (Hora,Hora)
  type Viagem = [Etapa]

  -- (a)

  testE :: Etapa -> Bool 
  testE (H h1 m1, H h2 m2) | elem h1 [0..23] && elem m1 [0..59] && elem h2 [0..23] && elem m2 [0..59] = testE' (H h1 m1, H h2 m2)
                           | otherwise = False

  testE' :: Etapa -> Bool
  testE' (H h1 m1, H h2 m2) | h1 == h2 && m1 < m2 = True
                            | h1 < h2 = True
                            | otherwise = False 
  -- (b)

  testV :: Viagem -> Bool
  testV ((h1,h2):[]) = testE (h1,h2)
  testV ((h1,h2):(h3,h4): hs) | testE (h1,h2) && testE (h2,h3) && testV ((h3,h4) : hs) = True
                              | otherwise = False

  -- (c)

  partcheg :: Viagem -> Etapa 
  partcheg [] = (H 0 0,H 0 0) 
  partcheg viag = (fst(head viag) , snd(last viag))

  -- (d)

  tempV :: Viagem -> Hora
  tempV [] = H 0 0
  tempV ((h1,h2):hs) = minThor (tempV' ((h1,h2):hs))
   
  tempV' :: Viagem -> Int
  tempV' [] = 0 
  tempV' ((h1,h2):hs) = (diferencaH h2 h1) + tempV' hs

  diferencaH :: Hora -> Hora -> Int
  diferencaH (H h1 m1) (H h2 m2) = (h1-h2)*60+(m1-m2)

  minThor :: Int -> Hora
  minThor 0 = H 0 0
  minThor n = H a b 
         where a = div n 60
               b = mod n 60  
  -- (e)
  
  tempE :: Viagem -> Hora
  tempE [] = H 0 0
  tempE ((h1,h2):(h3,h4):hs) = minThor (tempV' ((h3,h2):(h3,h4):hs)) 

  -- (f)

  tempT :: Viagem -> Hora 
  tempT [] = H 0 0
  tempT viag = tempT' (fst(head viag) , snd(last viag))

  tempT' :: Etapa -> Hora
  tempT' (H h1 m1, H h2 m2) | m2 < m1 = H (h2 - h1 - 1) (m2 - m1 + 60)
                            | otherwise = H (h2 - h1) (m2 - m1)

--ex.2

  type Poligonal = [F1.Ponto]

  -- (a)

  comprimento :: Poligonal -> Double
  comprimento [p1] = 0
  comprimento (p1:p2:ps) = (dist' p1 p2) + comprimento (p2:ps) 

  -- (b)

  testF :: Poligonal -> Bool
  testF [p1] = False
  testF [p1,p2] = False
  testF [p1,p2,p3] = p1 == p3
  testF (p1:p2:p3:ps) = testF (p1:p3:ps)

  -- (c) 

  triangula :: Poligonal -> [Figura]
  triangula [p1,p2,p3] = [(Triangulo p1 p2 p3)]
  triangula (p1:p2:p3:ps) = (Triangulo p1 p2 p3):triangula (p1:p3:ps)

  -- (d)

  areaPol :: Poligonal -> Double
  areaPol p = sum(map area (triangula p))

  -- (e)

  mover :: Poligonal -> Ponto -> Poligonal
  mover p (Cartesiano 0 0) = p
  mover p (Polar 0 0) = p
  mover p ponto = ponto : p

  -- (f)
  zoom :: Double -> Poligonal -> Poligonal 
  zoom z [p1@(Cartesiano x y),p2@(Cartesiano a b)] = p1:(Cartesiano (z*a) (z*b)):[]
  zoom z (p1@(Cartesiano x y):p2@(Cartesiano a b):pol) = p1:zoom z (p3:pol)
    where p3 = (Cartesiano (z*a) (z*b))

--ex.3

  data Contacto = Casa Integer
                | Trab Integer 
                | Tlm Integer
                | Email String
         deriving Show
  type Nome = String
  type Agenda = [(Nome, [Contacto])]


  -- (a)

  acrescEmail :: Nome -> String -> Agenda -> Agenda
  acrescEmail nome email [] = (nome,[Email email]):[]
  acrescEmail nome email ((h,t):ts) | nome == h = (h, t ++ [Email email]) : ts
                                    | otherwise = (h,t) : acrescEmail nome email ts

  -- (b)

  verEmails :: Nome -> Agenda -> Maybe [String]
  verEmails _ []  = Nothing
  verEmails n ((n',h):t) | n == n' = Just (emails h) 
                         | otherwise = verEmails n t
                    where emails :: [Contacto] -> [String]
                          emails [] = []
                          emails (Email e : t ) = e : emails t
                          emails (h: t) = emails t

  -- (c)

  consTelefs :: [Contacto] -> [Integer]
  consTelefs [] = []
  consTelefs (h:t)  = case h of Casa x -> x:consTelefs t
                                Trab x -> x:consTelefs t
                                Tlm x -> x:consTelefs t 
                                otherwise -> consTelefs t

  -- (d)

  casa :: Nome -> Agenda -> Maybe Integer
  casa n [] = Nothing
  casa n ((n',b):ns) | n == n' = casas n b
                     | otherwise = casa n ns
                where casas n ((Casa x):t) = Just x 
                      casas n (h:t) = casas n t
                      casas n [] = Nothing 

--ex.4

  type Dia = Int
  type Mes = Int
  type Ano = Int
  type Nome' = String

  data Data = D Dia Mes Ano
    deriving Show
  type TabDN = [(Nome',Data)]

  -- (a)
  
  procura :: Nome' -> TabDN -> Maybe Data
  procura nome [] = Nothing
  procura nome ((n',d):ds) | nome == n' = Just d
                           | otherwise = procura nome ds 

  -- (b)

  idade :: Data -> Nome' -> TabDN -> Maybe Int
  idade (D d1 m1 a2) n t | a1==a2 = Nothing
                         | m1>m2 = Just (a2-a1) 
                         | m1==m2 && d1>d2 = Just (a2-a1)
                         | otherwise = Just (a2-a1-1)
           where Just (D d2 m2 a1) = procura n t 

  -- (c)

  anterior :: Data -> Data -> Bool
  anterior (D d1 m1 a1) (D d2 m2 a2) = a1<a2 || (a1==a2 && m1<m2) || (a1==a2 && m1==m2 && d1<d2)

  -- (d)
  
  ordena :: TabDN -> TabDN
  ordena [] = []
  ordena (d:t) = insert d (ordena t)
     where insert d [] = [d] 
           insert (n,d) ((n',d'):t) | anterior d d' == True = (n,d): insert (n',d') t 
                                    | otherwise = (n',d'):insert (n,d) t

  -- (e)
 
  porIdade:: Data -> TabDN -> [(Nome,Int)]
  porIdade _ [] = []
  porIdade h tb = let ((n,d):t) = ordena tb
                      Just i = idade h n [(n,d)] 
                  in (porIdade h t)++[(n,i)]

--ex.5

  data Movimento = Credito Float | Debito Float deriving Show
  data Extracto = Ext Float [(Data, String, Movimento)] deriving Show

  -- (a)
  extValor :: Extracto -> Float -> [Movimento]
  extValor (Ext e []) _ = []
  extValor (Ext e ((d,s,Credito v):t)) v' = if v>v' then (Credito v):extValor (Ext e t) v' else extValor (Ext e t) v'
  extValor (Ext e ((d,s,Debito v):t)) v' = if v>v' then (Debito v):extValor (Ext e t) v' else extValor (Ext e t) v'

   {-
  extValor :: Extracto -> Float -> [Movimento]
  extValor (Ext x []) _ = []
  extValor (Ext x ((_,_,mov):ls)) valor = case mov of Credito n -> if n >= valor then mov : extValor (Ext x ls) valor else extValor (Ext x ls) valor
                                                      Debito n -> if n >= valor then mov : extValor (Ext x ls) valor else extValor (Ext x ls) valor
   -}

  -- (b) 
 
  filtro :: Extracto -> [String] -> [(Data,Movimento)]
  filtro (Ext x []) _ = []
  filtro (Ext x ((dat,desc,mov):ls)) listaStr | elem desc listaStr == True = (dat,mov):filtro (Ext x ls) listaStr 
                                              | otherwise = filtro (Ext x ls) listaStr
  
  --(c)

  creDeb :: Extracto -> (Float,Float)
  creDeb (Ext _ []) = (0,0)
  creDeb (Ext _ l) = aux l (0,0)
   where aux [] (c,d) = (c,d) 
         aux ((_,s,Credito v):t) (c,d) = aux t (c+v,d)
         aux ((_,_,Debito v):t) (c,d) = aux t (c,d+v)

  -- (d)

  saldo :: Extracto -> Float 
  saldo (Ext e []) = e
  saldo (Ext e ((d,s,m):t)) = aux ((d,s,m):t) e
   where aux [] e = e 
         aux ((dat,desc,mov):t) e = case mov of Debito v -> aux t (e+v)
                                                Credito v -> aux t (e-v) 