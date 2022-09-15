#include<stdio.h>

int isimpar(int n){                //funçao impar
    int r=1;
    if (n%2==0) r=0;
    return r;
}


void fibonacci (int n) {
  int a = 0, b = 1, aux, impar=0;
  for (; n > 0; n--) {
    printf("%d\n",a);
    if (isimpar(a)) impar++;
    aux = a;
    a = b;
    b = (b + aux) % 10000;
  }
  printf("São %d números impares.\n",impar);
}

int somaescrevedivisores(int x){
    int d=2, s=0;
    while (x!=1){
        if (x%d==0) {s=s+d;}
        else d+=1;
    }
    return s;
}

// Um número é abundante se for menor que a soma dos seus divisores próprios
void fibonacci1 (int n) {
  int a = 0, b = 1, aux, ab=0;
  int x;
  for (; n > 0; n--) {
    // printf("%d\n",a);
    x = somaescrevedivisores(a);
    if (a<x) {ab=ab+1;}
    aux = a;
    a = b;
    b = (b + aux) % 10000;
  }
  printf("São %d números abundantes.\n",ab);
}


int main(){
    int n = 95;
    fibonacci1(n);
    // printf("O somatório vai ser igual a: %d\n", fibonacci(n));
    return 0;
}

// Um número é abundante se for menor que a soma dos seus divisores próprios