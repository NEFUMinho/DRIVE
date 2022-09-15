--1
bingo :: IO ()
bingo = geraNum [] 

geraNum :: [Int] -> IO ()
geraNum p = if (length p == 90) then putStr "Fim" 
            else n <- randomRIO (1,90)

mastermind :: IO ()
mastermind = y <- geraSeq ()
             putStr "Escreva uma sequencia de 4 digitos"
             x <- getLine 
             let s = read x :: (Int,Int,Int,Int)
             if ((==) y s) then putStr "Acertou!" 
             else return {putStr "Escreva uma sequencia de 4 digitos"| mastermind}
                       
geraSeq :: IO ()
geraSeq = a <- randomRIO (1,..)
          b <- randomRIO (1,..)
          c <- randomRIO (1,..)
          d <- randomRIO (1,..)
          return (a,b,c,d)

--2
data Aposta = Ap [Int] (Int,Int)

valida :: Aposta -> Bool
valida (Ap l (x,y)) = (length l ==5) && (map (\a -> a elem [1..50])l) 
                      && naotemrepetidos l && x/=y && elem x [1..12] && elem y [1..12]
    where naotemrepetidos :: [a] -> Bool
          naotemrepetidos [] = True
          naotemrepetidos (x:xs) | elem x xs = False
                                 | otherwise = naotemrepetidos xs 

comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap l1 (a,b)) (Ap l2 (c,d)) = (      , 

instance Eq Aposta where 
 (==) ap1 ap2 = (==) (comuns ap1 ap2) (5,2)
 
premio :: Aposta -> Aposta -> Maybe Int
premio apj apv = case (comuns apj apv) of 
                 (5,2) -> Just 1 

leAposta :: IO Aposta
leAposta = putStr "Escreva 5 números de 1 a 50"         
           apj <- getLine 
           let l = read apj :: [Int]
           putStr "Escreva 2 estrelas entre 1 e 12"
           est <- getLine
           let e = read est :: (a,b)
           if valida (Ap l e) then return (Ap l e) else putStr "Aposta Invalida"
 
joga :: Aposta -> IO ()
joga cc = putStr "Escreva uma aposta" 
          x <- getLine 
          let apj = leAposta x 
          let Just p = if (premio apj cc) == Nothing then return "Sem Prémio"
                       else (premio apj cc)

geraChave :: IO Aposta
geraChave = let x <- geraNumero []
            let e <- geraEst 
            let aposta = (Ap x e)
            return aposta

geraNumero :: [Int] -> IO (Int)
geraNumero l = x <- randomRIO (1..50)
               if (length l) == 5 then return l 
               else if elem x l then geraNumero l 
               else geraNumero (x:l)
            
geraEst :: IO (Int,Int)
geraEst = a <- randomRIO (1..12)
          b <- randomRIO (1..12)
          if a/=b then return (a,b) 
          else geraEst

          













