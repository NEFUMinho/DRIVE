# -*- coding: utf-8 -*-
"""
Created on Mon Dec  5 11:38:11 2022

@author: LuísMarques"""

# Problema 6 ficha 7
# N = 50
# hsq=1.0/(N*N)
# A = np.zeros((N,N))
# Y= np.zeros((N,))
# Y1= np.ones((N,))

# ind=range(0,N)
# A[ind[0:N-1],ind[1:N]]=0.5
# A[ind[1:N],ind[0:N-1]]=0.5

# i=0
# while np.linalg.norm(Y1-Y) > 0.5E-7 :
#     Y1=Y
#     Y=A@Y+0.5*hsq*np.exp(Y)
#     i+=1

# plt.plot(Y)

# prob 1 ficha 7    
# def fun1(t,x): return -x**3+sin(t)

# #RK 4ª ordem
# sol = solve_ivp(fun1, [0.0, 2*np.pi], [0,] )


# t=sol.t
# y=sol.y[0]
# plt.plot(t,y)

# #RK 2ª ordem
# sol = solve_ivp(fun1, [0.0, 2*np.pi], [0,], method='RK23' )

# t1=sol.t
# y1=sol.y[0]
# plt.plot(t1,y1)

