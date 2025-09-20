#lab10
g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

def constroi(g,s):
    color = {}
    tree = {}
    for u in g:
        color[u] = 'WHITE'
        tree[u] = None
    visit_tree(g,s,color,tree)
    return tree

def visit_tree(g,s,color,parent):
    color[s]='GRAY'
    for u in g[s]:
        if color[u] == 'WHITE':
            parent[u]=s
            visit_tree(g,u,color,parent)
    color[s]='BLACK'

def simetrico(g):
    go = {}
    for u in g:
        go[u]=[]
    for u in g:
        for v in g[u]:
            go[u].append(v)
    for u in g:
        for v in g[u]:
            if u not in go[v]:
                go[v].append(u)
    return go
      
def mapa(g,s):
    color={}
    for u in g:
        color[u]='WHITE'
    return mapaAux(g,s,color)

def mapaAux(g,s,color):
    color[s]='GRAY'
    c=1
    for u in g[s]:
        if color[u]=='WHITE':
            c+= mapaAux(g,u,color)
    color[s]='BLACK'
    return c

def continentes(g):
    color={}
    for u in g:
        color[u]='WHITE'
    c=0
    for v in g:
        if color[v]=='WHITE':
            c+=1
            continentesAux(g,v,color)
    return c

def continentesAux(g,s,color):
    color[s]='GRAY'
    for u in g[s]:
        if color[u]=='WHITE':
            continentesAux(g,u,color)
    color[s]='BLACK'

#lab9

def gSaida(g):
    s = {u:len(g[u]) for u in g}
    return s

def gEntrada(g):
    e={}
    for u in g:
        e[u]=0
    for v in g:
        for x in g[v]:
            e[x]+=1
    return e

def vertices(g,s):
    color={}
    for u in g:
        color[u]='WHITE'
    return verticesAux(g,s,color)

def verticesAux(g,s,color):
    color[s]='GRAY'
    count=0
    for u in g[s]:
        if color[u]=='WHITE':
            count+=1+verticesAux(g,u,color)
    color[s]='BLACK'
    return count

def visit_all(g):
    color={}
    for u in g:
        color[u]='WHITE'
    for u in g:
        if color[u]=='WHITE':
            visit2(g,u,color)

def visit2(g,s,color):
    color[s]='GRAY'
    for u in g:
        if color[u] == 'WHITE':
            visit2(g, u)
    color[s] = 'BLACK'

def arvore2(g,s):
    tree={}
    color={}
    for u in g:
        color[u]='WHITE'
        tree[u]=None
    visita(g,u,s,color)
    return tree

def visita(g,s,parent,color):
    color[s]='GRAY'
    for u in g[s]:
        if color[u]=='WHITE':
            parent[u]=s
            visita(g,u,parent,color)
    color[s]='BLACK'

#lab8
def moda(u):
    d={}
    for v in u:
        if v in d: d[v] +=1
        else: d[v]=1
    x = set(d.values())
    m = max(x)
    a=[]
    for v in d:
        if d[v]==m:
            a.append(v)
    return a
print(moda([10,20,30,30,20,30,10,0,20]))

def add(d,x,n):
    if x not in d:
        d[x]=n
    else:
        d[x]+=n
    return d

def reverse(d):
    r={}
    for y in d.values():
        r[y]= []
    for x in d:
        y=d[x]
        r[y].append(x)
    return r

dict1 = {'one':'um', 'two':'dois', 'three':'três', 'four':'quatro', 'five':'cinco', 'six':'seis', 'ten':'dez'}
print(reverse(dict1))

#FAZER EX3

#lab7
def zeros(u):
    return [(x,y,z) for (x,y,z) in u if x+y+z==0]

def soma(u):
    return [x+y+z for (x,y,z) in u]

def aluno(u,x):
    for v in u:
        (num,nome,n1,n2)=v
        if x < num : return
        if x == num:
            media=(n1+n2)/2
            return(nome,media)

alunos =[(1,"rui",12.5,19), (5,"paulo",18.2,20), (12,"joao",14.5,19), (15,"ana",15.2,18), (17,"jorge",19.0,18)]
print(aluno(alunos,5))

def partition(u,p,r,cond):
    pivot=u[r][cond]
    i=p-1
    for j in range(p,r):
        if u[j][cond]<=pivot:
            u[j],u[i]=u[i],u[j]
    u[i+1],u[r]=u[r],u[i+1]
    return i+1

def qSort(v,i,f,cond):
    if f > i :
        p =partition(v,i,f,cond)
        qSort(v,i,p-1,cond)
        qSort(v,i,p+1,cond)

def comum(x,y,z):
    return [a for a in x if a in y and a in z]

def menorDist(u):
    if len(u)>2:
        a=u[0]
        b=u[1]
        d=abs(a-b)
        for x in u[2:]:
            if abs(x-b) < d:
                a=x
                d=abs(x-b)
            elif abs(x-a) < d:
                b=x
                d=abs(x-a)
        return (a,b)
    return u
print(menorDist([10,20,40,46]))

#lab6

def insert(u,a,b):
    if a > b : return
    x = u[b]
    i= b-1
    while i>=a and u[i]> x:
        u[i+1]=u[i]
        i-=1
    u[i+1]=x
    return u

def insert(u,a,b):
    if a<b and u[b-1]>=u[b]:
        u[b-1],u[b]=u[b],u[b-1]
        insert(u,a,b-1)

def iSort(u):
    for i in range(1,len(u)):
        insert(u,0,i)
    return u

def insertionSort(u):
    if len(u)==0:return []
    u2=insertionSort(u[1:])
    if u[0] <= u2[0]:
        return [u[0]]+u2
    return(u2[0]+insertionSort([u[0]]+u2[1:]))

def merge(u,x1,x2,x3):
    u1=[]
    u2=[]
    u3=[]
    for i in range(x1,x2):
        u1.append(u[i])
    for j in range(x2,x3):
        u2.append(u[j])
    y=0
    z=0
    while y < len(u1) and z < len(u2):
        if u1[y] <= u2[z]:
            u3.append(u1[y])
            y+=1
        else:
            u3.append(u2[z])
            z+=1
    while y < len(u1):
        u3.append(u1[y])
    while z < len(u2):
        u3.append(u2[z])

#lab5

def procura(u,x):
    i=0
    while x != u[i]:
        i+=1
    if i >= len(u): return -1
    return i

v = [30,10,20,40,10]
print(procura(v,10))


def procura2(u,x):
    i=0
    if i >= len(u): return
    if x > u[i] : return
    while x != u[i]:
        i+=1
    return i

def bprocura(u,x):
    a=0
    b=len(u)-1
    r = -1
    while a <= b and r == -1:
        m = (a+b)//2
        if u[m] < x : a = m+1
        elif u[m] > x : b = m-1
        r = m
    return r

#lab4
def hist(u):
    h = [0]*(max(u)+1)
    for x in u:
        h[x]+=1
    return h
a=[1,0,0,2,1,4,1]
print(hist(a))

def outro(u):
    h = hist(u)
    for i in range(1,len(h)):
        h[i]+=h[i-1]
    return h
a=[1,0,0,2,1,4,1]
print(outro(a))

def areTriangular(x,y,z):
    return (x < y+z and y < x+z and z< x+y)

def transpose(m):
    l = len(m)
    c = len(m[0])
    mtransposta = [[]]*c
    for i in range(c):
        mtransposta[i]=[0]*l
    for i in range(c):
        for j in range(l):
            mtransposta[i][j]=m[j][i]
    return mtransposta


def tabela(n):
    for i in range(1,n+1):
        for j in range(1,n+1):
            if mdc(i,j)==1:
                print('1',end='')
            else: print('0',end='')
    return
def mdc(a,b):
    n1 = min(a,b)
    n2 = max(a,b)
    while n1 >1:
        if n2%n1 == 0: return n1
        n1-=1
    return 1

def reverse(u):
    u2= reverse(u[1:])
    return(u2+u[0])
print(reverse([1,2,3,4]))

def reverse(u):
    r = []
    for x in u:
        r = [x]+ r
    return r
print(reverse([1,2,3,4]))

def reverse2(u):
    r = []
    for x in range(len(u)-1,-1,-1):
        r.append(u[x])
    return r
print(reverse2([1,2,3,4]))

def reverseIN(u):
    for x in range(len(u)//2):
        u[x], u[len(u)-x-1] = u[len(u)-x-1] , u[x]
    return u

#lab2
n=int.input("n=?")
s=[2*n]

#lab11
def generate(d,n):
    if n == 0: return {""}
    rec = generate(d,n-1)
    new = {x+y for x in d for y in rec}
    rec2 = {u for u in rec if u not in new}
    return new | rec2
s = generate({'a','b','c'}, 4)

dfa0mult3 = { 'Q': {'IF', 'A', 'B'},
              'Sigma': {'0', '1'},
              'Delta': { ('IF', '0'): 'A',
                         ('IF', '1'): 'IF',
                         ('A', '0'): 'B',
                         ('A', '1'): 'A',
                         ('B', '0'): 'IF',
                         ('B', '1'): 'B' },
              'q0': 'IF',
              'F': {'IF'}
            }

def consistente(D):
    Q     = D["Q"]
    Sigma = D["Sigma"]
    Delta = D["Delta"]
    q0    = D["q0"]
    F     = D["F"]
    chaves=set(Delta.keys())
    valores=set(Delta.values())
    return ( Q != {} and
            Sigma != {} and
            (x in Q and y in Sigma for (x,y) in chaves) and
            q0 in Q and (f in Q for f in F))

def executa(D,s):
    Q     = D["Q"]
    Sigma = D["Sigma"]
    Delta = D["Delta"]
    q0    = D["q0"]
    F     = D["F"]
    chaves=set(Delta.keys())
    valores=set(Delta.values())
    if s == "": return q0
    return executaAux(D,s,q0)

def executaAux(D,s,q):
    Q     = D["Q"]
    Sigma = D["Sigma"]
    Delta = D["Delta"]
    q0    = D["q0"]
    F     = D["F"]
    chaves=set(Delta.keys())
    valores=set(Delta.values())
    if s== "": return q0
    for x in s:
        executaAux(D,s[1:],Delta[(q0,s[0])])

def aceita(D,s):
    return (executa(D,s) in D["F"] and consistente(D))

print(aceita(dfa0mult3,'101001'))

def aceites(D,n):
    s=generate(D["Sigma"],n)
    return {ss for ss in s if aceita(D,s)}



















