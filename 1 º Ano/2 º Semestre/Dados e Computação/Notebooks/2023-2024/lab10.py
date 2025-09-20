#relembrar

def build(g,s):
    color={}
    tree={}
    for v in g:
        color[v]= 'WHITE'
        tree[v]= None
    visit_tree(g,s,color,tree)
    return tree

def visit_tree(g,s,color,parent):
    color[s]='GRAY'
    for v in g[s]:
        if color[v]== 'WHITE':
            parent[v]=s
            visit_tree(g,v,color,parent)
    color[s]='BLACK'

#ex1
import graphviz
graphviz_executable = 'C:\Users\pmog2\OneDrive\Área de Trabalho\dadosecomputações'.exe
def makeGVTree(t):
    gv= graphviz.Digraph()
    for u in t:
        if t[u]!= None:
            gv.node(str(u))
    for u in t:
        if t[u]!= None:
            gv.edge(str(t[u]),str(u))
    return gv

g2 = {}

g2[1] = [3,2]
g2[2] = [4]
g2[3] = [4]
g2[4] = [1,5]
g2[5] = [1]

makeGVTree(build(g2,1)).render('grafo1', format='png', view=True)



#simetria
def sym(g):
    go={}
    for u in g:
        go[u]=[]
    for u in g:
        for v in g[u]:
            go[u].append(v)
    for u in g:
        for v in g[u]:
            if not u in go[v]:
                go[v].append(u)
    return go

#ex2
def continente(g,s):
    color={}
    for v in g:
        color[v]='WHITE'
    return conta(g,s,color)

def conta(g,s,color):
    color[s]='GREY'
    c=1
    for v in g[s]:
        if color[v]=='WHITE':
            c+=conta(g,v,color)
    color[s]='BLACK'
    return c


#ex3
def continentes(g):
    color={}
    for v in g:
        color[v]='WHITE'
    c=0
    for v in g:
        if color[v]== 'WHITE':
            c+=1
            visit(g,v,color)
    return c

def visit(g,s,color):
    color[s]='GRAY'
    for u in g[s]:
        if color[u]=='WHITE':
            visit(g,u,color)
    color[s]='BLACK'

gu = {}
gu[1] = [2,3]
gu[2] = [3]
gu[3] = []
gu[4] = [5]
gu[5] = []
gu[6] = []
gu[7] = [6,8]
gu[8] = []

print(continentes(gu))
