#include <stdio.h>

void swapM (int *x, int *y){
    int tmp=*x;
    *x=*y;
    *y=tmp;
}

void swap (int v[], int i, int j){
    int tmp=*(v+i);
    *(v+i)=*(v+j);
    *(v+j)=tmp;
}

void inverteArray1 (int v[], int N){
    int i;
    for(i=0;i<N/2;i++){
        swapM(v+i,v+N-1-i);
    }
}

void inverteArray2 (int v[], int N){
    int i;
    for(i=0;i<N/2;i++){
        swap(v,i,N-1-i);
    }
}

void dumpV (int v[], int N){
    int i;
    for (i=0; i<N; i++) printf ("%d ", v[i]);
    putchar ('\n');
}

int soma (int v[], int N){
    int r=0, i;
    for(i=0;i<N;i++){
        r+=*(v+i);
    }
    return r;
}

int maximum (int v[], int N, int *m){
    if(N<=0) return 1;
    int x=v[0];
    int i=1;
    while(i<N){
        if(x<v[i]) x=v[i];
        i++;
    }
    *m=x;
    return 0;
}

void quadrados (int q[], int N){
    int i,x;
    if(N>0){
        q[0]=0;
        x=1;
        for(i=1;i<N;i++){
            q[i]=q[i-1]+x;
            x+=2;
        }
    }
}

void quadrados2 (int q[], int N){
    int i;
    if(N>0){
        q[0]=0;
        for(i=1;i<N;i++){
            q[i]=q[i-1]+2*(i-1)+1;
        }
    }
}

void pascal (int v[], int N){
    //...
}

void desenhaTriangulpP (int N){
//...
}

int main()
{  
    printf ("Testes\n");
    // teste das funções de swap
    
    int a, b, v[10] = {10, 6, 2, 3, 5, 1, 5, 9, 8, 7};
    int x = 3, y = 5;
    printf ("x = %d y = %d\n", x, y);
    swapM (&x, &y);
    printf ("x = %d y = %d\n", x, y);
    
    printf ("\n%d %d\n", v[0], v[9]);
    swap (v,0,9);
    printf ("%d %d\n", v[0], v[9]);
    
    
    printf ("\nao invertemos o array com o swapM "); dumpV (v,10);
    inverteArray1 (v,10);
    printf ("obtemos                           "); dumpV (v,10);

    printf ("\nao invertemos o array com o swap "); dumpV (v,10);
    inverteArray1 (v,10);
    printf ("obtemos                          "); dumpV (v,10);
    
    // teste das funções maximum, soma e quadrados
    
    x = maximum (v,10, &y);
    printf ("\nO maior elemento de "); dumpV (v,10);
    printf ("é %d\n", y);
    
    
    printf ("\nOs 10 primeiros quadrados1: "); 
    quadrados (v,10); 
    dumpV (v,10);
    
    printf ("\nOs 10 primeiros quadrados2: "); 
    quadrados2 (v,10); 
    dumpV (v,10);

    x = soma (v,10);
    printf ("\nA soma dos elementos de "); dumpV (v,10);
    printf ("é %d\n", x);
    
    
    // teste da função de cálculo do triangulo de Pascal
    /*
    printf ("\nA linha 5 do triângulo de Pascal é ");
    pascal (v,5); dumpV (v,6);
    */
    /*
    printf ("\nAs linhas 0 a 10 do triângulo de Pascal\n\n");
    desenhaTriangulpP (10);
    */
    printf ("\nFim dos testes\n");

    return 0;
}