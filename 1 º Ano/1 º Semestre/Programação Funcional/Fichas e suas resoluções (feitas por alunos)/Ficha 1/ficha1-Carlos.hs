  module Ficha1 where
  import Data.Char
  
--ex.1

  -- (a)

  perimetro :: Double -> Double
  perimetro r | r >= 0 = 2 * pi * r
              | otherwise = error "coloque um valor do raio válido"

  -- (b)

  dist :: (Double,Double) -> (Double,Double) -> Double 
  dist (x1,y1) (x2,y2) = sqrt (((x1 - x2)^2) + ((y1 - y2)^2)) 

  -- (c) 

  primUlt :: [a] -> (a,a)
  primUlt a = ((head a) , (last a))

  -- (d)

  multiplo :: Int -> Int -> Bool
  multiplo a b = (mod a b == 0) 

  -- (e)

  truncaImpar :: [a] -> [a]
  truncaImpar a | ( odd (length a) == True ) =  tail a
                | otherwise = a

  -- (f)

  max2 :: Int -> Int -> Int 
  max2 a b | a > b = a
           | otherwise = b

  -- (g)

  max3 :: Int -> Int -> Int -> Int
  max3 a b c = max2 (max2 a b) c

--ex.2

  -- (a)

  nRaizes :: Double -> Double -> Double -> Double
  nRaizes a b c = let x = b^2 - 4*a*c in if x>0 then 2 else if x==0 then 1 else 0

  -- (b)

  raizes :: Double -> Double -> Double -> [Double]
  raizes a b c  | n == 2 = [x1, x2] 
                | n == 1 = [x1] 
                | n == 0 = [] 
                 where n = nRaizes a b c
                       x = b^2 - 4*a*c
                       x1 = (( -b + sqrt(x))/(2*a))
                       x2 = (( -b - sqrt(x))/(2*a))

--ex.3

  --type Hora = (Int,Int)

  -- (a)

  horavld :: (Int,Int) -> Bool
  horavld (h,m) = h >= 0 && h <= 23 && m >= 0 && m <= 59  

  -- (b)
 
  compare :: (Int,Int) -> (Int,Int) -> Bool
  compare (h1,m1) (h2,m2) | h1 > h2 = True
                          | h1 == h2 && m1 > m2 = True
                          | otherwise = False

  -- (c)

  converth :: (Int,Int) -> Int
  converth (a,b) = (a*60) + b 

  -- (d)

  convertm :: Int -> (Int,Int)
  convertm m = (hora,min)
              where hora = div m 60
                    min = mod m 60

  -- (e)

  difere :: (Int,Int) -> (Int,Int) -> Int
  difere a b | min2 >= min1 = min2 - min1
             | otherwise = min1 - min2
          where min1 = converth a
                min2 = converth b  

  -- (f)

  addm :: (Int,Int) -> Int -> (Int,Int)
  addm a b = convertm n
         where n = b + (converth a)

--ex.4 (mesmo que anterior)

--ex.5

  data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

  -- (a)

  next :: Semaforo -> Semaforo
  next cor | cor == Verde = Amarelo
           | cor == Amarelo = Vermelho
           | otherwise = Verde

  -- (b)

  stop :: Semaforo -> Bool
  stop cor = if cor == Vermelho then True else False

  -- (c)

  safe :: Semaforo -> Semaforo -> Bool
  safe _ Vermelho = True
  safe Vermelho _ = True
  safe _ _ = False

--ex.6

  data Ponto = Cartesiano Double Double | Polar Double Double
          deriving (Show,Eq)

  -- (a)

  posx :: Ponto -> Double
  posx (Cartesiano a _) = a
  posx (Polar a b) = a * cos(b)

  -- (b)

  posy :: Ponto -> Double
  posy (Cartesiano _ b) = b
  posy (Polar a b) = a * sin(b)

  -- (c)

  raio :: Ponto -> Double
  raio (Cartesiano a b) = sqrt ((a^2) + (b^2))
  raio (Polar a b) = a

  -- (d)

  angulo :: Ponto -> Double
  angulo (Polar a b) = b
  angulo (Cartesiano x y) | x == 0 && y > 0 = (pi/2)
                          | x == 0 && y < 0 = ((3*pi)/2)
                          | x == 0 && y == 0 = 0
                          | x < 0 && y == 0 = pi
                          | x > 0 && y == 0 = 0
                          | x < 0 = pi + atan (y/x)
                          | x > 0 = atan (y/x) 

  -- (e)

  dist' :: Ponto -> Ponto -> Double 
  dist' (Cartesiano x1 y1) (Cartesiano x2 y2 ) = sqrt (((x1 - x2)^2) + ((y1 - y2)^2))
  dist' (Polar a1 b1) (Polar a2 b2) = let x1 = posx (Polar a1 b1)
                                          y1 = posy (Polar a1 b1)
                                          x2 = posx (Polar a2 b2)
                                          y2 = posy (Polar a2 b2)
                                      in sqrt (((x1 - x2)^2) + ((y1 - y2)^2))

--ex.7
 
  data Figura = Circulo Ponto Double
              | Rectangulo Ponto Ponto
              | Triangulo Ponto Ponto Ponto
        deriving (Show,Eq)

  -- (a)

  poligono :: Figura -> Bool
  poligono (Circulo p1 r) = r>0
  poligono (Rectangulo p1 p2) = (posx p1)/=(posx p2) && (posy p1)/=(posy p2)
  poligono (Triangulo p1 p2 p3) = let d12 = dist' p1 p2
                                      d13 = dist' p1 p3
                                      d23 = dist' p2 p3
                                  in d12<(d13+d23) && d13<(d12+d23) && d23<(d12+d13)
  
  -- (b)

  vertices :: Figura -> [Ponto]
  vertices (Circulo _ _) = []
  vertices (Rectangulo p1 p2) = [p1,p2,Cartesiano (posx p1) (posy p2),Cartesiano (posx p2) (posy p1)]
  vertices (Triangulo p1 p2 p3) = [p1,p2,p3]

  -- (c)

  area :: Figura -> Double
  area (Circulo p r) =  pi*(r^2)
  area (Rectangulo p1 p2) = 
   let b= (posx p2)-(posx p1)
       h= (posy p2)-(posy p1) 
   in (abs b)*(abs h)
  area (Triangulo p1 p2 p3) = 
   let a = dist' p1 p2 
       b = dist' p2 p3 
       c = dist' p3 p1 
       s = (a+b+c) / 2 -- semi-perimetro 
   in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron 

  -- (d)
  
  perimetro' :: Figura -> Double
  perimetro' (Circulo p r) = 2 * pi * r
  perimetro' (Triangulo p1 p2 p3) = let a = dist' p1 p2 
                                        b = dist' p2 p3 
                                        c = dist' p3 p1 
                                    in a + b + c
  perimetro' (Rectangulo p1 p2) = 
   let b= (posx p2)-(posx p1)
       h= (posy p2)-(posy p1) 
   in (2*(abs b)) + (2*(abs h))

--ex.8
  
  -- ord :: Char -> Int 
  -- chr :: Int -> Char

  --(a)

  isLower' :: Char -> Bool
  isLower' x | ( (ord 'a') <= (ord x) && (ord x) <= (ord 'z') ) = True
             | otherwise = False
            
  -- (b)

  isDigit' :: Char -> Bool
  isDigit' x | ( (ord '0') <= (ord x) && (ord x) <= (ord '9') ) = True
             | otherwise = False

  -- (c)
  
  isAlpha' :: Char -> Bool
  isAlpha' x | ( (isLower' x) || ( (ord 'A') <= (ord x) && (ord x) <= (ord 'Z') ) ) = True
             | otherwise = False

  -- (d)

  toUpper' :: Char -> Char
  toUpper' x | ( (ord 'A') <= (ord x) && (ord x) <= (ord 'Z') ) = x
             | otherwise = chr (a)
          where a = ord 'A' + ( (ord x) - (ord 'a')) 

  -- (e)

  intToDigit' :: Int -> Char
  intToDigit' x = chr ( x + ord '0' )

  -- (f)

  digitToInt' :: Char -> Int
  digitToInt' x = ord x - ord '0'

 ----------------------------------------------------------------