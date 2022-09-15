#include "abin.h"



ABin newABin (int r, ABin e, ABin d) {
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

void freeABin(ABin a){
    if((a)->esq) {
        freeABin((a)->dir);
        free(a);
    }
    else if((a)->dir){
        freeABin((a)->esq);
        free(a);
    }
    else free(a);
}

void dumpABin(ABin a,int N){
    int i=N;
    while(N){
        imprimeNivel(a,i-N);
        printf("\n");
        N--;
    }
}

int altura (ABin a){
    int ae, ad;
    if(a==NULL) return 0;
    ae=altura(a->esq);
    ad=altura(a->dir);
    return 1+(ae>ad ? ae : ad);
}

int nFolhas (ABin a){
    if(a==NULL) return 0;
    if(a->esq==NULL && a->dir==NULL) return 1;
    return nFolhas(a->esq)+nFolhas(a->dir);
}

ABin maisEsquerda (ABin a){
    if(a==NULL || a->esq==NULL) {return a;}
    return maisEsquerda(a->esq);
}

/*Versão Iterativa:
ABin maisEsquerda(ABin a){
    while(a && a->esq) a=a->esq;
    return a;
}
*/
void imprimeNivel (ABin a, int l){
    if(a){
        if(!l) printf("%d ",a->valor);
        else {
            imprimeNivel(a->esq,l-1);
            imprimeNivel(a->dir,l-1);
        }
    }
}

int procuraE (ABin a, int x){
    if(!a) return 0;
    return a->valor==x || procuraE(a->esq,x) || procura(a->dir,x);
}

struct nodo *procura (ABin a, int x){
    if(!a || a->valor==x) return a;
    if(x<a->valor) return 
    return NULL;
}

int nivel (ABin a, int x){
    return (-1);
}

void imprimeAte (ABin a, int x){
    
}
