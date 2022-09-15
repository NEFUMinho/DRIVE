module Ficha1 where
import Data.Char
--1
--a
perimetro :: Double -> Double
perimetro r = 2*pi*r
--b
dist :: (Double,Double) -> (Double,Double) -> Double
dist (x,y) (a,b) = sqrt((x-a)^2+(y-b)^2)
--c
primUlt :: [a] -> (a,a)
primUlt l = (head l,last l)
--d
multiplo :: Int -> Int -> Bool
multiplo x y = (mod x y) == 0
--e
truncaImpar :: [a] -> [a]
truncaImpar l = if (mod (length l) 2)==0 then l else tail l
--f
max2 :: Int -> Int -> Int
max2 x y = if x>y then x else y
--g
max3 :: Int -> Int -> Int -> Int
max3 x y z = max2 (max2 x y) z
--2
--a
nRaizes :: Double -> Double -> Double -> Double
nRaizes a b c = let x = b^2-4*a*c
 in if x>0 then 2 else if x==0 then 1 else 0
--b
raizes :: Double -> Double -> Double -> [Double]
raizes a b c = let n=nRaizes a b c
                   r1= (-b+sqrt n)/(2*a)
                   r2= (-b-sqrt n)/(2*a)
               in if n==1 then [r1] else if n==2 then [r1,r2] else []
--3
type Hora = (Int,Int)
--a
valida :: Hora -> Bool
valida (h,m) = h>=0 && h<=23 && m>=0 && m<=59 
--b
compar :: Hora -> Hora -> Bool
compar (h1,m1) (h2,m2) 
 | h1>h2 = True
 | h1==h2 && m1>m2 = True
 | otherwise = False
--c
convertHm :: Hora -> Int
convertHm (h,m) = h*60 + m
--d
convertmH :: Int -> Hora
convertmH x = let h= div x 60 
                  m= mod x 60
              in (h,m)
--e
dif :: Hora -> Hora -> Int
dif h1 h2 = let x= convertHm h1 
                y= convertHm h2 
            in if x>y then x-y else y-x
--f 
add :: Int -> Hora -> Hora
add x y = convertmH n 
 where n = x + convertHm y
--5
data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)
--a
next :: Semaforo -> Semaforo
next Verde = Amarelo
next Amarelo = Vermelho
next Vermelho = Verde
--b
stop :: Semaforo -> Bool
stop Vermelho = True 
stop _ = False 
--c
safe :: Semaforo -> Semaforo -> Bool
safe _ Vermelho = True 
safe Vermelho _ = True
safe _ _ = False
--6
data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)
--a
posx :: Ponto -> Double 
posx (Cartesiano x y) = sqrt(x^2)
posx (Polar x y) = sqrt((x*(cos y))^2)
--b
posy :: Ponto -> Double
posy (Cartesiano x y) = sqrt(y^2) 
posy (Polar x y) = sqrt((x*(sin y))^2)
--c
raio :: Ponto -> Double 
raio (Cartesiano x y) = sqrt(x^2 + y^2) 
raio (Polar x y) = x
--d
angulo :: Ponto -> Double
angulo (Polar x y) = y 
angulo (Cartesiano x y) = atan(y/x) 
--e
dist' :: Ponto -> Ponto -> Double 
dist' (Cartesiano x y) (Cartesiano a b) = sqrt((x-a)^2+(y-b)^2)
dist' (Polar x y) (Polar a b) = 
 let x'=x*(cos y)
     y'=x*(sin y)
     a'=a*(cos b)
     b'=a*(sin b)
 in sqrt((x'-a')^2+(y'-b')^2)
--7
data Figura = Circulo Ponto Double | Retangulo Ponto Ponto | Triangulo Ponto Ponto Ponto deriving (Show,Eq)
--a
poligono :: Figura -> Bool
poligono (Circulo p1 r) = r>0
poligono (Retangulo p1 p2) = (posx p1)/=(posx p1) && (posy p1)/=(posy p2)
poligono (Triangulo p1 p2 p3) =
 let d12 = dist' p1 p2
     d13 = dist' p1 p3
     d23 = dist' p2 p3
 in d12<(d13+d23) && d13<(d12+d23) && d23<(d12+d13)
--b
vertices :: Figura -> [Ponto]
vertices (Circulo _ _) = []
vertices (Retangulo p1 p2) = [p1,p2,Cartesiano (posx p1) (posy p2),Cartesiano (posx p2) (posy p2)]
vertices (Triangulo p1 p2 p3) = [p1,p2,p3]
--c
area :: Figura -> Double
area (Circulo p r) =  pi*r
area (Retangulo p1 p2) = 
 let b= (posx p2)-(posx p1)
     h= (posy p2)-(posy p1) 
 in (abs b)*(abs h)
area (Triangulo p1 p2 p3) = 
 let a = dist' p1 p2 
     b = dist' p2 p3 
     c = dist' p3 p1 
     s = (a+b+c) / 2 -- semi-perimetro 
 in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron 
--d
perimetro' :: Figura -> Double
perimetro' (Circulo p r) = 2*pi*r
perimetro' (Retangulo p1 p2) = 
 let b= (posx p2)-(posx p1)
     h= (posy p2)-(posy p1) 
 in 2*(abs b)+2*(abs h)
perimetro' (Triangulo p1 p2 p3) =
 let a = dist' p1 p2 
     b = dist' p2 p3 
     c = dist' p3 p1 
 in a+b+c
--8
--a
isLower' :: Char -> Bool
isLower' x = (ord x)>96 && (ord x)<123
--b
isDigit' :: Char -> Bool
isDigit' x = elem x ['0'..'9']
--c
isAlpha' :: Char -> Bool
isAlpha' x = ((ord x)>64&&(ord x)<91)||((ord x)>96 && (ord x)<123)
--d
toUpper' :: Char -> Char
toUpper' x = if isLower' x then chr(ord x -32) else x
--e
intToDigit' :: Int -> Char
intToDigit' x = chr(x+48)
--f
digitToInt' :: Char -> Int
digitToInt' x = (ord x)-48