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
  MT[1,2]=1
  MT[(N+1),N]=1
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

tray=trayMC(pi,SIS,10000)


table(tray)
st=as.character(seq(0:(N))-1)

#creando un nuevo objeto de cadena de Markov
MSIS=new("markovchain",transitionMatrix=SIS,name="MSIS",states=st)
MSIS




#muestra los estados
states(MSIS)

#transición entre estados particulares

transitionProbability(MSIS, "1", "0")

# transición en "m" pasos
m=1102
MSIS^m
# distribucion de la m-esima variable aleatoria 
pi*MSIS^m

# accesibilidad
is.accessible(MSIS,"1","3")


# clases de comunicación
communicatingClasses(MSIS)

#calcula el periodo
period(MSIS)

#estados transitorio
transientStates(MSIS)

# estados absorbentes
absorbingStates(MSIS)

# irreducible
is.irreducible(MSIS)

# clases recurrentes
recurrentClasses(MSIS)

#distribucion invariante o estacionaria
v=steadyStates(MSIS)
v
#tiempo medio de recurrencia
u=1/v
u


tray=trayMC(pi,SIS,100)
tray


pi=numeric(N+1)
pi[3]=1
