#ex1
import random

lados=6
a=random.randrange(1,lados+1)
b=random.randrange(1,lados+1)
total= a+b
print(total)

#ex2
dia= int(input("dia=?"))
mes= int(input("mês=?"))
primavera= (mes == 3 and 20 <= dia <= 31) or (mes == 4 and 1 <= dia <= 30) or (mes == 5 and 1<= dia <= 31) or (mes == 6 and 21<= dia <= 20)   

#ex3
a= int(input("a=?"))
b= int(input("b=?"))
c= int(input("c=?"))
menor= min(a,b,c)
maior=max(a,b,c)
meio=a+b+c-maior-menor

#ex4
a= int(input("a=?"))
b= int(input("b=?"))
c= int(input("c=?"))
if a == b and b == c:
    print("Iguais")
else:
    print("não iguais")

#ex5
import math
a= int(input("a=?"))
b= int(input("b=?"))
c= int(input("c=?"))
delta = b**2 - 4*a*c 
if delta < 0:
    print("não existem raízes reais")
else:
    x = (-b + math.sqrt(delta))/(2*a)
    y = (-b - math.sqrt(delta))/(2*a)
    if x != y: print(x,y)
    else: print(x)





    