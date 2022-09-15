#include <stdio.h>
#include <string.h>
#include <math.h>       //usado para incluir aqui a funcao 'round' 
#include "aluno.h"      //ficheiro onde se encontra definida a struct 'Aluno'


int nota(Aluno a);  //colocado aqui porque a funcao 'nota' sera usada numa funcao auxiliar (imprimeAluno)

//////////////FUNÇOES AUXILIARES /////////////////

//swapA() -> faz o mesmo que a swap mas para um arrays de elementos do tipo 'Aluno'
void swapA(Aluno t[], int i, int j) {
    Aluno tmp = t[i];
    t[i] = t[j];
    t[j] = tmp;
}

//swap() -> troca o valor das posicoes 'i' e 'c' do vetor 'v'
void swap(int v[], int i, int j) {
  //linhas de codigo em comentario podem substituir as anteriores

    int tmp = *(v+i);
    //int tmp = v[i];

    *(v+i) = *(v+j);
    //v[i] = v[j];

    *(v+j) = tmp;
    //v[j] = tmp;

}

//imparr() -> imprime um array 'v' com tamanho 'N'
void imparr(int v[], int N) {
    printf("{ ");
    for(int i = 0; i<N; i++) {
        printf("%d, ",v[i]);
    }
    printf("\b\b }");     //o uso de '\b' apaga o ultimo caracter, ao colocar dois pretendo apagar o ', '
} 

//mystrcmp() -> compara lexicograficamente duas strings
int mystrcmp(char s1[], char s2[]) {
    int r;  //variavel que guarda o resultado de acordo com as condicoes do enunciado
    int i;

    // ver site : https://www.ime.usp.br/~pf/algoritmos/aulas/string-manip.html 

    for(i=0; s1[i]==s2[i] && s1[i]!='\0'; i++) {;}

    if(s1[i]<s2[i]) {r=-1;}         // <0 se s1<s2
    else if (s1[i]>s2[i]) {r=1;}    // >0 se s1>s2
    else {r=0;}                     // =0 se s1=s2

    return r;
}

//imprimeAluno() -> apresenta no ecra todos os dados de um aluno
void imprimeAluno (Aluno *a){
    int i;
    printf ("%-5d %s (%d", a->numero, a->nome, a->miniT[0]);
    for(i=1; i<6; i++) printf (", %d", a->miniT[i]);
    printf (") %5.2f %d\n", a->teste, nota(*a));
}

/////////////////////////////////////////////////

//ex.1
int nota(Aluno a) {
//int nota (Aluno &a) {

    int nota;
    float np = 0;
    int i;

    for(i=0;i<6;i++) {
        np += a.miniT[i];
        //np += (*a.miniT[i]);
    }
    np /= 6.0;

    nota = round(2.5 * np + 0.75 * (a.teste));
    //nota = round(2.5*np + 0.75 * (*a.teste));

    nota = nota < 10 ? 0 : nota;

    return nota;
}

//ex.2
int procuraNum(int num, Aluno t[], int N) {
    int l=0;
    int r=N-1;
    
    while (l<= r) {
        int m = (l+r)/2; 
        if (t[m].numero == num) {return m;}
        else if (t[m].numero < num) {l=m+1;}
        else {r = m-1;}
    }

    return -1;
}

//ex.3
void ordenaPorNum(Aluno t[], int N) {
    int i,j;

    for(i=1; i<N; i++) {
        for(j=i; j>0 && t[j-1].numero > t[j].numero; j--) {
            swapA(t,j,j-1);
        }
    }
}

//ex.4
void criaIndPorNum(Aluno t[], int N, int ind[]) {
    int i,j;

    ind[0] = 0;

    for (i=1; i<N; i++) {
        ind[i]=i;
        for(j=i; j>0 && t[ind[j-1]].numero > t[ind[j]].numero; j-- ) {
            swap(ind, j, j-1);
        }
    } 
}

//ex.5
void imprimeTurmaInd(int ind[], Aluno t[], int N) {
    int i, j;

    printf("{ ");

    for(i=0; i<N; i++) {

        j = ind[i];

        printf("{%d, ", t[j].numero);
        printf("\"%s\", ", t[j].nome);
        imparr(t[j].miniT, 6);
        printf(" %5.2f}, ", t[j].teste);   //nota do teste em float
        printf("\n");
    }
    printf("\b\b}\n"); 

}

//ex.6
int procuraNumInd(int num, int ind[], Aluno t[], int N) {
    int i;

    for(i=0; i<N; i++) {
        int numAtual = t[ind[i]].numero;
        if (numAtual == num) {return ind[i];}
        else if (num < numAtual) {break;}
    }

    return -1;
}

//ex.7
void criaIndPorNome(Aluno t[], int N, int ind[]) {
    int i,j;

    ind[0]=0;

    for (i=1; i<N; i++) {
        ind[i]= i;
        for (j=i; j>0 && (strcmp( t[ind[j-1]].nome, t[ind[j]].nome ) > 0); j--) {
        //for (j=i; j>0 && (mystrcmp( t[ind[j-1]].nome, t[ind[j]].nome ) > 0); j--) {
            swap(ind, j, j-1);
        }
    }
}

/////////////////////////////////////////////////

int main(){

    Aluno Turma1 [7] = {{4444, "Andre", {2,1,0,2,2,2}, 10.5}
                       ,{3333, "Paulo", {0,0,2,2,2,1},  8.7}
                       ,{8888, "Carla", {2,1,2,1,0,1}, 14.5}
                       ,{2222, "Joana", {2,0,2,1,0,2},  3.5}
                       ,{7777, "Maria", {2,2,2,2,2,1},  5.5}
                       ,{6666, "Bruna", {2,2,2,1,0,0}, 12.5}
                       ,{5555, "Diogo", {2,2,1,1,1,0},  8.5}
                       } ;
    int indNome [7], indNum [7];
    int i;

    //ex.3
    ordenaPorNum (Turma1, 7);

    //ex.2 (precisa do ex.3, pois a turma esta ordenada segundo o enunciado)
    printf ("procura 5555: %d \n", procuraNum (5555, Turma1, 7));
    printf ("procura 9999:%d \n", procuraNum (9999, Turma1, 7));

    //imprimir turma -> versao professores
    printf("\nTurma: \n");
    for (i=0; i<7; imprimeAluno (Turma1 + i++));

    //ex.4
    criaIndPorNum (Turma1, 7, indNum);

    //ex.7
    criaIndPorNome (Turma1, 7, indNome);

    //ex.5
    printf("\nTurma ordenada por numero de aluno: \n");
    imprimeTurmaInd (indNum, Turma1, 7);
    printf("\nTurma ordenada por nome do aluno: \n");
    imprimeTurmaInd (indNome, Turma1, 7);

    //ex.6
    printf ("\nprocura 5555:%d \n",  procuraNumInd (5555, indNum, Turma1, 7));
    printf ("procura 9999:%d \n",  procuraNumInd (9999, indNum, Turma1, 7));    



    return 0;
}