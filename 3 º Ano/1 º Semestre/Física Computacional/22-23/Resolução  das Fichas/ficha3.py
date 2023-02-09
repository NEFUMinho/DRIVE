# -*- coding: utf-8 -*-
"""
Created on Mon Nov 21 23:16:59 2022

@author: LuísMarques
"""
import numpy as np
import numpy.linalg as LA
from matplotlib import pyplot as plt
from matplotlib import image as mpimg

#problema 4
#  q01*c01 -(q15+q12)*c1 =0
#  q12*c1  -(q23+q24+q25)*c2 =0
#  q03*c03 + q23*c2 -(q31+q34)*c3 =0
#  q24*c2 + q34*c3 -q44*c4 + q54*c5 =0
# q15*c1 + q25*c2 -(q54+q55)*c5 =0 
A=[[-9.0,0,3,0,0],[4,-4,0,0,0],[0,2,-9,0,0],[0,1,6,-9,2],[5,1,0,0,6]]
b=[-120.0,0,-350,0,0]
c=LA.solve(A,b)


#Problema 5
A=np.array([[2.0,-3.0,2.0],[1.9,-3, 2.2],[2.1,-2.9,2],[6.1,2.1,-3],[-3,5,2.1]])
b=np.array([1.01,1.01,0.98,4.94,4.1])
q,r=LA.qr(A)
y=LA.solve(q,b)
x=LA.solve(r[0:3,:],y[0:3])

print(LA.pinv(A)@b)

# Problema 7 
thet = np.linspace(0,2*np.pi,128)
x = np.cos(thet)
y = 2*np.sin(thet)
plt.plot(x,y)

t=np.array([[0.3, 0, 0],[0,0.8,0],[0,0,1.0]])
ob1 = np.array([x, y, np.ones(128)])
#ob2= t@ob1
#plt.plot(ob2[0,:],ob2[1,:])

t2= np.array([[1.0, 0, 0.8],[0,1.0,0.8],[0,0,1.0]])
ob3=t2@ob1
plt.plot(ob3[0,:],ob3[1,:])

plt.show()

#Problema 8
img = mpimg.imread('c:\Smiley.jpg')
plt.imshow(img[:,:,0])

w, v=LA.eig(img[:,:,0])
w1=w[0:100]
v1=v[:,0:100]
v1t=np.transpose(v1)
img2=v1@np.diag(w1)@v1t
plt.imshow(abs(img2))