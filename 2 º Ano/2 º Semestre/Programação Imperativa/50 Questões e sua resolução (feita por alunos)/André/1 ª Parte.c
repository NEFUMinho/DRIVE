typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;

typedef struct posicao {
   int x, y;
} Posicao;

int caminho (Posicao, Posicao, Movimento [], int );

int vizinhos (Posicao, Posicao [], int );

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MAX 100

//Exercício 1
int f1(){
    printf("Escreve uma sequência de números inteiros terminada com o número 0:\n");
    int x=1;
    int r=0;
    while (x){
        scanf("%d",&x);
        if (x>r) r=x;
    }
    return r;
}

//Exercício 2
float f2(){
    printf("Escreve uma sequência de números inteiros terminada com o número 0:\n");
    int x=0, k=0;
    float r;
    while (1) {
        scanf("%d",&x);
        if (x==0) break;
        r+=x;
        k+=1;
    }
    return (r/k);
}

//Exercício 3
int f3(){
    printf("Escreve uma sequência de números inteiros terminada com o número 0:\n");
    int x=1;
    int maior=0;
    int r=0;
    while (x){
        scanf("%d",&x);
        if (x>maior) {
            r=maior;
            maior=x;
        }
        else if(x>r) r=x;
    }
    return r;
}

//Exercício 4
int bitsUm (unsigned int n){
    if (n==0) return 0;
    double x = log2(n);
    int y = x;
    if (x==y) return 1;
    return 1 + bitsUm(n-pow(2,y));
}

//Exercício 5
int trailingZ (unsigned int n) {
    if (n==0) return 1;
    double x = log2(n);
    int y = x;
    if (x==y) return y;
    return trailingZ(n-pow(2,y));
}

//Exercício 6
int qDig (unsigned int n){
    int c=0;
    while(n){
        c+=1;
        n=n/10;
    }
    return c;
}

//Exercício 7
char *mystrcat(char s1[], char s2[]) {
    int i,j;
    for (i=0; s1[i]!='\0';i++);
    for (j=0; s2[j]!='\0';j++) s1[i++]=s2[j];
    s1[i]='\0';
    return s1;
}

//Exercíco 8
char *mystrcpy(char *dest, char source[]) {
    int i;
    for(i=0;source[i]!='\0';i++) dest[i]=source[i];
    dest[i]='\0';
    return dest;
}

//Exercício 9
int mystrcmp(char s1[], char s2[]) {
    int i;
    for (i=0; s1[i]==s2[i] && s1[i]!='\0';i++);
    if(s1[i]==s2[i]) return 0;
    if(s1[i]<s2[i]) return -1;
    return 1;
}

//Exercício 10
char *mystrstr (char s1[], char s2[]){
    if(s2[0]=='\0') return s1;
    int i, j, k;
    for(i=0; s1[i]!='\0';i++){
    	if(s1[i]==s2[0]){
            for(k=i, j=0; s1[k]!='\0' && s2[j]!='\0';k++,j++){
                if(s1[k]!=s2[j]){
                    break;
                }
            }
            if(s2[j]=='\0'){
                return s1+i;
            }
    	}
    }
    if(s1[0]=='\0' && s2[0]=='\0'){
        return s1;
    }
    return NULL;
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MAX 100

//Extras
void swapi(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

//Exercício 11
void strrev (char s[]){
    int i;
    char temp;
    for(i=0;s[i]!='\0';i++);
    int j=i; 
    for(i=0;i<j/2;i++){
        temp=s[i];
        s[i]=s[j-i-1];
        s[j-i-1]=temp;
    }
}

//Exercício 12
int e_vogal (char c){
    return (c=='A') || (c=='a') || (c=='E') || (c=='e') || (c=='I') || (c=='i') || (c=='O') || (c=='o') || (c=='U') || (c=='u');
}

void strnoV (char s[]){
    int i,j;
    for (i=0,j=0;s[i]!='\0';i++){
        if (!e_vogal(s[i])) s[j++]=s[i];
    }
    s[j]='\0';
}

//Exercício 13
void truncW (char t[], int n){
    int i,j,c=0;
    for(i=0,j=0;t[i]!='\0';i++){
        if(t[i]==' ') c=-1;
        if(c==n){
            c=-1;
            while(t[i]!=' ' && t[i]!='\0' ) i++;
        }
        t[j++]=t[i];
        c++;
    }
    t[j]='\0';
}

//Exercício 14
int maxInArray (int *ascii, int n){
    int i = 0;
    int j = 0;
    int max = ascii[i];
    for (i = 0; i < n; i++){
        if (ascii[i] > max){
            max = ascii[i];
            j = i;
        }
    }
    return j;
}

char charMaisfreq (char s[]) {
    int ascii[127] = {0};
    int i;
    if (s[0] == '\0'){
        return 0;
    }
    for (i = 0; s[i] != '\0'; i++){
        ascii[s[i]] += 1;
    }
    return maxInArray (ascii, 127);
}

//Exercício 15
int iguaisConsecutivos (char s[]){
    int i,c,r=1;
    if(s[0]=='\0') return 0;
    for(i=1;s[i]!='\0';i++){
        c=1;
        while(s[i-1]==s[i]){
            c++;
            i++;
        }
        if(c>r) r=c;
    }
    return r;
}

//Exercício 16
int difConsecutivos (char s[]){
    int i,c,r=1;
    if(s[0]=='\0') return 0;
    for(i=1;s[i]!='\0';i++){
        c=1;
        while(s[i-1]!=s[i]){
            c+=1;
            i++;
        }
        if(c>r) r=c;
    }
    return r;
}

//Exercício 17
int maiorPrefixo (char s1 [], char s2 []){
    int i;
    for(i=0;s1[i]==s2[i] && s1[i]!='\0';i++);
    return i;
}

//Exercício 18
int maiorSufixo (char s1 [], char s2 []){
    strrev(s1);
    strrev(s2);
    int r = maiorPrefixo(s1,s2);
    strrev(s1);
    strrev(s2);
    return r;
}

//Exercício 19
int pref(char s1[],char s2[]){
    int i;
    for(i=0; s1[i]!='\0';i++){
        if (s1[i]!=s2[i]) return 0;
    }
    return 1;
}



int surfPref (char s1[],char s2[]){
    int i;
    for(i=0;s1[i]!='\0'&&!pref(s1+i,s2);i++);
    return strlen(s1+i);
}

//Exercício 20
int contaPal (char s[]){
    int i,r=0;
    if(s[0]!=' '&&s[0]!='\0') r++;
    for(i=0;s[i]!='\0';i++) if(s[i]==' ' && s[i+1]!=' ' && s[i+1]!='\0') r++;
    return r;
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

//Exercício 21
int contaVogais (char s[]){
    int i,r=0;
    for(i=0;s[i]!='\0';i++){
        if(e_vogal(s[i])) r++;
    }
    return r;
}

//Exercício 22
int contida (char a[], char b[]){
    int i,j;
    for(i=0;a[i]!='\0';i++){
        for(j=0;b[j]!=a[i] && b[j]!='\0';j++);
        if(b[j]=='\0') return 0;
    }
    return 1;
}

//Exercício 23
int palindrome (char s[]){
    int i,j;
    for(i=0;s[i]!='\0';i++);
    j=i;
    for(i=0;s[i]==s[j-i-1] && i<j/2;i++);
    if(i==j/2) return 1;
    return 0;
}

//Exercício 24
int remRep (char x[]){
    int i,j;
    if(x[0]=='\0') return 0;
    for(i=1,j=1;x[i]!='\0';i++){
        while(x[i]==x[i-1]) i++;
        if(x[i]=='\0') break;
        x[j++]=x[i];
    }
    x[j]='\0';
    return j;
}

//Exercício 25
int limpaEspacos (char t[]){
    int i,j,c=0;
    for(i=0,j=0;t[i]!='\0';i++){
        t[j++]=t[i];
        c++;
        if(t[i]==' ') while(t[i+1]==' ') i++;
    }
    t[j]='\0';
    return c;
}

//Exercício 26
void insere (int v[], int N, int x){
    int i;
    for(i=0;v[i]<x && i<N;i++);
    int j=i;
    for(i=N;i>j;i--) v[i]=v[i-1];
    v[i]=x;
}

//Exercício 27
void merge (int r [], int a[], int b[], int na, int nb){
    int i,j,x=0;
    for(i=0,j=0;i<na && j<nb;){
        if(a[i]<=b[j]) r[x++]=a[i++];
        else r[x++]=b[j++];
    }
    if(i!=na) for(;i<na;i++) r[x++]=a[i];
    else for(;j<nb;j++) r[x++]=b[j];
}

//Exercício 28
int crescente (int a[], int i, int j) {
    for(;i<j;i++) 
        if(a[i]>a[i+1]) return 0;
    return 1;
}

//Exercício 29
int retiraNeg (int v[], int N){
    int i,c=0,j=0;
    for(i=0;i<N;i++){
        while(v[i]<0 && i<N) i++;
        if(i==N) break;
        v[j++]=v[i];
        c++;
    }
    return c;
}

//Exercício 30
int menosFreq (int v[], int N){
    int i,r=v[0],c=1,min=0;
    for(i=0;i<N;i++){
        while(v[i]==v[i+1] && i<N-1){
            i++;
            c++;
        }
        if(c<min || min==0){
            r=v[i];
            min=c;
        }
        c=1;
    }
    return r;
}
#include <stdio.h>

//Exercício 31
int maisFreq (int v[], int N){
   int r = v[0],i,c=1,max=1;
   for(i=0;i<N;i++){
       while(v[i]==v[i+1]){
           c++;
           i++;
       }
       if(c>max){
           r=v[i];
           max=c;
       }
       c=1;
      
    }
    return r;
}

//Exercício 32
int maxCresc (int v[], int N) {
   int i,r = 0,c=1;
   if(N==0) return 0;
   for(i=0;i<N;i++){
       while(v[i]<=v[i+1]){
           i++;
           c++;
       }
       if(c>r) r=c;
       c=1;
   }
   return r;
}

//Exercício 33
int elimRep (int v[], int N) {
    int r=1,i,j;
    if(N==0) return 0;
    for(i=1;i<N;i++){
        for(j=0;j<r && v[i]!=v[j];j++); 
        if(j==r){
            v[r]=v[i];
            r++;
        }
    }
    return r;
}

//Exercício 34
int elimRepOrd (int v[], int N) {
   int r = 0,i;
   for(i=0;i<N;i++){
       while(v[i]==v[i+1]) i++;
       v[r++]=v[i];
   }
   return r;
}

//Exercício 35
int comunsOrd (int a[], int na, int b[], int nb){
   int i,j,r = 0;
   for(i=0,j=0;i<na && j<nb;){
       if(a[i]==b[j]){ 
           r++;
           i++;
           j++;
       }
       else if(a[i]<b[j]) i++;
       else j++;
   }
   return r;
}

//Exercício 36
int comuns (int a[], int na, int b[], int nb){
    int r=0,i,j;
    for(i=0;i<na;i++){
        for(j=0;j<nb;j++){
            if(a[i]==b[j]){ 
                r++;
                break;
            }
        }
    }
    return r;
}

//Exercício 37
int minInd (int v[], int n) {
   int r = -1,i;
   if(n==0) return r;
   r=0;
   for(i=1;i<n;i++){
       if(v[i]<v[r]) r=i;
   }
   return r;
}

//Exercício 38
void somasAc (int v[], int Ac [], int N){
   int i,c=0;
   for(i=0;i<N;i++){
       c+=v[i];
       Ac[i]=c;
   }
}

//Exercício 39
int triSup (int N, int m [N][N]) {
    int l,c;
    for(l=1;l<N;l++){
        for(c=0;c<l;c++){
            if(m[l][c]!=0) return 0;
        }
    }
    return 1;
}

//Exercício 40
void transposta (int N, float m [N][N]) {
    float t [N][N];
    int l,c;
    for(l=0;l<N;l++){
        for(c=0;c<N;c++){
            t[l][c]=m[c][l];
        }
    }
    for(l=0;l<N;l++){
        for(c=0;c<N;c++){
            m[l][c]=t[l][c];
        }
    }
    return;
}
#include <stdio.h>
#include "posicao.h"

//Exercício 41
void addTo(int N, int M, int a [N][M], int b[N][M]) {
    int l,c;
    for(l=0;l<N;l++){
        for(c=0;c<M;c++){
            a[l][c]+=b[l][c];
        }
    }
    return;
}

//Exercício 42
void unionSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0;i<N;i++){
        if(v1[i]) r[i]=1;
        else if(v2[i]) r[i]=1;
        else r[i]=0;
    }
}

//Exercício 43
int intersectSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0;i<N;i++){
        if(v1[i]==v2[i]) r[i]=v1[i];
        else r[i]=0;
    }
    return i;
}

//Exercício 44
int intersectMSet (int N, int v1[N], int v2[N], int r[N]){
    int c;
    for(c=0;c<N;c++){
        if(v1[c]<=v2[c]) r[c]=v1[c];
        else r[c]=v2[c];
    }
    return c;
}

//Exercício 45
int unionMSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0;i<N;i++){
        if(v1[i]>=v2[i]) r[i]=v1[i];
        else r[i]=v2[i];
    }
    return i;
}

//Exercício 46
int cardinalMSet (int N, int v[N]){
    int i,c=0;
   	for(i=0;i<N;i++) c+=v[i];
    return c;
}


//Exercício 47
Posicao posFinal (Posicao inicial, Movimento mov[], int N){
    int i;
    for(i=0;i<N;i++){
        if(mov[i]==Norte) inicial.y++;
        else if(mov[i]==Sul) inicial.y--;
        else if(mov[i]==Oeste) inicial.x--;
        else inicial.x++;
    }
    return inicial;
}

//Exercício 48
int caminho (Posicao inicial, Posicao final, Movimento mov[], int N){
    int i;
    for(i=0; (inicial.x != final.x) || (inicial.y != final.y); i++){
        if (inicial.x < final.x) {
            mov[i] = Este;
            inicial.x++;
        }
        else if(inicial.x > final.x) {
            mov[i] = Oeste;
            inicial.x--;
        }
        else if(inicial.y < final.y) {
            mov[i] = Norte;
            inicial.y++;
        }
        else if(inicial.y > final.y) {
            mov[i] = Sul;
            inicial.y--;
        }
    }
    return (i>N) ? -1 : i;
}

//Exercício 49
int maiscentral (Posicao pos[], int N) {
    int i,d,min=pos[0].x*pos[0].x+pos[0].y*pos[0].y,r=0;
    for(i=1;i<N;i++){
        d=pos[i].x*pos[i].x+pos[i].y*pos[i].y;
        if(d<min){
            min=d;
            r=i;
        }
    }
    return r;
}

//Exercício 50
int vizinhos (Posicao p, Posicao pos[], int N) {
    int i,c=0,x,y;
    for(i=0;i<N;i++){
        x=p.x-pos[i].x;
        y=p.y-pos[i].y;
        if(x==0 && y*y==1) c++;
        else if(y==0 && x*x==1) c++;
    }
    return c;
}