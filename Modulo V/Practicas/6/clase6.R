# ===================================== Sistema Bonus-Malus ================================== #

# Programos su matriz de transicion para esta situacion en donde 
                              # se clasifica a los asegurados por clases....

# Parametros:
p = 0.1     # probabilidad de no presentar siniestro
nt = 6      # número de tarifas

# funcion de la Matriz de transición:
FMTBM = function(nt,p)
{
  MT = matrix(0,nrow = nt,ncol = nt)    # Creamos una matriz cero
  
  # Aplicamos p en la entrada (1,1) e (nt,nt-1)
  MT[1,1] = p
  MT[nt,(nt-1)] = p
  
  # Aplicamos 1-p en ultima columna de la matriz
  MT[,nt] = 1-p
  
  # Aplicamos las p en la diagonal inferior
  for(i in 2:(nt-1))
  {
    MT[i,i-1] = p
  }
  
  return(MT)
}

# Veamos un ejemplo
MT = FMTBM(nt,p)
MT

# supongamos que la tarifas que maneja este sistema es la unidad por # de la clase....
vec_tarifas = 1:nt
vec_tarifas

# ============================================================================================ #

# ========================================== Cuestionario ==================================== #

# -> ¿Cómo se calcula p?

# cargamos los datos en una varible (que lo considera en tabla)
tabla <- read.csv("D:\\Biblioteca\\Descargas\\Diplomado_1\\Modulos\\5_Simulacion_Estocastica (FERNANDO BALTAZAR LARIOS)\\Practicas\\6\\his_num_sin.csv")

# Sacamos la probabilidad de que no haya ocurrido siniestros (0) en todo los datos de la base
p = sum(tabla == 0, na.rm = TRUE)/ length(unlist(tabla))
p

# Para evitar que ocurra errores; vamos guardar este resultado en digitos...
p = 0.0201
p



# -> Si el cliente es nuevo, ¿Qué tarifa se le debe cobrar?

# Realizaremos algunas suposiciones para este sistema:

    # - las clasificacion van de la mejor a la peor (de forma decendente)
    # - Los nuevos clientes no tiene antecedentes y son totalmente nuevos

# los colocaremos en la clasificacion del medio ya que no podemos castigarlos con la peor clase que es "nt"
# ni recompensarlo en la mejor clase que es 1 y esta asignacion nos ayudara a forma la distribucion inicial

dis_inic = rep(0, nt)
clase_inicial = ceiling(nt / 2) # si las clasificaciones son pares, lo dejamos en la clase central con mejor calificacion
dis_inic[clase_inicial] = 1
dis_inic



# -> ¿cuál es la tarifa promedio o a largo plazo que se paga en este sistema?

# para esta ocasion veresmo 2 versiones para ver la tarifa en general y con los nuevos clientes...


# ========================================= Version 2 ====================================== #

# Calculamos la distribucion estacionaria de la matriz de transicion...

# Creamos el Espacio de estados como objeto
st = as.character(vec_tarifas)

# Creamos la cadena de Markov
clasificacion = new("markovchain",transitionMatrix = MT,name = "Clases",states = st)
clasificacion

#distribucion invariante o estacionaria
v = as.numeric(steadyStates(clasificacion))
v

# y para ver las tarifas promedio a largo plazo es multiplicando "vec_tarifas" * "distribucion estacionaria"
tarifa_promedio = sum(v * vec_tarifas)
cat("Tarifa promedio a largo plazo:", tarifa_promedio, "\n")

# y para el caso de un nuevo cliente sera:
tarifa_nuevo = sum(cliente_nuevo * vec_tarifas)
cat("Tarifa para cliente nuevo:", tarifa_nuevo, "\n")

# ========================================================================================== #


# ========================================= Version 2 ====================================== #

# Por definicion; vamos a calcular la distribucion estacionaria de la matriz de transicion...

library(expm)  # para %^% operador de potencias de matrices

# Usamos potencias altas de MT para aproximar la distribuci?n estacionaria
pi_est = matrix(rep(1/nt, nt), nrow = 1)  # distribuci?n inicial uniforme
for (i in 1:100) 
  {
    pi_est = pi_est %*% MT
  }

# veamos como queda...
pi_est = as.vector(pi_est)
pi_est

# Calcular tarifa promedio a largo plazo
tarifa_promedio = sum(pi_est * vec_tarifas)
cat("Tarifa promedio a largo plazo:", tarifa_promedio, "\n")

# Calcular la tarifa que se le cobra inicialmente
tarifa_nuevo = sum(dis_inic * vec_tarifas)
cat("Tarifa para cliente nuevo:", tarifa_nuevo, "\n")

# ========================================================================================== #
