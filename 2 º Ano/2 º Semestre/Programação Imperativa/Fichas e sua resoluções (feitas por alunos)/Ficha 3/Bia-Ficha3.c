#include<stdio.h>

// VETORES DE INTEIROS - FICHA 3


// Exercício 2
void swapM (int *x, int *y){
    int tmp;
    tmp = *x;
    *x = *y;
    *y = tmp;
}

// Exercício 3

void swap(int v[], int i, int j){
    swapM(v+i,v+j);    
}

// Exercício 4

int soma(int v[], int N){
    int s=0;
    int i;
    for(i=0;i<N;i++){
        s += v[i];
    }
    return s;
}

// Exercício 5

void inverteArray(int v[], int N){
    int i, k;
    for (i = 0, k = N-1; k > i; i++,k--){   // estamos a percorrer o inicio da lista e o final ao mesmo tempo.
        swap(v,i,k);        // trocar a posição entre os dois elementos
    }
}

// Exercício 6

int maximum(int v[], int N, int *m){
    int i;
    for(i=0;i<N;i++){
        if(v[i]>*m){
            *m=v[i];
        }
    }
    return 0;
} 


// Exercício 7

void quadrados(int q[], int N){
    int i;
    if(N>0){
        q[0]=1;
        for(i=1;i<N;i++){
            q[i]=q[i-1]+(2*i+1);
        }
    }
}

// Exercício 8

    // alínea a)

void pascal(int v[], int N){
    int i, j;
    v[0]=1;
    for(i=1;i<N;i++){
        v[i] = 1;
        for(j=i-1;j>0;j--){
            v[j] += v[j-1];
        }
    }
}

    // alínea b)

void pascal (int v[], int N){
    v[0] = 1;
    printf("\t\t");print_array(v,1);
    for (int i = 1; i < N; i++){
        v[i] = 1;
        for (int j = i-1; j > 0 ; j--){
            v[j] += v[j-1];
        }
        printf("\t\t");print_array(v,i+1);
    }
}
