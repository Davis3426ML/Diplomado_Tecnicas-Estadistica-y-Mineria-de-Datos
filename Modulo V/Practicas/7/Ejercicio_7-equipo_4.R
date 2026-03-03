# ============================== Generador infinitesimal Q para SIS ========================= #

# Creamos la matriz de intensidad correspondientes al modelo SIS 
# (que es casi parecido a la matriz de transicion en tiempo discreto)

# Parámetros:
N = 6         # Numero de la poblacion cerrada
beta = 0.3    # tasa de contagios
gama = 0.15   # tasa de recuperacion

# Vamos a ver el algoritmo
QSIS = function(beta,gama,N)
{
  Q = matrix(0,nrow = N+1,ncol = N+1)
  Q[N+1,N] = N*gama
  Q[N+1,N+1] = -N*gama
  Q[1,2] = beta
  Q[1,1] = -beta
  for(i in 2:(N))
  {
    Q[i,(i)] =  -((beta*(i-1)*(N-(i-1)))/N+(gama*(i-1)))
    Q[i,(i-1)] = gama*(i-1)
    Q[i,(i+1)] = (beta*(i-1)*(N-(i-1)))/N
  }
  
  return(Q)
}

# Veamos como queda la generadora infinitesimal del SIS
GSIS = QSIS(beta,gama,N)
GSIS

# Por definicion; veamos como queda la matriz de transicion en el momento 7
expm(7*GSIS)

# =========================================================================================== #

# ============================== Matriz de probabilidad de salto ============================ #

# Al ser el tiempo continuo, los estados estaran cierto tiempo y su cambio sera por medio de 
# una matriz de probabilidad....

# Parámetros:
gen_inf = GSIS      # Requerimos de una matriz de intensidad

# Pasando al algoritmo...
prob_salto = function(gen_inf)
{
  # establecemos las dimensiones de la matriz
  n = dim(gen_inf)[1]
  PS = matrix(0,nrow = n,ncol = n)
  
  # con estos "for" anidados estariamos aplicando la definicion de "q_ij"
  for(i in 1:n)
  {
    for(j in 1:n)
    {
      if(i!=j) PS[i,j] = gen_inf[i,j]/-gen_inf[i,i]
    }
  }
  
  return(PS)  
  
}

# veamos como nos queda la matriz de intensidad con el modelo anterior:
prob_salto(gen_inf)

# =========================================================================================== #

# ============== Generador de trayectorias en procesos de saltos de Markov modificado ======= #

# para este modelos; vamos a considerar el el hecho de que deseamos ver los salto que realiza 
# esta cadena (a tiempo continuo) hasta el estado absorbente (el estado 1 )

# Parametros:

pi = numeric(N+1)     # "dis_ini": distribución inicial
pi[2] = 1

GSIS            # "gen_inf": Matriz de intensidad


# Pasamos al algoritmo...
tray_psm = function(dis_ini,gen_inf,HT)
{
  # creamos variables vacias que almacene los estados que salta y en que tiempo lo hace (respectivamente)
  edos = NULL
  tiempos_saltos = NULL
  
  # Creamos el espacio de estados
  E = seq(length(dis_ini))
  
  #paso 1: establecemos el primer estado en el tiempo cero
  edos = sample(x = E,size = 1,prob = dis_ini)
  tiempos_saltos = 0
  
  #paso 2: calculamos la matriz de probabilidad y la exp(matriz de intensidad) (agregando a los tiempos)
  tiempos_saltos = c(tiempos_saltos,rexp(1,-gen_inf[tail(edos,1),tail(edos,1)]))
  P = prob_salto(gen_inf)
  
  #paso 3-6: mientras el tiempo no sobre pase el horizonte de tiempo...
  while(tail(edos,1) != 1)
  {
    edos = c(edos,sample(x = E,size = 1,prob = P[tail(edos,1),]))
    tiempos_saltos=c(tiempos_saltos,tail(tiempos_saltos,1)+rexp(1,-gen_inf[tail(edos,1),tail(edos,1)]))
  }
  
  return(list(edos = edos,ts = tiempos_saltos))
  
}

# veamos algun ejemplo....
tray_psm(pi,GSIS)

# =========================================================================================== #

# ======================== Tiempo promedio de recuperacion en la poblacion ================== #

# Parametros:

# pi: Necesitamos una distribucion inicial
# MT: Matriz de transicion
# n_sim: Número de simulaciones en trayectorias
# n_pas: Número de pasos para todas las trayectorias


# Pasamos al algoritmo:
Aproxi = function(dis_ini,gen_inf,n_sim)
{
  final_states = numeric(n_sim)       # Vector para guardar el tiempo en que se alcanza el estadoo de 0 infectados
  
  for (i in 1:n_sim)        
  {
    trayectory = tray_psm(dis_ini,gen_inf)   # Simulamos las trayectorias y guardamos el ultimo evento
    final_states[i] = tail(trayectory$ts, 1)
  }
  
  # Calculamos el promedio en el tiempo de llegar al estado recurrente...
  approx_pi = mean(as.vector(final_states))
  return(approx_pi)
}

tiempo_ext <- Aproxi(pi,GSIS,1000)
cat("Tiempo aproximado de extinciòn del virus: ", tiempo_ext)
