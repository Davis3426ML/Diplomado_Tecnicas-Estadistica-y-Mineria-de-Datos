# ============== Proceso de Poisson homogeneo (Proceso de nacimiento y muerte) ============== #

# Este proceso de salto de markov es donde se realice un conteo de los nacimientos y muerte en una poblacion...


# Parametros:

lambda = 0.1      # Parametro de intensidad
N = 5             # Numero de la poblacion

# vamos recrear la funcion de intensidad para este particular salto de markov
FGI = function(lambda,N)
{
  Q = matrix(0,nrow = N+1,ncol = N+1)
  for(i in 1:N)
  {
    Q[i,i] = -lambda
    Q[i,i+1] = lambda
  }
  return(Q)
}

# veamos algun ejemplo de esta funcion....
Q = FGI(lambda,N)
Q

# y de paso ver si como queda la matriz de transicion en el tiempo 8:
library(Matrix)     # Aplicamos esta libreria para multiplicar matrices
t = 8
expm(t*Q)     # al tiempo 8

# ========================================================================================== #




E = 0:N           # Espacio de estados

pi = numeric(N+1) # Distribucion inicial
pi[1] = 1












































Q=matrix(0,nrow = 3,ncol=3)
Q[1,1]=-1
Q[1,2]=0.5
Q[1,3]=0.7
Q[2,1]=0.3
Q[2,2]=-1
Q[2,3]=0.7
Q[3,1]=0.1
Q[3,2]=0.9
Q[3,3]=-1

Z=c(0,0,0)

s=solve(Q,Z)















#matriz de saltos
prob_salto(Q)
#distribucion inicial
pi=c(0,1/2,1/2)
#horizonte de tiempo
HT=10000


tps=tray_psm(pi,Q,HT)

ts=tps$ts
edos=tps$edos

MJPMLE(3,ts,edos)


#**********************************************
tray_psm=function(dis_ini,gen_inf,HT)
{
  edos=NULL
  tiempos_saltos=NULL
  E=seq(length(dis_ini))
  #paso 1
  edos=sample(x=E,size=1,prob=dis_ini)
  tiempos_saltos=0
  #paso 2 
  tiempos_saltos=c(tiempos_saltos,rexp(1,-gen_inf[tail(edos,1),tail(edos,1)]))
  P=prob_salto(gen_inf)
  #paso 3-6
  while(tail(tiempos_saltos,1)< HT)
  {
    
    edos=c(edos,sample(x=E,size=1,prob=P[tail(edos,1),]))
    #   if(tail(edos,1)==1) 
    #   {tiempos_saltos=c(tiempos_saltos,HT)
    #   break
    #   }
    #   else{
    tiempos_saltos=c(tiempos_saltos,tail(tiempos_saltos,1)+rexp(1,-gen_inf[tail(edos,1),tail(edos,1)]))
    
    #   }
  }
  tiempos_saltos[length(tiempos_saltos)]=HT
  return(list(edos=edos,ts=tiempos_saltos,Q=gen_inf))
}

##genera la matriz de probabilidades de saltos
prob_salto=function(gen_inf)
{
  n=dim(gen_inf)[1]
  PS=matrix(0,nrow=n,ncol=n)
  for(i in 1:n){
    for(j in 1:n)
    {
      if(i!=j) PS[i,j]=gen_inf[i,j]/-gen_inf[i,i]
    }
  }
  
  return(PS)  
  
}



dis_ini=pi
gen_inf=Q

#### calcula los estadisticos sufientes para estimar Q
#m= el numero de estados
#time=vector de tiempos de saltos
#tray=vector de edos visitados
MJPSS<-function (m,time,tray)
{
  #numero de saltos
  jmp<-length(tray)-1
  
  #tiempo de visita a cada estado
  R<-rep(0,m)
  #matriz de numero de saltos entre estados
  MS<-matrix(0,m,m)
  for (i in 1:jmp)
  {
    #estado del que salto
    ini<-tray[i]
    #estado al que salto
    fin<-tray[i+1]
    MS[ini,fin]<-MS[ini,fin]+1
    R[ini]<-R[ini]+time[i+1]-time[i]
  }
  R[tray[jmp+1]]<-R[tray[jmp+1]]+time[jmp+2]-time[jmp+1]
  return(list(vector=R,matrix=MS))
}



#=####################################################
#Calculate the maximum likelihood estimator for the infinitesimal generator matrix.

#@param m: dimension.
#@param time: the start time, jump times and horizon time
#@param tray: state visited and final state

#@return Q_est: maximum likelihood estimator for the infinitesimal generator matrix.
#####################################################
MJPMLE<- function (m,time,tray)
{
  Q_est<-matrix(0,m,m)
  res <- MJPSS(m,time,tray)
  est1<-res$vector
  est2<-res$matrix
  aij<-bij<-1
  for (i in 1:m)
  {
    Q_est[i,]<-(est2[i,]+aij)/(est1[i]+bij)
    Q_est[i,i]<-0
    Q_est[i,i]<--sum(Q_est[i,])
  }
  return(Q_est)
}

