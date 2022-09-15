#include<stdio.h>

// ALGORITMOS NUMÉRICOS SOBRE INTEIROS - FICHA 2

float multInt1 (int n, float m);  // exercício 1
float multInt2(int n, float m);   // exercício 2
int mdc1 (int a, int b);          // exercício 3
int mdc2 (int a, int b);          // exercício 4
int mdc3 (int a, int b);          // exercício 5
int fib1 (int n);                 // exercício 6 a)
int fib2 (int n);                 // exercício 6 b)

int main(){
    int n = 6, m = 15;
    // int d = multInt1(n,m);
    // printf("O produto de um numero m por um inteiro n: %d\n", d);      // %f quer dizer float
    // int f = multInt2(n,m);
    // printf("O produto de um numero m por um inteiro n: %d\n", f);
    // int b = mdc1(n,m);
    // printf("O máximo divisor comum entre dois números não inteiros é: %d\n", b);
    // int c = mdc2(n,m);
    // printf("O máximo divisor comum entre dois números não inteiros é: %d\n", c);
    // int g = mdc3(n,m);
    // printf("O máximo divisor comum entre dois números não inteiros é: %d\n", g);
    // int h = fib1(n);
    // printf("O n-ésimo número da sequência de Fibbonaci é: %d\n", h);
    int e = fib2(n);
    printf("O n-ésimo número da sequência de Fibbonaci é: %d\n", e);
    return 0;
}

// Exercício 1
float multInt1 (int n, float m){
    float r;
    int i;
    r=0;
    for(i=0; i<n; i++){
        r = r+m;
    }
    return r;
}

// Exercício 2
float multInt2(int n, float m){
    float r;
    r = 0;
    int i=0;
    while(n>0){  
        if (n%2 != 0) {r = r+m;}
        m = m*2;
        n = n/2;
        i = i+1;
    }
    return r;

}

// Exercício 2 - versão do professor
float multInt21 (int n, float f){
    float r=0;
    int k=0;
    while (n>0){
        if(n%2 != 0) {r += f;}
        f*=2;
        k++;
        n/=2;
    }
    printf("ops = %d\n",k);
    return r;
}

// Exercício 3
#define MIN(A,B) A<B?A:B
#define MAX(A,B) A>B?A:B
int mdc1 (int a, int b){
    int m,i,d;
    m = MIN(a,b);
    d = MAX(a,b);
    for(i=m; i<0; i--){
        if (m%i==0 && d%i==0) break;
    }
    return i;
}

// Exercício 3 - versão do professor 
int mdc11 (int a, int b){
    int d;
    d = MIN(a,b);
    while(d>0 && !(a%d==0 && b%d==0)){
        d--;
    }
    return d;
}

// Exercício 3 - versão do professor 
int mdc12 (int a, int b){
    int d;
    d = MIN(a,b);
    while (d>0){
        if (a%d==0 && b%d==0) break;
    }
    return d;
}

// Exercício 4
int mdc2 (int a, int b){
    while (a!=b){
        if (a>b) {a=a-b;}
        else {b=b-a;}
    }
    return a;
}

// Exercício 4 - versão do professor
int mdc21 (int a, int b){
    while (a!=0 && b!=0){
        if (b>a) {b=b-a;}
        else {a=a-b;}
    }
    return a+b;
}

// Exercício 5  - não consigo testar
int mdc3 (int a, int b){
    while (a!=b){
        if (a>b) {a=a%b;}
        else {b=b%a;}
    }
    return a;
}

// Exercício 6
    // alínea a) 
int fib1 (int n){
    int d=1;
    if (n>=2) {return fib1(n-1) + fib1(n-2);}
    else {return d;}
    
}

    // alínea a) - versão do professor
int fib12 (int n){
    if (n<2) {return 1;}
    return fib12(n-1) + fib12(n-2);
} 

    // alínea b)
int fib2 (int n){
    if (n<2) {return 1;}
    int v1, v2, vs, i;
    v1 = 1;
    v2 = 1;
    vs = v1 + v2;
    for(i=n;i>=2;i--){
        v2 = vs;
        v1 = v2;
        vs = v1 + v2;
    }
    return vs;

}

    // alínea b) - versão do professor
int fib21 (int n){
    int f1,f2,i;
    f1 = 1;
    f2 = 1;
    for(i=2;i<=n;i++){
        int tmp=f2;
        f2 = f1;
        f1 += tmp;
    }
    return f1;
}
