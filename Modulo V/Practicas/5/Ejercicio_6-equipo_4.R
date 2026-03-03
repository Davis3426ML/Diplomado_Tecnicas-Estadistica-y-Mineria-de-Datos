# Leer los datos
data = read.csv("C:\\Users\\Misael\\Documents\\modulo 5\\ST_SIS.csv")
infectados = data$x
N <- max(infectados)
Delta = 0.1

eventos_contagio = 0
eventos_recuperacion = 0
suma_I_S = 0
suma_I = 0

for (t in 1:(length(infectados) - 1)) {
  I_t = infectados[t]
  I_tp1 = infectados[t + 1]
  S_t = N - I_t
  
  if (I_tp1 == I_t + 1) {
    eventos_contagio = eventos_contagio + 1
    suma_I_S = suma_I_S + (I_t * S_t / N)
  } else if (I_tp1 == I_t - 1) {
    eventos_recuperacion = eventos_recuperacion + 1
    suma_I = suma_I + I_t
  }
}

# Estimaciones
beta_est = eventos_contagio / (Delta * suma_I_S)
gamma_est = eventos_recuperacion / (Delta * suma_I)

cat("Beta estimado:", beta_est, "\n")
cat("Gamma estimado:", gamma_est, "\n")
