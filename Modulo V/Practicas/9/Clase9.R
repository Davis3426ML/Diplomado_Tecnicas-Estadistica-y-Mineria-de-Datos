# Reduccion de varianza de la Cauchy



#tamaño de muestra
n=1000

# cantidad de estimadores a generar
mc=1000

#theta 1
the1=theta1(mc,n)
mean(the1)
var(the1)
#theta2
the2=theta2(mc,n)
mean(the2)
var(the2)
#theta5
the5=theta5(mc,n)
mean(the5)
var(the5)
# Primer estimador

theta1=function(mc,n)
{
  vest=numeric(mc)
  
  for(k in 1:mc){
    mcua=GNA_Cauchy(n)
    
    exito=0
    for(i in 1:n)
    {
      if(mcua[i]>=2) exito=exito+1
    }
    
    vest[k]=exito/n
  }
  
  return(vest)
}
#  estimador

theta2=function(mc,n)
{
  vest=numeric(mc)
  
  for(k in 1:mc){
    mcua=GNA_Cauchy(n)
    
    exito=0
    for(i in 1:n)
    {
      if(mcua[i]>=2 || mcua[i]<=-2 ) exito=exito+1
    }
    
    vest[k]=exito/(2*n)
  }
  
  return(vest)
}





#Generador de la variable Cauchy(0,1)
GNA_Cauchy=function(n)
{
  u=runif(n)
  mcau=Inv_Cauchy(u)
  
  return(mcau)
}

#funcuion de distribucion inversa de la Cauchy(0,1)
Inv_Cauchy=function(x)
{
  y=tan((x-1/2)*pi)
  
  return(y)
}


x=GNA_Cauchy(1000)
plot(density(x))





#muestreo por importancia

#simulando variable aleatoria con densidad "g"

sim_va_g=function(n)
{
  u=runif(n)
  g=2/(1-u)
  return(g)
}

#estimador de mc

theta5=function(mc,n)
{
  vest=numeric(mc)
  
  for(k in 1:mc){
    mcua=sim_va_g(n)
    
    vest[k]=(1/n)*sum((mcua^2)/(2*pi*(1+mcua^2)))
  }
  
  return(vest)
}
