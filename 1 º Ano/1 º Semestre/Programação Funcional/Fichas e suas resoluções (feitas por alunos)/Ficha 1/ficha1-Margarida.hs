{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Data.Time.Format.ISO8601 (yearFormat)
{-# HLINT ignore "Use even" #-}
{-# HLINT ignore "Use max" #-}
{-# HLINT ignore "Use camelCase" #-}
import Data.Char
import Data.Binary.Get (label)

--ex1

perimetro1 :: Float -> Float
perimetro1 r = 2 * pi * r

dist1 :: (Double, Double) -> (Double, Double)-> Double
dist1 (x1,y1) (x2,y2) = sqrt ((x2-x1)^2+(y2-y1)^2)

primUlt1 :: [a] -> (a,a)
primUlt1 l = (head l, last l)

multiplo1 :: Int -> Int -> Bool
multiplo1 m n = mod m n == 0

truncaImpar1 :: [a] -> [a]
truncaImpar1 l
    | mod (length l) 2 == 0 = l
    | otherwise = tail l

max2 :: Int -> Int -> Int
max2 m n = if m > n then m else n

max3 :: Int -> Int -> Int -> Int
max3 x y z = if x > y then max2 x z else max2 y z

--ex2

nRaizes1 :: Double -> Double -> Double -> Int
nRaizes1 a b c
    | b^2 == 4 * a * c = 1
    | b^2 > 4 * a * c = 2
    | otherwise = 0

raizes1 :: Double -> Double -> Double -> [Double]
raizes1 a b c
    | nRaizes1 a b c == 0 = []
    | nRaizes1 a b c == 1 = [-b / (2*a)]
    | nRaizes1 a b c == 2 = [(-b + sqrt (b^2 - 4 * a * c ))/(2*a),(-b - sqrt (b^2 - 4 * a * c ))/(2*a)]

--ex3

type Hora = (Int,Int)

alinea_a :: Hora -> Bool --testa se a hora é valida
alinea_a (x,y)
    | x > 23 || x < 0 = False
    | y > 59 || y < 0 = False
    | otherwise = True

alinea_b :: Hora -> Hora -> Bool --testa de a segunda hora é depois da primeira
alinea_b (x1,y1) (x2,y2)
    | x2 == x1 = y2 > y1
    | x2 > x1 = True
    | otherwise = False

alinea_c :: Hora -> Int -- converte horas em minutos
alinea_c (x,y) = x * 60 + y

alinea_d :: Int -> Hora --converte minutos em horas
alinea_d x = (div x 60, mod x 60)

alinea_e :: Hora -> Hora -> Int --diferença entre duas horas em minutos
alinea_e (x,y) (x2,y2) = (x2-x) *60 + (y2-y)

alinea_f :: Int -> Hora -> Hora -- adiciona n mintuos a uma hora
alinea_f n (h,m)
    | n + m < 60 = (h, n+m)
    | otherwise = (h+ div (n+m) 60, mod (n+m) 60)

--ex4

data Horas = H Int Int  deriving (Show, Eq)

alinea_a' :: Horas -> Bool --testa se a hora é valida
alinea_a' (H x y)
    | x > 23 || x < 0 = False
    | y > 59 || y < 0 = False
    | otherwise = True

alinea_b' :: Horas -> Horas -> Bool --testa de a segunda hora é depois da primeira
alinea_b' (H x1 y1) (H x2 y2)
    | x2 == x1 = y2 > y1
    | x2 > x1 = True
    | otherwise = False

alinea_c' :: Horas -> Int -- converte horas em minutos
alinea_c' (H x y) = x * 60 + y

alinea_d' :: Int -> Horas --converte minutos em horas
alinea_d' x = H (div x 60) (mod x 60)

alinea_e' :: Horas -> Horas -> Int --diferença entre duas horas em minutos
alinea_e' (H x y) (H x2 y2) = (x2-x) *60 + (y2-y)

alinea_f' :: Int -> Horas -> Horas -- adiciona n mintuos a uma hora
alinea_f' n (H h m)
    | n + m < 60 = H h (n+m)
    | otherwise = H (h+ div (n+m) 60) (mod (n+m) 60)

--ex5

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

next1 :: Semaforo -> Semaforo
next1 Verde = Amarelo
next1 Amarelo = Vermelho
next1 Vermelho = Verde

stop1 :: Semaforo -> Bool
stop1 Verde = False
stop1 Amarelo = False
stop1 Vermelho = True

safe1 :: Semaforo -> Semaforo -> Bool
safe1 Vermelho x = True
safe1 x Vermelho = True
safe1 x y = False

--ex6

data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

posx1 :: Ponto -> Double
posx1 (Cartesiano x y) = x
posx1 (Polar d a) = d * cos a

posy1 :: Ponto -> Double
posy1 (Cartesiano x y) = y
posy1 (Polar d a) = d * sin a

raio1 :: Ponto -> Double
raio1 (Cartesiano x y) = sqrt (x^2 + y^2)
raio1 (Polar d a) = d

angulo1 :: Ponto -> Double
angulo1 (Cartesiano x y) = atan (y/x) --atan é tan-1
angulo1 (Polar d a) = a

dist1' :: Ponto -> Ponto -> Double
dist1' p1 p2 = sqrt ((posx1 p1 -posx1 p2)^2 + (posy1 p1 - posy1 p2)^2)


--ex7

data Figura = Circulo Ponto Double
    | Rectangulo Ponto Ponto
    | Triangulo Ponto Ponto Ponto
    deriving (Show,Eq)


poligono1 :: Figura -> Bool
poligono1 (Circulo p r) = False
poligono1 (Rectangulo p1 p2) = posx1 p1 /= posx1 p2 && posy1 p1 /= posy1 p2
poligono1 (Triangulo p1 p2 p3) = posx1 p1 /= posx1 p2 || posx1 p2 /= posx1 p3 || posx1 p1 /= posx1 p3 && posy1 p1 /= posy1 p2 || posy1 p2 /= posy1 p3 || posy1 p1 /= posy1 p3

vertices1 :: Figura -> [Ponto]
vertices1 (Circulo p r) = []
vertices1 (Rectangulo p1 p2) = [p1,p2,Cartesiano x1 y2,Cartesiano x2 y1]
    where x1 = posx1 p1
          y1 = posy1 p1
          x2 = posx1 p2
          y2 = posy1 p2
vertices1 (Triangulo p1 p2 p3) = [p1,p2,p3]

area1 :: Figura -> Double
area1 (Triangulo p1 p2 p3) =
    let a = dist1' p1 p2
        b = dist1' p2 p3
        c = dist1' p3 p1
        s = (a+b+c) / 2 -- semi-perimetro
    in sqrt (s*(s-a)*(s-b)*(s-c))
area1 (Rectangulo p1 p2) = abs (posx1 p1 - posx1 p2)* abs (posy1 p1 - posy1 p2)
area1 (Circulo p r) = pi * r^2

perimetro1' :: Figura -> Double
perimetro1' (Circulo p r) = 2 * pi * r
perimetro1' (Triangulo p1 p2 p3) = dist1' p1 p2 + dist1' p1 p3 + dist1' p2 p3
perimetro1' (Rectangulo p1 p2) =2*dist1' p1 p3 + 2*dist1' p2 p3
    where p3 = Cartesiano (posx1 p2) (posy1 p1)

--ex8
--ver tabela ascii

isLower1 :: Char -> Bool
isLower1 l = ord l <= 122 && ord l >= 97

isDigit1 :: Char -> Bool
isDigit1 n = ord n >= 48 && ord n <= 57

isAlpha1 :: Char -> Bool
isAlpha1 l = (ord l <= 122 && ord l >= 97) || (ord l <= 90 && ord l >= 65)

toUpper1 :: Char -> Char
toUpper1 l = if isLower1 l then l else chr (ord l + (97-65))

intToDigit1 :: Int -> Char
intToDigit1 n = chr (n+48)

digitToInt1 :: Char -> Int
digitToInt1 x = ord x -48
