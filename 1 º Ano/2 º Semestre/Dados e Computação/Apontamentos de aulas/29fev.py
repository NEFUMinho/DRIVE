#maximo divisor comum 

m = 108
n = 42

        #trocar os valores caso m seja menor que n
if m<n:
   m,n = n,m
r=m%n
while(m%n !=0):
    print(m,n)
    m, n = n,m%n

#ex1: dado n, imprime uma tabela com n linhas e n colunas que na linha i e coluna j deverá conter 1 se mdc(i,j)= 1 e 0 caso não seja

n = 11

for i in range(1,n+1):
    for j in range(1,n+1):
        a,b=i,j
        if a <b:
            a,b =b,a
        while (a %b ):
            a,b= b, a%b
        if (b==1):
            print('1 ',end='')
        else: 
            print('0 ', end='')
    print()

#ex2: construir um array com as cartas do baralho
    #array com os naipes(n)
    #array com os numeros(m)

n = ['ás','dois','três','quatro','cinco','seis','sete','oito','nove','dez','valete','dama', 'rei']
m = ['copas','ouros','espadas','paus']

baralho = []
for num in n:
    for naipe in m:
        carta = num + ' de ' + naipe
        baralho += [carta]

for carta in baralho:   #este imprime linha a linha
    print(carta)
    #ou
print(baralho)          #este imprime o array todo

#ex3: gera os numeros de 0 a 99 sem repetições, por uma ordem aleatoria
import random
""" 
numeros = range(0,100)

numeros2 = []
for n in random.range(0,100):
    for n2 in random.range(n,100):
 """
    #criar o array com os 100 numeros
n = 100
perm = [0]*n    #criar um array com 100 zeros
for i in range(n):
    perm[i] (i) #escreve o i na posicao i

print(perm)
print()

for i in range(n):
    r = random.randrange(i,n)
    perm[i],perm[r]= perm[r],perm[i] #faz swap


#ex4 : inverter um array
    #ex4.1 : percorrer do inicio para o fim

a = [1,2,3,4]
b=[]
for x in a :
    b = [x]+b 
#OU
a = [1,2,3,4]
n = len(a)
b =[]
for i in range(n-1,-1,-1): #onde começa,como é que percorre o array(se fosse -2 era de dois em dois valores), o fim
    b += [a[i]]
print(b)

    #ex4.2 : percorrer do fim para o inicio
a= [1,2,3,4]
l=len(a)
b = [0]*l
for i in range(l):
    b[i] (i) #nao acabei

#ex5 -> array histograma
a = [1,0,0,2,1,4,1]
m = max(a)
hist = [0]*(m+1) #cria um array com m+1 zeros
for x in a:
    hist[x] +=1
print(hist) 

#ex6 
    









