# Paso 1: Definir parámetros
n <- 33                          # Número de componentes en la mezcla
pi_vec <- rep(1/n, n) # Probabilidades de mezcla (suman 1)
pi_vec
beta <- 1.5                         # Tasa de los Erlang (beta > 0)
sample_size <- 1000                # Tamaño de la muestra

# Paso 2: Validar
stopifnot(length(pi_vec) == n, sum(pi_vec) == 1, all(pi_vec >= 0), beta > 0)

# Paso 3: Simular muestra
set.seed(123)  # Para reproducibilidad

# 1. Elegir componente de mezcla para cada muestra
componentes <- sample(1:n, size = sample_size, replace = TRUE, prob = pi_vec)

# 2. Generar muestras Erlang (Erlang(k, beta) = suma de k exp(beta))
muestra <- sapply(componentes, function(k) sum(rexp(k, rate = beta)))

# Resultado
hist(muestra, breaks = 40, main = "Mezcla de Erlangs", col = "skyblue", xlab = "Valor")

# Paso 4: Media teórica
a <- sum(pi_vec * (1:n)/beta)
a
b <- mean(muestra)
b