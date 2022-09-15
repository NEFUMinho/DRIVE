import System.Random
import System.IO
import Data.Char
import Data.List
--1
--a
bingo :: IO()
bingo = do nl <- acumularNumeros []
           print "Fim,esta foi a ordem pela qual sairam os numeros:"
           print nl

acumularNumeros :: [Int] -> IO [Int]
acumularNumeros l | length l == 90 = do return l
                  | otherwise = do v <- randomRIO (1,90)
                                   if elem v l then acumularNumeros l else do{print v;getChar;acumularNumeros (v:l)}
--b
mastermind :: IO ()
mastermind = do putStrLn "Bem-vindo ao jogo mastermind:"
                k <- getKey 
                doGuess k

getKey :: IO (Char,Char,Char,Char)
getKey = do n1 <- randomRIO ('1','9')
            n2 <- randomRIO ('1','9') 
            n3 <- randomRIO ('1','9') 
            n4 <- randomRIO ('1','9') 
            return (n1,n2,n3,n4)

getGuess :: IO (Char,Char,Char,Char)
getGuess = do x <- getLine
              let (n1:n2:n3:n4:r) = x
              return (n1,n2,n3,n4)

doGuess :: (Char,Char,Char,Char) -> IO ()
doGuess n =
 do g <- getGuess
    if (nC g n)==4 then print "Ganhaste" 
    else do putStrLn("Valores corretos: "++show (nC g n))
            putStrLn("Valores corretos no sitio errado: "++show (nS g n))
            doGuess n

nC :: (Char,Char,Char,Char) -> (Char,Char,Char,Char) -> Int
nC (g1,g2,g3,g4) (n1,n2,n3,n4) =(if g1==n1 then 1 else 0)+(if g2==n2 then 1 else 0)+(if g3==n3 then 1 else 0)+(if g4==n4 then 1 else 0) 

nS :: (Char,Char,Char,Char) -> (Char,Char,Char,Char) -> Int
nS (g1,g2,g3,g4) (n1,n2,n3,n4) = (if g1/=n1 && elem g1 n then 1 else 0)+(if g2/=n2 && elem g2 n then 1 else 0)+(if g3/=n3 && elem g3 n then 1 else 0)+(if g4/=n4 && elem g4 n then 1 else 0)
 where n = [n1,n2,n3,n4]
--2
data Aposta = Ap [Int] (Int,Int) deriving Show
--a
valida :: Aposta -> Bool 
valida (Ap l (a,b)) = (validaN l) && a/=b && elem a [1..12] && elem b [1..12]

validaN :: [Int] -> Bool
validaN l@(h:t)= length l==5 && and(map (\a ->elem a [1..50]) l) && aux h t
 where aux x (h:t) = if elem x (h:t) then False else aux h t 
       aux x [] = True
--b
comuns :: Aposta -> Aposta -> (Int,Int) 
comuns (Ap l (a,b)) (Ap c (x,y)) = ((comunsN l c),(comunsE (a,b) (x,y)))
 where comunsN (h:t) c = (if elem h c then 1 else 0) + comunsN t c
       comunsN [] c = 0
       comunsE (a,b) (x,y) = (if a==x || a==y then 1 else 0)+(if b==x||b==y then 1 else 0)
--c
--i
instance Eq Aposta where
 a==b = (comuns a b)==(5,2)
--ii
premio :: Aposta -> Aposta -> Maybe Int
premio ap ch = case (comuns ap ch) of
 (5,2) -> Just 1
 (5,1) -> Just 2
 (5,0) -> Just 3
 (4,2) -> Just 4
 (4,1) -> Just 5
 (4,0) -> Just 6
 (3,2) -> Just 7
 (2,2) -> Just 8
 (3,1) -> Just 9
 (3,0) -> Just 10
 (1,2) -> Just 11
 (2,1) -> Just 12
 (2,0) -> Just 13
 _ -> Nothing
--d
leAposta :: IO Aposta 
leAposta = do putStrLn "Aposta(5 números entre 1 e 50 da forma [a,b,c,d,e], Enter no final):"
              x<-getLine
              let n = read x :: [Int]
              putStrLn "Estrelas(2 números entre 1 e 12 da forma (a,b) espaços,Enter no final):"
              y<-getLine
              let e = read y :: (Int,Int)
              let aposta = Ap n e
              if valida aposta then return aposta else do {putStrLn "Faz outra aposta";leAposta}
--e
geraChave :: IO Aposta
geraChave = do n<- geraN []
               e<- geraE
               return (Ap n e)

geraN :: [Int] -> IO [Int]
geraN l = do x<-randomRIO(1,50)
             if length l==5 then return l else if elem x l then geraN l else geraN (x:l)

geraE :: IO (Int,Int)
geraE = do a<-randomRIO(1,12)
           b<-randomRIO(1,12)
           if a==b then geraE else return (a,b)
--f
main :: IO () 
main = do ch <- geraChave 
          ciclo ch

menu :: IO String 
menu = do { putStrLn menutxt ; putStr "Opcao: " ; c <- getLine ; return c } 
 where menutxt = unlines ["", "Apostar ........... 1", "Gerar nova chave .. 2", "", "Sair .............. 0"]

ciclo :: Aposta -> IO ()
ciclo c = do m<-menu
             case m of "0" -> putStrLn "Acabou o jogo" 
                       "1" -> do {joga c;ciclo c}
                       "2" -> main 
                       otherwise -> do {putStrLn "Opção inválida!";main}

joga :: Aposta -> IO ()
joga c = do putStrLn "Faça a sua Aposta"
            a <- leAposta
            let x = comuns a c
            let Just p = if (premio a c)==Nothing then Just 0 else premio a c
            if x==(0,0)||x==(0,1)||x==(0,2)||x==(1,0)||x==(1,1) then do putStrLn "Perdeu"  else do putStrLn("Ganhou o "++show p++"º prémio!")