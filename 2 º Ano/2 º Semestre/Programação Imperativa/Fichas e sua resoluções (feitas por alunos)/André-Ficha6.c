#include <stdio.h>
#include <stdlib.h>
#include "Queue.h"

// Static queues 

void SinitQueue (SQueue q){
	q->front = q->length = 0;
}

int  SisEmptyQ (SQueue q){
	return q->length==0;
}

int  Senqueue (SQueue q, int x){
	if(q->length>=Max) return 1;
	q->values[(q->front + q->length)%Max]=x;
	q->length++;
	return 0;
}

int  Sdequeue (SQueue q, int *x) {
	if(q->length==0) return 1;
	*x = q->values[q->front];
	q->front++;
	if(q->front>=Max) q->front=0;
	q->length--;
	return 0;
}

int  Sfront (SQueue q, int *x) {
	if(q->length==0) return 1;
	*x = q->values[q->front];
	return 0;
}

void ShowSQueue (SQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%Max;
    }
    putchar ('\n');
}

// Queues with dynamic arrays

int dupQueue (DQueue q) {
	int r = 0, i;
	int *t = malloc (2*q->size*sizeof(int));

	if (t == NULL) r = 1;
	else {
		for (i=0; i<q->size; i++) 
			t[i] = q->values[q->front + i];
		free (q->values);
		q->values = t;
		q->size*=2;
	}
	return r;
}

void DinitQueue (DQueue q) {
	q->front = 10;
	q->length = 0;
	q->size=16;
	q->values=malloc(16*sizeof(int));
}

int  DisEmptyQ (DQueue s) {
	return (-1);
}

int  Denqueue (DQueue q, int x){
    if(q->length>=q->size) {
        int *new=malloc(2*q->size*sizeof(int));
        int i;
        for(i=0;i<q->size;i++) new[i]=q->values[(q->front + i)%q->size];
        free(q->values);
        q->values=new;
        q->size*=2;
        q->front=0;
    }
    q->values[(q->front + q->length)%q->size]=x;
    q->length++;
	return 0;
}

int  Ddequeue (DQueue q, int *x){
	if(q->length == 0) return 1;
	*x = q->values[q->front++];
	q->length--;
	q->front %= q->size;
	return 0;
}

int  Dfront (DQueue q, int *x){
	if(q->length == 0) return 1;
	*x = q->values[q->front];
	return 0;
}

void ShowDQueue (DQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%q->size;
    }
    putchar ('\n');
}
#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"

// Static stacks 

void SinitStack (SStack s){
	s->sp=0;
}

int  SisEmpty (SStack s){
	return s->sp==0;
}

int  Spush (SStack s, int x){
	if(s->sp>=Max) return 1;
	s->values[s->sp++]=x;
	return 0;
}

int  Spop (SStack s, int *x) {
	if(s->sp==0) return 1;
	*x = s->values[--s->sp];
	return 0;
}

int  Stop (SStack s, int *x) {
	if(s->sp==0) return 1;
	*x = s-> values[s->sp-1];
	return 0;
}

void ShowSStack (SStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}

// Stacks with dynamic arrays

int dupStack (DStack s) {
	int r = 0, i;
	int *t = malloc (2*s->size*sizeof(int));

	if (t == NULL) r = 1;
	else {
		for (i=0; i<s->size; i++) 
			t[i] = s->values[i];
		free (s->values);
		s->values = t;
		s->size*=2;
	}
	return r;
}

void DinitStack (DStack s) {
	s->sp=0;
	s->size=16;
	s->values=malloc(16*sizeof(int));
}

int  DisEmpty (DStack s) {
	return s->sp==0;
}

int  Dpush (DStack s, int x){
	int r=0;
	if(s->sp>=s->size) r=dupStack(s);
	s->values[s->sp++]=x;
	return r;
}

int  Dpop (DStack s, int *x){
	int r=0;
	
	return r;
}

int  Dtop (DStack s, int *x){
	int r=0;
	
	return r;
}

void ShowDStack (DStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}