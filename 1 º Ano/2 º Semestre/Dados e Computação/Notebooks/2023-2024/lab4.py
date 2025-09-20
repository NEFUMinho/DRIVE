#ex2
def areTriangular(x,y,z):
    if x < y+ z and y < x+z and z< x+y: return True
    return False

#ex3
def transpose(m):
    return [[c[i] for c in m] for i in range(len(m[0]))]
m=[[10,20,30],[40,50,60]]
print(transpose(m))

#ex4
def sem_ultimo(c):
    return c //10

def soma_digitos(x):
    if x <10: return x
    else:
        y = x // 10
        z = x % 10
        return (z+ soma_digitos(y))

def checksum(x):
    s=0
    y= str(x)
    for j in range(len(y)):
        if j % 2 == 0:
            s+= soma_digitos(2*int(y[j]))
        else:
            s+= int(y[j])
    return s
print(checksum(1234))

def valid(cartao):
    u = cartao % 10
    checksum2 = checksum(sem_ultimo(cartao))
    s = u + checksum
    if s % 10 == 0: return True
    return False
print(valid(4578423013769219))





