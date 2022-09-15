#include<stdio.h>
#include <stdlib.h>

// Strings e Arrays Ordenados - Ficha 4

// Funções sobre Strings

// exercício 1

int isVogal(char c){
    return (c=='A') || (c=='a') || (c=='E') || (c=='e') || (c=='I') || (c=='i') || (c=='O') || (c=='o') || (c=='U') || (c=='u')
}

int contaVogais(char *s){
    int i;
    int c=0;
    for(i=0;s[i]!='\0';i++){
        if (isVogal(s[i])){
            c++;
        }
    }
    return c;
}

// exercício 2

int strlen(char *s){
    int i;
    int c=0;
    for(i=0;s[i]!='\0';i++){
        c++;
    }
}

// usando uma string auxiliar

int retiraVogaisRep1(char *s){
    char aux[strlen(s)+1];
    int i,j;
    int c=0;
    for(i=0,j=0;s[i]!='\0';i++){
        aux[j++]=s[i];
        if(isVogal(s[i])){
            while(s[i+1]==s[i]){
                i++;
                c++;
            }
        }
    }
    for(i=0;i<j;i++){s[i]=aux[i];}
    s[j]='\0';
    return c;
}

// não usando uma string auxiliar

int retiraVogaisRep2 (char *s){
    int i,j,c=0;
    for (i=0,j=0;s[i]!='\0';i++){
        s[j++]=s[i];
        if (e_vogal(s[i])){
            while (s[i+1]==s[i]){
                i++;
                c++;
            }
        }
    }
    s[j]='\0';
    return c;
}

// Exercício 3

// usando uma string auxiliar

int duplicaVogais1(char *s){
    int i,j;
    int c=0;
    char aux[strlen(s)*2];
    for(i=0,j=0;s[i]!='\0';i++){
        s[j++]=s[i];
        if (e_vogal(s[i])){
            aux[j++];
            c++;
        }
    }
    for(i=0;i<j;i++){
        s[i]=aux[i];
    }
    s[j]='\0';
    return c;
}

// sem usar uma string auxilixar

int duplicaVogais2 (char *s){
    int c=contaVogais(s),i,j;
    i=strlen(s);
    j=i+c;
    s[j--]='\0';
    i--;
    while (i>=0){
        s[j--]=s[i];
        if(e_vogal(s[i])){ 
            s[j--]=s[i];
        }
        i--;
    }
    return c;
}

// ARRAYS ORDENADOS

// Exercício 1  -> isto deve estar errado

int ordenado(int v[], int N){
    int i;
    for(i=0;i<N;i++){
        if(v[i+1]>v[i]){
            return 1;
        }
    }
    return 0;
}


// Exercício 2  -> ????

void merge(int a[], int na, int b[], int nb, int r[]){
    int ia = 0, ib = 0;

    while(ia < na && ib < nb){
        if(a[ia] <= b[ib]) {r[ia+ib] = a[ia]; ia++;}
        else {r[ia+ib] = b[ib]; ib++;}
    }
    while(ia < na){
        r[ia+ib] = a[ia]; ia++;
    }
    while(ib < nb){
        r[ia+ib] = b[ib]; ib++;
    }
}

// Exercício 3

// usando um array auxiliar

int partition(int v[], int N, int x){
    int i,j;
    int m=0;
    int aux[N];
    for(i=0,j=0;i<N;i++){
        if(v[i]<=x){
            aux[j++]=v[i];
            m++;
        }
    }
    for(i=0;i<N;i++){
        if(v[i]>x){
            aux[j++]=v[i];
        }
    }

    for(j=0;j<N;j++){v[j]=aux[j];}
    return m;
}

// não usando um array auxiliar  -> ver com atenção

void swapM (int *x, int *y){
    int tmp;
    tmp = *x;
    *x = *y;
    *y = tmp;
}

void swap(int v[], int i, int j){
    swapM(v+i,v+j);    
}

int partition (int v[], int N, int x){
    int m = 0; int i = N-1;
    while(i >= m){
        if(v[i] <= x){
            swap(v,m,i);
            m++;
        }else i--;
    }
    return m;
}
