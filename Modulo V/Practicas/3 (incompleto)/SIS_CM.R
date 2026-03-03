# Modelo SIS

#parámetros

#tasa de infección
beta=0.3
#tasa de recuperación 
gamma=0.15
#Tamaño de la población
N=5
#Discretización
Delta=0.1


MT_SIS=function(beta,gamma,N,Delta)
{
  MT=matrix(0,nrow=(N+1),ncol=(N+1))
  MT[1,1]=1
  MT[(N+1),(N+1)]=1
  for(i in 2:N)
  {
    #número de infectados
    j=i-1
    MT[i,i+1]=Delta*beta*j*(N-j)/N
    MT[i,i-1]=Delta*gamma*j
    MT[i,i]=1-Delta*beta*j*(N-j)/N- Delta*gamma*j
  }
  return(MT)
}


SIS=MT_SIS(beta,gamma,N,Delta)

