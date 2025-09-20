""" tuplos : podemos ter coisas de tipos diferentes; não podem ser mutáveis
podem ser definidor de maneiras diferentes
t1= tuple((1,"aluno",12.5))
t2= "hoje", "ontem", "amanhã

para imprimir "aluno" em t1
print(t1[1])

ver na blackboard


podemos comparar diretamente analisando primeiro o 1 campo e se forem iguais, depois o 2 e depois o 3 : ordem lexicográfica

famous - the life of pablo

podemos escrever:
quociente, resto = divmod(10,3)

a função zip também existe para juntar dois arrays em pares, mas para imprimir temos de escrever print(list(x)), sendo x o resultado do zip, mas sao estruturas feitas para serem removidas, ou seja,
se impimirmos duas vezes seguidas a segunda vez vai devolver algo vazio, porque a primeira vai esvaziar a lista

o map e o filter também existem aqui


"""
#ex1.1
def filtrar(u):
    v= []
    for i in range(len(u)):
        (x,y,z)= u[i]
        s= x+y+z
        if s == 0:
            v+=[u[i]]
    return v

u=[(1,-1,0),(1,2,3),(2,1,-3)]
print(filtrar(u))

u=[(1,-1,0),(1,2,3),(2,1,-3)]
b=[s for s in u if s[1]+s[2]+s[0]==0]
print(b)

#ex1.2
u=[(1,-1,0),(1,2,3),(2,1,-3)]
b=[s[0]+s[1]+s[2] for s in u]

#ex2
def pesquisa(u,n):
    for i in range(len(u)):
        (nome,numero,nota1,nota2)= u[i]
        if numero == n:
            media = (nota1 + nota2)/2
            return([nome,media])
        if numero > n: return()


u=[("margarida",3,20,19),("ruben",5,20,15)]
print(pesquisa(u,5))

#ex3
def qSort(u,i,f,n):
    x = qSort(u,i+1,f,n)
    if (u[i])[n] <= (x[i])[n]:
        return([u[i]]+x)
    return x

#ex adicionais

def comum(u,v,w):
    for i in range(len(u)):
        if u[i] in w and u[i] in v: return u[i]
    return()
u = [1,2,3,4]
v = [3,4,5,6]
w = [4,5,6,7]
print(comum(u,v,w))

#ou
def comum2(u,v,x):
    r = [x for x in u if x in v and x in w]
    return r


u = [1,5,7,10]
def distancia(u):
    r=max(u)- min(u)
    a=[]
    for i in range(len(u)):
        for j in range(len(u)):
            if i != j:
                x = max(u[i],u[j])
                y = min(u[i],u[j])
                s = x-y
                if s <= r :
                    r =s
                    a=[u[min(i,j)],u[max(i,j)]]
    return a
print(distancia(u))




