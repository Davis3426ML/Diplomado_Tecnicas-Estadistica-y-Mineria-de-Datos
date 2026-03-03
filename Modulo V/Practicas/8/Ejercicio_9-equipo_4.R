# ================================= Metodo de Monte Carlos =================================== #

                    # Ejemplo 2: Estimacion de la distribucion Normal Estandar...

# Realizamos una limpieza de la consola para evitar errores en el codigo
shell("cls")


# Parametros:

a = -1      # Limite inferior de integracion
b = 1      # Limite superior de integracion
n = 10      # Tamano de la m.a.

# Cargamos el algoritmo en base a la N(0,1) y su definicion....

# ---------------------------
# FunciOn Monte Carlo
# ---------------------------

EMC_normal <- function(n, a, b) 
{
  x <- runif(n, min = a, max = b)        # Muestra uniforme en [a, b]
  fx <- dnorm(x)                         # Evaluar densidad normal estandar
  est <- mean(fx) * (b - a)              # Estimacion por Monte Carlo
  ds <- sd(fx) * (b - a) / sqrt(n)       # Error est?ndar
  
  return(list(est = est, ds = ds))
}

# veamos un ejemplo:
EMC_normal(n,a,b)

# ========================================================================================== #

# Realizaremos varias simulaciones con MC anterior con diferentes tamanos de m.a. 
          # (que va creciendo en cada caso) para ver como se aproxima a algo....

# Tamanos de muestra
n_vals <- c(10, 50, 100, 500, 1000, 5000, 10000, 50000)

# Inicializar vectores
estimaciones <- numeric(length(n_vals))
desv_est <- numeric(length(n_vals))

# -----------------------------------
# Calculo para cada m.a. por el metodo MC
# ----------------------------------

for (i in seq_along(n_vals)) 
{
  res <- EMC_normal(n_vals[i], a, b)
  estimaciones[i] <- res$est
  desv_est[i] <- res$ds
}

# ---------------------------
# Grafica de convergencia 
# ---------------------------

# Para corroborrar la aproximaciones del metodo;, esta es el valor al que deseamos llegar
valor_exacto <- pnorm(b) - pnorm(a)     # Valor exacto de la integral en [a, b]

# sobre la grafica
plot(n_vals, estimaciones, type = "b", col = "blue", pch = 19, log = "x",
     ylim = range(c(estimaciones, valor_exacto)),
     xlab = "Tamano de muestra (n, escala log)",
     ylab = "Estimacion de la integral",
     main = paste("Convergencia MC para N(0,1) en [", a, ", ", b, "]"))

abline(h = valor_exacto, col = "red", lty = 2)

legend("bottomright",
       legend = c("Estimacion MC", "Valor exacto"),
       col = c("blue", "red"), lty = c(1, 2), pch = c(19, NA),
       bty = "n")

# ========================================================================================= #

# Conclusiones: 

# observando la grafica podemos ver que las proximaciones a las probabilidades de una normal 
# estandar no tiene sentido si el tamano de la muestra aleatoria es muy pequena (ya que son 
# superiores a 1) pero la razon de esto recai en el error y el sesgo que tiene el metodo de 
# resolver este problema analitico. Conforme "n" sea mas grande, este sesgo e error son mas 
# pequenos y no estan casi presente; e nos acercamos a la probabilidad que queriamos encontra.

