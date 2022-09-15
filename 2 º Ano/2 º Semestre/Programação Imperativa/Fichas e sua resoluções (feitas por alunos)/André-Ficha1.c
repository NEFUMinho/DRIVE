/* 3 Programas Iterativos  */

#include <stdio.h>

//Exercício 1
void quadrado (int n){
    int i,j;
    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            putchar('#');
        }
        putchar('\n');
    }
    
}

//Exercício 2
void xadrez (int n){
    int l,c;
    for(l=0;l<n;l++){
        for(c=0;c<n;c++){
            if((l+c)%2==0){
                putchar('#');
            } else {
                putchar('_');
            }
        }
    putchar('\n');
    }
}

//Exercício 3
void nputchar (int n, char c){
    int i;
    for (i=0;i<n;i++){
        putchar(c);
    }
}

void trianguloV (int n){
    int i;
    for (i=1;i<n;i++){
        nputchar(i,'#');
        putchar('\n');
    }
    for (i=n;i>0;i--){
        nputchar(i,'#');
        putchar('\n');
    }
}

void trianguloH (int n){
    int i;
    for (i=1;i<=n;i++){
        nputchar(n-i,' ');
        nputchar(2*i-1,'#');
        putchar('\n');
    }
}

//Exercício 4
int circulo (int n){
    int i;
    n+=1;
    for (i=1;i<n;i++){
        nputchar(n-i,' ');
        nputchar(2*i-1,'#');
        putchar('\n');
    }
    for (i=n;i>0;i--){
        nputchar(n-i,' ');
        nputchar(2*i-1,'#');
        putchar('\n');
    }
}

int main()
{
    int x;
    printf("Introduza o tamanho do quadrado:");
    scanf("%d",&x);
    quadrado (x);
    printf("Introduza o tamanho do xadrez:");
    scanf("%d",&x);
    xadrez (x);
    printf("Introduza o tamanho do triângulo vertical:");
    scanf("%d",&x);
    trianguloV (x);
    printf("Introduza o tamanho do triângulo horizontal:");
    scanf("%d",&x);
    trianguloH (x);
    printf("Introduza o tamanho do raio do círculo:");
    scanf("%d",&x);
    printf ("\nForam usados %d caracteres para fazer o circulo\n", circulo (x));
    return 0;
}
