# -*- coding: utf-8 -*-
"""
Created on Mon Nov 21 23:17:33 2022

@author: LuísMarques
"""
import numpy as np
import numpy.linalg as la
import scipy
from math import sin, cos

#  prob 2 - Método do ponto fixo
x= 0.5
xi=1.0
while abs(xi-x) > 0.5E-3:
    x=xi
    xi=(1-np.log(x))**0.5
    print(xi)
    
print(" Solução:", xi)

#prb 4  square root of N
N=np.pi
x= 2
xi = 3
while abs(xi-x) > 0.5E-3:
    x=xi
    xi=0.5*(x+N/x)  
print(" Solução:", xi)

# #prb 5
A=np.array([[3,2],[1,2]])
b=[1, -1]
Dinv=np.diag(1/np.diag(A))
x = [1.0, 1.0]
e=[1.0, 1.0]
while ( la.norm(e)>1E-3 ):
    x1=x+Dinv@(b-A@x)
    e=abs(x-x1)
    x=x1
print("Result: ",x, "Correct: ",la.solve(A,b))

# #prob 6
def equations(p):
    x,y = p
    return(x**2+x-y**2-1,y-sin(x**2) )

x,y =scipy.optimize.fsolve(equations, (0,0))
print("Result: ",x,y)

# # #prob 7  Gauss - Seidel
x1 = 2.0
x2 = 2.0
x=y=0.0
while (abs(x-x1)>1E-3 and abs(x2-y)>1E-3):
    x=x1
    x1=(13-x1**2-2*x2**2)/10
    y=x2
    x2=(6-2*x1**3+x2**2)/5
    
print("Result Gauss seidel: ",x1,x2)

# #Jacobi
# x1 = 0.5
# x2 = 1.0
# e1=e2=1.0
# while ( e1>1E-3 and e2>1E-3):

#     x=(13-x1**2-2*x2**2)/10
#     y=(6-2*x1**3+x2**2)/5
#     e1=abs(x-x1)
#     e2=abs(y-x2)
#     x1=x
#     x2=y
    
# print("Result Jacobi: ",x1,x2)

#prob 8 
def jacobmatrix(p):
    x,y = p
    J=[[-5+2*cos(x), -sin(y)],[-4*sin(x), 2*cos(y)-5]]
    f=[-5*x+2*sin(x)+cos(y),4*cos(x)+2*sin(y)-5*y]
    return(np.array(J),np.array(f))

x=[0,0]
e=[1,1]

while ( la.norm(e)>1E-3 ):
    Jac, fs = jacobmatrix(list(x))
    x1=x - la.solve(Jac,fs)
    e=abs(x-x1)
    x=x1
print("Result: ",x)