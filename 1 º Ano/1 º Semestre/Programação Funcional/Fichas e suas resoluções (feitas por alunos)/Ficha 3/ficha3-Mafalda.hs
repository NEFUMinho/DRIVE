--1

data Hora = H Int Int deriving Show
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

valida :: Hora -> Bool
--valida (h, m) = if ((h<24) && (h>=0) && (m>=0) && (m<60)) then True else False
valida (h,m) = (elem h[0..23] && elem m[0..59]) 

comparação :: Hora -> Hora -> Bool
comparação (h1,m1) (h2,m2) 
 | h1>h2 = False
 | h2>h1 = True 
 | h1==h2 && (m2>m1) = True 
 | h1==h2 && (m2<m1) = False

horamin :: Hora -> Int 
horamin (h,m) = h*60 + m

minhora :: Int -> Hora 
minhora x = (mod(div x 60)24, mod x 60)

diferença :: Hora -> Hora -> Int 
diferença (h1,m1) (h2,m2) = abs (horamin (h1,m1) - horamin(h2,m2))
--
construida :: [Etapa] -> Bool
construida ((h1,m1):(h2,m2))
 | h1>h2 = True
 | h1==h2 && m2>m1 = True 
 | otherwise = False
 
--4
type Dia = Int
type Mes = Int
type Ano = Int
type Nome = String
data Data = D Dia Mes Ano deriving Show
type TabDN = [(Nome,Data)]

procura :: Nome -> TabDN -> Maybe Data
procura _ [] = Nothing 
procura n ((x,d):xs) = if n ==x then Just d1 else procura n xs 

--idade :: Data -> Nome -> TabDN -> Maybe Int
--idade (D d1 m1 a1) n ((x, D di me an):xs) 
-- | n==x || procura n xs = Just 
--let x = procura n t 
--in case x of  

anterior :: Data -> Data -> Bool 
anterior (D d1 m1 a1) (B d2 m2 a2)
 | a2>a1 = True 
 | a2==a1 && (m1,d1)<(m2,d1) = True 
 | otherwise = False 
-- if (a2,m2,d2)>(a1,m1,d1) then True else False

ordenaT :: TabDN -> TabDN 
ordenaT [] = []
ordenaT ((n,d):t) = insere (n,d) (ordenaT t)
 where insere :: (Nome, Data) -> TabDN -> TabDN
       insere (n,d) [] = [(n,d)]
	   insere (n,d) ((n1,d1):t) 
	    | anterior d1 d = (n1,d1): insere (n,d) t 
		| otherwise = ((n,d):(n1,d1):t)

porIdade:: Data -> TabDN -> [(Nome,Int)]
porIdade d [] = []
porIdade (D d1 m1 a1) ((n,d):(n2,d2):t) 
 | d2>d1 = idade (D d1 m1 a1) 
 
--3
data Contacto = Casa Integer | Trab Integer | Tlm Integer | Email String deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]
-- ag = [("AAA", [ Casa 999, Trab 879, Email "abc"])]

acrescEmail  :: Nome -> String -> Agenda -> Agenda
acrescEmail n em [] = [(n, [Email em])]
acrescEmail n em ((n1,lc):ag)
 | n==n1 = (n1, (Email em):lc):ag
 | n/= n1 = (n1,lc) : acrescEmail (n em ag)

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((n1,lc):ag)
 | n==n1 = Just (getEmails lc)
 | n/=n1 = verEmails n ag
 where getEmails :: [Contacto] -> [String]
       getEmails [] = []
	   getEmails ((Email em):lc) = em : getEmails lc
	   getEmails ( _ : lc) = getEmails lc 

consTelefs :: [Contacto] -> [Integer]
consTelefs ((Casa t):lc) = t : consTelefs lc 
consTelefs ((Trab t):lc) = t : consTelefs lc
consTelefs ((Tlm t):lc) = t: consTelefs lc
consTelefs ( _:lc) = consTelefs lc
--consTelefs (n,lc) = case x of
--(Casa t) -> t : consTelefs lc
--(Trab t) -> t : consTelefs lc
--(Tlm t) -> t : consTelefs lc
-- _ -> consTelefs lc

casa :: Nome -> Agenda -> Maybe Integer
casa n [] = Nothing
casa n ((n1,lc):ag)
 | n==n1 = getCasa lc
 | n/=n1 = casa n ag
 where getCasa :: [Contacto] -> Maybe Integer
       getCasa [] = Nothing
       getCasa ((Casa t): lc) = Just t
	   getCasa ( _ : lc) = getCasa lc

































 
