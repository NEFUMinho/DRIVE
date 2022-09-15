#include <stdio.h>

//////////////FUNÇOES AUXILIARES /////////////////

//imprime_array -> função auxiliar
void imparr(int v[], int N) {
    printf("array: { ");
    for(int i = 0; i<N; i++) {
        printf("%d, ",v[i]);
    }
    printf("\b\b }\n");     //o uso de '\b' apaga o ultimo caracter, ao colocar dois pretendo apagar o ', '
} 

//funçao auxiliar para imprimir linha triangulo pascal
void printlinha(int v[], int N) {
    for(int i = 0; i<N; i++) {
        printf("%d ",v[i]);
    }
    printf("\t\n");
} 

//funçao auxiliar para imprimir varios char's
void nputchar(int a, char b) {
    int i;
    for (i=0; i<a; i++) {
        putchar(b);
    }
}
/////////////////////////////////////////////////

//ex.2
void swapM(int *x, int *y) {

    int tmp = *x;

    *x = *y;

    *y = tmp;

}

//ex.3
void swap(int v[], int i, int j) {
  //linhas de codigo em comentario podem substituir as anteriores

    int tmp = *(v+i);
    //int tmp = v[i];

    *(v+i) = *(v+j);
    //v[i] = v[j];

    *(v+j) = tmp;
    //v[j] = tmp;

}

//ex.4
int soma(int v[], int N) {

    int s = 0;  //variavel que vai servir de somatorio

    for(int i = 0; i<N ; i++) {
        s += v[i];
    }
    return s;
}

//ex.5

    //1ºversao
void inverteArray1(int v[], int N){

    for(int i = 0; i < (N/2); i++) {
        swapM( &(v[i]) , &(v[N-(1+i)]) );
    }
}

    //2ºversao
void inverteArray2(int v[], int N){

    for(int i = 0; i < (N/2); i++) {
        swap( v, i, N-(1+i) );
    }
}

//ex.6
int maximum(int v[], int N, int *m){
    
    if(N<=0) {return 1;}

    *m = v[0];

    for (int i = 1 ; i<N ; i++) {
        if (*m < v[i]) {*m = v[i];}
    }

    return 0;
}

//ex.7
void quadrados(int q[], int N) {

    int i;
    
    if (N>0) {

        q[0] = 0;
        int x = 0;
        
        for(i=1; i<N ; i++){
            q[i] = q[i-1] + x + 1;
            x += 2;
        }
    }
}

//ex.8
    //8,a)
void pascal (int v[], int N){
    
    v[0] = 1;
    
    for (int i = 1; i < N; i++){
    
        v[i] = 1;
    
        for (int j = i-1; j > 0 ; j--){
            v[j] += v[j-1];
        }
    }
    printlinha(v,N);   
}

    //8,b)
void tripasc(int v[], int N) {

    for (int i = 1; i <= N; i++) {
        nputchar(N-i,' ');
        pascal(v,i);
    }
}

int main() {

    // //ex.2
    // int x=3, y=5;
    // swapM(&x,&y);
    // printf("%d %d \n", x, y);

    // // ex.3
    // int x[5] = {1, 2, 3, 4, 5};
    // printf("before: x[2] = %d and x[4] = %d\n",x[2],x[4]);
    // swap(x, 2, 4);
    // printf("after:  x[2] = %d and x[4] = %d\n",x[2],x[4]);

    // //ex.4
    // int x[5] = {1, 2, 3, 4, 5};
    // int s = soma(x, 5);
    // printf("soma de todos os elementos do array: %d \n", s);

    // //ex.5
    // int x[5] = {1, 2, 3, 4, 5}; 
    // printf("original ");
    // imparr(x, 5);   //funçao que criei para imprimir um array        
    
    //     //1ºversao
    // inverteArray1(x, 5);
    // printf("inverted ");
    // imparr(x, 5);   

    //     //2ºversao
    // inverteArray2(x, 5);
    // printf("inverted ");
    // imparr(x, 5);

    // //ex.6
    // int x[5] = {1, 7, 3, 4, 5};   
    // imparr(x,5);
    // int *a = x + 6;
    // maximum(x, 5, a); 
    // printf("maior elemento: %d\n", *a);

    // //ex.7
    // int x[5] = {1, 7, 3, 4, 5};
    // printf("original ");
    // imparr(x, 5);
    // quadrados(x, 5);
    // printf("modified ");
    // imparr(x, 5);

    // //ex.8
    
    //     //a)
    // int x[5] = {1, 7, 3, 4, 5};
    // pascal(x,5);

    //     //b)
    // int x[5] = {1, 7, 3, 4, 5};
    // tripasc(x,5);    
    
    return 0;
}