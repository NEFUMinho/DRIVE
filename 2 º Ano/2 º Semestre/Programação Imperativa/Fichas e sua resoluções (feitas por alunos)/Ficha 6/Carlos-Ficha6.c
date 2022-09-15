#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structs.h"

#define Max 10

//////////////FUNÇOES AUXILIARES(DADAS PELO STOR) /////////////////

void ShowSQueue (SQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%Max;
    }
    putchar ('\n');
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

void ShowSStack (SStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}

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

void ShowDStack (DStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}

/////////////////////////////////////////////////


/////MEMÓRIA ESTÁTICA /////

//STACKS!!!!

//(a)
void SinitStack (SStack s) {
    s->sp=0;
    //(*s).sp=0;
}

//(b)
int SisEmpty (SStack s) {
    return (s->sp == 0);
}

//(c)
int Spush (SStack s, int x) {
    if (s->sp >= Max) return 1;
    s->values[s->sp++] = x;
    return 0;
}

//(d)
int Spop (SStack s, int *x) {
    if (s->sp==0) return 1;
    *x = s->values[s->sp-1];
    s->sp--;
    return 0;
}

//(e)
int Stop (SStack s, int *x) {
    if (s->sp == 0) return 1;
    *x = s-> values[s->sp-1];
    return 0;
}


//QUEUES!!!!

//(a)
void SinitQueue (SQueue q) {
    q->front=0;
    q->length=0;
}

//(b)
int SisEmptyQ (SQueue q) {
    return (q->length == 0);
}

//(c)
int Senqueue (SQueue q, int x) {
    if(q->length >= Max) return 1;
    q->values[ ((q->front) + (q->length)) % Max ] = x;
    q->length++;
    return 0;
}

//(d)
int Sdequeue (SQueue q, int *x) {
    if (q->length==0) return 1;
    *x = q->values[q->front];
    q->front++;
    if(q->front >= Max) q->front=0;
    q->length--;
    return 0;
}

//(e)
int Sfront(SQueue q, int *x){
    if (SisEmptyQ(q)) return 1;
    *x = q->values[q->front];
    return 0;
}

///// MEMÓRIA DINÂMICA /////

//QUEUES DINÂMICAS

//(a)
void DinitQueue (DQueue q) {
    q->front = q->length=0;
    q->size=16;
    q->values = malloc(16*sizeof(int));
}

//(c)
int Denqueue (DQueue q, int x) {
    if (q->length >=q->size) {
        int *new = malloc(2*(q->size)*sizeof(int));
        int i;
        for(i=0;i<q->size;i++) {
            new[i] = q->values[(q->front + i)%q->size];   
        }
        free(q->values);
        q->values = new;
        q->size *= 2;
        q->front = 0;
    }
    q->values[(q->front+q->length)%(q->size)] = x;
    q->length++;
    return 0;
}


//main do stor

int main() {

  int i ; 
  struct staticStack s1;
  SStack S1 = &s1;
  struct dinStack d1;
  DStack D1 = &d1;

  struct staticQueue q1;
  SQueue Q1 = &q1;
  struct dinQueue r1;
  DQueue R1 = &r1;
  
  printf ("Testing Stacks .... \n");
  SinitStack (S1);
  //DinitStack (D1);
  for (i=0; i<15; i++) {
    if (Spush (S1,i) != 0) printf ("ERROR pushing %d\n", i);
  //  if (Dpush (D1,i) != 0) printf ("ERROR pushing %d\n", i);
  }
  ShowSStack (S1);
  ShowDStack (D1);
  
  printf ("Testing Queues .... \n");
  SinitQueue (Q1);
  DinitQueue (R1);
  for (i=0; i<15; i++) {
    if (Senqueue (Q1,i) != 0) printf ("ERROR enqueueing %d\n", i);
    if (Denqueue (R1,i) != 0) printf ("ERROR enqueueing %d\n", i);
  }
  ShowSQueue (Q1);
  ShowDQueue (R1);

  return 0;
} 
