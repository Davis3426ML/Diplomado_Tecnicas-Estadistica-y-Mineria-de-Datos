# Modelo SIS

#parámetros

#tasa de infección
beta=0.3
#tasa de recuperación 
gamma=0.15
#Tamaño de la población
N=5
#Discretización
Delta=0.1


MT_SIS=function(beta,gamma,N,Delta)
{
  MT=matrix(0,nrow=(N+1),ncol=(N+1))
  MT[1,1]=1
  MT[(N+1),(N+1)]=1
  for(i in 2:N)
  {
    #número de infectados
    j=i-1
    MT[i,i+1]=Delta*beta*j*(N-j)/N
    MT[i,i-1]=Delta*gamma*j
    MT[i,i]=1-Delta*beta*j*(N-j)/N- Delta*gamma*j
  }
  return(MT)
}

# Crear la matriz de transición
SIS=MT_SIS(beta,gamma,N,Delta)
SIS

trayMC_modif_infect = function(pi,MT)
{
  tray = NULL       # guardaremos la trayectoria generada en este variable (estara vacio al inicio)
  N = length(pi)    # N sera el tamano sera E
  E = 1:N             # generamos el conjunto de estados
  
  #paso 1: escojemos una X_0 en base a E por su distribucion inical y lo guardamos en "tray"
  tray = sample(E,1,prob = pi)
  
  #paso 2: comenzamos con la iteracion con 1 y con el while sigue la iteracion hasta que sean iguales
  i=1
  while(tray[i]!= 1 && tray[i] != N)
  {
    #paso 3: escogemos un X_i en base a E y la distribucion estara en la matriz de transicion
    tray = c(tray,sample(E,1,prob = MT[tail(tray,1),]))
    
    #paso 4: para que itere a la siguiente caso lo hacemos con lo siguiente:
    i=i+1
  }
  return(tray)
}

# distribución inicial: empezamos con 2 infectados
pi = rep(0, N+1)
pi[3] = 1

tray = trayMC_modif_infect(pi, SIS)
tray

plot(tray - 1, main = "Trayectoria de una cadena de Markov - Modelo SIS",
     xlab = "Tiempo", ylab = "Número de infectados",
     ylim = c(0, N), type = "o", pch=19, col="blue")

#=============================================================================================#

#============================= Simulacion de Trayectorias ==============================#

# Parametros:

# pi: Necesitamos una distribucion inicial
# MT: Matriz de transicion
# n_sim: Número de simulaciones en trayectorias
# n_pas: Número de pasos para todas las trayectorias

#Nota: suponemos que la matriz que vamos a considerar ya es irreducible y aperiodica

# Pasamos al algoritmo:
Aproxi = function(pi,MT,n_sim)
{
  final_states = numeric(n_sim)       # Vector para guardar el estado final de cada trayectoria
  
  for (i in 1:n_sim)        
  {
    trayectory = trayMC_modif_infect(pi, MT)   # Simulamos las trayectorias y guardamos el ultimo evento
    final_states[i] = tail(trayectory, 1)
  }
  
  # Estimar distribución empírica
  approx_pi = table(factor(final_states, levels = c(1, 6))) / n_sim
  return(approx_pi)
}

Aproxi(pi,SIS,1000)