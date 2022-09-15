  module Ficha7 where

--ex.1 
 
  data ExpInt = Const Int
              | Simetrico ExpInt
              | Mais ExpInt ExpInt
              | Menos ExpInt ExpInt
              | Mult ExpInt ExpInt
 
  -- (a)

  calcula :: ExpInt -> Int
  calcula x = case x of Simetrico x -> - (calcula x)
                        Const x -> x
                        Mais x y -> (calcula x) + (calcula y)
                        Menos x y -> (calcula x) - (calcula y)
                        Mult x y -> (calcula x) * (calcula y)

  -- (b)

  infixa :: ExpInt -> String
  infixa x = case x of Const x -> show x
                       Simetrico x -> " - " ++ infixa x
                       Mais x y -> "(" ++ infixa x ++ " + " ++ infixa y ++ ")"
                       Menos x y -> "(" ++ infixa x ++ " - " ++ infixa y ++ ")"
                       Mult x y -> "(" ++ infixa x ++ " * " ++ infixa y ++ ")"

  -- (c)

  posfixa :: ExpInt -> String
  posfixa x = case x of Const x -> show x
                        Simetrico x -> " - " ++ infixa x
                        Mais x y -> posfixa x ++ " " ++ posfixa y ++ " + "
                        Menos x y -> posfixa x ++ " " ++ posfixa y ++ " - " 
                        Mais x y -> posfixa x ++ " " ++ posfixa y ++ " * "  
    
--ex.2

  data RTree a = R a [RTree a]

  -- (a)

  soma :: Num a => RTree a -> a 
  soma (R a []) = a 
  soma (R a b) = a + sum ((map (soma) b))   

  -- (c)

  altura :: RTree a -> Int 
  altura (R a []) = 1
  altura (R a b ) = 1 + maximum (map altura b)

  -- (d)

  prune :: Int -> RTree a -> RTree a
  prune 1 (R a _) = R a []
  prune n (R a []) = R a [] 
  prune n (R a l) = R a (map (prune (n-1)) l)

  -- (e)

  mirror :: RTree a -> RTree a 