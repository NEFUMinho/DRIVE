#ex2- testa se tres numero spodem ser lados de um trinagulo

def areTriangular(x,y,z):
    if x <= y + z or y <= x + z or z <= x + y:
        return(False)
    return(True)
#para  testar, coloca-se print() e dentro dos parenteses colocamos os 3 valores

#ex3- transposta da matriz
m1 = [[1,2],[3,4],[5,6]]

def transpose(m):
    c = len(m)
    l = len(m[0])
    a = []
    for i in range(l):
        linha = [0] * c
        a += [linha]
    for x in range(c):
        for y in range(l):
            a[y][x] = m[x][y]
    return(a)
print(transpose(m1))

#ex3.2 - para matrizes quadradas sem criar uma matriz nova
m1 = [[1,2],[3,4]]
def transpose2(m):
    n = len(m)
    for i in range(n):
       m[m[i]][i]=m[i][m[i]]
    return(m)
print(transpose(m1))

#ex4
cartao1 = 4578423013769219

def separa(cartao):
    sem_ultimo = cartao // 10
    return(sem_ultimo)
print(separa(cartao1))

def soma_digitos(n):
    if n < 10:
        return(n)
    else:
        x = n % 10
        y = n // 10
        return(x+y)

def checksum(sem_ultimo):
    soma = 0
    s = str(sem_ultimo)
    for i in range(len(s)):
        if i % 2 == 0:
            soma += soma_digitos(2*(int(s[i])))
        else:
            soma += int(s[i])
    return(soma)
print(checksum(separa(cartao1)))
def check(cartao):
    ultimo = cartao % 10
    resto = checksum(separa(cartao))
    x = ultimo + resto
    if x % 10 == 0:
        return(True)
    else:
        return(False)
    
print(check(cartao1))

#ex5
a=[0,1,2,3,4,5]
def procura_pos(a,x):
    y = procura_pos_aux(a,x,0)
    return(y)
def procura_pos_aux(a,x,i):
    if x == a[i]:
        return(i)
    else:
        if i == len(a):
            return(-1)
        else:
            return(procura_pos_aux(a,x,i+1))
print(procura_pos(a,3))

#ex5.2
#fazer com lista ordenada
a=[0,1,2,3,4,5]
def procura_pos(a,x):
    y = procura_pos_aux(a,x,0)
    return(y)
def procura_pos_aux(a,x,i):
    if x == a[i]:
        return(i)
    else:
        if i == len(a):
            return(-1)
        else:
            if x < a[i]:
                return(-1)
            else: 
                return(procura_pos_aux(a,x,i+1))

#fibonacci
def fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib_aux(n,0,0,1)

def fib_aux(n,n2,x,y):
    if n2 == n:
        return y
    return fib_aux(n,n2+1,y,x+y)
print(fib(100))

