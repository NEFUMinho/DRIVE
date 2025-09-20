#ex1
def zeros(u):
    r=[]
    for x in u: 
        (a,b,c)= x
        s= a+b+c
        if s == 0:
            r.append([x])
    return r
def soma(u):
    r=[]
    for x in u:
        (a,b,c)= x
        s= a+b+c
        r.append(s)
    return r
print(soma([(1,-1,2),(1,1,-2),(2,-1,-1),(1,2,-2)]))

#ex2
def aluno(u,a):
    for x in u:
        (num,nome,n1,n2)=x
        media = (n1+n2)/2
        if a == num : return (nome,media)

alunos =[(1,"rui",12.5,19), (5,"paulo",18.2,20), (12,"joao",14.5,19), (15,"ana",15.2,18), (17,"jorge",19.0,18)]
print(aluno(alunos,12))

#ex3
def partition(u,x1,x2,cond):
    p = u[x2][cond]
    i = x1-1
    for j in range(x1,x2):
        if (u[j][cond]<=p):
            i+=1
            u[j],u[i]=u[i],u[j]
    u[i+1],u[x2]=u[x2],u[i]
    return (i+1)

def qsort(u,i,f,cond):
    if(f>i):
        p = partition(u,i,f,cond)
        qsort(u,i,p-1,cond)
        qsort(u,p+1,f,cond)

#extra
#1
def comum(x,y,z):
    s=[]
    for u in x:
        if u in y and u in z:
            s.append(u)
    return s

def dist(u):
    x = u[0]
    y = u[1]
    d = abs(y-x)
    for i in u[2:]:
        if abs(x-i)<d:
            y=i
            d= abs(x-i)
        if abs(y-i)<d:
            x=i
            d= abs(y-i)
    return(x,y)
print(dist ([10,20,40,46]))



        
    
