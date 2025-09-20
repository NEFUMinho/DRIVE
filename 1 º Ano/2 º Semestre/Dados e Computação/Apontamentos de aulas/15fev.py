import random

#ex1  -- lança daados e soma os valores
SIDES = 6

a= random.randrange(1, SIDES+1)
b= random.randrange(1, SIDES+1)

total = a + b
print(total)



#ex2

month = int(input("month=?"))
day = int(input("day=?"))

isSpring = (month == 3 and day >= 20 and day <= 31) or \
           (month == 4 and day >= 1 and day <= 30) or \
           (month == 5 and day >= 1 and day <= 31) or \
           (month == 6 and day >= 1 and day <=20)

print(isSpring)

#ex3

import sys

a = 20
b = 10
c = 30

## Compute stats.
minimum = min(a, b, c)
maximum = max(a, b, c)
median = a + b + c - minimum - maximum

## Write stats.
print(minimum)
print(median)
print(maximum)

###outra forma de fazer
if a <= b and a <= c :
    minimum2 = a
else :
    if b >= c :
        maximum2 = b
    else :
        maximum2 = c

#ex4

a = int(input("Primeiro número"))
b = int(input("Segundo número"))
c = int(input("Terceiro número"))

if a == b and b == c : 
    print('iguais')
else : 
    print('não iguais')

#ex5
 
import math

a = 1
b = 5
c = 2

discriminant = b**2 - 4*a*c

if discriminant >= 0:
  print((-b + math.sqrt(discriminant))/(2*a))
  print((-b - math.sqrt(discriminant))/(2*a))
else:
  print('raízes complexas')


#AUTONOMO

#ex1'
import random

numeros = 6
n1 = random.randrange(1, numeros+1)
n2 = random.randrange(1, numeros+1)
soma = n1 + n2
print(soma)

#ex2'
dia = int(input('dia?'))
mes = int(input('mês?'))
primavera=(mes == 3 and dia >=20 and dia <=31)or (mes == 4 and dia <=30) or (mes == 5 and dia <=31) or (mes == 5 and dia <=20 and dia <=30)
print(primavera)

#ex3'
n1 = int(input('n1='))
n2 = int(input('n2='))
n3 = int(input('n3='))
min = min(n1,n2,n3)
max = max(n1,n2,n3)
other = (n1+n2+n3-min-max)
print(min)
print(other)
print(max)

#ex4'
n1 = int(input('n1='))
n2 = int(input('n2='))
n3 = int(input('n3='))
if n1==n2 and n2==n3 :
    print('Iguais')
else : print('Não iguais')

#ex5'
a = int(input('a='))
b = int(input('b='))
c = int(input('c='))

dis = b**2 - 4*a*c

if dis < 0:
    print('não há raizes reais')
else :
    print((-b + math.sqrt(dis))/(2*a))
    print((-b - math.sqrt(dis))/(2*a))
