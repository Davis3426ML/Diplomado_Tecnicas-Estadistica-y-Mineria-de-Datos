# ====================================== Ejemplo 6.2.2 ==================================== #

# Resolviendo el el ejemplo que se encuentra al final de la pagina 165....


# Parámetros
lambda = 1
tau = 3
n = 1000  # tamaño de muestra
mc = 1000 # número de simulaciones

# Estimación con muestreo por importancia usando g*(x) = Exp(λ) para x > T
theta_importancia = function(mc, n, lambda, tau) 
{
  vest = numeric(mc)    # Creamos el vector numerico
  
  for(k in 1:mc)
  {
    x = tau + rexp(n, lambda)  # La funcion g(x) definido en el ejemplo
    
    # Creamos el coficiente de verosimilitud
    w = (lambda * exp(-lambda * x)) / (lambda * exp(-lambda * (x - tau)))
    
    # Calculamos la E[phi(x)] Y pasara ya que x > T
    vest[k] = mean(w)  
  }
  
  return(vest)
}

# veamos como nos queda la media  y varianza
the7 = theta_importancia(mc, n, lambda, tau)
mean(the7)
var(the7)

# Valor exacto para comparación
theta_teorico = exp(-lambda * tau)
theta_teorico