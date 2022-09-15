#include <stdio.h>
#include <stdlib.h>

//1
int paresImpares (int v[], int N){
    int i=0,a=N-1;
    while(i<a){
        if(v[i]%2){
            int tmp = v[a];
            v[a] = v[i];
            v[i] = tmp;
            a--;
        }
        else i++;
    }
    return (v[i]%2) ? a : a+1;
}

//2
typedef struct lligada{
    int valor;
    struct lligada *prox;
} *LInt;

void merge (LInt *r, LInt a, LInt b){
    while(a && b){
        if(a->valor<=b->valor){ (*r)->valor=a->valor;a=a->prox;}
        else{ (*r)->valor=b->valor;b=b->prox;}
        r=&(*r)->prox;
    }
    if(a) *r=a;
    if(b) *r=b;
}

//3


//4
typedef struct nodo {
    int valor;
    struct nodo *pai, *esq, *dir;
} *ABin;

ABin next (ABin a){
    if(a->esq) return a->esq;
    if(a->dir) return a->dir;
    return NULL;
}

//5
typedef struct palavras {
    char *palavra;
    int nOcorr;
    struct palavras *esq, *dir;
} *Palavras;

int acrescentaPal (Palavras *p, char *pal){
    int n=0;
    if(!*p){
        *p = malloc(sizeof(struct palavras));
        (*p)->palavra = *pal;
        (*p)->nOcorr = 1;
        n=1;
        (*p)->esq=(*p)->dir=NULL;
    }
    else{
        if((*p)->palavra == *pal){
            n = (*p)->nOcorr++;
        }
        else n = 
    }
    return n;
}

int main()
{
    int v[] = {0,1,2,3,4,5,7,8,10};
    int i,N=9;
    printf("A lista original é: [");
    for(i=0;i<N-1;i++){
        printf("%i,",v[i]);
    }
    printf("%i]\n",v[i]);
    
    printf("Com a função paresImpares obtemos [");
    int x = paresImpares(v,N);
    for(i=0;i<N-1;i++){
        printf("%i,",v[i]);
    }
    printf("%i] com %i pares\n",v[i],x);
}
