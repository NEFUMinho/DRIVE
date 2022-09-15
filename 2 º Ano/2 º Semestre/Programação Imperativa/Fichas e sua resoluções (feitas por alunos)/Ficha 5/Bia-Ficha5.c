#include<stdio.h>
#include <stdlib.h>

typedef struct aluno {
    int numero;
    char nome[100];
    int miniT [6];
    float teste;
} Aluno;

// funções dadas no blackboard

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

// exercício 1

int nota (Aluno a){
    int nota;
    float miniteste;
    miniteste = (a.miniT[0] + a.miniT[1] + a.miniT[2] + a.miniT[3] + a.miniT[4] + a.miniT[5])/6.0;
    nota = 0.25*miniteste + 0.75*a.teste;
    if(nota<10) {nota=0;}
    return nota;
}

// exercício 2

int procuraNum(int num, Aluno t[], int N){
    int i;
    for(i=0;i<N;i++){
        if(num == t[i].numero){return i;}
    }
    return -1;
}

// exercício 3

void ordenaPorNum (Aluno t [], int N){
    int i,j;
    for(i=1;i<N;i++){
        for(j=i ;(j>0 && t[j-1].numero>t[j].numero);j--){
            swapA(t,j,j-1);
        }
    }
}

// exercício 4

void criaIndPorNum(Aluno t [], int N, int ind[]){

}



int procuraNumInd (int num, int ind[], Aluno t[], int N){
    return -1;
}

// exercício 5


