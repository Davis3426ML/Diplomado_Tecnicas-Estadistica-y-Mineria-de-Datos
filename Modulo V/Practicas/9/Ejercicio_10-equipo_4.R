# =========================== Reduccion de varianza de la Cauchy ============================= #

# Es encontrar estimadores de Monte Carlo de varianza con minima varianza en ellos. 
# Para ello vamos crear 2 funciones que nos genere una m.a. en base a la distribucion cauchy.

# Funcion de distribucion inversa de la Cauchy(0,1)
Inv_Cauchy = function(x)
{
  y = tan((x-1/2)*pi)
  
  return(y)
}

# Generador de la variable Cauchy(0,1)
GNA_Cauchy = function(n)
{
  u = runif(n)
  mcau = Inv_Cauchy(u)
  
  return(mcau)
}

# Veamos como queda la m.a. de tamano 1000
x = GNA_Cauchy(1000)

# Graficamente
plot(density(x))

# ========================================================================================= #

# veremos como se reduce la varianza de los 4 ejemplos siguientes, mientras se conserva la media

# Parametro:
n = 1000      # tamaño de muestra
mc = 1000     # cantidad de estimadores a generar

                                      # Ejemplo 1 (Estimacion 1):
# Creamos el algoritmo para este caso
theta1 = function(mc,n)
{
  vest = numeric(mc)
  
  for(k in 1:mc)
    {
      mcua = GNA_Cauchy(n)
      exito = 0
      
      for(i in 1:n)
      {
        if(mcua[i]>=2) exito = exito+1
      }
      
      vest[k]=exito/n
    }
  
  return(vest)
}

# Veamos como queda la media y la varianza estimada
the1 = theta1(mc,n)
mean(the1)
var(the1)

                                      # Ejemplo 2 (Estimacion 2):
# Creamos el algoritmo para este caso
theta2 = function(mc,n)
{
  vest = numeric(mc)
  
  for(k in 1:mc)
    {
      mcua = GNA_Cauchy(n)
      exito = 0
      
      for(i in 1:n)
      {
        if(mcua[i]>=2 || mcua[i]<=-2 ) exito = exito+1
      }
    
      vest[k]=exito/(2*n)
    }
  
  return(vest)
}

# Veamos como queda la media y la varianza estimada
the2 = theta2(mc,n)
mean(the2)
var(the2)

                                      # Ejemplo 3 (Estimacion 3):
# Creamos el algoritmo para este caso
theta3 = function(mc, n) 
{
  # Creamos una vector numerico
  vest = numeric(mc)
  
  # Establecemos una "for" donde los numero aleatorios de una U(0,2) 
                                          # y la evaluamos en una funcion e guardamos
  for (k in 1:mc) 
  {
    x = runif(n, min = 0, max = 2)
    vest[k] = (1/2) - 2 * mean(1 / (pi * (1 + x^2)))
  }
  
  return(vest)
}

# Veamos como queda la media y la varianza estimada
the3 = theta3(mc,n)
mean(the3)
var(the3)

                                      # Ejemplo 4 (Estimacion 4):
# Creamos el algoritmo para este caso
theta4 = function(mc, n) 
{
  # Creamos una vector numerico
  vest = numeric(mc)

  # Establecemos una "for" donde los numero aleatorios de una U(0,1/2) 
                                          # y la evaluamos en una funcion e guardamos
  for (k in 1:mc) 
  {
    y = runif(n, min = 0, max = 0.5)
    vest[k] = mean(1 / (pi * (1 + y^2))) / 2
  }
  
  return(vest)
}

# Veamos como queda la media y la varianza estimada
the4 = theta4(mc,n)
mean(the4)
var(the4)

# ====================================== Metodo de Importancia ============================ #

# lo que logro con esto 4 ejemplos es el hecho de que el metodo de Monte Carlos crea mucha 
# varianza de sus estimacion si no se elige adecuadamente el intervalos para resolver el problema.

# Este metodo garantiza la reduccion de la varianza para evitar problemas de sesgo en la solucion;
# Veamos un ejemplo:

# Parametro:
n = 1000      # tamaño de muestra

# vemos una m.a. con la nueva distribucion que creamos por definicion:
sim_va_g = function(n)
{
  u = runif(n)
  g = 2/(1-u)
  return(g)
}

# Realizamos la estimacion del parametro usando la funcion anteriro...
theta5 = function(mc,n)
{
  vest = numeric(mc)
  
  for(k in 1:mc)
  {
    mcua = sim_va_g(n)
    vest[k] = (1/n)*sum((mcua^2)/(2*pi*(1+mcua^2)))
  }
  
  return(vest)
}

# veamos como queda sus media y varianza...
the5 = theta5(mc,n)
mean(the5)
var(the5)

# ========================================================================================== #

# Vamos a crear una tabla para ver los resultados y como va mejorando con el cada ejemplo la varianza

# Parámetros
n <- 1000     # tamaño de muestra
mc <- 1000    # cantidad de estimaciones

# Evaluación de los nuevos estimadores
the3 <- theta3(mc, n)
cat("Media de theta3:", mean(the3), "\n")
cat("Varianza de theta3:", var(the3), "\n")

the4 <- theta4(mc, n)
cat("Media de theta4:", mean(the4), "\n")
cat("Varianza de theta4:", var(the4), "\n")

the5 <- theta5(mc, n)
cat("Media de theta5:", mean(the5), "\n")
cat("Varianza de theta5:", var(the5), "\n")

# Crear la tabla resumen con los resultados
resumen <- data.frame(
  Estimador = c("theta1", "theta2", "theta3", "theta4", "theta5"),
  Distribucion = c("Cauchy(0,1)", "Cauchy(0,1)", "U(0,2)", "U(0,0.5)", "g(U)"),
  Definicion = c(
    "1/n * sum(1_{X >= 2})",
    "1/(2n) * sum(1_{|X| >= 2})",
    "1/n * sum(1 / (pi * (1 + X^2)))",
    "1/(2n) * sum(1 / (pi * (1 + Y^2)))",
    "2/(1-U)"
  ),
  Media = c(mean(the1), mean(the2), mean(the3), mean(the4), mean(the5)),
  Varianza = c(var(the1), var(the2), var(the3), var(the4), var(the5))
)

# Imprimir la tabla
print(resumen, row.names = FALSE)
