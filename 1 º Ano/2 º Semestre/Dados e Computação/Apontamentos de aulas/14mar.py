#ex1:procura nos arrays (7mar)
#ex2:procura com array ordenado (7mar)
#ex3:procura comparando com o elemento do meio
a=[10,10,20,30,30,40]
def procura(x,a):
    l2 = len(a) - 1
    l1 = 0
    return procura_aux(x,a,l1,l2)

def procura_aux(x,w,a,b):
    l = int(a + (b-a) / 2)
    if x == w[l]:
        return l
    if b-a == 0:
        if x == w[a]:
            return a
        return(-1)
    if x > w[l] :
        return procura_aux(x,w,l+1,b)
    else:
        return procura_aux(x,w,a,l-1)
print(procura(15,a))

#tpc
v= [40,20,10,30,60,0,80,40]
def maximo(a,x,y):
    return(maximo_aux(a,a[x],x,x,y))

def maximo_aux(a,n,i,x,y):
    if x > y: return i
    if a[x] > n :
        return maximo_aux(a,a[x],x,x+1,y)
    return maximo_aux(a,n,i,x+1,y)
print(maximo(v,0,7))
def minimo(a,x,y):
    return(minimo_aux(a,a[x],x,x,y))
def minimo_aux(a,n,i,x,y):
    if x > y: return i
    if a[x] < n :
        return minimo_aux(a,a[x],x,x+1,y)
    return minimo_aux(a,n,i,x+1,y)
print(minimo(v,0,7))

#sem usar recursiva

v= [40,20,10,30,60,0,80,40]
def maximo(a,x,y):
    m = a[x]
    n=x 
    for i in range(x+1,y+1):
        if a[i]>m:
            m=a[i]
            n=i
    return n    
print(maximo(v,0,7))

def minimo(a,x,y):
    m = a[x]
    n=x 
    for i in range(x+1,y+1):
        if a[i]<m:
            m=a[i]
            n=i
    return n    
print(minimo(v,0,7))

#tpc2-conta o numeor de ocorrencias

v= [40,20,10,30,60,0,80,40]
def conta(a,n,x,y):
    s=0
    for i in range(x,y+1):
        if a[i]==n:
            s+=1
    return s    
print(conta(v,20,0,7))

v= [40,20,10,30,60,0,80,40]
def conta(a,n,x,y):
    return(conta_aux(a,n,0,x,y))
def conta_aux(a,n,s,x,y):
    if x > y: return s
    if a[x] == n :
        return conta_aux(a,n,s+1,x+1,y)
    return conta_aux(a,n,s,x+1,y)

print(conta(v,40,0,7))
