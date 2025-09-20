g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

import graphviz
def makeGV(g):
    gv= graphviz.Digraph()
    for u in g:
        gv.node(str(u))
    for u in g:
        for v in g[u]:
            gv.edge(str(u),str(v))
    return gv

#ex1
#grau de saída
g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

def saida(g):
    s={}
    for u in g:
        su=0
        for y in g[u]:
            su+=1
        s[u]=su
    return s

print(saida(g))

#grau de entrada
def entrada(g):
    s={}
    for u in g:
        s[u]=0
    for u in g:
        for y in g[u]:
                s[y]+=1
    return s

g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

print(entrada(g))

#tarvessia
color = {}
for v in g:
    color[v]='WHITE'

def visit(g,s):
    color[s]='GRAY'
    for v in g[s]:
        if color[v]=='WHITE':
            visit(g,v)
    color[s]='BLACK'

#ex1
def vertices_alcançados(g,s):
    x=1
    y=[s]
    for u in g[s]:
        if u not in y:
            x+=vertices_alcançados(g,u)
            y+=[u]
    return x

def conta(g,s):
    color={}
    for v in g:
        color[v]='WHITE'
    return conta_aux(g,s,color)

def conta_aux(g,s,color):
    c=0
    color[s]='GRAY'
    for v in g[s]:
        if color[v]=='WHITE':
            c+=1+ conta_aux(g,v,color)
    color[s]='BLACK'
    return c

g = {}

g[1] = [2]
g[2] = [2,4,5]
g[3] = []
g[4] = [1,5]
g[5] = [4]
g[6] = [3]

print (conta(g, 1))

#ex2
def visit_all(g):
    color= {}
    for u in g:
        color[u]='WHITE'
    for u in g:
        if color[u] == 'WHITE':
            visit_aux(g,u)

def visit_aux(g,u):
    color[u]='GRAY'
    for v in g[u]:
        if color[v]== 'WHITE':
            visit_aux(g,v)
    color[u]=='BLACK'

#ex3
def build(g,s):
    color={}
    tree={}
    for v in g:
        color[v]='WHITE'
        tree[v]= None
    visit_tree(g,s,color,tree)
    return tree

def visit_tree(g,s,color,parent):
    color[s]='GRAY'
    for v in g[s]:
        if color[v]== 'WHITE':
            parent[v] =s
            visit_tree(g,v,color,parent)
    color[s]='BLACK'


