import Cliente

rodri       = Cliente "Rodri" 55 [] [Tintico]
marcos      = Cliente "Marcos" 40 [rodri] [(Klusener "guinda")]
cristian    = Cliente "Cristian" 2 [] [GrogXD, JarraLoca]
ana         = Cliente "Ana" 120 [marcos, rodri] []
robertoCarlos = Cliente "Roberto Carlos" 165 [] []

mezclaExplosiva = Itinerario 
    "Mezcla explosiva" 
    2.5 
    [(tomarTrago GrogXD),
    (tomarTrago (Klusener "huevo")), 
    (tomarTrago (Klusener "frutilla"))]
itinerarioBasico = Itinerario 
    "Itinerario básico"
    5.0 
    [(tomarTrago JarraLoca), 
    (tomarTrago (Klusener "chocolate")), 
    (rescatarse 2), 
    (tomarTrago (Klusener "huevo"))]
salidaDeAmigos = Itinerario 
    "Salida de amigos"
    1
    [(tomarTrago (Soda 1)),
    (tomarTrago Tintico),
    (amigarse robertoCarlos),
    (tomarTrago JarraLoca)]

{- Pruebas planteadas en el enunciado -}

{- Primera parte-}

{- Objetivo 3 -}

parte1objetivo3a = "Cristian se encuentra duro: " ++ show(comoEsta cristian)
parte1objetivo3b = "Rodri se encuentra fresco" ++ show(comoEsta rodri)
parte1objetivo3c = "Marcos se encuentra duro: " ++ show(comoEsta marcos)
parte1objetivo3d = 
        "Marcos se hace amigo de Ana y Rodry y encuentra piola: " ++ 
        show(comoEsta (amigarse (amigarse marcos ana) rodri ))

{- Objetivo 4 -}

parte1Objetivo4a = "Rodri se inteta agregarse a sí mismo, y sus lista de amigos no se modifica: " ++
        show(amigos (amigarse rodri rodri))

parte1Objetivo4b = "Marcos se inteta agregar a Rodri (que ya es su amigo), y sus lista de amigos no se modifica: " ++
        show(amigos (amigarse marcos rodri))

parte1Objetivo4c = "Rodri se inteta agregar a Marcos (que ya es su amigo), y sus lista de amigos no se modifica: " ++
        show(amigos (amigarse rodri marcos))

parte1Objetivo5a = "Ana toma GrogXD. Queda con resistencia 0. " ++ show(resistencia (tomarTrago GrogXD ana))

parte1Objetivo5b = "Ana toma la Jarra Loca. Queda con resistencia 110, su amigo Marcos queda con 30 de resistencia y su amigo Rodri queda con 45 de resistencia. " ++ show (amigos (tomarTrago JarraLoca ana))

parte1Objetivo5c = "Ana toma un Klusener de huevo, queda con 115 de resistencia" ++ show(tomarTrago (Klusener "huevo") ana)

parte1Objetivo5d = "Ana toma un Klusener de chocolate, queda con 111 de resistencia" ++ show(tomarTrago (Klusener "chocolate") ana)

parte1Objetivo5e = "Cristian toma un Tintico, queda con 2 de resistencia por no tener amigos." ++ show(tomarTrago Tintico cristian)

parte1Objetivo5f = "Ana toma un Tintico, pasa de 120 a 130 de resistencia (tiene 2 amigos)" ++ show(tomarTrago Tintico ana)

parte1Objetivo5g = "Rodri toma una Soda de fuerza 2, queda con nombre 'errpRodri'”" ++ show(tomarTrago (Soda 2) rodri)

parte1Objetivo5h = "Ana toma una Soda de fuerza 10, queda con nombre 'errrrrrrrrrpAna'" ++ show(tomarTrago (Soda 10) ana)

parte1Objetivo5i = "Ana toma una Soda de fuerza 0, queda con nombre 'epAna'" ++ show(tomarTrago (Soda 10) ana)

{- Objetivo 6 -}


parte1Objetivo6a = "Rodri se rescata 5 horas, queda con 255 de resistencia (55 + 200 ya que son más de 3 horas)" ++ show(rescatarse 5 rodri)
parte1Objetivo6b = "Rodri se rescata 1 hora, queda con 155 de resistencia (55 + 100 porque son menos de 3 horas)" ++ show(rescatarse 1 rodri)

{- Objetivo 7 -}

parte1Objetivo7 = 
        "Luego de evaluar el itinerario de Ana, queda con 196 de resistencia, como amigos a Marcos (30 de resistencia) y Rodri (45 de resistencia)." 
        ++ show (
            hacerItinerario 
                (Itinerario 
                "Ana's Itinerario" 
                2 
                [tomarTrago JarraLoca,
                tomarTrago (Klusener "chocolate"),
                rescatarse 2,
                tomarTrago (Klusener "huevo")])
                ana
            )

{- Parte 2 -}

rodriTomado = tomarTragos rodri [Tintico] 
marcosTomado = tomarTragos marcos [(Klusener "guinda")]
cristianTomado = tomarTragos cristian [GrogXD, JarraLoca] 

{-Objetivo 1b-}

parte2Objetivo1ba = 
    "Marcos toma una soda de nivel 3 y queda con 2 bebidas" 
    ++ show(tomarTrago (Soda 3) marcos)

parte2Objetivo1bb = 
    "Marcos toma una soda de nivel 3 y queda con 40 de resistencia" 
    ++ show(tomarTrago (Soda 3) marcos)

{-Objetivo 1c-}

parte2Objetivo1ca = 
    "Rodri toma una soda de nivel 1 y una soda de nivel 2 y queda con nombre “errperpRodri”" 
    ++ show(tomarTragos rodri [(Soda 1), (Soda 2)])

parte2Objetivo1cb = 
    "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 30 de resistencia" 
    ++ show(tomarTragos marcos [(Klusener "huevo"), Tintico, JarraLoca])

parte2Objetivo1cd = 
    "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 4 bebidas en el historial" 
    ++ show(tomarTragos marcos [(Klusener "huevo"), Tintico, JarraLoca])

{-Objetivo 1d-}

parte2Objetivo1da = 
    "Ana pide “dame otro” y debe dar error" 
    ++ show(dameOtro ana)

parte2Objetivo1db = 
    "Marcos pide “dame otro” y tiene 2 bebidas en el historial" 
    ++ show(dameOtro marcos)

parte2Objetivo1dc = 
    "Marcos pide “dame otro” y lo deja con 34 de resistencia" 
    ++ show(dameOtro marcos)

parte2Objetivo1dd = 
    "Rodri toma una soda de nivel 1, y “dameOtro” da como resultado que tiene 3 bebidas" 
    ++ show( (dameOtro . (tomarTrago (Soda 1))) rodri )

parte2Objetivo1de = 
    "Rodri toma una soda de nivel 1, y “dameOtro” da como resultado que su nombre queda “erperpRodri”" 
    ++ show((dameOtro . (tomarTrago (Soda 1))) rodri)

{-Objetivo 2b-}

parte2Objetivo2ba = 
    "Rodri puede tomar dos bebidas, entre un grog XD, un tintico y un klusener de frutilla." 
    ++ show(cualesPuedeTomar rodri [ GrogXD, Tintico, (Klusener "frutilla") ])

parte2Objetivo2bb = 
    "Entre un grog XD, un tintico, un klusener de 'fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla' se puede tomar una sola bebida" 
    ++ show(cualesPuedeTomar rodri 
    [GrogXD, Tintico, 
    (Klusener "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla")] )

{-Objetivo 3b-}

parte2Objetivo3ba = 
    "Rodri hace una salida de amigos y debe quedar con un amigo" 
    ++ show(hacerItinerario salidaDeAmigos rodri)

parte2Objetivo3bb = 
    "Rodri hace una salida de amigos y se debe llamar “erpRodri”" 
    ++ show(hacerItinerario salidaDeAmigos rodri)

parte2Objetivo3bc = 
    "Rodri hace una salida de amigos y debe quedar con 45 de resistencia" 
    ++ show(hacerItinerario salidaDeAmigos rodri)

parte2Objetivo3bd = 
    "Rodri hace una salida de amigos y su primer y único amigo Roberto Carlos debe quedar con 155 de resistencia" 
    ++ show(hacerItinerario salidaDeAmigos rodri)

parte2Objetivo3be = 
    "Rodri hace una salida de amigos y debe quedar con 4 bebidas en su historial." 
    ++ show(hacerItinerario salidaDeAmigos rodri)

{-Objetivo 4a-}

parte2Objetivo4aa = 
    "la intensidad de la mezcla explosiva es 1.2" 
    ++ show(intensidad mezclaExplosiva)

parte2Objetivo4ab = 
    "la intensidad de la salidaDeAmigos es 4.0" 
    ++ show(intensidad salidaDeAmigos)

parte2Objetivo4ac = 
    "la intensidad del itinerario basico es 0.8" 
    ++ show(intensidad itinerarioBasico)

{-Objetivo 4b-}

parte2Objetivo4ba = 
    "Entre la salida de amigos, la mezcla explosiva y el itinerario básico, el itinerario más intenso es la salida de amigos" 
    ++ show((intensidad mezclaExplosiva, intensidad itinerarioBasico))

parte2Objetivo4bb = 
    "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con el nombre 'erpRodri'" 
    ++ show(hacerElMasIntenso [salidaDeAmigos, mezclaExplosiva, itinerarioBasico] rodri)

parte2Objetivo4bd = 
    "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con resistencia 45" 
    ++ show(hacerElMasIntenso [salidaDeAmigos, mezclaExplosiva, itinerarioBasico] rodri)

parte2Objetivo4bc = 
    "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con un amigo: Roberto Carlos" 
    ++ show(hacerElMasIntenso [mezclaExplosiva, salidaDeAmigos, itinerarioBasico] rodri)

{-Objetivo 5-}

parte2Objetivo5a = 
    "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 0, sigue quedando con una sola amiga (Ana)" 
    ++ show(tomarTrago (JarraPopular 0) (amigarse robertoCarlos ana))

parte2Objetivo5b = 
    "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 3, queda con 3 amigos (Ana, Marcos y Rodri)" 
    ++ show(tomarTrago (JarraPopular 3) (amigarse robertoCarlos ana))

parte2Objetivo5c = 
    "Cristian se hace amigo de Ana. Roberto Carlos se hace amigo de Cristian, toma una jarra popular de espirituosidad 4, queda con 4 amigos (Cristian, Ana, Marcos y Rodri)" 
    ++ show(tomarTrago (JarraPopular 4) (amigarse robertoCarlos (amigarse cristian ana)))

