import Cliente

rodri       = Cliente "Rodri" 55 [] []
marcos      = Cliente "Marcos" 40 [rodri] []
cristian    = Cliente "Cristian" 2 [] []
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
