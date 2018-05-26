module Cliente 
    (TipoCliente (..),
    como_esta,
    rescatarse,
    es_amigo,
    agregar_amigo,
    amigarse)
    where

import Data.Char

data TipoCliente = 
    Cliente {
    nombre      :: String,
    resistencia :: Int,
    amigos      :: [TipoCliente]}
    deriving (Show)

{-Un cliente se sabe comparar-}
{-Dos cliente son iguales si sus nombres (en minúsculas) son iguales-}
instance Eq TipoCliente where
    c1 == c2 = lowercase (nombre c1) == lowercase (nombre c2)
        where lowercase cadena = [toLower c | c <- cadena]
    c1 /= c2 = not(c1 == c2)

como_esta :: TipoCliente -> String
como_esta cliente 
  | resistencia cliente > 50 = "fresco"
  | length (amigos cliente) >= 1 = "piola"
  | otherwise = "duro"

rescatarse :: TipoCliente -> Int -> TipoCliente
rescatarse (Cliente nombre resistencia amigos) horas
  | horas > 3 = Cliente nombre (resistencia+200) amigos
  | otherwise = Cliente nombre (resistencia+100) amigos

es_amigo :: TipoCliente -> TipoCliente -> Bool
es_amigo cliente amigo = elem amigo (amigos cliente)

agregar_amigo :: TipoCliente -> TipoCliente -> TipoCliente
agregar_amigo (Cliente nombre resistencia amigos) nuevo_amigo = Cliente nombre resistencia (nuevo_amigo:amigos)
--Otra forma de agregar el amigo es concatenando listas (hacer una lista con el nuevo_amigo)
--agregar_amigo (Cliente nombre resistencia amigos) nuevo_amigo = Cliente nombre resistencia (amigos++[nuevo_amigo])

amigarse :: TipoCliente -> TipoCliente -> TipoCliente
amigarse cliente amigo
  | cliente /= amigo && not(es_amigo cliente amigo) = agregar_amigo cliente amigo 
  | otherwise = cliente
