# Algoritmo 9

#parametros
#cantidad de numeros a generar
n=1000

X=ALG9(n)
X$X
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

mean(X$X)
U=runif(n)
V=U*c
c=135/64

plot(density(X),col="red")
lines(density(U),col="blue")


