#include <stdio.h>
#include <math.h>
#include "Alunos.h"

void dumpV (int v[], int N){
    int i;
    for (i=0; i<N; i++) printf ("%d ", v[i]);
}
void imprimeAluno (Aluno *a){
    int i;
    printf ("%-5d %s (%d", a->numero, a->nome, a->miniT[0]);
    for(i=1; i<6; i++) printf (", %d", a->miniT[i]);
    printf (") %5.2f %d\n", a->teste, nota(*a));
}

int nota (Aluno a){
    int nota;
    float np;
    np =(a.miniT[0]+a.miniT[1]+a.miniT[2]+a.miniT[3]+a.miniT[4]+a.miniT[5])/6.0;
    nota = round(2.5*np+0.75*a.teste);
    if(nota<10) nota=0;
    return nota;
}
//esta função só funciona para arrays ordenados
int procuraNum (int num, Aluno t[], int N){
    int l = 0;
    int r = N-1;
    while(l<=r){
        int m = (l+r)/2;
        if(t[m].numero==num) return m;
        if(t[m].numero<num) l=m+1;
        else r=m-1;
    }
    return -1;
}

void ordenaPorNum (Aluno t [], int N){
    int i,j;
    for(i=1;i<N;i++){
        for(j=i;0<j&&t[j-1].numero>t[j].numero;j--) swapA(t,j,j-1);
    }
    
}

int procuraNumInd (int num, int ind[], Aluno t[], int N){
    return -1;
}

void criaIndPorNum (Aluno t [], int N, int ind[]){
    int i,j;
    ind[0]=0;
    for(i=1;i<N;i++){
        ind[i]=i;
        //for(j=i;0<j&&t)
    }
}
void criaIndPorNome (Aluno t [], int N, int ind[]){
    int i,j;
    ind[0]=0;
    for(i=1;i<N;i++){
        ind[i]=i;
        for(j=i;0<j&&strcmp(t[ind[j-1]].nome,t[ind[j]].nome)>0;j--) swapI(ind,j,j-1);
    }
}

void imprimeTurmaInd (int ind[], Aluno t[], int N){
    int i;
    for (i=0; i<N; i++)
        imprimeAluno (t + ind[i]);
}
#include "Alunos.h"

void swapA (Aluno t [], int i, int j){
	Aluno aux = t[i];
	t[i] = t[j]; t[j] = aux;
}

void swapI (int v[], int i, int j){
	int aux = v[i];
	v[i] = v[j] ; v[j] = aux;
}

void sort1ByNum (Aluno t[], int N) {
	int i, j;

	for (i=0; i<N-1; i++)
		for (j=i+1; j<N; j++)
			if (t[i].numero > t[j].numero) swapA (t,i,j);
}

int searchByNum (int num, Aluno t[], int N){
	int i=0, s=N-1, m=(N-1)/2, r=-1;
	while (i<s && t[m].numero != num){
		if (t[m].numero > num) s=m-1;
		else i = m+1;
		m=(i+s)/2;
	}
	if (t[m].numero == num) r = m;
	return r;
}

//////////// criação e uso de um indice 

void sort1ByNumInd (Aluno t[], int N, int ind[]) {
	int i, j;

	for (i=0;i<N; i++) ind[i] = i;

	for (i=0; i<N-1; i++)
		for (j=i+1; j<N; j++)
			if (t[ind[i]].numero > t[ind[j]].numero) swapI (ind,i,j);
}

int searchByNumInd (int num, Aluno t[], int N, int ind[]){
	int i=0, s=N-1, m=(N-1)/2, r=-1;
	while (i<s && t[ind[m]].numero != num){
		if (t[ind[m]].numero > num) s=m-1;
		else i = m+1;
		m=(i+s)/2;
	}
	if (t[ind[m]].numero == num) r = m;
	return r;
}

//////////// adaptação de um bubblesort
//// original
int bubble (Aluno t[], int N) {
	// retorna a posição onde foi feito o último swap
	// daí para a frente o array está ordenado
	Aluno aux;
	int i, r=0;
	for (i=0; i<N-2; i++)
		if (t[i].numero > t[i+1].numero) { swapA (t,i,i+1); r = i+1;}
    return r;
}

void sort2ByNum (Aluno t[], int N) {
	while ((N = bubble (t,N))) ;
}
/// adaptação
int bubbleInd (Aluno t[], int N, int ind[]) {
	// retorna a posição onde foi feito o último swap
	// daí para a frente o array está ordenado
	int i, r=0;
	for (i=0; i<N-2; i++)
		if (t[ind[i]].numero > t[ind[i+1]].numero) {
			swapI (ind,i,i+1); r = i+1;
		}
    return r;
}

void sort2ByNumInd (Aluno t[], int N, int ind[]) {
	int i;
	for (i=0;i<N; i++) ind[i] = i;

	while ((N = bubbleInd (t,N, ind))) ;
}

//////////// adaptação de um quicksort
//// original
int partition (Aluno t[], int N) {
	int i, p;
    for (i=p=0; i<N-1; i++)
    	if (t[i].numero <= t[N-1].numero) swapA (t,i,p++);
    swapA (t,p,N-1);
    return p;
}

void sort3ByNum (Aluno t[], int N) {
	int p;
	if (N > 1) {
		p = partition (t, N);
		sort3ByNum (t,p);
		sort3ByNum (t+p+1,N-p-1);
	}
}
/// adaptação
int partitionInd (Aluno t[], int N, int ind[]) {
	int i, p;
    for (i=p=0; i<N-1; i++)
    	if (t[ind[i]].numero <= t[ind[N-1]].numero) swapI (ind,i,p++);
    swapI (ind,p,N-1);
    return p;
}

void sort3ByNumIndRec (Aluno t[], int N, int ind[]) {
	int p;
	if (N > 1) {
		p = partitionInd (t, N, ind);
		sort3ByNumIndRec (t,p, ind);
		sort3ByNumIndRec (t,N-p-1, ind+p+1);
	}
}

void sort3ByNumInd (Aluno t[], int N, int ind[]) {
	int i;
	for (i=0;i<N; i++) ind[i] = i;
	
	sort3ByNumIndRec (t,N, ind);
}