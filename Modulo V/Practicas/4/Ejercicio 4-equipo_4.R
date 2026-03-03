#======================= Aproximacion a la distribucion invariante ===========================#

# modificamos la funcion con solo hacer la trayectoria....

#=============================================================================================#

trayMC_modif = function(pi,MT,m)
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
  return(tray)
}

#=============================================================================================#

# Parametros:

# pi: Necesitamos una distribucion inicial
# MT: Matriz de transicion
# n_sim: Número de simulaciones en trayectorias
# n_pas: Número de pasos para todas las trayectorias

#Nota: suponemos que la matriz que vamos a considerar ya es irreducible y aperiodica

# Pasamos al algoritmo:
Aproxi = function(pi,MT,n_sim,n_pas)
{
    final_states = numeric(n_sim)       # Vector para guardar el estado final de cada trayectoria
    
    for (i in 1:n_sim)        
    {
      trayectory = trayMC_modif(pi, MT, n_pas)   # Simulamos las trayectorias y guardamos el ultimo evento
      final_states[i] = trayectory[n_pas]
    }
    
    # Estimar distribución empírica
    approx_pi = table(factor(final_states, levels = 1:3)) / n_sim
    print(approx_pi)
    
    # Distribucion invariante o estacionaria
    mc_obj = new("markovchain", transitionMatrix = MT)
    D_V = steadyStates(mc_obj)
    print(D_V)
}


# veamos un ejemplo:

distri = c(1/4,1/4,1/2)     # Necesitamos una distribucion inicial

MT = matrix(0,nrow = 3,ncol = 3)     # Su matriz de transicion
MT[1,1] = 1/4
MT[1,2] = 3/4
MT[2,3] = 1
MT[3,1] = 1/2
MT[3,3] = 1/2




Aproxi(distri,MT,360,1000)

