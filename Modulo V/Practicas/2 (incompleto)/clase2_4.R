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

#Algoritmo 18

#gamma de parametros alpha>=1 y lambda=1
alpha=1.4
# tamaño de la muestra n
n=1000

my_gamma_18=function(n,alpha)
{
  X=numeric(n)
  for(i in 1:n){
    ban=0
    while(ban==0){
      #paso 1 generar la uniforme para decidir si se acepta
      U=runif(1)
      #paso 2 generar el candidato de una gamma de parametros a y b
      a=floor(alpha)
      b=a/alpha
      y=sum(rexp(a,b))
      #paso 3 criterio de aceptar 
      h=(y^(alpha-a))*(b^(-a))*(exp(-y*(1-b)))
      c=(b^(-a))*((alpha-a)/((1-b)*exp(1)))^(alpha-a)
      if(U<=(h/c)){
        X[i]=y
        ban=1
      }
    }
  }
  return(X)
}

g18=my_gamma_18(n,alpha)

mean(g18)

plot(density(g18))
var(g18)
var(g18)

rg18=rgamma(n,alpha,1)

qqplot(g18,rg18)
abline(0,1,col="red")
ks.test(g18,rg18)

#funcion que genera gamma de parametro alpha<1 y lambda=1

my_gamma_19=function(n,alpha)
{
  #paso 1
  U=runif(n)
  #paso 2
  y=my_gamma_18(n,1+alpha)
  #paso 3
  x=(U^(1/alpha))*y
  
  return(x)
}

alpha=0.7
g19=my_gamma_19(n,alpha)
mean(g19)

#genera gamma de parametros alpha>0 y lambda>0
my_gamma=function(n,alpha,lambda)
{
  #genera gammas para lambda=1
  #para gamma>=1
  if(alpha>=1){
    y=my_gamma_18(n,alpha)
  }
  y=my_gamma_19(n,alpha)
  
  #transformo a la lambda original
  x=y/lambda
  return(x)
  
}

alpha=1.4
lambda=3.3
mg=my_gamma(n,alpha,lambda)

mean(mg)
alpha/lambda
rg=rgamma(n,alpha,lambda)

qqplot(mg,rg)
abline(0,1,col="red")

ks.test(mg,rg)

#ALGORITMO 20
#Genera v.a. beta de parametros alpha y beta
alpha=3.2
beta=2.1
my_beta=function(n,alpha,beta)
{
  #paso 1
  Y1=my_gamma(n,alpha,1)
  Y2=my_gamma(n,beta,1)
  #paso 2
  x=Y1/(Y1+Y2)
  return(x)
  
}

mb=my_beta(n,alpha,beta)
rb=rbeta(n,alpha,beta)

qqplot(mb,rb)
abline(0,1,col="red")

ks.test(mb,rb)




