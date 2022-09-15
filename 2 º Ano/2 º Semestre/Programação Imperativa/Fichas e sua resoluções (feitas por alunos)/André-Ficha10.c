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


// Questão 1
ABin removeMenor (ABin *a){
    if(!*a) return NULL;
    while((*a)->esq != NULL) a=&(*a)->esq;
    ABin aux=*a;
    a=&(*a)->dir;
    return aux;
}
void removeRaiz (ABin *a){
    ABin aux;
    if(!a) return ;
    if(!(*a)->dir) {
        aux = (*a)->esq;
        free(*a);
        *a = aux;
    }
    else{
        aux=removeMenor(&(*a)->dir);
        aux->esq = (*a)->esq;
        aux->dir = (*a)->dir;
        free(*a);
        *a=aux;
    }
}

int removeElem (ABin *a, int x){
    if(!a) return 1;
    if((*a)->valor==x) removeRaiz(a);
    else if(x<((*a)->valor)) removeElem(&(*a)->esq,x);
    else removeElem(&(*a)->dir,x);
    return 0;
}

/*Versão iterativa
int removeElem (ABin *a, int x){
    while(!(*a) && (*a)->valor != x){
        if(x<(*a)->valor) a=&(*a)->esq;
        else a=&(*a)->dir;
    }
    if(!*a) return 1;
    removeRaiz(a);
    return 0;
}
*/

// Questão 2
void rodaEsquerda (ABin *a){
    ABin b = (*a)->dir;
    (*a)->dir = b->esq;
    b->esq = (*a);
    *a = b;
}
void rodaDireita (ABin *a){
    ABin b = (*a)->esq;
    (*a)->esq = b->dir;
    b->dir = *a;
    *a = b;
}
void promoveMenor (ABin *a){
    if(!(*a) || !(*a)->esq) return;
    promoveMenor( &(*a)->esq);
    rodaDireita(*a);
}
void promoveMaior (ABin *a){
}
ABin removeMenorAlt (ABin *a){
    return NULL;
}

// Questão 3
int constroiEspinhaAux (ABin *a, ABin *ult){
    return (-1);
}
int constroiEspinha (ABin *a){
    if(!*a) return 0;
    promoveMenor(a);
    return 1+constroiEspinha(&(*a)->dir);
}

ABin equilibraEspinha (ABin *a, int n) {
	return NULL;
}

void equilibra (ABin *a) {
}
#include "abin.h"
#include "sol.h"
#include <time.h>


int main (){
  int v1[15] = { 1, 3, 5, 7, 9,11,13,15,17,19,21,23,25,27,29},
      N=15, i;
  ABin a1,r;
  
  srand(time(NULL));
  
  printf ("_______________ Testes _______________\n\n");
  // N = rand() % 16;
  a1 = RandArvFromArray (v1, N);
  printf ("________________________________________\n");
  printf ("Primeira árvore de teste (%d elementos)\n", N);
  dumpABin (a1, N);
  
  /*
  printf ("Espinha\n");
  constroiEspinha_sol (&a1);

  dumpABin (a1, N);
  
  printf ("Equilibrar espinha\n");
  equilibraEspinha_sol (&a1,N);
  dumpABin (a1, N);
  */
  
  i = rand() %N;
  printf ("Remoção do elemento %d\n", v1[i]);
  removeElem_sol (&a1,v1[i]);
  dumpABin (a1, --N);
  
  
  r = removeMenor_sol (&a1);
  printf ("Remoção do menor %d\n", r->valor);
  dumpABin (a1, --N);

  printf ("Remoção da raiz %d\n", a1->valor);
  removeRaiz_sol (&a1);
  dumpABin (a1, --N);

  freeABin (a1);

  a1 = newABin(v1[7], RandArvFromArray (v1  ,7), 
                      RandArvFromArray (v1+8,7));
  N = 15;
  printf ("_______________________________________\n");
  printf ("Segunda árvore de teste (%d elementos)\n", N);
  dumpABin (a1, N);
  
  printf ("Rotação à direita\n");
  rodaDireita (&a1);
  dumpABin (a1, N);

  printf ("Rotação à esquerda\n");
  rodaEsquerda (&a1);
  dumpABin (a1, N);
  
  printf ("Promoção do maior\n");
  promoveMaior_sol (&a1);
  dumpABin (a1, N);
  
  printf ("Promoção do menor\n");
  promoveMenor_sol (&a1);
  dumpABin (a1, N);
  

  printf ("\n\n___________ Fim dos testes ___________\n\n");
  return 0;
} 