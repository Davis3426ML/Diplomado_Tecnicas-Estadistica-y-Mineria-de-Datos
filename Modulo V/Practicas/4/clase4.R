# Antes de continuar con los temas de cadenas de Markov; hay que instalar una paqueteria previa 
      # que nos ayudara en la visualizacion y calculos que son parte de este tema.

#cargando el paquete
library(markovchain)

# Probemos que cargo la paqueria con crea una matriz

P3 = matrix(0,nrow=3,ncol=3)      # Matriz de 3x3

# Establecemos los valores en cada lugar de la matriz
P3[1,1]=1/2
P3[1,2]=1/4
P3[1,3]=1/4
P3[2,1]=1/3
P3[2,2]=1/3
P3[2,3]=1/3
P3[3,1]=0
P3[3,2]=1
P3[3,1]=0

# Convertimos la matriz de transicion
Ejem = new("markovchain",transitionMatrix = P3,name = "Ejemplo")
Ejem


#=================================== Cadenas de Markov =======================================#

                      # Ejemplo 1: Ruina del jugador

# Observando la situacion de ganar un pesos (con p de probabilidad) o perderlo (con 1-p de probilidad)
# ya empezando una cantidad k$ y es posible ver su matriz de transicion:


# Parametros:
k = 3     # Capital inicial k
p = 67/100   # Probabildad de aguila


# Creamos la Matriz de Transicion en funcion a este caso
MTRG = function(k,p)
{
  MT = matrix(0,nrow = (2*k+1),ncol = (2*k+1))      # 2*k+1 es el tamano de E
  
  # En esta posicion es seguro que pase por eso el 1 (de igual forma con los demas)
  MT[1,1] = 1               
  MT[(2*k+1),(2*k+1)] = 1
  
  # En cada posicion colocamos la probabilidad p (por el analisis que realizamos)
  for(i in 2:(2*k))
  {
    MT[i,i+1] = p
    MT[i,i-1] = 1-p
  }
  
  return(MT)
}

# Veamos como queda la matriz 
MT = MTRG(k,p)
MT

# Pero podemos verlo de forma mas resumida sus caracteristisca con lo sig.

# Creamos el Espacio de estados como objeto
st = as.character(seq(0:(2*k))-1)

#creando un nuevo objeto de la matriz de transicion de la cadena de Markov analisado
Ruina = new("markovchain",transitionMatrix = MT,name = "Ruina",states = st)
Ruina

#y por ejemplo con esta version podemos ver cosas como:

# - Muestra los estados
states(Ruina)

# - Podemos ver la probabilidad en transiciónar entre estados particulares (en texto los parametros)
transitionProbability(Ruina, "3", "4")

# - en "m" paso podemos ver como quedaria la matriz de transicion (por definicion)
m = 3     # Con m-pasos
Ruina^m

# - Distribución inicial de la cadena (x_0 = i)
pi = numeric(2*k+1)     
pi[k+1] = 1
pi

# - Distribucion inicial de la cadema de la m-esima variable aleatoria (x_m = i)
pi*Ruina^m

#=============================================================================================#

#=================================== Comunicacion entre Estados ==============================#

                            # Ejemplo 1: Ruina del jugador (sin modificar)

# accesibilidad (ver si 2 estados se comunican)
is.accessible(Ruina,"1","3")

# clases de comunicación (comunicaciones existentes)
communicatingClasses(Ruina)

#estados transitorio (los estados mas recurrentes en pasar)
transientStates(Ruina)

# estados absorbentes (los estados donde una vez hay es imposible salir)
absorbingStates(Ruina)

# irreducible (si solo existe una clase de comunicacion)
is.irreducible(Ruina)

# clases recurrentes (los estados donde es mas comun estar)
recurrentClasses(Ruina)

#calcula el periodo (m.c.d del # paso de pasar de un estado a otro y solo con matriz irreducibles)
period(Ruina)


                        # Ejemplo 2: Ruina del jugador (con la posibilidad de que un 
                                   # jugador pueda presar un peso cuando este en cero)

# Creamos la Matriz de Transicion en funcion a este caso
MTRG_1 = function(k,p)
{
  MT = matrix(0,nrow = (2*k+1),ncol = (2*k+1))      # 2*k+1 es el tamano de E
  
  # En esta posicion es seguro que pase por eso el 1 (de igual forma con los demas)
  MT[1,2] = 1               
  MT[(2*k+1),(2*k)] = 1
  
  # En cada posicion colocamos la probabilidad p (por el analisis que realizamos)
  for(i in 2:(2*k))
  {
    MT[i,i+1] = p
    MT[i,i-1] = 1-p
  }
  
  return(MT)
}

# Veamos como queda la matriz 
MT_1 = MTRG_1(k,p)
MT_1

# Pero podemos verlo de forma mas resumida sus caracteristisca con lo sig.

#creando un nuevo objeto de la matriz de transicion de la cadena de Markov analisado
Ruina_1 = new("markovchain",transitionMatrix = MT_1,name = "Ruina_1",states = st)
Ruina_1

# Replicamos cada uno de los terminos del ejemplo anterior....

# accesibilidad (ver si 2 estados se comunican)
is.accessible(Ruina_1,"1","3")

# clases de comunicación (comunicaciones existentes)
communicatingClasses(Ruina_1)

#estados transitorio (los estados mas recurrentes en pasar)
transientStates(Ruina_1)

# estados absorbentes (los estados donde una vez hay es imposible salir)
absorbingStates(Ruina_1)

# irreducible (si solo existe una clase de comunicacion)
is.irreducible(Ruina_1)

# clases recurrentes (los estados donde es mas comun estar)
recurrentClasses(Ruina_1)

#calcula el periodo (m.c.d del # paso de pasar de un estado a otro y solo con matriz irreducibles)
period(Ruina_1)


#=============================================================================================#

#=================================== Invarianza e Estacionalidad ==============================#

# Se dice que una vector de distribucion de probabilidad v_i es invariante o estacional si 


#distribucion invariante o estacionaria
v = steadyStates(Ruina)
v

#tiempo medio de recurrencia
u=1/v
u

v*Ruina # (nos tiene que devolver el propio V)

#=============================================================================================#

#======================================= Cadena regular =====================================#

# Distribución límite: Si la cadena de Markov es irreducible, aperiódica (con periodo 1) 
        # y con distribución invariante v_i; entonces
              # el limite de probabilidad de pasar del estado i a j en n-pasos es el mismo v_i


# Ejemplo de cadena de Markov regular:
P = matrix(0,nrow = 3,ncol = 3)
P[1,1] = 1/4
P[1,2] = 3/4
P[2,3] = 1
P[3,1] = 1/2
P[3,3] = 1/2


#creando un nuevo objeto de cadena de Markov
E1 = new("markovchain",transitionMatrix = P,name = "E1")
E1

# muestra los estados
states(E1)

# transición entre estados particulares 
transitionProbability(E1, "2", "1")

# transición en "m" pasos
m = 35
E1^m

# accesibilidad
is.accessible(E1,"3","1")


# clases de comunicación
communicatingClasses(E1)


#distribucion invariante o estacionaria
v = steadyStates(E1)
v

# y con esto podemos ver por definicion el promedio de paso de estar en algunos de los estados 
u = 1/v
u

#calcula el periodo
period(E1)

#estados transitorio
transientStates(E1)

# estados absorbentes
absorbingStates(E1)

# irreducible
is.irreducible(E1)

# clases recurrentes
recurrentClasses(E1)

# Con la condiciones anteriores; podemos ver que con n -> infinito; esta se aproxima a la distribucion invariante
E1
E1^2
E1^3
E1^5
E1^6
E1^7
E1^8
E1^10
E1^12
E1^14
E1^20
E1^50



# veamos como es la distribucion invariante y el promedio de veces en la que pasa en ese estado
v = steadyStates(E1)
u = 1/v
u

# Podemos ver que esta distribucion si es invariante por definicion 
v*E1
v



#=============================================================================================#

#======================= simulacion de trayectorias de cadenas de markov ====================#

# Parametros:

pi = c(1/4,1/4,1/2)     # Necesitamos una distribucion inicial

P = matrix(0,nrow = 3,ncol = 3)     # Matriz de transicion
P[1,1] = 1/4
P[1,2] = 3/4
P[2,3] = 1
P[3,1] = 1/2
P[3,3] = 1/2

m = 10        # El horizonte de paso (los m-pasos de la trayctoria)

# Seguimos los pasos que nos indica el algoritmo sobre generar la trayectorias (pag. 17-18)
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


# Veamos algunos ejemplos
tray = trayMC(pi,P,m)

tray=trayMC(c(1/3,1/3,1/3),P,100)


#=============================================================================================#

#======================= Estimador Maximo Verosimil de una trayectoria =======================#

#### EMV calcula el estimado maximo verosimil dada la trayectoria observada

# Parametros:

# tray: La trayectoria a analizar generada
# N: Numero de estados qque tiene la cadena de markov

# realicemos el algortimo
EMVMT = function(tray,N)
{
  m = length(tray)-1       #numero de saltos 
  
  MTE = matrix(0,nrow = N,ncol = N)     # Matriz principal

  S = matrix(0,nrow = N,ncol = N)       # Matriz de apoyo
  
  for(i in 1:m)
  {
    MTE[tray[i],tray[i+1]] = MTE[tray[i],tray[i+1]]+1
    
  }
  diag(S) = 1/rowSums(MTE)
  MTE = S%*%MTE
  return(MTE)
  
}


# veamos algunos ejemplos:
EMVMT(tray,3)

x = EMVMT(tray,3)
x$a
x$b