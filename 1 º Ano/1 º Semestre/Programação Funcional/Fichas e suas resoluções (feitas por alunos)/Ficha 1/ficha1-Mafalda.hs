perimetro :: Float -> Float 
perimetro r = pi*2*r

dist :: (Double, Double) -> (Double, Double) -> Double
dist (x1,y1) (x2,y2) = (sqrt ((x1-x2)^2 + (y1-y2)^2)) 

primUlt :: [Float] -> (Float, Float)
primUlt l = (head l, last l)

multiplo :: Int -> Int -> Bool
multiplo x y = if (mod x y)==0 then True else False 

truncaImpar :: [a] -> [a]
truncaImpar l = if (mod(length l) 2)==0 then l else tail l

max2:: Int -> Int -> Int 
max2 x y   | x < y = y
           | otherwise = x

max3 :: Int -> Int -> Int -> Int 
max3 x y z = max2 x (max2 y z)

--2
--nRaizes :: Float -> Float -> Float -> Int 
--nRaizes a b c | d>0 = 2
--              | d>0 = 0
--			  | d==0 =1
--              where d= sqrt (b^2-4*a*c)
--nRaizes a b c let d= (sqrt (b^2-4*a*c))	
--              in if d>0 then 2 else if d<0 then 1 else 0

--raizes :: Float -> Float -> Float -> [Float]
--raizes a b c 
--    | d<o = []
--    | d>0 = [r1,r2]
--    | d==0 = [r]
--	where d= b^2-4*a*c
--	r1 = (-b -sqrtd)/(2+a)
--   r2 = (-b +sqrtd)/(2+a)
--    r = (-b)/(2*a)

--3
type Hora = (Int, Int)
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

--adicionar :: Int -> Hora -> Hora
--adicionar x (h,m) = ( (div x 60) + h , (mod x 60) + m)
--adicionar x h = (inverso ((horamin h) +x))

--5
data Semaforo = Verde | Amarelo | Vermelho deriving (Show, Eq)

next :: Semaforo -> Semaforo
next s 
 | s== Verde = Amarelo
 | s==Amarelo = Vermelho
 | s==Vermelho = Verde

stop :: Semaforo -> Bool 
stop x
 | x==Verde = False 
 | otherwise = True

safe :: Semaforo -> Semaforo -> Bool 
safe Vermelho  _ = True 
safe  _  Vermelho = True 
safe _ _ = False

--6
data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

posx :: Ponto -> Double 
posx (Cartesiano x y) = x
posx (Polar r a) = (cos a)*r

posy :: Ponto -> Double 
posy (Cartesiano x y) = y
posy (Polar r a) = r*(sin a)

raio :: Ponto -> Double 
raio (Polar r a ) = r
raio (Cartesiano x y) = sqrt ( x^2 + y^2)

angulo :: Ponto -> Double 
angulo (Polar r a ) = a
angulo (Cartesiano x y) = if (x<0 && y==0) then pi else atan (y/x)
--angulo (Cartesiano x y) 
-- |x>=0 && y==0 =0
-- |x==0 && y>0 = pi/2
-- |x<0 && y==0 = pi
-- |x==0 && y<0 = pi+(pi/2)
-- |x>0 && y>0 = atan(y/x)
-- |x<0 && y>0 = pi - atan(y/(-x))
-- |x<0 && y<0 = pi + atan(y/x)
-- |x>0 && y<0 = (2*pi) - atan(-y/x)
 

--dist :: Ponto -> Ponto -> Double 
--dist ( x1 ,y1) (x2 ,y2) = sqrt ( (x1-x2)^2 + (y1-y2)^2)

--7
data Figura = Circulo Ponto Double | Rectangulo Ponto Ponto | Triangulo Ponto Ponto Ponto deriving (Show,Eq)

poligono :: Figura -> Bool
poligono (Circulo p r) = if r>0 then True else False 
poligono (Rectangulo p1 p2) = if (posx p1/= posx p2 && posy p1/= posy p2) then True 
                                                                          else False
--poligono (Triangulo p1 p2 p3) = 
--let d12 = dist p1 p2
--    d23 = dist p2 p3
--    d13 = dist p1 p3
--in (d12<(d23+d13)) && (d23=d12+d13) && (d13=d12+d23)

 
vertices :: Figura -> [Ponto]
vertices (Circulo p r) = []
vertices (Rectangulo p1 p2) = [p1,p2,p3,p4] 
                            where p3= (Cartesiano x2 y1)
                                  p4= (Cartesiano x1 y2)
                                  x2= posx p2
                                  y1= posy p1
                                  x1= posx p1
                                  y2= posy p2
vertices (Triangulo p1 p2 p3) = [p1,p2,p3]

area :: Figura -> Double 
area (Circulo p r) = pi*(r^2)
area (Rectangulo p1 p2) = abs ((posx p2 - posx p1) * (posy p2 -posy p1))
area (Triangulo p1 p2 p3) = abs (((posx p2 - posx p1) * (posy p3 - posy p1)) / 2)

perimetro' :: Figura -> Double 
perimetro' (Circulo p r) = pi* (2*r)
perimetro' (Rectangulo p1 p2) = abs (((posx p2 -posx p1)*2) + (posy p2 -posy p1)*2)
--perimetro' (Triangulo p1 p2 p3) = 

--8
isLower' :: Char -> Bool 
isLower' c = if (elem c['a'..'z']) then True else False

isAlpha' :: Char -> Bool 
isAlpha' c = if ((elem c['a'..'z']) || (elem c['A'..'Z'])) then True else False

--toUpper' :: Char -> Char 
--toUpper' c = let k= odd 'a' - odd 'A'
--             in if (isLower' c) then char((odd c)-k)
--			 else c


