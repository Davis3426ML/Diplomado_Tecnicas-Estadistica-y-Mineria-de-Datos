# Algoritmo 9

#parametros
#cantidad de numeros a generar
n=1000

X=ALG9(n)
muestra=X$X
no_iter=X$ni
mean(X$ni)

ALG9=function(n)
{
  #generando el vector de numeros aletorios
  X=numeric(n)
  #número de iteraciones
  ni=numeric(n)
  for(i in 1:n){
    #bandera
  y=0
  while(y==0){
  #paso 1 generar dos v.a. uniformes en (0,1) 
  U1=runif(1)
  U2=runif(1)
  #paso 2
  #cociente de aceptacio
  coc=(256*U1*(1-U1)^3)/27
  #checamos si cumple la condicion de aceptacion
  if(U2<=coc){
    X[i]=U1
    y=1
   
  }
  ni[i]=ni[i]+1
  }
  
  }
 return(list(X=X,ni=ni))
}

plot(density(X))

mean(muestra)
var(muestra)

U=runif(n)
V=U*c
c=135/64

plot(density(muestra),col="red")
lines(density(U),col="blue")

# Simular una v.a. normal de parametros mu y sigma2

# funcion que genera n numeros aletorios
#distribucion normal

#parametros
# tamaño de la muestra
n=10000
#media
mu=-5
# desvia estandar
sigma=2.12


My_normal=function(n,mu,sigma)
{
  # vector de numeros aleatorios
  X=numeric(n)
  for(i in 1:n){
    ban=0
    
    while(ban==0){
      #generar un v.a. exponencial de parametro 1
      Y=rexp(1,1)
      #v.a. uniforme para decidir si aceptar
      U=runif(1)
      # checar la condicion de aceptar
      c=1/sqrt(pi/(2*exp(1)))
      f=exp(-(Y^2)/2)*sqrt(2/pi)
      g=exp(-Y)
      h=f/(c*g)
      if(U<=h){
        Z=Y
        
        ban=1
      }
    }
    #asignar el signo correcto paso 4
    E=c(1,-1)
    W=sample(E,1)*Z
    #paso 5
    X[i]=mu+sigma*W
    
  }
  
  return(X)
}



MN=My_normal(n,mu,sigma)

mean(MN)
sd(MN)
plot(density(MN))

#funcion que genera normales con R

RN=rnorm(n,mu,sigma)

qqplot(MN,RN)
abline(0,1,col="red")

ks.test(MN,RN)
