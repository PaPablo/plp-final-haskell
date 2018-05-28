module Cliente 
    (TipoCliente (..),
    comoEsta,
    rescatarse,
    esAmigo,
    agregarAmigo,
    amigarse,
    grogXD,
    jarraLoca,
    klusener,
    tintico,
    soda
    )
    where

import Data.Char

{- Objetivo 1 -}

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

esAmigo :: TipoCliente -> TipoCliente -> Bool
esAmigo cliente amigo = elem amigo (amigos cliente)

agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente
agregarAmigo (Cliente nombre resistencia amigos) nuevo_amigo = Cliente nombre resistencia (nuevo_amigo:amigos)
--Otra forma de agregar el amigo es concatenando listas (hacer una lista con el nuevo_amigo)
--agregarAmigo (Cliente nombre resistencia amigos) nuevo_amigo = Cliente nombre resistencia (amigos++[nuevo_amigo])

amigarse :: TipoCliente -> TipoCliente -> TipoCliente
amigarse cliente amigo
  | cliente /= amigo && not(esAmigo cliente amigo) = agregarAmigo cliente amigo 
  | otherwise = cliente

{- Objetivo 3 -}

comoEsta :: TipoCliente -> String
comoEsta cliente 
  | resistencia cliente > 50 = "fresco"
  | length (amigos cliente) >= 1 = "piola"
  | otherwise = "duro"

{- Objetivo 5 -}

{---------------------------
-----Bebidassssssssssss-----
----------------------------}

grogXD:: TipoCliente -> TipoCliente
grogXD (Cliente nombre resistencia amigos) = (Cliente nombre 0 amigos)

disminuirResistencia :: Int -> TipoCliente -> TipoCliente
disminuirResistencia cantidad (Cliente nombre resistencia amigos) 
    | resistencia > 10 = (Cliente nombre (resistencia-10) amigos)
    | otherwise = (Cliente nombre 0 amigos)
    
jarraLoca :: TipoCliente -> TipoCliente
jarraLoca (Cliente nombre resistencia amigos) = 
        disminuirResistencia 10 (Cliente nombre resistencia (map (disminuirResistencia 10) amigos))

klusener :: String -> TipoCliente -> TipoCliente
klusener nombreBebida (Cliente nombre resistencia amigos) = 
                disminuirResistencia (length nombreBebida) (Cliente nombre resistencia amigos)
                {-(Cliente nombre (disminuirResistencia (length nombreBebida) resistencia) amigos)-}

tintico :: TipoCliente -> TipoCliente
tintico (Cliente nombre resistencia amigos) = 
                (Cliente nombre (resistencia + (5 * (length amigos))) amigos)

soda :: Int -> TipoCliente -> TipoCliente
soda fuerza (Cliente nombre resistencia amigos) = 
                (Cliente (erpear fuerza nombre) resistencia amigos)
                where erpear fuerza nombre = "e" ++ (replicate fuerza 'r') ++ "p" ++ nombre

{- Objetivo 6 -}

rescatarse :: TipoCliente -> Int -> TipoCliente
rescatarse (Cliente nombre resistencia amigos) horas
  | horas > 3 = Cliente nombre (resistencia+200) amigos
  | otherwise = Cliente nombre (resistencia+100) amigos
