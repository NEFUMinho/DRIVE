#ex3

def procura_bin(x,u):
    a = 0
    b = -1
    l = len(u)-1
    while a <= l and b == -1:
        m = a + (l-a)//2
        if u[m] < x : a = m+1
        elif u[m] > x : l = m-1
        else: b = m
    return l

#tpc1
def minimo(v,x1,x2):
    i = x1
    mp = x1
    mv = v[x1]
    while i <= x2:
        if v[i] < mv :
            mp = i
            mv = v[i]
            i+=1
        else:
            i+=1
    return mp
v1=[40,20,10,30,60,0,80, 40]
print(minimo(v1,0,7))

def minimorec(v,x1,x2):
    mp = minimorec(v,x1+1,x2)
    if v[x1] <= v[mp]: return x1
    return mp
v1=[40,20,10,30,60,0,80, 40]
print(minimorec(v1,0,2))

#tpc2
def conta(v,y,x1,x2):
    s = 0
    i = x1
    while i <= x2:
        if v[i] == y:
            s+=1
            i+=1
        else:
            i+=1
    return s

def conta_rec(v,y,x1,x2):
    if v[x1] == y:
        return 1 + conta_rec(v,y,x1+1,x2)
    return conta_rec(v,y,x1+1,x2)

