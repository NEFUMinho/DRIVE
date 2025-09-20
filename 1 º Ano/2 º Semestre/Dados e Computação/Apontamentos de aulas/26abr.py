#grafo: dicionario: arvore
g= {1: None, 2: 1, 3: 1 , 4:3, 5:4}

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

gv1 = makeGV (g,"arvore",True)
gv1.view()


#GRAFOS NAO SIMETRICOS
def sym(gi):
    go={}   #copia de g
    for u in gi:
        go[u]=[]
    for u in gi:
        for v in gi[u]:
            go[v].append(u)

    for u in gi:
        for v in gi[u]:
            if v not in go[u]:
                go[u].append(v)

    return go

#ex2
#dado um grafo e um vertice, vai verificar o tamanho do continente(vertices juntos)

#feito por mim
g={1:[2,3],2:[1,3],3:[1,2],6:[7,8],7:[6,8],8:[6,7]}
def mapa(g,x,c=[]):
    s=1
    for y in g[x]:
        if y not in c:
            c.append(y)
            s+=mapa(g,y,c)
    return s
print(mapa(g,1,[]))

#feito pelo professor
g={1:[2,3],2:[1,3],3:[1,2],6:[7,8],7:[6,8],8:[6,7]}

def size(g,s):
    vis={}
    for v in g: vis[v] ='WHITE'
    return visit(g,s,vis)

def visit(g,s,vis):
    vis[s]='GRAY'
    count=1
    for v in g[s]:
        if vis[v]=='WHITE':
            count+=visit(g,v,vis)
    vis[s]='BLACK'
    return count

#conta continentes

#feito pelo professor
def countCont(g):
    vis={}
    for v in g: vis[v] ='WHITE'
    count=0
    for v in g:
        if vis[v]=='WHITE':
            count+=1
            visit(g,v,vis)
    return count

print(countCont(g))


def visit(g,s,vis,gvcolor,currentcolor):
    vis[s]='GRAY'
    gvcolor[s]= currentcolor
    for v in g[s]:
        if vis[v]=='WHITE':
            visit(g,v,vis,gvcolor,currentcolor)
    vis[s]='BLACK'

def visit_all(g):
    vis={}
    gvcolor={}
    for v in g: 
        vis[v] ='WHITE'
        gvcolor[v] = 0
    currentcolor=0
    for v in g:
        if vis[v]=='WHITE':
            visit(g,v,vis,gvcolor,currentcolor)
            currentcolor+=1
    return gvcolor

print(visit_all(g))

colors=["blue","green","yellow","red","purple","orange","brown","white","black"]

def makeGV (g,gvcolor):
    gv = graphviz.Graph()
    for u in g :
        gv.node(str(u),colors[gvcolor[u]])
    for u in g:
        for v in g[u]:
            gv.edge(str(u),str(v),colors[gvcolor[v]])
    return gv

