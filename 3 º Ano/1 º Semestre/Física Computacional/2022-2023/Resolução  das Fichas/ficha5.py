# -*- coding: utf-8 -*-
"""
Created on Mon Nov 21 23:19:31 2022

@author: LuísMarques
"""
import numpy as np
import numpy.linalg as la
from matplotlib import pyplot as plt

#Problema 1
#Interpolação polinomial
A= np.array([[2**4,2**3,2**2,2.0,1.0],[2.1**4,2.1**3,2.1**2,2.1,1],[2.2**4,2.2**3,2.2**2,2.2,1],[2.41**4,2.41**3,2.41**2,2.41,1],[2.53**4,2.53**3,2.53**2,2.53,1.0]])
b= np.array([0.9772,0.9821,0.9861,0.992,0.9943])
a=la.solve(A,b)
plt.scatter(A[:,3],b)
x=np.linspace(2.0,2.53)
y=a[0]*x**4+a[1]*x**3+a[2]*x**2+a[3]*x+a[4]
plt.plot(x,y)
plt.show()

#Problema 2 
A=np.array([[1,0.1],[1,0.2],[1,0.3],[1,0.5],[1,0.7],[1,1.0],[1,1.4],[1,2.0]])
y=np.array([1.97,3.81,5.4,7.85,9.51,11.1,12.3,13.3])
c=np.linalg.pinv(A)@y
plt.scatter(A[:,1],y)

x=np.linspace(0.1,2)
f=c[0]+c[1]*x
plt.plot(x,f)

A=np.array([[1,0.1,0.1**2],[1,0.2,0.2**2],[1,0.3,0.3**2],[1,0.5,0.5**2],[1,0.7,0.7**2],[1,1.0,1.0],[1,1.4,1.4**2],[1,2.0,4.0]])
y=np.array([1.97,3.81,5.4,7.85,9.51,11.1,12.3,13.3])
c=np.linalg.pinv(A)@y
plt.scatter(A[:,1],y)

x=np.linspace(0.1,2)
f=c[0]+c[1]*x+c[2]*x**2
plt.plot(x,f)

#Prob 6
#Os intervalos não são uniformes!! Nas regras compostas não se pode pôr h em evidência
#Massa = integral{ 10^9*rho*4*pi*R^2 dR}
R=np.array([0,1100,1500,2450,3400,3630,4500,5380,6060,6280,6380.0])
Rsz=len(R)-1
h=R[1:Rsz+1]-R[0:Rsz]
rho=1.0E9*np.array([13,12.4,12,11.2,9.7,5.7,5.2,4.7,3.6,3.4,3])
# Regra do rectangulo usando limite inferior
Mi=np.sum(4*np.pi*h*rho[0:Rsz]*R[0:Rsz]**2)
Ms=np.sum(4*np.pi*h*rho[1:Rsz+1]*R[1:Rsz+1]**2)

# #Regra trapézio. Pode-se ver como a média das 2 anteriores.
MT=np.sum(4*np.pi*h*(rho[0:Rsz]*R[0:Rsz]**2+rho[1:Rsz+1]*R[1:Rsz+1]**2))/2

#Densidade média = M/V
V=4.0*np.pi*R[Rsz]**3/3
rm=MT/V/1E9

#Prob 7
# Simpson simples 3 pontos
x=[2,98/2,100]
f=1/np.log(x)
I=1+(100-2)/6*(f[0]+4*f[1]+f[2])

# Simpson composta 100 pontos
x2=np.linspace(2,100,99)
y2=1/np.log(x2)
y3=y2[1:97:2]
I2=(y2[0]+y2[98]+4*sum(y2[1:97:2])+2*sum(y2[2:99:2]))/3 +1

# Simpson composta 1000 pontos
x1=np.linspace(2,99.9,980)+0.05
y=1/np.log(x1)
I1=sum(y)*0.1 +1

#Prob 8. Romberg extrapolation
# Usar regra Simpson com 8 intervalos (I9) e com 4 intervalos (I5) e 
# combinar com formula I= (4*I9 - I5)/(4-1) 
h=0.2
y=[1,1.221,1.492,1.822,2.226,2.718,3.32,4.056,5.216]
s=len(y)-1
I9=h/3*( y[0]+y[s]+4*sum(y[1:s:2])+2*sum(y[2:s:2]) )
I5=2*h/3*( y[0]+y[s]+4*sum(y[2:s:4])+2*sum(y[4:s:4]) )
I3=4*h/3*(y[0]+y[s]+4*y[s//2])

#I1 é a extraploação de romberg de I5. Tem precisão
# ~ h^6 ~0.4E-2 portanto 2 casas decimais.
I1=(4*I5-I3)/(4-1)

#I2 é a extraploação de romberg de I9. Tem precisão
# ~ h^6 ~0.6E-4 portanto 3 casas decimais.
I2=(4*I9-I5)/(4-1)
#I é a extraploação de romberg de I2. Tem precisão
# ~ h^8 ~0.3E-5 portanto 5 casas decimais.
I=(4**2*I2-I1)/(4**2-1)


