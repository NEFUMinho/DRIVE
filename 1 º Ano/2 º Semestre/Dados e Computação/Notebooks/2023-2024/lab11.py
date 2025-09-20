def generate(sigma,n):
    if n == 0 : return set({""})
    rec= generate(sigma,n-1)
    new ={ c+ s for c in sigma for s in rec if len(s)== n-1}
    return new | rec


#automato
dfa0mult3 = { 'Q': {'IF', 'A', 'B'},
              'Sigma': {'0', '1'},
              'Delta': { ('IF', '0'): 'A',
                         ('IF', '1'): 'IF',
                         ('A', '0'): 'B',
                         ('A', '1'): 'A',
                         ('B', '0'): 'IF',
                         ('B', '1'): 'B' },
              'q0': 'IF',
              'F': {'IF'}
            }

#testar consistencia total
def consT(d):
    Q = d["Q"]
    Sigma= d["Sigma"]
    Delta= d["Delta"]
    q0= d["q0"]
    F= d["F"]
    chaves=set(Delta.keys)
    valores=set(Delta.values)
    return ( Q != {} and
            Sigma !=  {} and
            chaves <= {(x,y) for x in Q for y in Sigma} and
            valores != {} and
            valores <= Q and
            q0 in Q and
             F <= Q)

#aceitação da palavra pelo automato
def aceita(D,s):
    return aceitaAux(D,D["q0"],s)

def aceitaAux(D,q,s):
    Delta = D["Delta"]
    if s == "": return q
    return aceitaAux(D,Delta[q,s[0]],s[1:])


#ex1
def execução(DFA,s):
    Q=DFA["Q"]
    Sigma=DFA["Sigma"]
    Delta=DFA["Delta"]
    chaves=set(Delta.keys())
    valores=set(Delta.values())
    q0=DFA["q0"]
    F=DFA["F"]
    estado=q0
    estados=[q0]

    if len(s)==0 and estado not in F:
        return (False,[])
    
    for u in s:
        if u not in chaves:
            return
        estado = Delta[(estado,u)]
        estados.append(estado)
    return (True,estados)

dfa0mult3 = { 'Q': {'IF', 'A', 'B'},
              'Sigma': {'0', '1'},
              'Delta': { ('IF', '0'): 'A',
                         ('IF', '1'): 'IF',
                         ('A', '0'): 'B',
                         ('A', '1'): 'A',
                         ('B', '0'): 'IF',
                         ('B', '1'): 'B' },
              'q0': 'IF',
              'F': {'IF'}
            }

print(execução(dfa0mult3,'101001'))



#SESSAO DE DUVIDAS

def generate(sigma,n):
    if n == 0 : return set({""})
    u = generate(sigma,n-1) #conjunto de todas as palavras de comprimento máximo n-1
    u2 = {c+s for c in sigma for s in u if len(s)== n-1} #juntar o caracter a essas palavras
    u3 = u + u2
    return u3
    #return u | u2 #dá a uniao dos dois

s = generate({'a','b','c'}, 4)
print(s)

#aceitação do automato
def executa(D,s):
    Q = D["Q"]
    Sigma = D["Sigma"]
    Delta = D["Delta"]
    chaves= set(Delta.keys())
    valores= set(Delta.values())
    q0 = D["q0"]
    F = D["F"]
    return executa_aux(D,s,q0)

def executa_aux(D,s,q):
    Q = D["Q"]
    Sigma = D["Sigma"]
    Delta = D["Delta"]
    chaves= set(Delta.keys())
    valores= set(Delta.values())
    q0 = D["q0"]
    F = D["F"]
    if s == "": return q
    return executa_aux(D,s[1:],Delta[(q,s[0])])

def aceita(D,s):
    return executa(D,s) in D["F"] and valida(D,s)

def valida(D,s):
    return valida_aux(D,s,D["q0"])

def valida_aux(D,s,q):
    if s == "":
        if q in D["F"]: return True
        return False
    return valida_aux(D,s[1:],D["Delta"][(q,s[0])])

dfa0mult3 = { 'Q': {'IF', 'A', 'B'},
              'Sigma': {'0', '1'},
              'Delta': { ('IF', '0'): 'A',
                         ('IF', '1'): 'IF',
                         ('A', '0'): 'B',
                         ('A', '1'): 'A',
                         ('B', '0'): 'IF',
                         ('B', '1'): 'B' },
              'q0': 'IF',
              'F': {'IF'}
            }

print(valida(dfa0mult3,'101000'))






