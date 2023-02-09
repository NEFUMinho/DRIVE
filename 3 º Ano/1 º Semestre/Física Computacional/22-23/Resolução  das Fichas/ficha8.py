import numpy as np
from scipy.integrate import solve_ivp
from math import sin
import matplotlib.pyplot as plt

#Ficha 8 prob 1
#   V0N V1N V2N V3N ... VNN   1V
#          ...
#   V01 V11 V21 V31     VN1
#   V00 V10 V20 V30 ..  VN0   0V
#
#  Condições fronteira: V0i=0  V4i=0 Vi0=0 Vi4=1
#  Equações:
#  V0,1 -4V1,1 + V2,1 + V1,0 + V1,2 = 0
#  V1,1 -4V2,1 + V3,1 + V2,0 + V2,2 = 0
#    ....
#  VN-1,1 -4VN-1,1 + VN,1 + VN-1,0 + VN-1,2 = 0
#  V0,2 -4V1,2 + V2,2 + V1,1 + V1,3 =0
#                  ....
#  V0,N-1 -4V1,N-1 + V2,N-1 + V1,N-2 + V1,N = 0
#    ....
#
#   Na forma matricial
#    |-4  1  0  0 ... 1 0 .... 0 ...     |  | V1,1   |  = | -V10 - V01     | = | 0  |
#    | 1 -4  1  0 ... 0 1 .... 0 ...     |  | V2,1   |  = | -V20           | = | 0  |
#    | 0  1 -4  1 0 ... 0 1... 0 ...     |  | V3,1   |  = | -V30           | = | 0  |
#    |         ...                       |  | ..     | 
#    |              0 1 -4  1  0 ...     |  | VN-3,1 |  = | -VN-3,0        | = | 0  |
#    |                0  1 -4  1 ...     |  | VN-2,1 |  = | -VN-2,0        | = | 0  |
#    |            ...     0 1 -4 1 ..    |  | VN-1,1 |  = | -VN-1,0 -VN,1  | = | 0  |
#    | 1  0  0  ...            0 -4  1  0|  | V1,2   |  = |                | = | 0  |
#    | 0  1  0  ...            0  1 -4  1|  | V2,2   |  = |                | = | 0  |
#    |            ...                    |  |   ...  |  = |                | = | 0  |
#    |                                   |  |V1,N-1  |  = | -V1,N -V0,N-1  | = |-1  |
#    |            ...                    |  |   ...  |  = |                | = |-1  |
#    |                                   |  |VN-1,N-1|  = | -VN-1,N -VN,N-1| = |-1  |

#Number inner points
N = 5
N2= N*N

V0 = np.zeros(N2)
V0[N2-N:N2] = -1.0

A= -4.0*np.eye(N2)

for i in range(0,N):
    A[range(N*i,N*(i+1)-1),range(N*i+1,N*(i+1))]=1.0
    A[range(N*i+1,N*(i+1)),range(N*i,N*(i+1)-1)]=1.0

A[range(0,N2-N),range(N,N2)]=1.0
A[range(N,N2),range(0,N2-N)]=1.0

V = np.linalg.solve(A,V0)
B= V.reshape((N,N))
