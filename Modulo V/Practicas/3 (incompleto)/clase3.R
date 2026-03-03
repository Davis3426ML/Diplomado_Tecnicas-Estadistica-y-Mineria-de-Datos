# Algoritmo 27 Mezcla de 3 normales

#parametros
#medias
mus=c(-3,0,3)
#desviaciones estandares
sigmas=c(1,1,1)
#ponderaciones
p=c(11/10,122/200,1/12)
#tamano de muestra
n=10000

#funcion que simula el Algo 27

Alg_27 = function(n,mus,sigmas,p)
{
  X = numeric(n)
  for(i in 1:n){
  #tamano de la mezcla
  m = length(mus)
  #Paso 1 soporte de Y
  E=seq(1:m)
  #elegir el elemento de la mezcla
  Y=sample(E,1,prob=p)
  #paso 2
  X[i]=My_normal(1,mus[Y],sigmas[Y])
  
  }
 
  return(X) 
  
}

XM=Alg_27(n,mus,sigmas,p)

plot(density(XM))

#media muestral
mean(XM)
#esperanz
sum(mus*p)


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
      c=sqrt(2*exp(1)/pi)
      f=exp(-(Y^2)/2)*sqrt(2/pi)
      g=exp(-Y)
      h=f/(c*g)
      if(U<=h){
        Z=Y
        
        ban=1
      }
    }
    #asignar el signo correcto
    E=c(1,-1)
    a=sample(E,1)
    W=Z*a
    #paso 5 
    X[i]=mu+sigma*W
    
  }
  
  return(X)
}



MN=My_normal(n,1,1)


## simula muestra del vector aleatorio del ejercicio 15
#tamano de la muestra
n=1000

vec_15=function(n)
{
  vec_ale=matrix(0,nrow=2,ncol=n)
  for(i in 1:n){
    #paso 1
    Y=rexp(1,1)
    #paso 2
    X=rexp(1,1/Y)
    vec_ale[1,i]=X
    vec_ale[2,i]=Y
  }
  
  return(vec_ale)
  }



v15=vec_15(1000)

dim(v15)
Y=v15[2,]
mean(Y)
YR=rexp(1000,1)
qqplot(Y,YR)
abline(0,1)
ks.test(Y,YR)
