#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {   // tipo para o nó das arvores
    int valor;
    struct nodo *esq, *dir;    // a diferença com as listas é que tem 2 nodos, enquanto as listas só têm 1
} * ABin;

ABin newABin (int r, ABin e, ABin d) {     // esta função é equivalente ao newLInt -> mas esta aloca o número na raiz da arvore (adiciona um nodo à arvore)
   ABin a = malloc (sizeof(struct nodo));
   if (a!=NULL) {
      a->valor = r; a->esq = e; a->dir = d;
   }
   return a;
}

ABin RandArvFromArray (int v[], int N) {
   ABin a = NULL;
    int m;
    if (N > 0){
    	m = rand() % N;
    	a = newABin (v[m], RandArvFromArray (v,m), RandArvFromArray (v+m+1,N-m-1));
    }
    return a;	
}

// exercício 1  -> árvores em geral

    // alínea a)   -> pede a altura de uma arvore binária (é o caminho desde a raiz até à folha mais distante)
// como folha dizemos que são aqueles que não têm sub-árvores!!!!
int altura (ABin a){   // -> vai nos dizer o pior quase quando queremos procurar um elemento
    // a árvore é um tipo recursivo -> temos um caso base e depois aplicamos um caso base.
    int ae,ad;
    if(a==NULL) {return 0;}
    ae = altura(a->esq);  // altura da árvore esquerda
    ad = altura(a->dir);  // altura da árvore direita
    return  1+(ae>ad?ae:ad);    // if then else
}

    // alínea b) -> diz o número de folhas
int nFolhas (ABin a){
    if (a==NULL) return 0;
    if (a->esq==NULL && a->dir==NULL){return 1;}
    return nfolhas(a->esq)+nFolhas(a->dir);
}

    // alínea c) -> queremos o nodo mais à esquerda das sub-árvores
// podemos fazer iterativamente porque só queremos aceder a uma sub-arvore e não percorrer a árvore toda
ABin maisEsquerda (ABin a){   // -> versão recursiva
    if (a==NULL || a->esq==NULL) {return a;}
    return maisEsquerda(a->esq);
}

ABin maisEsquerda2 (ABin a){   // -> versão iterativa
    while(a!=NULL && a->esq != NULL) {a=a->esq};
    return a;
}

    // alínea d)

void imprimeNivel (ABin a, int l){
   // if(a==NULL) {return;}      // como é void não tenho que retornada nada -> mas também podemos fazer como está em baixo
   if(a!=NULL){
       if(l==0) {printf("%d",a->valor);}
       else {imprimeNivel(a->esq,l-1);
             imprimeNivel(a->dir,l-1);}
   }
}
    // alínea e)
int procuraE (ABin a, int x){
    if(a==NULL) {return 0;}
    return {a->valor==x || procuraE(a->esq,x) || procuraE(a->dir,x);}
}

// exercício 2   -> são sobre árvores binárias de procura

    // alínea f)
ABin procura (ABin a, int x){      // -> versão recursiva
    if(a==NULL || a->valor==x) {return a;}
    if(x<a->valor) {return procura(a->esq,x);}
    else {return procura(a->dir,x);}
}

ABin procura (ABin a, int x){      // -> versão iterativa
    while(a!=NULL &&a->valor!=x){
        if(x<a->valor) a=a->esq;
        else {a=a->dir;}
    }
    return a;
}
    // alínea g)
int nivel (ABin a, int x){
    int l=0;
    while(a!=NUL && a->valor!=x){
        if(a<a->valor) {a=a->esq;}
        else {a=a->dir;}
        l++;
    }
    if(a==NULL) {l=-1;}
    return l;
}

    // alínea h)

void inorder(ABin a){  // -> está a imprimir todos os elementos da lista de forma ordenada 
    if(a!=NULL){
        inorder(a->esq);
        printf("%d",a->vetor);
        inorder(a->dir);
    }
}
  
void imprimeAte (ABin a, int x){    // -> vai apenas imprimir os elementos de forma ordenada até ao elemento x
    if(a!=NULL){
        imprimeAte(a->esq,x);
        if(a->valor < x){
            printf("%d",a->vetor);
            imprimeAte(a->dir,x);
        }
    }
}

