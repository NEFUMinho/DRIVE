#ex1
def mdc(a,b):
    if a == 0: return b
    if b == 0: return a
    if a > b: return mdc(b,a%b)
    return mdc(a,b%a)

n=10
for l in range(1,n):
    for c in range(1,n):
        if mdc(l,c)==1: print('1', end='')
        else : print('0', end='') 
    print('')
print()

#ex2
naipes = ['copas','ouros','espadas','paus']
outros = ['A','2','3','4','5','6','7',',8','9','10','J','Q','R']
baralho= [o + ' de '+ n for o in outros for n in naipes]
print(baralho)

#ex3
import random
u=[x for x in range(100)]
def perm(u):
    for i in range(len(u)):
        x = random.randrange(len(u))
        u[i],u[x]=u[x],u[i]
    return u
print(perm(u))

#ex4
def reverse(u):
    for i in range(len(u)//2):
        u[i],u[len(u)-i-1]=u[len(u)-i-1],u[i]
    return u
u=[1,2,3,4,5]
print(reverse(u))

def reverse(u):
    b=[]
    for x in u:
        b = [x]+b
    return b
u=[1,2,3,4,5]
print(reverse(u))

#ex5
def histograma(u):
    m = max(u)
    hist = [0]* (m+1)
    for x in u:
        hist[x]+=1
    return hist
print(histograma([1,0,0,2,1,4,1]))

#ex6
def menores(u):
    v=[]
    for x in range(len(u)):
        s=0
        for y in range(len(u)):
            if u[y] < u[x]:
                s+=1
        v.append(s)
    v.pop(x)
    return v
print(menores([1,0,0,2,1,4,1]))

#ex7.1
def procura(x,u):
    for i in range(len(u)):
        if u[i]== x: return i
    return()
print(procura(0,[1,0,0,2,1,4,1]))

#ex7.2
def procura_ord(x,u):
    i=0
    while i< len(u):
        if u[i]==x: return i
        if u[i] > x: 
            return ()
        i+=1
    return()
print(procura_ord(7,[0,0,1,2,2,7,87]))