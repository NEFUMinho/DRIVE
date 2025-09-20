#ex1- inserção ordenada (inplace- sem criar um array novo)

u1 = [10,20,30,40,25]
#insert(u1,0,4) = [10,20,25,30,40]
""" 
def insert(u,n1,n2):
    if n1 == n2-1 and u[n1] >= u[n2] :
        u[n1], u[n2] = u[n2],u[n1]
    i = n2
    while u[n2] <= u[n2-1]:
        u[n2],u[n2-1],u[i-1],u[i]=u[n2-1],u[n2],u[i],u[i-1]
        i -= 1
    insert(u,n1,n2-1)

insert(u1,0,4)
print(u1) """


# solução
def insert2(u,a,b):
    if a >= b or u[b] > u[b-1]: return      #este return faz-nos sair da função
    u[b-1],u[b]=u[b],u[b-1]
    insert2(u,a,b-1)


#ex2
def insertionSort(u):
    i = 0
    while i <= len(u) -1:
        insert2(u,0,i)
        i +=1
    
u1 = [10,20,30,40,25]
insertionSort(u1)
print(u1)

#ex3- insertionSort sem função auxiliar

#ex4-fusão ordenada
u=[0,10,20,30,40,60,80,5,8,31,100]

#i-posição inicial
#f- posição final
#n - (len(u)-1)
""" def merge(u,i,f,n): """





