import graphviz #biblioteca de visualização de grafos
 #para instalar o graphviz, no terminal escrever "pip install graphviz"
""" no collab: 

def makeGV (g) : #grafo vazio
    gv =graphviz.Digraph 
    for u in g :
        gv.node(str(u))
    for u in g:
        for v in g[u]:
            gv.edge(str(u),str(v))
    return gv

gv1 = makeGV (g)
 """

#no vsc

import graphviz
def makeGV (g,fname,directed):
    filename = "output/" + fname + ".gv"
    if directed :
        gv = graphviz.Digraph(filename = filename)
    else :
        gv = graphviz.Graph(filename = filename)
    for u in g :
        gv.node(str(u))
    for u in g:
        for v in g[u]:
            gv.edge(str(u),str(v))
    return gv

gv1 = makeGV (g)


def visit(g,s):
    color[s]= 'GRAY'
    print (s, 'GRAY')
    for v in g[s]:
        if color[v]=='WHITE':
            visit(g,v)
    color[s]='BLACK'
    print (s, 'BLACK')

color = {}
for v in g:
    color[v]= 'WHITE'

visit(g,1)
print()


g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

print(g)
#ex1 conta vertices

def visit2(g,s):
    conta = 0
    color[s]= 'GRAY'
    for v in g[s]:
        if color[v]=='WHITE':
            """ visit(g,v) """
            conta=visit2(g,v) + 1
    color[s]='BLACK'
    return conta

def visit(g,s):
    for v in g:
        color[v]='WHITE'
    return visit2(g,s)


color = {}
for v in g:
    color[v]= 'WHITE'

print(visit(g,6))

#ex2
def visit_all(g,s):
    u=[]
    color[s]= 'GRAY'
    u+=[s]
    for v in g[s]:
        if color[v]=='WHITE':
            u+= visit_all(g,v)
    color[s]='BLACK'
    for w in g:
        if color[w]=='WHITE':
            u+= visit_all(g,w)
    return u

color = {}
for v in g:
    color[v]= 'WHITE'

g= {1: [2], 2: [2, 4, 5], 3: [], 4: [1, 5], 5: [4], 6: [3]}
print(visit_all(g,1))

#ex3
def travessia(g,s):
    u={}
    color[s]= 'GRAY'
    for v in g[s]:
        if color[v]=='WHITE':
            u[v]=s
            u.update(travessia(g,v))
    color[s]='BLACK'
    return u

color = {}
for v in g:
    color[v]= 'WHITE'

g= {1: [2], 2: [2, 4, 5], 3: [], 4: [1, 5], 5: [4], 6: [3]}
print(travessia(g,2))

#ex4 desenhar a arvore travessia

