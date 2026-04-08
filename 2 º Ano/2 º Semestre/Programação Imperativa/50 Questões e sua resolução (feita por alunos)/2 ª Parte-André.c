#include "abin.h"
#include "listas.h"
#include <stdio.h>
#include <stdlib.h>

ABin newABin (int r, ABin e, ABin d){
	ABin new = (ABin) malloc (sizeof (struct nodo));

	if (new!=NULL){
		new->valor = r;
		new->esq   = e;
		new->dir   = d;
	}
	return new;
}

//28
int altura (ABin a){
    if(!a) return 0;
    int esq = altura(a->esq);
    int dir = altura(a->dir);
    if(esq>dir) return 1+esq;
    return 1+dir;
}

//29
ABin cloneAB (ABin a) {
    ABin new = NULL;
    if(a){
        new = malloc(sizeof(struct nodo));
        new->valor = a->valor;
        new->esq = cloneAB(a->esq);
        new->dir = cloneAB(a->dir);
    }
    return new;
}

//30
void mirror (ABin *a) {
    if(*a){
        mirror(&(*a)->esq);
        mirror(&(*a)->dir);
        ABin temp = (*a)->esq;
        (*a)->esq = (*a)->dir;
        (*a)->dir = temp;
    }
}

//31
void inorderaux (ABin a, LInt * l) {
    if(a){
        inorderaux(a->dir,l);
        LInt new = (LInt) malloc(sizeof(struct lligada));
        new->valor = a->valor;
        new->prox = *l;
        *l = new;
        inorderaux(a->esq,l);
    }
}

void inorder(ABin a,LInt *l){
    *l = NULL;
    inorderaux(a,l);
}

//32
void preorderAux (ABin a, LInt *l){
    if(a){
        preorderAux(a->dir,l);
        preorderAux(a->esq,l);
        LInt new = (LInt) malloc(sizeof(struct lligada));
        new->valor = a->valor;
        new->prox = *l;
        *l = new;
    }
}
void preorder (ABin a, LInt *l){
    *l = NULL;
    preorderAux(a,l);
}

//33
void posorderaux (ABin a, LInt * l) {
    if(a){
        LInt new = (LInt) malloc(sizeof(struct lligada));
        new->valor = a->valor;
        new->prox = *l;
        *l = new;
        posorderaux(a->dir,l);
        posorderaux(a->esq,l);
    }
}

void posorder (ABin a, LInt * l) {
    *l = NULL;
    posorderaux(a,l);
}

//34
int min(int a, int b){
    return (a<b) ? a : b;
}

int depth (ABin a, int x) {
    if(!a) return -1;
    if(a->valor == x) return 1;
    int esq = depth(a->esq,x);
    int dir = depth(a->dir,x);
    if(esq == -1 && dir == -1) return -1;
    if(dir == -1 ) return 1 + esq;
    if(esq == -1) return 1 + dir;
    return 1 + min(esq,dir);
}

//35
int freeAB (ABin a) {
    if(!a) return 0;
    free(a);
    return 1 + freeAB(a->esq) + freeAB(a->dir);
}

//36
int pruneAB (ABin *a, int l) {
    if(!*a) return 0;
    if(!l){
        int c = freeAB(*a);
        *a = NULL;
        return c;
    }
    return pruneAB(&(*a)->esq,l-1)+pruneAB(&(*a)->dir,l-1);
}

//37
int iguaisAB (ABin a, ABin b) {
    if(!a && !b) return 1;
    if(!a || !b) return 0;
    if(a->valor == b->valor) return iguaisAB(a->esq,b->esq) && iguaisAB(a->dir,b->dir);
    return 0;
}

//38
void nivelaux(ABin a, int n, LInt *l){
    if(!a) return;
    if(n){
        nivelaux(a->dir,n-1,l);
        nivelaux(a->esq,n-1,l);
    }
    else{
        LInt new = malloc(sizeof(struct lligada));
        new->valor=a->valor;
        new->prox=*l;
        *l=new;
    }
}

LInt nivelL (ABin a, int n) {
    LInt l = NULL;
    if(n) nivelaux(a,n-1,&l);
    return l;
}

//39
int nivelV(ABin a, int n, int v[]){
    if(!a || !n) return 0;
    if(n>1){
        int l = nivelV(a->esq,n-1,v);
        return l+nivelV(a->dir,n-1,v+l);
    }
    else{
        v[0]=a->valor;
        return 1;
    }
}

//40
int dumpAbin (ABin a, int v[], int N) {
    if(!a || !N) return 0;
    int e = dumpAbin(a->esq, v, N);
    if(e < N){
        v[e] = a->valor;
        return 1 + e + dumpAbin(a->dir, v+e+1, N-e-1);
    }
    return N;
}

//41 - dá erro
ABin somasAcA (ABin a) {
    if(!a) return a;
    if(a->esq && a->dir) a->valor += somasAcA(a->esq)->valor + somasAcA(a->dir)->valor;
    else if(a->esq) a->valor += somasAcA(a->esq)->valor;
    else if(a->dir) a->valor += somasAcA(a->dir)->valor;
    return a;
}

//42
int contaFolhas (ABin a) {
    if(!a) return 0;
    if(!a->esq && !a->dir) return 1;
    return contaFolhas(a->esq)+contaFolhas(a->dir);
}

//43
ABin cloneMirror (ABin a) {
    if(!a) return NULL;
    ABin new = malloc(sizeof(struct nodo));
    new->valor = a->valor;
    new->esq = cloneMirror(a->dir);
    new->dir = cloneMirror(a->esq);
    return new;
}

//44
int addOrd (ABin *a, int x) {
    while(*a){
        if((*a)->valor == x) return 1;
        if((*a)->valor > x) a=&(*a)->esq;
        else a=&(*a)->dir;
    }
    ABin new = malloc(sizeof(struct nodo));
    new-> valor = x;
    new->esq=new->dir=NULL;
    *a=new;
    return 0;
}

//45
int lookupAB (ABin a, int x) {
    while(a){
        if(a->valor == x) return 1;
        if(a->valor > x) a=a->esq;
        else a=a->dir;
    }
    return 0;
}

//46
int depthOrd (ABin a, int x) {
    int r=1;
    while(a){
        if(a->valor == x) return r;
        if(a->valor > x) a=a->esq;
        else a=a->dir;
        r++;
    }
    return -1;
}

//47
int maiorAB (ABin a) {
    while(a->dir) a=a->dir;
    return a->valor;
}

//48
void removeMaiorA (ABin *a) {
    while((*a)->dir) a=&(*a)->dir;
    ABin tmp = (*a)->esq;
    free(*a);
    *a=tmp;
}

//49
int quantosMaiores (ABin a, int x) {
    if(!a) return 0;
    if(x<a->valor) return 1 + quantosMaiores(a->esq,x) + quantosMaiores(a->dir,x);
    return quantosMaiores(a->dir,x);
}

//50
//CAGUEI

//51
int allLess (ABin a, int x){
    if(!a) return 1;
    return (x > a->valor) && allLess(a->dir,x) && allLess(a->esq,x);
}

int allMore (ABin a, int x){
    if(!a) return 1;
    return (x < a->valor) && allMore(a->dir,x) && allMore(a->esq,x);
}

int deProcura (ABin a){
    if(!a) return 1;
    return allMore(a->dir,a->valor) && allLess(a->esq,a->valor) && deProcura(a->dir) && deProcura(a->esq);
}
#include <stdio.h>
#include <stdlib.h>
#include "listas.h"

LInt newLInt (int v, LInt t){
    LInt new = (LInt) malloc (sizeof (struct lligada));
    
    if (new!=NULL) {
        new->valor = v;
        new->prox  = t;
    }
    return new;
}

int length (LInt l){
    int r;
    while(l){
        r++;
        l=l->prox;
    }
    return r;
}

void freeL (LInt l){
    LInt temp;
    while(l){
        temp=l->prox;
        free(l);
        l=temp;
    }
}

void imprimeL (LInt l){
    while(l){
        printf("%d\n",l->valor);
        l=l->prox;
    }
}

void insertOrd (LInt *l, int x){
    while(*l && (*l)->valor < x){
        l = &((*l)->prox);
    }
    *l = newLInt(x, *l);
}

int removeOneOrd (LInt *l, int x){
    for(;*l && (*l)->valor != x; l=&((*l)->prox));
    if(*l==NULL) return 1;
    LInt tmp=(*l)->prox;
    free(*l);
    *l=tmp;
    return 0;
}

void merge (LInt *r, LInt l1, LInt l2){
    while(l1!=NULL && l2!=NULL){
        if(l1->valor <= l2->valor) {*r=l1; l1=l1->prox;}
        else {*r=l2;l2=l2->prox;}
        r=&((*r)->prox);
    }
    if(l1==NULL) *r=l2;
    else *r=l1;
}

void splitQS (LInt l, int x, LInt *mx, LInt *Mx){
    while(l){
        if(l->valor < x) {*mx=l;mx=&((*mx)->prox);}
        else {*Mx=l;Mx=&((*Mx)->prox);}
        l=l->prox;
    }
    *mx=NULL;
    *Mx=NULL;
}

LInt parteAmeio (LInt *l){
    int mid = length(*l)/2;
    LInt y = *l;
    LInt x = *l;
    if(!mid) return NULL;
    while(mid > 0){
        x = x->prox;
        mid--;
    }
    *l = x;
    x = NULL;
    return y;
}

int removeAll (LInt *l, int x){
    int c=0;
    while(*l){
        if((*l)->valor == x) {
            c++;
            LInt tmp=(*l)->prox;
            free(*l);
            *l=tmp;
        }
        else l=&((*l)->prox);
    }
    return c;
}

int removeDups (LInt *l){
    while(*l){
        removeAll(&(*l)->prox,(*l)->valor);
        l=&((*l)->prox);
    }
    return -1;
}

int maximo(LInt l){
    int max = (l)->valor;
    l=(l)->prox;
    for(;l;l=(l)->prox){
        if((l)->valor>max){
            max=(l)->valor;
        }
    }
    return max;
}

int removeMaiorL (LInt *l){
    int max = maximo(*l);
    for(;*l;l=&(*l)->prox){
        if((*l)->valor==max) {
            LInt tmp=(*l)->prox;
            free(*l);
            *l=tmp;
        }
    }
    return max;
}

void init (LInt *l){
    if(*l==NULL);
    else{ 
        while((*l)->prox != NULL) l=&(*l)->prox;
        free(*l);
        *l=NULL;
    }
}

void appendL (LInt *l, int x){
    while(*l!=NULL) l=&(*l)->prox;
    *l=newLInt(x,NULL);
}

void concatL (LInt *a, LInt b){
    while(*a!=NULL) a=&(*a)->prox;
    *a=b;
}

LInt cloneL (LInt l){
    LInt clone=NULL;
    LInt *end= &clone;
    for(;l;l=l->prox){
        *end=newLInt(l->valor,NULL);
        *end=(*end)->prox;
    }
    return clone;
} 

LInt cloneRev (LInt l){
    LInt clone = NULL;
    if(l){
        LInt aux = l;
        for(; aux; aux = aux->prox){
            clone = newLInt(aux->valor,clone);
        }
    }
    return clone;
}

int take (int n, LInt *l){
    int len=length(*l);
    if(n>=len) return len;
    len=n;
    while(n>0){
        l=&(*l)->prox;
        n--;
    }
    while(*l){
        LInt tmp=(*l)->prox;
        free(*l);
        *l=tmp;
    }
    return len;
}

int drop (int n, LInt *l){
    int c=0;
    while(n && *l){
        LInt tmp=(*l)->prox;
        free(*l);
        *l=tmp;
        n--;
        c++;
    }
    return c;
}

LInt NForward (LInt l, int N){
    while(N){
        l=l->prox;
        N--;
    }
    return l;
}

int listToArray (LInt l, int v[], int N){
    int i=0;
    while(N && l){
        v[i++]=l->valor;
        l=l->prox;
        N--;
    }
    return i;
}

LInt arrayToList (int v[], int N){
    int i;
    LInt l= NULL;
    LInt *e=&l;
    for(i=0;i<N;i++){
        *e=newLInt(v[i],NULL);
        e=&(*e)->prox;
    }
    return l;
}

LInt somasAcL (LInt l) {
    LInt new = NULL;
    LInt *e=&new;
    int c=0;
    while(l){
        c+=l->valor;
        *e=newLInt(c,NULL);
        e=&(*e)->prox;
        l=l->prox;
    }
    return new;
}

void remreps (LInt l){
    while(l){
        int x=l->valor;
        LInt *e=&(l->prox);
        while(*e){
            if((*e)->valor==x){
                LInt tmp=(*e)->prox;
                free(*e);
                *e=tmp;
            }
            else e=&(*e)->prox;
        }
        l=l->prox;
    }
}

LInt rotateL (LInt l){
    LInt *e = &l;
    if(l && l->prox){
        while(*e){
            e=&(*e)->prox;
        }
        LInt tmp = l->prox;
        l->prox=NULL;
        *e=l;
        l=tmp;
    }
    return l;
}

LInt parte (LInt l){
    LInt y = NULL; 
    LInt *ey = &y;
    LInt *el = &l;
    
    if(l){
        int i = 1;
        el = &(*el)->prox;
        l = l->prox;
        
        while(l){
            if(i % 2 == 0){
                *el = l;
                el = &(*el)->prox;
            }else{
                *ey = l;
                ey = &(*ey)->prox;
            }
            l = l->prox;
            i++;
        }
        *el = *ey = NULL;
    }
    return y;
}