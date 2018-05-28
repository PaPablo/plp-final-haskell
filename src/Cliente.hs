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
    soda,
    tomarTragos,
    dameOtro,
    cualesPuedeTomar,
    )
    where

import Data.Char

{- Objetivo 1 -}

data TipoCliente = 
    Cliente {
    nombre          :: String,
    resistencia     :: Int,
    amigos          :: [TipoCliente],
    bebidas_tomadas :: [String]}
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
agregarAmigo (Cliente nombre resistencia amigos bebidas_tomadas) nuevo_amigo = Cliente nombre resistencia (nuevo_amigo:amigos) bebidas_tomadas
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
grogXD (Cliente nombre resistencia amigos bebidas_tomadas) = (Cliente nombre 0 amigos ("Grog XD":bebidas_tomadas))

disminuirResistencia :: Int -> TipoCliente -> TipoCliente
disminuirResistencia cantidad (Cliente nombre resistencia amigos bebidas_tomadas) 
  | resistencia > cantidad = (Cliente nombre (resistencia-cantidad) amigos bebidas_tomadas)
  | otherwise = (Cliente nombre 0 amigos bebidas_tomadas)
    
jarraLoca :: TipoCliente -> TipoCliente
jarraLoca (Cliente nombre resistencia amigos bebidas_tomadas) = 
    disminuirResistencia 10 (Cliente nombre resistencia (map (disminuirResistencia 10) amigos) ("Jarra loca":bebidas_tomadas))

klusener :: String -> TipoCliente -> TipoCliente
klusener nombreBebida (Cliente nombre resistencia amigos bebidas_tomadas) = 
    disminuirResistencia (length nombreBebida) (Cliente nombre resistencia amigos (("Klusener de " ++ nombreBebida):bebidas_tomadas))
                {-(Cliente nombre (disminuirResistencia (length nombreBebida) resistencia) amigos)-}

tintico :: TipoCliente -> TipoCliente
tintico (Cliente nombre resistencia amigos bebidas_tomadas) = 
    (Cliente nombre (resistencia + (5 * (length amigos))) amigos ("Tintico":bebidas_tomadas))

soda :: Int -> TipoCliente -> TipoCliente
soda fuerza (Cliente nombre resistencia amigos bebidas_tomadas) = 
    (Cliente (erpear fuerza nombre) resistencia amigos (("Soda de fuerza " ++ show(fuerza)):bebidas_tomadas))
                where erpear fuerza nombre = "e" ++ (replicate fuerza 'r') ++ "p" ++ nombre

{- Objetivo 6 -}

rescatarse :: TipoCliente -> Int -> TipoCliente
rescatarse (Cliente nombre resistencia amigos bebidas_tomadas) horas
  | horas > 3 = Cliente nombre (resistencia+200) amigos bebidas_tomadas
  | otherwise = Cliente nombre (resistencia+100) amigos bebidas_tomadas


{---------------------
----Segunda parte-----
----------------------}

{- Objetivo 1 -}

tomarTrago cliente trago =
    trago cliente

tomarTragos [] cliente = cliente
tomarTragos (unTrago:otrosTragos) cliente = 
    tomarTragos otrosTragos (unTrago cliente)
    
dameOtro (Cliente nombre resistencia amigos bebidas_tomadas) =
    (Cliente nombre resistencia amigos ((head bebidas_tomadas):bebidas_tomadas))
