#ex1
def moda(u):
    d=dict()
    for x in u:
        if x in d: d[x]+=1
        else: d[x]=1
    m = max(d.values())
    r=[]
    for y in d:
        if d[y]==m: r+=[y]
    return r
print(moda([10,20,30,30,20,30,10,0,20]))

#add
def add(u,x,n):
    if x not in u: u[x]=[]
    u[x]+=n

#ex2
def inverte(u):
    u2={}
    for x in u:
        if u[x] in u2:
                u2[u[x]]+=[x]
        else: u2[u[x]]=[x]
    return u2

dict1 = {'one':'uno', 'two':'uno', 'three':'três', 'four':'quatro', 'five':'cinco', 'six':'seis', 'ten':'dez'}
print(inverte(dict1))