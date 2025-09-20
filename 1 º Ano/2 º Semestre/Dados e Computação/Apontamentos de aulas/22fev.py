#ex2 inverter a ordem dos digitos dos numeros

n = int(input("n=?"))
s = ''

if n <= 0 :
    print(s)
else :
    ns = n % 10
    n //= 10
    s += str(ns)
    print(s)    #nao funciona porque o ciclo tem de ser com o bloco while

#correção

n=10810

s = ''
while n > 0 :
    digit = n % 10
    s += str(digit)
    n = n // 10
print (s)

#ex3 calcular um valor aproximado de pi
#1)SOZINHA
import math

n = 1
s = 0
while n < 100001 :
    ns = 1 / (n*n)  # para expoente é ** # a / é com floats e o // é inteiro = div do haskell
    s += ns
    n += 1
print(math.sqrt(s*6))

#2)
import math

err = (1e-6)**2 /6
print('Erro= ') + str(math.sqrt(6*err))

total = 0
i =1
while (1 / (1**2)) > err :
    total += 1 /(1**2)
    i += 1
print('Valor aproximado = ' + str(math.sqrt(6*total)))


#ex4
n = int(input("n=?"))
ns = 0
n1 = 0
n2 = 1
n3 = 0
while ns < n :
    n1 = n
    n2 = n1
    n3 = n1 + n2
print(n1)
print(n2)
print(ns)

#correcao
n = 10

a = 0
b = 1

print(a)
print(b)

for i in range(1,n-1):
    old_a = a
    a = b
    b = old_a + b
    #é igual a 
    #a,b=b, a+b -> nao usamos uma terceira variavel
    print(b)

#ex5

n = 6

el = True           #linha par?
for l in range(0,n):
    ec = True       #coluna par?
    for c in range(0,n):
        if (el and ec) or (not el and not ec):
            print('#', end ="")
        else:
            print(' ', end="")
        ec= not ec
    el= not el
    print('')


#ex6 : maximo divisor comum
    
""" 
106 | 32 | 10
32  | 10 | 2
10  | 2  | 0
 """

"runaway- mbdtf"

#exaula-> numeros primos ate n

n = 10
a = []
for i in range(n+1):
    a += [i]
print(a)

for i in range(1,len(a)):
    for j in range(i,(len(a))):
        if j % i == 0:
            a[i] == 'F'
        else:
            a[i] == 'T'
print(a)

#correção no caderno


    