# INCISO a)

# Definición del tamaño de la muestra
n = 1000

# Función para simular el vector aleatorio
vec_15 = function(n) {
  # Creamos una matriz de 2 filas y n columnas para almacenar las simulaciones
  vec_ale = matrix(0, nrow = 2, ncol = n)
  
  for (i in 1:n) {
    # Paso 1: Simulamos Y de una distribución gamma (2, 1)
    marginal_y = rgamma(1, 2, 1)
    
    # Paso 2: Simulamos X de una distribución uniforme (0,Y)
    X = runif(1, min = 0, max = marginal_y)
    
    # Guardamos los valores simulados en la matriz
    vec_ale[1, i] = X
    vec_ale[2, i] = marginal_y
  }
  
  # Retornamos la matriz con los vectores (X,Y) simulados
  return(vec_ale)
}

# Ejecutamos la simulación con tamaño de muestra 1000
v15 = vec_15(1000)

# Verificamos las dimensiones de la matriz generada (debe ser 2 x 1000)
dim(v15)

# Extraemos la segunda fila que corresponde a los valores simulados de Y
marginal_y = v15[2, ]

# Calculamos la media muestral de Y (Aproximadamente 2)
mean(marginal_y)

# Simulamos otra muestra de tamaño 1000 de una gamma(2, 1) para comparación
YR = rgamma(1000, 2, 1)

# Hacemos un gráfico Q-Q para comparar la muestra Y con una muestra teórica gamma
qqplot(marginal_y, YR)
abline(0, 1)  # Línea de referencia y = x

# Prueba de Kolmogorov-Smirnov para ver si Y proviene de la misma distribución que YR
ks.test(marginal_y, YR)

#INCISO b)

# Definición del tamaño de la muestra
n = 1000

# Función para simular el vector aleatorio
vec_15 = function(n) {
  # Creamos una matriz de 2 filas y n columnas para almacenar las simulaciones
  vec_ale = matrix(0, nrow = 2, ncol = n)
  
  for (i in 1:n) {
    # Paso 1: Simulamos la marginal de x con una distribución exponencial(1)
    marginal_x = rexp(1, 1)
    
    # Paso 2: Simulamos la condicional de x dado Y con una distribución exponencial(1) + Y
    condicional_X_y = rexp(1, 1) + marginal_x
    
    # Guardamos los valores simulados en la matriz
    vec_ale[1, i] = condicional_X_y
    vec_ale[2, i] = marginal_x
  }
  
  # Retornamos la matriz con los vectores (X,Y) simulados
  return(vec_ale)
}

# Ejecutamos la simulación con tamaño de muestra 1000
v15 = vec_15(1000)

# Verificamos las dimensiones de la matriz generada (debe ser 2 x 1000)
dim(v15)

# Extraemos la segunda fila que corresponde a los valores simulados de de la marginal
marginal_x = v15[2, ]

# Calculamos la media muestral de la marginal (Aproximadamente 1)
mean(marginal_x)

# Simulamos otra muestra de tamaño 1000 de una exponencial(1) para su comparación
YR = rexp(1000, 1)

# Hacemos un gráfico Q-Q para comparar la marginal con una muestra teórica exponencial
qqplot(marginal_x, YR)
abline(0, 1)  # Línea de referencia y = x

# Prueba de Kolmogorov-Smirnov para ver si la marginal proviene de la misma distribución que YR
ks.test(marginal_x, YR)

