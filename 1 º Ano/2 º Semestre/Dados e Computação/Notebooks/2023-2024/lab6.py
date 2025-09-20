#ex1

def insert (u,a,b) :
    if b<a : return
    c = u[b]
    i = b-1
    while i>=a and u[i] > c :
        u[i+1] = u[i]
        i-=1
    u[i+1] = c

def insert_rec(u,a,b):
    if a<b and u[b-1]>=u[b] :
        u[b-1],u[b] = u[b],u[b-1]
        insert(u,a,b-1)

#ex2
def insertionSort(u):
    for i in range(1,len(u)):
        insert(u,0,i)
    return u

def insertionSort2(u):
    if len(u) == 0 : return []
    u2 = insertionSort2(u[1:])
    if len(u2) ==0 or u[0] <= u2[0]:
        return [u[0]] + u2
    return([u2[0]] + insertionSort2([u[0]]+u2[1:]))

#ex3
def merge(u1,u2):
    u3=[]
    i=j=0
    while i < len(u1) and j < len(u2):
        if u1[i] <= u2[j]:
            u3.append(u1[i])
            i+=1
        else:
            u3.append(u2[j])
            j+=1
    while i < len(u1):
        u3.append(u1[i])
        i+=1
    while j < len(u2):
        u3. append(u2[j])
        j+=1
    return u3
    
""" a2 = [5, 8, 31, 100]
a1 = [0, 10, 20, 30, 40, 60, 80]
print(merge(a1,a2)) """

def mSort(u):
    l = len(u)
    if l <= 1: return u
    m = l //2
    return merge(mSort(u[m:]),mSort(u[:m]))
print(mSort([0, 10, 20, 30, 40, 60, 80, 5, 8, 31, 100]))

#ex5
def partition(u,x1,x2):
    pivot = u[x2]
    i = x1 - 1
    for j in range(x1,x2):
        if u[i] <= u [j]:
            i+=1
            u[i],u[j]=u[j],u[i]
    u[i+1], u[x2]= u[x2], u[i+1]
    return u


