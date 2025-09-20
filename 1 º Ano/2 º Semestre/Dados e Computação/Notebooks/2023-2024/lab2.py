#ex1
n = int(input("n = ? "))
i=0
while i <= n:
    print(2**i)
    i +=1

#ex2
#string
n = int(input("n = ? "))
u = ''
while n > 0:
    s = n % 10
    u+=str(s)
    n //= 10
print(u)

#digitos
n = int(input("n = ? "))
m=0
while n != 0:
    m = (10*m)+(n%10)
    n//=10
print(m)

#ex3.1
import math
i=1
s=0
while i < 100001:
    s+= 1/(i**2)
    i+=1
pi= math.sqrt(6*s)

#ex3.2
import math
s = 1
s2 = 0
i = 2
while s - s2 > 10**(-6):
    s+= 1/(i**2)
    s2=s
    i+=1
pi= math.sqrt(6*s)

#ex4
n1 = 0
n2= 1
i = 2
n = int(input("n = ? "))
while n >= i:
    n1= n1+n2
    n2= n1
print(n1)

#ex5
n = int(input("n = ? "))
n=6
l = True
for x in range(0,n):
    c = True
    for y in range(0,n):
        if (l and c) or (not l and not c):
            print('#',end='')
        else:
            print(' ', end='')
        c = not c
    l = not l
    print('') #mudar de linha
print()

#ex6
def mdc(a,b):
    if a == 0: return b
    if b == 0: return a
    if a > b: return mdc(b,a%b)
    return mdc(a,b%a)

print(mdc(10,15))


