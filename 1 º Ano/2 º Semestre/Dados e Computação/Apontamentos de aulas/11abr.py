""" dicionarios: funciona como dominio e contradominio
em vez de chamarmos indices, chamamos chaves e os outros sao os valores das chaves
se o resultado for fazio vai aparecer {}
os pares separam-se por vírgulas
o KeyError quer dizer que a chave nao foi encontrada
"dic1.keys" : chaves do dic1
"dic1.values" : valores do dic1

"""

def histo(texto):
    d={}
    texto = texto.upper() #converte tudo para maiusculas
    lista = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    for c in lista:
        d[c]=0
    for c in texto:
        if(c in d):
            d[c] +=1
    return d

""" def print_hist(d):
    for k in sorted(d.keys()):
        print """

#ex1
u = [10,20,30,30,20,30,10,0,20]
def dic(u):
    d = {}
    for x in u:
        if (x in d) :
            d[x] +=1
        else: 
            d[x] =1
    return d
print(dic(u))
def moda(d):
    m = []
    n = 0
    for x in d:
        if d[x] > n:
            m = [x]
            n = d[x]
        else:
            if d[x] == n:
                m +=[x]
    return m

print(moda(dic(u)))

#nota: acrescentar pares
def add(d,k,v):
    if k in d : d[k]=[]
    d[k] +=v

#ex2
u={"A":4,"B":20,"C":4}
def inverte(u):
    m = {}
    for x in u:
        if u[x] in m:
            m[u[x]] += [x]
        else:
            m[u[x]] = [x]
    return m
print(inverte(u))

#ex3
#novas compras: add
#clientes que compram cada item: inverte
#moda do dicionario

a={"a":1,"b":2}
b={"a":3,"b":4}
a.update(b)
print(a)



