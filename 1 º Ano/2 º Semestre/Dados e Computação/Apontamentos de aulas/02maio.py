def generate(sigma,n):
    if n == 0: return set({""})
    rec = generate(sigma,n-1)
    new = {c+sigma for c in sigma for s in rec if len(s)== n-1}
    return new | rec

s= generate({'a','b','c','d'})
print(s)
print(len(s)== 3**4 + 3**3 + 3**2 + 3**1 + 3**0)

#REPRESENTAÇÃO DE AUTOMATO- permite dizer se pertence ou nao a uma linguagem

dfa0mult3={'Q': {'IF','A','B'},
           'Sigma': {'0','1'},
           'Delta': {('IF', '0'): 'A',
                     ('IF', '1'): 'IF',
                     ('A', '0'): 'B',
                     ('A', '1'): 'A',
                     ('B', '0'): 'IF',
                     ('B', '1'): 'B'},
            'q0': 'IF',
            'F': {'IF'}}

#um automato consistente é parcialmente consistente e o dominio da funcao delta(conjunto de todas as chaves) tem de conter todas as hipoteses
#os automatos normalmente sao desenhados em grafos
#estados finais sao bolinhas com dois circulos
#estado inicial é uma seta no circulo(o graphviz nao faz mas podemos fazer um nó invisivel(nao desenhado) para por uma seta para o estado inicial)
#VER LAB11
