#include <stdio.h>
#include <stdlib.h>

int ndivisores(int n) {         //obtem a soma dos divisores próprios de n
    int i, s=0;

    for(i=n; i > 0; i--) {

        if(n%i==0) {
            s += i;
        }
    }
   return s;
}

int is_prime(int n){
    // Works for any nymber
    if (n <= 1) return 0;

    for (int i=2; i<n; i++){
        if (n % i == 0) return 0;
    }
    return 1;
}


void fibonacci (int n) {
  int a = 0, b = 1, aux, soma = 0, primo=0, abund = 0;
  for (; n > 0; n--) {
    //printf("%d\n",a);
    if(a<ndivisores(a)) {abund++;}      //um número é abundamente se for menor que a soma dos seus divisores próprios
    if (is_prime(a)) primo++;           
    soma += a; 
    aux = a;
    a = b;
    b = (b + aux) % 10000;
  }
  printf("n_abund: %d\n",abund);       //imprime a quantidade de numeros impressos que sejam abundantes
  printf("primos: %d\n",primo);         //imprime a quant. de numeros impressos que eram primos
  printf("somatório: %d\n",soma);            //imprime a soma dos numeros impressos
}


int main() {

    fibonacci(50);

    return 0;
}