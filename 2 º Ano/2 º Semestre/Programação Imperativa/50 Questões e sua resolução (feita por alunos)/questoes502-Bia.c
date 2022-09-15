#include <stdio.h>
#include <stdlib.h>

typedef struct lligada{
    int valor;
    struct lligada *prox;    // basicamente isto quer dizer que o primeiro elemento tem o endereço do 2º elemento e vice-versa
} *LInt;

// exercício 1:

LInt newLInt (int v, LInt t){     // acrescenta um número a uma lista, e ele fica como cabeça
    LInt new = (LInt) malloc (sizeof (struct lligada));
    if (new!=NULL) {
        new->valor = v;
        new->prox  = t;
    }
    return new;
}

int length(LInt l){
    //... completar
    int comprimento=0;
    while(l!=NULL){
        comprimento++;
        l = l->prox;
    }
    return comprimento;
}

// exercício 2

// A instrução free (ptr) avisa ao sistema que o bloco de bytes apontado por ptr está disponível para reciclagem

void freeL(LInt l){  
    LInt temp = NULL; 
    while(l!=NULL){
        temp = l->prox
        free(l);
        l=temp;
    } 
}

// exercício 3

// imprime no ecrã os elementos de uma lista (um por linha)

void imprimeL(LInt l){
    int i;
    while(l!=NULL){
        printf("%d\n",l->valor);
        l=l->prox;
    }
}

// exercício 4

//  inverte uma lista (sem criar uma nova lista).

LInt reverseL (LInt l){
    LInt temp=NULL;
    LInt aux=NULL;
    //... completar
    while(l!=NULL){
        temp = l->prox;
        l->prox = aux;
        aux = l;
        l = temp;
    }
    l = aux;
    return l;
}


// exercício 5

void insertOrd (LInt *l, int x){
    //... completar
    while((*l)!=NULL && (*l)->valor < x){    // isto é para irmos correr a lista até antes de colocarmos o elemento x
        l = &((*l)->prox);
    }
    LInt novalista = newLInt(x,*l);      // ao resto da lista inserimos o x como cabeça
}

// exercício 6

int removeOneOrd (LInt *l, int x){
    LInt temp;
    //... completar
    while((*l)!=NULL && (*l)->valor != x){     // estamos a percorrer a lista até encontrarmos o elemento x ou até a lista ser nula
        l = &((*l)->prox);
    }
    if((*l)==NULL) {return 1;}        // se o x não existir, então a lista que resta é nula e por isso devolvemos 1 segundo o enunciado.
    temp = (*l) -> prox;
    free(*l);
    *l = temp;    
    return 0;
}

// exercício 7

void merge (LInt *r, LInt l1, LInt l2){
    //... completar
    while((l1 != NULL) && (l2 != NULL)){
        if(l1->valor <= l2-> valor){
            *r = l1;
            l1 = l1->valor;
        }
        else {
            *r = l2;
            l2 = l2->prox;
        }
        r = &((*r)->prox);
    }
    if(l1==NULL) {*r=l2;}
    else {*r=l1;}
}

// exercício 8

void splitQS (LInt l, int x, LInt *mx, LInt *Mx){
    //... completar
    *mx = NULL;
    *Mx = NULL;
    while(l!=NULL){
        if((l->valor)<x){
            *mx = l;
            mx = &((*mx)->prox);
        }
        else{
            *Mx = l;
            Mx = &((*Mx)->prox);
        }
        l = l->prox;
    }
}

// exercício 9  -> pedir explicação a alguém 

       // versão do fábio
       
LInt parteAmeio (LInt *l){
    int mid = length(*l)/2;
    LInt y = *l; LInt* curr = &y;
    
    while(mid > 0){
        curr = &((*curr)->prox);
        mid--;
    }
    
    *l = *curr;
    *curr = NULL;
    return y;
}

// exercício 10

int removeAll (LInt *l, int x){
    //... completar
    int c=0;
    LInt temp = NULL;
    while((*l)!=NULL){
        if((*l)->valor == x){
            temp = (*l)->prox;
            free(*l);
            *l = temp;
            c++;
        }
        else{
            l = &((*l)->prox);
        }
    }
    return c;
}

// exercício 11 -> é suposto retornar o quê?

int removeDups (LInt *l){
    //... completar
    int c=0;
    while((*l)!=NULL){
        c+=removeAll(&(*l)->prox,(*l)->valor);
        l = &((*l)->valor);
    }
    return c;
}

// exercício 12

int maiorL(LInt *l){
    int max = 0;
    int temp = 0;
    while((*l)!=NULL){
        temp = (*l)->valor;
        if (temp>max) {max=temp;}
        else {l = &((*l)->prox);}
    }
    return max;
}

int removeMaiorL (LInt *l){
    LInt aux = NULL;
    int max = maiorL(*l);
    while(((*l)!=NULL)&&((*l)->valor != max)) {l=&((*l)->prox);}
    aux = (*l)->prox;
    free(*l);
    *l = aux;
    return max;
}

// exercício 13

void init (LInt *l){
    //... completar
    while((*l)->prox != NULL) {l = &(*l)->prox;}
    free(*l);
    *l = NULL;
}

// exercício 14

void appendL (LInt *l, int x){
    //... completar
    LInt novo = NULL;
    while((*l)!=NULL) {l=&((*l)->prox);}
    novo = newLInt(x,*l);
    *l = novo;
}

// exercício 15

void concatL (LInt *a, LInt b){
    //... completar
    LInt novo = NULL;
    int c=0;
    while((*a)!=NULL) {a = &((*a)->prox);}
    *a = b;
}

// exercício 16 -> ver com atenção

LInt cloneL (LInt l){
    LInt new = NULL;                  // nova lista de inteiros que eu vou retornar
    LInt* newAd = &new;               // tas a criar um apontador, que aponta para a lista new
    while (l!=NULL){
        *newAd = malloc(sizeof(struct lligada));    // vamos criar espaço para a nova lista
        (*newAd)->valor = l->valor;
        (*newAd)->prox = NULL;
        newAd = &(*newAd)->prox;
        l = l->prox;
    }
    return new;
}

// exercício 17

LInt cloneRev (LInt l){
    //... completar
    LInt new = NULL;   
    LInt temp=NULL;       
    LInt aux=NULL;                     
    if(l!=NULL){
        temp=l;
        while(temp!=NULL){
            aux = malloc(sizeof(struct lligada));
            aux->valor = temp->valor;
            aux->prox = new;
            new = aux;
        }
    }
    return new;
}

// exercício 18

int maximo (LInt l){
    int max = 0;
    int temp = 0;
    while(l){
        temp = (l)->valor;
        if (temp>max) {max=temp;}
        else {l = l->prox;}
    }
    return max;
}

// exercício 19

int take (int n, LInt *l){
    //... completar
    int comprimento=0;
    while((*l)!=NULL && n>0){
        l = &((*l)->prox);
        n--;
        comprimento++;
    }
    freeL(*l);        // libertar o espaço do que sobra
    *l=NULL;           // apagar todos os elementos que sobram
    return comprimento;
}

// exercício 20

int drop (int n, LInt *l){
    //... completar
    int removidos = 0;
    LInt temp = NULL;
    while((*l)!=NULL && n>0){
        temp = (*l)->prox;
        free(*l);
        *l=temp;
        n--;
        removidos++;

    }
    return removidos;
}

// exercício 21

LInt NForward (LInt l, int N){
    //... completar
    while(N>0){
        l = l->prox;
        N--;
    }
    return l;
}

// exercício 22

int listToArray (LInt l, int v[], int N){
    //... completar
    int i;
    int preenchidos=0;
    for(i=0;i<N && l!=NULL;i++){
        v[i] = l->valor;
        preenchidos++;
        l = l->prox;
    }
    return preenchidos;
}

// exercício 23

LInt arrayToList (int v[], int N){
    //... completar
    int i;
    LInt l = NULL;
    LInt* aux = &l
    for(i=0;i<N;i++,aux=&((*aux)->prox)){
        *aux = malloc(sizeof(struct lligada));
        (*aux)->valor = v[i];
        (*aux)->prox = NULL;
    }
    return l;
}

// exercício 24  -> só me dá bem para dois testes

LInt somasAcL (LInt l) {
    
    LInt nova = NULL;
    LInt *p = &nova;
    int soma = 0;
    
    while(l!=NULL){ 
        
        soma += l->valor;
        *p = newLInt(soma,NULL);
        p = &((*p)->prox);
        l = l->prox;
        
    }
    
    return nova;
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



// exercício 25

void remreps (LInt l){
    //... completar
    int recorrente;
    if(l!=NULL){
        recorrente = l->valor;
        LInt* aux = &(l->prox);
        while((*aux)!=NULL){
            if((*aux)->valor == recorrente){
            LInt temp = (*aux)->prox;
            free(*aux);
            *aux= temp;
            }
            else{
                recorrente=(*aux)->valor;
                aux = &(*aux)->prox;
            }
        }
    }

}

// exercício 26

LInt rotateL (LInt l){
    //... completar
    if(l!=NULL && (l->prox)!=NULL){
        LInt* aux = &l;
        while(*aux) {aux = &((*aux)->prox);}
        LInt temp = l->prox;
        l->prox = NULL;
        *aux = l;
        l = temp;
    }
    return l;
}

// exercício 27

LInt parte (LInt l){
    //... completar
    LInt par = NULL;
    LInt* paraux = &par;
    LInt impar = l;
    LInt* imparaux = &l;
    if (l!=NULL){
        int i = 1; 
        imparaux = &(*imparaux)->prox;
        l = l->prox;
        while(l!=NULL){
            if(i % 2 == 0){      // se a posição for par
                *imparaux = l;
                imparaux = &(*imparaux)->prox;
            }else{
                *paraux = l;
                paraux = &(*paraux)->prox;
            }
            l = l->prox;
            i++;                  
        }
        *imparaux = *paraux = NULL;
    }

    return par;
}

