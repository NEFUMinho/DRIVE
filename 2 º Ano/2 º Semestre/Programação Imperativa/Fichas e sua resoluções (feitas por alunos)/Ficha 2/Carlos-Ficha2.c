#include <stdio.h>

//ex.3 <- definicao da macro
#define MIN(A,B) A<B ? A : B

//ex.1
float multInt1(int n, float m) {

    float r=0;

    for (int i=0; i<n; i++) {
        r += m;
    }

    return r;
}

//ex.2
float multInt2(int n, float m) {

    float r = 0;
    int c = 0;

    while (n>0) {

        if (n%2 != 0) {r += m;}
        
        m *= 2;
        n /= 2;
        c++; 
    }

    printf("Ocorreram %d iteracoes.\n", c);

    return r;
}

//ex.3

    //1ºversao
int mdc11(int a, int b) {

    int md = MIN(a,b);

    while (md>0) {
        
        if (a%md == 0 && b%md == 0) {break;}
        else {md--;}

    }

    return md;
}
    //2ºversao
int mdc12(int a, int b) {

    int md = MIN(a,b);

    while (md>0 && !(a%md == 0 && b%md == 0)) {
           
        md--;

    }
    
    return md;
}

//ex.4

    //versao recursiva
int mdc21(int a, int b) {

    if (a>b) { return ( mdc21(a-b,b) );}
    else if (a<b) { return ( mdc21(a, b-a) );}
    else {return a;}
}
    //versao iterativa
int mdc22(int a, int b) {

    int c = 0;

    while (a!=0 && b!=0) {
        c++;
        if (a<b) {b = b-a;}
        else {a = a-b;}
    }
    printf("Ocorreram %d iteracoes.\n", c);

    return a+b;
}

//ex.5

    //versao recursiva
int mdc31(int a, int b) {
    
    if (a==0 || b==0) return a+b;
    if (a>b) {return (mdc31(a % b,b));}
    else if (a<b) {return (mdc31(a, b % a));}
    else {return a;}

}

    //versao iterativa
int mdc32(int a, int b) {

    int c = 0;
    
    while (a!=0 && b!=0) {
        c++;
        if (a<b) {b = b % a;}
        else {a = a % b;}
    }
    printf("Ocorreram %d iteracoes.\n", c);

    return a+b;
}

//ex.6

    //a) - versao recursiva
int fib1(int n) { 

    if (n<2) {return 1;}
    
    else {return ( fib1(n-1) + fib1(n-2) );}
}

    //b) - versao iterativa
int fib2(int n) {

    int f1,f2;
    f1=f2=1;
    int c = 0;

    if (n<2) {return 1;}

    for (int i=2; i <= n; i++) {
        int tmp = f2;
        f2 = f1;
        f1 += tmp;
        c++;
    }

    printf("Ocorreram %d iteracoes.\n", c);
    return f1;
}


int main() {

    // //ex.1
    // printf("%f \n", multInt1(81,423));

    //ex.2
    // printf("%f \n", multInt2(81,423));

    // //ex.3
    // printf("%d \n", mdc11(25,130));
    // printf("%d \n", mdc12(25,130));   //uso de outro ciclo while
    
    // //ex.4
    // printf("%d \n", mdc21(25,130));  //recursivo
    // printf("%d \n", mdc22(25,130));  //iterativo

    // //ex.5
    printf("%d \n", mdc31(25,130));  //recursivo
    printf("%d \n", mdc32(25,130));  //iterativo

    // // //ex.6,a)
    // printf("%d \n", fib1(25));

    // // //ex.6,b)
    // printf("%d \n", fib2(25));

    return 0;
}

