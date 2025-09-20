# -*- coding: utf-8 -*-
"""
Created on Tue Nov 22 21:33:56 2022

@author: LuísMarques
"""

import numpy as np
import math 
from matplotlib import pyplot as plt

# Prob 2
a=b=1.0
c=1E-20
x1=(-b-math.sqrt(b**2-4*a*c))/(2*a)
#naive 
x2=(-b+math.sqrt(b**2-4*a*c))/(2*a)
#Correct implementation
x2=c/(a*x1)

#prob 3. Sequência instável. Erro de arrendonadamento na inicialização 
#multiplica por n! sobrepondo-se ao resultado após 18 passos.

I=(math.exp(1)-1.0)/math.exp(1)
for n in range(30):
    I=1.0-(n+1.0)*I
    print("Iteration:", n, "Value: ",I)
    
#prob 4
s=0
for n in range(1000):
    s+=(1.0/16.0)**n*(4.0/(8*n+1)-2.0/(8*n+4)-1.0/(8*n+5)-1.0/(8*n+6))
    if (np.pi-s) < 0.5E-8:
        break
print("Nº termos: ",n)

#prob 5
def somas(N):
    su=0.0
    for n in range(1,N+1):
        su+=1.0/n
    sd=0.0    
    for n in range(N,0,-1):
        sd+=1.0/n 
    return su,sd

index=range(1,100000,10)
dif=[]
for n in index:
    su,sd=somas(n)
    dif.append((sd-su)/(abs(su)+abs(sd)))
    
plt.loglog(index,abs(np.array(dif)),color='red')
plt.loglog(index,dif,color='blue')
plt.show()

