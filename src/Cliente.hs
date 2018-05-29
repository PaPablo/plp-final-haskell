module Cliente 
    (TipoCliente (..),
    TipoBebida (..),
    TipoItinerario (..),
    comoEsta,
    rescatarse,
    esAmigo,
    agregarAmigo,
    amigarse,
    tomarTrago,
    tomarTragos,
    dameOtro,
    cualesPuedeTomar,
    cuantasPuedeTomar,
    hacerItinerario,
    intensidad,
    hacerElMasIntenso,
    )
    where

import Data.Char

{- Objetivo 1 -}

data TipoCliente = 
    Cliente {
    nombre          :: String,
    resistencia     :: Int,
    amigos          :: [TipoCliente],
    bebidas_tomadas :: [TipoBebida]}

instance Show TipoCliente where
    show (Cliente nombre resistencia amigos bebidas_tomadas) = show(nombre)
    
{-Un cliente se sabe comparar-}
{-Dos cliente son iguales si sus nombres (en minúsculas) son iguales-}
instance Eq TipoCliente where
    c1 == c2 = lowercase (nombre c1) == lowercase (nombre c2)
        where lowercase cadena = [toLower c | c <- cadena]
    c1 /= c2 = not(c1 == c2)



esAmigo :: TipoCliente -> TipoCliente -> Bool
esAmigo cliente amigo = elem amigo (amigos cliente)

agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente
agregarAmigo (Cliente nombre resistencia amigos bebidas_tomadas) nuevo_amigo = 
    Cliente nombre resistencia (nuevo_amigo:amigos) bebidas_tomadas
--Otra forma de agregar el amigo es concatenando listas (hacer una lista con el nuevo_amigo)
--agregarAmigo (Cliente nombre resistencia amigos) nuevo_amigo = Cliente nombre resistencia (amigos++[nuevo_amigo])

amigarse :: TipoCliente -> TipoCliente -> TipoCliente
amigarse amigo cliente
  | cliente /= amigo && not(esAmigo cliente amigo) = agregarAmigo cliente amigo 
  | otherwise = cliente

{- Objetivo 3 -}

comoEsta :: TipoCliente -> String
comoEsta cliente 
  | resistencia cliente > 50 = "fresco"
  | length (amigos cliente) >= 1 = "piola"
  | otherwise = "duro"

{- Objetivo 5 -}

data TipoBebida = 
        GrogXD 
      | JarraLoca
      | Klusener    {sabor :: String}
      | Tintico
      | Soda        {fuerza :: Int}

instance Show TipoBebida where
    show GrogXD = "GrogXD"
    show JarraLoca = "Jarra Loca"
    show (Klusener sabor) = ("Klusener de " ++ sabor)
    show Tintico = "Tintico"
    show (Soda fuerza) = ("Soda de fuerza " ++ show(fuerza))

{- Objetivo 6 -}

rescatarse :: Int -> TipoCliente -> TipoCliente
rescatarse horas (Cliente nombre resistencia amigos bebidas_tomadas) 
  | horas > 3 = Cliente nombre (resistencia+200) amigos bebidas_tomadas
  | otherwise = Cliente nombre (resistencia+100) amigos bebidas_tomadas


{---------------------
----Segunda parte-----
----------------------}

{- Objetivo 1 -}


disminuirResistencia :: Int -> TipoCliente -> TipoCliente
disminuirResistencia cantidad (Cliente nombre resistencia amigos bebidas_tomadas) 
  | resistencia > cantidad = (Cliente nombre (resistencia-cantidad) amigos bebidas_tomadas)
  | otherwise = (Cliente nombre 0 amigos bebidas_tomadas)


tomarTrago :: TipoBebida -> TipoCliente -> TipoCliente
tomarTrago 
    GrogXD 
    (Cliente nombre resistencia amigos bebidas_tomadas) = 
        (Cliente nombre 0 amigos (GrogXD:bebidas_tomadas))
tomarTrago 
    JarraLoca 
    (Cliente nombre resistencia amigos bebidas_tomadas) = 
        disminuirResistencia 10 
            (Cliente nombre resistencia (map (disminuirResistencia 10) amigos) (JarraLoca:bebidas_tomadas))
tomarTrago 
    (Klusener nombreBebida) 
    (Cliente nombre resistencia amigos bebidas_tomadas) = 
        disminuirResistencia (length nombreBebida) 
            (Cliente nombre resistencia amigos ((Klusener nombreBebida):bebidas_tomadas))
tomarTrago 
    Tintico 
    (Cliente nombre resistencia amigos bebidas_tomadas) = 
        (Cliente nombre (resistencia + (5 * (length amigos))) amigos (Tintico:bebidas_tomadas))
tomarTrago 
    (Soda fuerza) 
    (Cliente nombre resistencia amigos bebidas_tomadas) = 
        (Cliente (erpear fuerza nombre) resistencia amigos ((Soda fuerza):bebidas_tomadas))
                where erpear fuerza nombre = "e" ++ (replicate fuerza 'r') ++ "p" ++ nombre


tomarTragos :: TipoCliente -> [TipoBebida] -> TipoCliente
tomarTragos cliente listaTragos =
    foldr tomarTrago cliente listaTragos
    
dameOtro :: TipoCliente -> TipoCliente
dameOtro (Cliente nombre resistencia amigos []) =
    (Cliente nombre resistencia amigos [])
dameOtro cliente =
    tomarTrago (head (bebidas_tomadas cliente)) cliente 


{- Objetivo 2 -}

cualesPuedeTomar :: TipoCliente -> [TipoBebida] -> [TipoBebida]
cualesPuedeTomar cliente listaTragos =
    filter (puedoTomar cliente) listaTragos
        where puedoTomar cliente trago = resistencia (tomarTrago trago cliente) > 0

cuantasPuedeTomar :: TipoCliente -> [TipoBebida] -> Int
cuantasPuedeTomar cliente listaTragos = 
    length (cualesPuedeTomar cliente listaTragos)

{- Objetivo 3 -}

data TipoItinerario = 
    Itinerario {
    nombreItinerario    :: String,
    duracion            :: Float,
    acciones            :: [(TipoCliente -> TipoCliente)]}

instance Show TipoItinerario where
    show (Itinerario nombre duracion acciones) = 
        nombre
        ++ ": " 
        ++ "itinerario de duracion " 
        ++ show(duracion) 
        ++ " horas (intensidad " 
        ++ show(intensidad (Itinerario nombre duracion acciones)) 
        ++ ")"

instance Eq TipoItinerario where
    it1 == it2 = intensidad it1 == intensidad it2
    it1 /= it2 = not(it1 == it2)

instance Ord TipoItinerario where
    it1 <= it2 = intensidad it1 <= intensidad it2


hacerItinerario :: TipoItinerario -> TipoCliente -> TipoCliente
hacerItinerario (Itinerario _ _ []) cliente = cliente
hacerItinerario (Itinerario nombre duracion (accion:acciones)) cliente =
    hacerItinerario (Itinerario nombre duracion acciones) (accion cliente)
    
intensidad :: TipoItinerario -> Float
intensidad (Itinerario nombre duracion acciones) =
    (fromIntegral (length acciones)) / duracion

hacerElMasIntenso :: [TipoItinerario] -> TipoCliente -> TipoCliente
hacerElMasIntenso listaItinerarios cliente =
    hacerItinerario (maximum listaItinerarios) cliente
