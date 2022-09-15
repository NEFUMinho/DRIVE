/* Main function of the C program. */

#include <stdio.h>
#include <stdlib.h>

int sumhtpo (int n) {
    int r = 0;
    while (n != 1) {
        r += n;
        if (n%2 == 0) n = n/2; else n = 1+(3*n);
    }
    return r;
}

//2
int moda(int v[], int N, int *m){
    int a[N],b[N];
    int n=0,i,j;
    for(i=0;i<N;i++){
        for(j=0;j<n;j++){
            if(v[i]==a[j]) b[j]++;
        }
        if(j==n){
            a[j] = v[i];
            b[j] = 1;
            n++;
        }
    }
    int max=0;
    for(j=0;j<n;j++){
        if(b[j]>max){ max=b[j]; *m=a[j];}
        if(b[j]==0) return 0;
    }
    return max;
}

typedef struct lligada {
    int valor;
    struct lligada *prox;
} *LInt;

//3
int procura (LInt *l, int x){
    LInt *end = &(*l);
    for(;*l;l=&(*l)->prox){
        if((*l)->valor==x){
            LInt tmp = *l;
            *l= (*l)->prox;
            tmp->prox = *end;
            *end=tmp;
            return 1;
        }
    }
    return 0;
}

//4
typedef struct nodo {
    int valor;
    struct nodo *pai, *esq, *dir;
} *ABin;

int freeAB(ABin a){
    if(!a) return 0;
    int r= 1 +freeAB(a->esq)+freeAB(a->dir);
    free(a);
    return r;
}

//5
void caminho(ABin a){
    if(a->pai){
        caminho(a->pai);
        if(a=(a->pai)->esq) printf("esq\n");
        else printf("dir\n");
    }
}

LInt newLInt (int v, LInt t){
    LInt new = (LInt) malloc (sizeof (struct lligada));
    
    if (new!=NULL) {
        new->valor = v;
        new->prox  = t;
    }
    return new;
}

int main(){
    int l[10] = {1,2,3,4,2,3,5,3,4,3};
    int c;
    int r = moda(l,10,&c);
    printf("A moda é %i e a frequência é %i\n",c,r);
    
    LInt x = newLInt(1,NULL);
    LInt y = x;
    int i,N=8;
    for(i=2;i<N;i++){
        x->prox=newLInt(i,NULL);
        x=x->prox;
    }
    LInt a = y;
    while(a){
        printf("%i",a->valor);
        a=a->prox;
    }
    
    printf("\n%i\n",procura(&y,3));
    a=y;
    for(;a;a=a->prox){
        printf("%i",a->valor);
    }
}
