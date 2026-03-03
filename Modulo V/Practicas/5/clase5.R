
#======================= Modelo SIS de infeccion (pag. 23) ===================================#

# Parametros:

# Tasa de infeccion
beta = 0.3

# Tasa de recuperacion
gamma = 0.15

# Tamano de la poblacion
N = 5

# Discretizacion
delta = 0.1

# Creamos la funcion siguiente para la matriz de trasicion...
MT_SIS = function(beta,gamma,N,delta)
{
  MT = matrix(0,nrow = (N+1), ncol = (N+1))
  MT[1,1] = 1
  MT[N+1,N+1] = 1
  
  for (i in 2:N) 
  {
    # numero de infectados
    j = i-1
    MT[i,i+1] = delta*beta*j*(N-j)/N 
    MT[i,i-1] = delta*gamma*j
    MT[i,i]   = 1 - delta*beta*j*(N-j)/N- delta*gamma*j
  }
  return(MT)
}

# veamos un ejemplo:
SIS = MT_SIS(beta,gamma,N,delta)
SIS

#===========================================================================================#

#======================= Modelo SIS de infeccion modificado ================================#

# como podemo ver; la matriz de transicion no es reducible y por ende, muchas de las cosa que hemos estudiado nos limita.
# Asi que para revertir este hecho, vamos a suponer que:

# - la poblacion no tiene infectados al comienzo y en el estado 2 uno esta infectado uno
# - mientras que si toda l poblacion este infectada, se recupere al menos uno

# Parametros:

# Tasa de infeccion
beta = 0.3

# Tasa de recuperacion
gamma = 0.15

# Tamano de la poblacion
N = 5

# Discretizacion
delta = 0.1

# Creamos la funcion siguiente para la matriz de trasicion...
MT_SIS_Modif = function(beta,gamma,N,delta)
{
  MT = matrix(0,nrow = (N+1), ncol = (N+1))
  MT[1,2] = 1
  MT[(N+1),N] = 1
  
  for (i in 2:N) 
  {
    # numero de infectados
    j = i-1
    MT[i,i+1] = delta*beta*j*(N-j)/N 
    MT[i,i-1] = delta*gamma*j
    MT[i,i]   = 1 - delta*beta*j*(N-j)/N - delta*gamma*j
  }
  return(MT)
}

# veamos un ejemplo:
SIS_1 = MT_SIS_Modif(beta,gamma,N,delta)
SIS_1

#=============================================================================================#

# traemos la funcion con solo hacer la trayectoria....

#=============================================================================================#

trayMC = function(pi,MT,m)
{
  tray = NULL       # guardaremos la trayectoria generada en este variable (estara vacio al inicio)
  N = length(pi)    # N sera el tamano sera E
  E = 1:N             # generamos el conjunto de estados
  
  #paso 1: escojemos una X_0 en base a E por su distribucion inical y lo guardamos en "tray"
  tray = sample(E,1,prob = pi)
  
  #paso 2: comenzamos con la iteracion con 1 y con el while sigue la iteracion hasta que sean iguales
  i=1
  while(i<=m)
  {
    #paso 3: escogemos un X_i en base a E y la distribucion estara en la matriz de transicion
    tray = c(tray,sample(E,1,prob = MT[tail(tray,1),]))
    
    #paso 4: para que itere a la siguiente caso lo hacemos con lo siguiente:
    i=i+1
  }
  # dejando a un lado el algoritmo; podemos ver la trayectoria que hemos generado
  plot(tray,main = "Trayectoria de una cadena de Markov",xlab = "Momentos",ylab = "Estados",ylim = c(-0.5,N+1),type = "p")
  
  return(tray)
}

#=============================================================================================#

# veamos como queda la trayectoria de ejemplo:
pi=numeric(N+1)   # distribucion inicial
pi[3]=1

tray = trayMC(pi,SIS_1,100)
tray

# veamos la veces en la que pasa por los 5 estados la poblacion
table(tray)

# Vamos a guarda la matriz de una objeto "Markovchain"
st = as.character(seq(0:(N))-1)     # establecemos los estados

#creando un nuevo objeto de cadena de Markov
MSIS = new("markovchain",transitionMatrix = SIS_1,name = "MSIS",states = st)
MSIS

#muestra los estados
states(MSIS)

#transición entre estados particulares
transitionProbability(MSIS, "1", "0")

# transición en "m" pasos (vemos que la distribucion invariante esta mas presente)
m = 1102
MSIS^m

# distribucion de la m-esima variable aleatoria 
pi*MSIS^m

# accesibilidad
is.accessible(MSIS,"1","3")

# clases de comunicación
communicatingClasses(MSIS)

#calcula el periodo
period(MSIS)

#estados transitorio
transientStates(MSIS)

# estados absorbentes
absorbingStates(MSIS)

# irreducible
is.irreducible(MSIS)

# clases recurrentes
recurrentClasses(MSIS)

#distribucion invariante o estacionaria
v=steadyStates(MSIS)
v
#tiempo medio de recurrencia
u=1/v
u