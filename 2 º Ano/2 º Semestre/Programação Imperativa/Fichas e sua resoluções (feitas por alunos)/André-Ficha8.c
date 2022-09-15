#include <stdio.h>
#include <stdlib.h>
#include "Deque.h"


void initDeque (Deque *q){
    q->front=q->back=NULL;
}

int DisEmpty (Deque q){
    return q.front==NULL;
}
int pushBack (Deque *q, int x){
    DList new = malloc(sizeof(struct dlist));
    new->valor=x;
    new->prox=NULL;
    if(DisEmpty(*q)){
        new->ant=NULL;
        q->front=q->back=new;
    } else {
        new->ant=q->back;
        q->back->prox=new;
        q->back=new;
    }
    return 0;
}
int pushFront (Deque *q, int x){
    DList new = malloc(sizeof(struct dlist));
    new->valor=x;
    new->ant=NULL;
    if(DisEmpty(*q)){
        new->prox=NULL;
        q->front=q->back=new;
    } else {
        new->prox=q->front;
        q->front->ant=new;
        q->front=new;
    }
    return 0;
}
int popBack (Deque *q, int *x){
    return -1;
}
int popFront (Deque *q, int *x){
    if(DisEmpty(*q)) return 1;
    *x=q->front->valor;
    if(q->front==q->back){ //Caso em que só tem 1 elemento
        free(q->front);
        q->front=q->back=NULL;
    } else {
        Deque tmp = q->front->prox;
        free(q->front);
        tmp->ant=NULL;
        q->front=tmp;
    }
    return 0;
}
int popMax (Deque *q, int *x){
    return -1;
}
int back (Deque q, int *x){
    return -1;
}
int front (Deque q, int *x){
    return -1;
}
#include <stdio.h>
#include <stdlib.h>
#include "Listas.h"

LInt newLInt (int x, LInt xs){
    LInt r = malloc (sizeof(struct slist));
    if (r!=NULL) {
        r->valor = x; r->prox = xs;
    }
    return r;
}

DList newDList (int x, DList xs){
    DList r = malloc (sizeof(struct dlist));
    if (r!=NULL) {
        r->valor = x; r->prox = xs; r->ant = NULL;
    }
    return r;
}
#include <stdio.h>
#include <stdlib.h>
#include "Queue.h"

void initQueue (Queue *q){
    q->inicio=q->fim=NULL;
}
int QisEmpty (Queue q){
    return q.inicio==NULL;
}
int enqueue (Queue *q, int x){
    if(QisEmpty(*q)) q->inicio=q->fim=newLInt(x,NULL);
    else {
        q->fim->prox=newLInt(x,NULL);
        q->fim=q->fim->prox;
    }
    return 0;
}
int dequeue (Queue *q, int *x){
    if(!QisEmpty(*q)){
        LInt tail = q->inicio->prox;
        *x=q->inicio->valor;
        free(q->inicio);
        q->inicio=tail;
        return 0;
    }
    return 1;
}
int frontQ (Queue q, int *x){
    if(!QisEmpty(q)){
        *x=q.inicio->valor;
        return 0;
    }
    return 1;
}

typedef LInt QueueC;

void initQueueC (QueueC *q){
    *q=NULL;
}
int QisEmptyC (QueueC q){
    return q==NULL;
}
int enqueueC (QueueC *q, int x){
    LInt new = newLInt(x,NULL);
    if(QisEmptyC(*q)){
        new->prox=new;
        *q=new;
    } else {
        new->prox=(*q)->prox;
        (*q)->prox=new;
        *q=new;
    }
    return 0;
}
int dequeueC (QueueC *q, int *x){
    if(QisEmptyC(*q)) {return 1;}
    if((*q)->prox==*q){
        *x=(*q)->valor;
        free(*q);
        *q=NULL;
    } else {
        LInt tmp=(*q)->prox;
        *x=tmp->valor;
        (*q)->prox=tmp->prox;
        free(tmp);
    }
    return 0;
}
int frontC (QueueC q, int *x){
    if(QisEmptyC(q)) return 1;
    *x=q->valor;
    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"

void initStack (Stack *s){
    *s=NULL;
}
int SisEmpty (Stack s){
    return s==NULL;
}
int push (Stack *s, int x){
    *s = newLInt(x,*s);
    return 0;
}
int pop (Stack *s, int *x){
    if(SisEmpty(*s)) return 1;
    LInt tail = (*s)->prox;
    *x=(*s)->valor;
    free(*s);
    *s=tail;
    return 0;
}
int top (Stack s, int *x){
    if(SisEmpty(s)) return 1;
    *x = s->valor;
    return 0;
}
