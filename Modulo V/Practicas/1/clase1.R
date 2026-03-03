
#===================== Generadores lineales congruenciales (2.2.1) ==========================#

              # Ejemplo 1: genera numeros pseudpaleatorios por funcion recursiva #

# Parametro:
n = 1000      #cantidad de numeros a generar

a = 7^5       #multiplicador

m = 2^31-1    #modulo

c = 0         #incremento

sem = as.numeric(Sys.time())    # semilla inicial 
                                # (convierte la hora de este momento en numero para que sea aleatorio)

# Creamos por un "for" para la formula recursiva
Gen.Lin.Cong <- function(n,a,m,c,sem)
{ 
  X <- numeric(n)     # escribir mi sucesión de naturales (un arreglo de n elementos con 0 por default)
  
  X[1] <- sem         # indicamos la "sem" como "x_0" en la lista
  
  for(i in 1:(n-1))
  { X[i+1] <- (a*X[i]+c)%%m }
  
  return(X/m)
}

# Veamos un ejemplo de la funcion
myu = Gen.Lin.Cong(n,a,m,c,sem)
myu

#=============================================================================================#

                # Ejemplo 2: Hay una funcion que ayude generar numero aleatorios 
                                # por la funcion uniforme por un rango en especifico


a = 1     #limite inferior
b = 10     #limite superior

# con el # de valores aleatorios entre 0-1
m1 = runif(n)

# establecemos el rango pero siempre que a<b
m2 = runif(n,a,b)

#=============================================================================================#

                # Algunos pruebas que nos dice que los numero son aleatorios y nada predecibles

# Comparar por percentiles ordenados nuestro numero aleatorio y una uniforme continua 
qqplot(m1,myu)
abline(0,1,col="red")
# Si se aproxima a la recta; podemos decir que los numero aleatorios generados son buenos


# Por la prueba de Kolmogorov-Smirnov es una prueba de hipotesis de las cuales se ve 
  # si 2 distribuciones de parece entre si y para este caso sera una uniforme continua 
    # y nuestro numeros aleatorios
ks.test(m2,myu)
# h_0: se aproximan (p-value > .05) Vs h_1: son distintos (p-value < .05)


# si los histogramas e funcion de densidad son mayores a 0 de los numeros aleatorios
hist(myu,breaks =10)
plot(density(myu))

#=============================================================================================#

            
#===================== Simulacion de otra distribucion a partir de U(a,b) (2.4) ==========================#

              # Ejemplo 1: Genera numeros aleatorios con la V.A. Exp(lambda)

# Parametros:
n = 7500         #tamaño de la muestra

lambda = 1.5     #parametro de la exponencial

# Creamos la funcion
my_exp = function(n,lambda)
{
  U = runif(n)    # Generar uniformes en (0,1)
  
  X = -(1/lambda)*log(U)  # Evaluar en la inversa de la funcion acumulativa de las exponencial
  
  return(X)
}

# Veamos un ejemplo de la funcion
exp1 = my_exp(n,lambda)
exp1

# En teoria para comprobar la veracidad de a la aleatoridad; la esperzanza VS media

# esperanza (de acuerdo a la distribucion)
media = 1/lambda
media

#media muestral
mean(exp1)

#=============================================================================================#

                # Ejemplo 2: Genera numeros aleatorios con la funcion de R y conparacion

# en R; podemos generar numeros aleatorios con la familia "r-distribucion" (para este caso sera de Exp(lambda))
exp2 = rexp(n,lambda)

# Visualizacion de los numeros aleatorios (de las 2 generaciones anteriores)
plot(density(exp1))
lines(density(exp2),col="red")

# Comparar percentiles (una perdida de aleatoridad al ultimo)
qqplot(exp1,exp2)
abline(0,1,col="red")

# veamos si son de las misma distribucion (y lo son)
ks.test(exp1,exp2)

#=============================================================================================#

                # Ejemplo 3: Genera numeros aleatorios con V.A. Discretas

# Variables Aleatorias Discretas:

# Parametros:

S = seq(1:5)      # Soporte de la V.A.
S

p = c(1/10,1/10,1/10,2/10,5/10)     # Distribucion de probabilidad (debe de dar 1 la suma)
sum(p)

m = 10000     # El numeros de valores aleatorios

# Como las V.A. discretas no tiene formulas en concreta para la f.d.a 
                                # y podemos generarlos por medio del sig. comando:

# ejecutamos esta funcion para ver genera estos valores (Con "replace" se puede repetir los valores)
na = sample(S,m,replace = T,prob = p)

# Comprobemos sus aleatoridad

sum(S*p)      # esperanza Teorica
mean(na)      # media muestral

# visualizacion de los numeros aleatorios
hist(na,breaks = 5)
table(na)/m

#=============================================================================================#

                  # Ejemplo 4: Genera numeros aleatorios con V.A. Discretas U(0,10)

# soporte de la V.A.
n = 10
S = seq(1:n)
S

# Generamos los numeros aleatorios de m valores
m = 1000
na = sample(S,m,replace = T)    # si el parametro p; por default reparte la probabilidad equitativamente (como la U(0,10))
na

# Veamos como es su histograma
hist(na)

# comparemos terminos estadisticos

sum(S)/na     # Esperanza
mean(na)      # Media Muestral
var(na)       # Varianza Muestral

#=============================================================================================#

                # Ejemplo 5: Genera numeros aleatorios con V.A. Discretas mas conocida 
                            # y sus funciones "r-distribucion"

# Distribucion Binomial bin(n,p)

# Parametros:
n = 1000
p = 1/10
m = 10      # Tamano de la muestra a generar

# Aplicamos la funcion
na = rbinom(m,n,p)
na

# Veamos el histograma
hist(na)

# Ver los terminos Comparativos para comprobar

mean(na)      # Esperanza Vs Media Muestral
n*p

var(na)       # Varianza Vs Varianza Muestral
n*p*(1-p)




# Distribucion Geometrica geo(p)

# Parametros:
p = 1/8
m = 10000     # Tamaño de la muestra m

# Aplicamos la funcion
na=rgeom(m,p)
na

# Veamos el histograma
hist(na)

# Ver los terminos Comparativos para comprobar
mean(na)
(1-p)/p       # Esperanza Vs Media Muestral




# Distribucion Poisson poisson(lambda)

# Parametro:
lambda = 2
m = 10000       # Tamaño de la muestra m

# Aplicamos la funcion
na=rpois(m,lambda)
na

# Veamos el histograma
hist(na)

mean(na)



