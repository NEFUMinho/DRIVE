# -*- coding: utf-8 -*-
"""
Created on Sun Oct  2 18:32:43 2022

@author: LuísMarques
"""

import numpy as np
import math as mth
import matplotlib.pyplot as plt
import time

#Prob 8 ficha 1
st = time.time()
s=0
for n in np.arange(1,100001):
    s+=(1/2)**n+(1/3)**n
    
ft = time.time()
print("Result:",s,"time: ",ft-st," seconds")


st = time.time()
n=np.arange(1,100001)
s=np.sum((1/2)**n+(1/3)**n)
ft = time.time()
print("Result:",s,"time: ",ft-st," seconds")

#Prob 7
def tri(t,T,m):
    s=0
    for i in range(1,m+1,2):
        s+=8*(-1)**((i-1)//2)/(mth.pi*i)**2*mth.sin(2*mth.pi*i*t/T)
    return s    

t=np.arange(0,4,0.1)
y=[]
for j in t:
    y.append(tri(j,2,7))
plt.plot(t,y)
plt.show()

#Prob 1
def isprime(n):
    if n<2:
        return False
    if n%2==0:
        return n==2   
    k = 3
    while k*k <= n:
        if n % k == 0:
            return False
        k += 2
    return True

def isprime2(n):
    if n <= 3:
        return n > 1
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i *i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

st=time.time()
print( list( filter( isprime, range(40000)[2:]) )[:20] )
ft=time.time()
print("time: ",ft-st)


#Prob 5
fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
x=np.arange(-3,3,0.5)
y=np.arange(-3,3,0.5)
x,y = np.meshgrid(x,y)
z=np.sin(x)*np.cos(y)

ax.plot_surface(x,y,z)
plt.show()

#prob 6
A = np.zeros((4,4))
A[range(0,4),range(0,4)] = 2
A[range(0,3),range(1,4)] = -3
B=A[:,[0,2]]
A[:,[0,3]] = A[:,[3,0]]
B = A[:,[0,1,3]][[0,1,3],:]

