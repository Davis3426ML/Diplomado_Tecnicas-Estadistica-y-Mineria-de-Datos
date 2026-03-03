# ===================================== Metodo de Monte Carlos ============================== #

# Este metodo consiste en representar la solucion analitica por medio de 
          # la estimacion de un parametro poblacional y esta a su vez, sus solucion es 
              # usando una m.a.


                  # Ejemplo 1: Estimacion de la funcion Gamma...

# Parametro:
alpha = 2.8       # parametro de la Gamma lo denotamos por alpha
n = 10000         # tamaño de la muestra

# Veamos el Algoritmo....
EMC_gamma = function(n,alpha)
{
  # Generando la muestra aletoria de tamano n de una exponencial de parametro 1
  expo = rexp(n,1)
  
  # Evaluando la muestra en la funcion: g(x) = x^(alpha-1)
  muestra = (expo)^(alpha-1)
  
  # Calcular el estimador de MC
  emc = mean(muestra)
  
  # Calcular el error 
  ds = sd(muestra)
  
  return(list(muestra = muestra,est = emc,ds=ds))
  
}

# Veamos los resultados:
datos_gamma_alpha = EMC_gamma(n,alpha)
datos_gamma_alpha$est
datos_gamma_alpha$ds

# ========================================================================================== #

# ===================== Intervalo de confianza de la muestra aleatoria ===================== #

# Parametro:
# Necesitamos una muestra
# necesitamos un nivel de confianza

ICMM = function(muestra,nivcon)
{
  # Establecemos la media, varianza y tamano de la m.a.
  est = mean(muestra)
  vari = var(muestra)
  n = length(muestra)
  
  # Creamos una vector con 2 entradas
  ic = numeric(2)
  
  # Entrada 1: Limite inferior
  ic[1] = est-nivcon*sqrt(vari)/sqrt(n)
  
  # Entrada 2: Limite Superior
  ic[2] = est+nivcon*sqrt(vari)/sqrt(n)
  
  return(ic)
}

# Veamos el intervalo de confianza de la m.a. que hemos generado:

nivcon = 1.96     # nivel de confianza
muestra = datos_gamma_alpha$muestra   #m.a.

mean(muestra)   # como es la media de la m.a.
ICMM(muestra,nivcon)    # generemos el intervalo de confianza


# Desarrollemos algunas graficas para visuazalir mejor nuestro resultados
quantile(muestra,probs = c(0.025,0.975))
hist(muestra)
plot(density(muestra),col="red")

# ========================================================================================== #

# ============================ Optimizacion de la Varianza en un MC ======================== #


# optimizacion monte carlo

#tamano de la muestra

n=10


# funcion a optimizar
fh=function(x,y)
{
  fv=((x*sin(20*y)+y*sin(20*x))^2)*cosh(x*sin(10*x))+((x*cos(10*y)-y*sin(10*x))^2)*cosh(y*cos(20*y))
  
  return(fv)
}

# genera la muestra

fgm_opt=function(n)
{
  u1=runif(n,-1,1)
  u2=runif(n,-1,1)
  muestra=rbind(u1,u2)
  return(muestra)
}
fgm_opt(n)

#encontrar el maximo y minimo

min_max=function(n)
{
  
  muestra=fgm_opt(n)
  x=muestra[1,]
  y=muestra[2,]
  res=fh(x,y)
  maxi=max(res)
  mini=min(res)
  
  return(list(min=mini,max=maxi))
  
}
min_max(10)


ICMM=function(muestra,nivcon){
  est = mean(muestra)
  vari = var(muestra)
  n = length(muestra)
  ic = numeric(2)
  ic[1] = est-nivcon*sqrt(vari)/sqrt(n)
  ic[2] = est+nivcon*sqrt(vari)/sqrt(n)
  return(ic)
}

