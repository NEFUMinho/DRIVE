#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Função auxiliar que imprime strings

void imprimeStr(char x[]){
    int i;
    for(i=0;x[i]!='\0';i++){
        printf("%c",x[i]);
    }
    printf("\n");
}

// Função auxiliar que dá o comprimento de uma string

int comprimentoStr(char x[]){
    int i;
    int c=0;
    for(i=0;x[i]!='\0';i++){
        c++;
    }
    c=c+1;
    return c;
}

// Função auxiliar que dá falso na presença de uma vogal

void vogalerrada(char v){
    if ( v=='a' || v=='e' || v=='i' || v=='o' ||v=='u' || v=='A' || v=='E' || v=='I' || v=='O' || v=='U' ) return 0;
    else return 1;
}

// Função auxiliar que dá verdadeiro na presença de uma vogal

void vogalcerto(char v){
    if ( v=='a' || v=='e' || v=='i' || v=='o' ||v=='u' || v=='A' || v=='E' || v=='I' || v=='O' || v=='U' ) return 1;
    else return 0;
}

// Função que vê se o elemento pertence já ao array

int repeteArray(int v[],int N, int v1){
    int i;
    int r=0;
    for(i=0;i<N;i++){
        if(v1==v[i]) {r=1;}
    }
    return r;
}


// exercício 1

int maximo() {
    int x;
    int max=0;
    scanf("%d",&x);
    while(x!=0){
        if (x>max) max=x;
        scanf("%d",&x);
    }
    printf("O maior número da sequência é:%d",max);
    return 0;
}

// exercício 2

int media() {
    int x;
    int y=0;
    int med=0;
    int conta=0;
    scanf("%d",&x);
    while(x!=0){
        conta = conta + 1;
        y += x;
        scanf("%d",&x);
    }
    med = y/conta;
    printf("A média da sequência é:%d",med);
    return 0;
}

// exercício 3

int segmaior(){
    int x;
    scanf("%d",&x);
    int m1=0;
    int m2=0;
    while(x!=0){
        if (x>m1 && x>m2) {
            m2 = m1;
            m1 = x;
        }
        else if (x<m1 && x>m2) {m2 = x;}
        scanf("%d",&x);
    }
    printf("O segundo maior valor da sequência é:%d",m2);
    return 0;
}

// exercício 4

int bitsUm(unsigned int n){
    int r=0;
    while(n!=0) {
        if (n%2==0) {n = n/2;}
        else {
            n = n/2;
            r++;
        }
    }
    return r;
}

// exercício 5

int trailingZ (unsigned int n) {
    // a função  trailingZ  calcula o número de bits a 0  no final da 
    // representação binária de um número (i.e., o expoente da maior potência de 2 que é divisor desse número).
    int r = 0;
    while(n%2==0){
        r++;
        n = n/2;
    }
    return r;
}

// exercício 6

 /* Defina uma função int qDig (unsigned int n) 
    que calcula o número de dígitos necessários 
    para escrever o inteiro n em base decimal. 
    Por exemplo, qDig (440) deve retornar 3.
*/

int qDig (int n) {
    int r = 0;
    while(n!=0){
        r++;
        n = n/10;
    }
    return r;
}

// exercício 7

/*
  Apresente uma definição da função pré-definida em C "char *strcat (char s1[], char s2[])"
  que concatena a string s2 a s1 (retornando o endereço da primeira).
*/

char *mystrcat(char s1[], char s2[]) {
    int i;
    int j;
    for(i=0;s1[i]!='\0';i++){;}
    for(j=0;s2[j]!='\0';j++){
        s1[i]=s2[j];
        i++;
    }
    s1[i] = '\0';
    return s1;
}

// exercício 8

char *mystrcpy(char *dest, char source[]){
    int i;
    for(i=0;source[i]!='\0';i++){
        dest[i]=source[i];
    }
    dest[i] = '\0';
    return dest;
}

// exercício 9

/*
  Apresente uma definição da função pré-definida em C "int strcmp (char s1[], char s2[])"
  que compara (lexicograficamente) duas strings. O resultado deverá ser:
   • 0, se as strings forem iguais;
   • <0, se s1<s2;
   • >0, se s1>s2.
*/

/*

Dizemos que uma string s é lexicograficamente menor que uma string t  
se o primeiro byte de s que difere do correspondente byte de t é menor que o byte de t.  
Mais precisamente, para decidir se s é lexicograficamente menor que t basta fazer o seguinte:
 -> Procure a primeira posição, digamos k, em que as duas strings diferem. 
        Se s[k] < t[k] então s é lexicograficamente menor que t.
        Se s[k] > t[k] então t é lexicograficamente menor que s.  
        Se k não está definido então s e t são iguais ou uma é prefixo próprio da outra; 
no segundo caso, a string mais curta é lexicograficamente menor que a mais longa.

*/
int mystrcmp(char s1[], char s2[]) {
    int i;
    int j;
    for(i=0;s1[i]!='\0';i++){
        for(j=0;s2[j]!='\0';j++){
            if (s1[i]!=s2[j]){
                if (s1[i]<s2[j]) {return -1;}
                else if (s1[i]>s2[j]) {return 1;}
            }
        }
    }
    return 0;
}

// exercício 10

char *mystrstr (char s1[], char s2[]) {
    int i;
    int j;
    int posi=0;
    for(i=0;s1[i]!='\0';i++){
        if (s1[i]==s2[0]){
            posi=i;
            for(j=1;s1[i+1]==s2[j] || s2[j]!='\0';j++,i++){;}
            if (s2[j]=='\0') {return s1+posi;}
        }
    }
    return NULL;
}

// exercício 11

/*
  Defina uma função "void strrev (char s[])" que inverte uma string.
*/
void strrev (char s[]) {
    int i=comprimentoStr(s) - 1;
    int j;
    int aux=0;
    char aux[i+1];
    for(i;i>=0;i--){
        aux[aux]=s[i];
        aux++;
    }
    aux[aux]='\0';
    for(j=0;aux[j]!='\0';j++){
        s[j]=aux[j];
    }
    s[i]='\0';
}

// exercício 12

/*
 Defina uma função void strnov(char s[]) que retira todas as vogais de uma string
*/

void strnov(char t[]){
    int i;
    int j;
    j=comprimentoStr(t);
    int n=0;
    char v[j];
    mystrcpy(v,t);
    for(i=0;v[i]!='\0';i++){
        if (vogalerrada(t[i])){
            t[n]=v[i];
            n++;
        }
    }
    t[n]='\0';

}

// exercício 13

/* 
Defina uma função void truncW(char t[],int n) que dado um texto t com várias palavras (as palavras estão separadas por um
ou mais espaçados) e um inteiro n, trunca todas as palavras de forma a terem no máximo n caracteres.
*/

void truncW(char t[], int n){
    int i;
    int j=0;
    int rep=n;
    for(i=0;t[i]!='\0';i++){
        if (t[i]==' '){
            t[j]=' ';
            j++;
            rep=n;
        }
        else {
            if(rep!=0) {
                t[j] = t[i];
                j++;
                rep--;
            }

        }
    }
    t[j]='\0';
}

// exercício 14

/* Defina uma função "char charMaisfreq(char s[])" que determina qual o caracter mais frequente numa string.
A função deverá retornar 0 no caso de s ser string vazia.
*/

char charMaisfreq(char s[]){
    int i;
    int conta=0;
    int tempconta=0;
    char resultado = '\0';

    if (s[0]=='\0') {return '0';}

    for(i=0; s[i]!='\0'; i++){
        if (s[i]!=resultado) {
            tempconta=0;
            for(c=1;s[c]!='\0';c++){
                if (s[i]==s[c]) {tempconta++;}
            }
            if (tempconta>conta){
                resultado = s[i];
                conta=tempconta;
            }
        }

    }
    return resultado;
}

// exercício 15

/*
defina uma função "int iguaisConsecutivos(char s[])" que, dada uma string s calcula o comprimento da maior sub-string
com caracteres iguais. Por exemplo, "iguaisConsecutivos("aabcccaac") deve dar como resultado 3, correspondendo à 
repetição "ccc".
*/

int iguaisConsecutivos(char s[]){
    int i;
    int resultado=0;
    int n=1;

    for(i=0;s[i]!='\0';i++){
        if (s[i+1]==s[i]) {n++;}
        else {
            if (n>resultado) {
                resultado=n;
                n=1;
            }
        }

    }
    return resultado;
}

// exercício 16

/*
Defina uma função "int difConsecutivos (char s[])" que, dada uma string s calcula o comprimento da maior sub-string com
caracteres diferentes. Por exemplo, "difConsecutivos("aabcccaac")" deve dar como resultado 3, correpondendo à string "abc".
*/

int difConsecutivos(char s[]){
    int i;
    int resultado=0;
    int n=1;
    for(i=0;s[i]!='\0';i++){
        if (s[i+1]!=s[i]) {n++;}
        else {
            if (n>resultado) {
                resultado=n;
                n=1;
            }
        }
    }
    return resultado;
}

// exercício 17

/* Defina uma função "int maiorPrefixo(char s1[], char s2[])" que calcula o comprimento do maior prefixo comum
entre as duas strings,
*/

int maiorPrefixo(char s1[],char s2[]){
    int i;
    int conta;
    for(i=0;s1[i]==s2[i];i++){
        conta++;
    }
    return conta;
}

// exercício 18

/* 
Defina uma função "int maiorSufixo(char s1[],char s2[])" que calcula o comprimento do maior sufixo comum entre as 2 strings.
*/

int maiorSufixo(char s1[],char s2[]){
    int i=comprimentoStr(s1);
    int j=comprimentoStr(s2);
    int conta;
    for(i,j;s1[i]==s[j];i--,j--){
        conta++;
    }
    return conta;
}

// exercício 19

/*
  Defina a função "int sufPref (char s1[], char s2[])" que calcula o tamanho
  do maior sufixo de s1 que é um prefixo de s2. Por exemplo
  "sufPref("batota","totalidade")" deve dar como resultado 4, uma vez que a
  string "tota" é um sufixo de "batota" e um prefixo de "totalidade".
*/

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
    return comprimentoStr(s1+i);
}

// exercício 20

/*
Defina uma função "int contaPal (char s[])" que conta as palavras de uma string. Uma palavra é uma sequência de caracteres
(diferentes de aspeto) terminada por um ou mais espaços. Assim se a string p tiver o valor "a a bb a", o resultado de "contaPal(p)" 
deve ser 4.
*/

int contaPal (char s[]){
    int i,r=0;
    if(s[0]!=' '&& s[0]!='\0') r++;
    for(i=0;s[i]!='\0';i++){
        if(s[i]==' ' && s[i+1]!=' ' && s[i+1]!='\0') r++;
    }
    return r;
}

// exercício 21

/*
Defina uma função "int contaVogais(char s[])" que retorna o nº de vogais da string s. Não se esqueça de considerar tanto 
maiúsculas como minúsculas.
*/

int contaVogais(char s[]){
    int i;
    int contav=0;
    for(i=0;s[i]='\0';i++){
        if (vogalcerto(s[i])) {contav++;}
    }
    return contav;
}

// exercício 22

/*
Defina uma função "int contida(char a[],char b[])" que testa se todos os caracteres da 1ª string também aparecem na 2ª.
Por exemplo, contida "braga" "bracara augusta" deve retornar verdadeiro enquanto que contida "braga" "bracarense" deve 
retornar falso.
*/

int charcontido(char s1,char s2[]){
    int i;
    int r=0;
    for(i=0;s2[i]!='\0';i++){
        if (s1==s2[i]) {r=1;}
    }
    return r;
}

int contida(char a[],char b[]){
    int i;
    int r=0;
    for(i=0;s1[i]!='\0';i++){
        if (charcontido(s1[i],s2)) {r=1;}
    }
    return r;
}

// exercício 23

/* 
Define uma função "int palindroma(char s[])" que testa se uma palavra é palíndroma, isto é, lê-se de igual forma
nos 2 sentidos.
*/

int palindroma(char s[]){
    int i;
    int j;
    int r=1;
    char v[j];
    mystrcpy(v,s);
    strrev(v);
    for(i=0;s[i]!='\0';i++){
        if (v[i]!=s[i]) {r=0;}
    }
    return r;
}

// -> ver se esta versão anterior está certa!!!!!!

// versão do rapaz

int palindorome(char s[]){
    int i, j, r=1;
    for(i=0,j=strlen(s)-1; s[i] != '\0'; i++ , j--){
        if (s[i]!=s[j]) r=0;
    }
    return r;
}

// exercício 24

/* 
A função remRep deve remover da string argumento todos os caracteres que se repetem sucessivamente
deixando lá apenas uma cópia.
*/

int remRep(char texto[]){
    int r=0;
    int i;
    int j;
    j = comprimentoStr(texto);
    char v[j];
    for(i=0;texto[i]!='\0';i++){
        if (texto[i+1]!=texto[i]){
            v[i]=texto[i];
            r++;
        }
        else 
    }
    return r;
}


// exercício 25

/* 
A função "int limpaEspacos(char t[])" elimina repetições sucessivas de espaços por um único espaço. A função deve retornar
o comprimento da string resultante.
*/

int limpaEspacos(char t[]){
    int j;
    int i;
    int r=0;
    for(i=0;t[i]!='\0';i++){
        if (t[i+1]==t[i] && t[i]==' ') {
            for(j=i;t[j]='\0';j++){
                t[j]=t[j+1];
            }
        }
        t[j]='\0';
        i--;
    }
    r=comprimentoStr(t);
    return r;
}

// exercício 26

/* 
a função "void insere(int v[], int N, int x)" que insere um elemento (x) num vector ordenado. Assuma que as N primeiras posições
do vector estão ordenadas e que por isso, após a inserção o vector terá as primeiras N+1 posições ordenadas.
*/

void insere(int s[], int N, int x){
    int i=N-1;
    while(s[i]>x && i>=0){
        s[i+1]=s[i];
        i--;
    }
    s[i+1]=x
}

// exercício 27

/*
A função "void merge(int r[], int a[], int b[], int na, int nb)" que, dados vetores ordenados a (com na elementos) e b (com nb elementos)
preenche o vector r (com na+nb elementos) com os elementos de a e b ordenados.
*/

void merge(int r[], int a[], int b[], int na, int nb){
    int ia;
    int ib;
    int ir;
    for(ia=ib=ir=0;ia<na && ib<nb;ir++){
        if (a[ia]<=b[ib]) {r[ir]=a[ia++];}
        else {r[ir]=b[ib++];}
    }
}

// exercício 28

/*
A uma função "int crescente(int a[], int i, int j)" que testa se os elementos do vector a, entre as posições i e j (inclusive) estão 
ordenados por ordem crescente.
A função deve retornar 1 ou 0 consoante o vector esteja ou não ordenado.
*/ 

int crescente(int a[],int i; int j){
    int a;
    int b;
    int r=1;
    if (i<j) {
        for(a=i;a<=j;a++){
            if (a[a+1]<a[a]) {r=0;}
        }
    }
    else {
        for(b=j;b<=i;b++){
            if (a[b+1]<a[b]) {r=0;}
        }
    }
    return r;
    
}

// exercício 29

/*
A função "int retiraNeg(int v[], int N)" que retira os nº negativos de um vetor com N inteiros.
A função deve retornar o nº de elementos que não foram retirados.
*/

int retiraNeg(int v[],int N){
    int conta=N;
    int i;
    int j;
    for(i=0;i<N;i++){
        if (v[i]<0) {
            for(j=N-1;j>=i;j--){
                v[j-1]=v[j];
                conta--;
            }
        }
    }
    return conta;
}

// exercício 30

/* 
Defina uma função "int menosFreq(int v[], int N)" que recebe um vector v com N elementos ordenado por ordem crescente e 
retorna o menos frequente dos elementos do vector. Se houver mais do que um elemento nessas condições deve retornar o que 
começa por aparecer no índice mais baixo.
*/

int menosFreq(int v[], int N){
    int i;
    int j;
    int conta;
    int min=v[0];
    int n=N;
    int r=0;

    for(i=0; i<N; i++){
        conta=0;
        for(j=i;j<N;j++){
            if (v[i]==v[j]) {conta++;}
        }
        if(conta<n) {
            min= v[i];
            n=conta;
        }
    }
    r=n;
    return r;
}

// exercício 31

/* 
A função maisFreq(int v[],int N) que recebe um vector v com N elementos ordenado por ordem crescente e retorna o mais frequente 
dos elementos do vector. Se houver mais do que um elemento nessas condições deve retornar o que começa por aparecer 
no índice mais baixo.
*/

int maisFreq(int v[], int N){
    int i;
    int j;
    int conta;
    int min=v[0];
    int r=0;

    for(i=0; i<N; i++){
        conta=0;
        for(j=i;j<N;j++){
            if (v[i]==v[j]) {conta++;}
        }
        if(conta>n) {
            min = v[i];
            n=conta;
        }
    }
    r=n;
    return r;
}


// exercício 32

/* 
A função "int maxCresc(int v[],int N)" que calcula o comprimento da maior sequência crescente de elementos consecutivos num vector
v com N elementos. Por exemplo, se o vector contiver 10 elementos pela seguinte ordem {1,2,3,2,1,4,10,12,5,4}, a função deverá
retornar 4, correspondendo ao tamanho da sequência {1,4,10,12}.
*/

int maxCresc(int v[],int N){
    int n=N;
    int conta;

    for(i=0;i<N;i++){
        conta=0;
        for(j=i;j<N;j++){
            if(v[j]<v[j+1]) {conta++;}
        }
        if (conta>n){
            n=conta;
        }
    }
    return n;
}

// exercício 33

/* 
A função "int elimRep(int v[], int n)" que recebe um vector v com n inteiros e elimina as repetições. A função deverá retornar o nº
de elementos do vector resultante. Por exemplo, se o vector v contiver nas suas primeiras 10 posições os nº 
{1,2,3,2,1,4,2,4,5,4} a invocação elimRep(v,10) deverá retornar 5 e colocar nas primeiras 5 posições do vector os elementos 
{1,2,3,4,5}.
*/

int elimRep (int v[], int N) {
    int r=1;
    int i;
    int j;
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

// exercício 34

/*
A uma função "int elimRepOrd(int v[], int n)" que recebe um vector v com n inteiros ordenado por ordem crescente e elimina 
as repetições.
A função deverá retornar o nº de elementos do vector resultante.
*/

int elimRepOrd(int v[], int N){
    int conta=0;
    int i;
    int j;
    int n=N;
    for(i=0;i<n;i++){
        if(v[i+1]==v[i]){
            for(j=i;j<n;j++){
                v[j]=v[j+1];
                n--;
                i--;
            }
        }
        else{conta++;}
    }
    return conta;
}

// -> versão do outro rapaz

int elimRepOrd(int v[], int N){
    int i;
    int j=0;
    for(i=0; i<N; i++){
        if(v[i]!=v[j]){
            j++;
            v[j] = v[i];
        }
    }
    N = j+1;
    return N;
}

// exercício 35 

/* 
A uma função int comunsOrd (int a[], int na, int b[], int nb) que calcula quantos elementos os vectores a (com na elementos) 
e b (com nb elementos) têm em comum. Assuma que os vectores a e b estão ordenados por ordem crescente.
*/

int comunsOrd (int a[], int na, int b[], int nb){
    int r = 0;
    int i;
    int j;
    for(i=0;i<na;){
        for(j=0;j<nb;){
            if(a[i]==b[j]){
                r++;
                i++;
                j++;
            }
            else {
                if (a[i]<b[j]) {i++;}
                else {j++;}
            }
        }
    }
    return r;
}


// exercício 36

/* a função int comuns (int a[], int na, int b[], int nb) que calcula quantos elementos do vector a (com na elementos) 
ocorrem no vector b (com nb elementos). Assuma que os vectores a e b não estão ordenados e defina a função sem alterar os vectores.
*/

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

// exercício 37

/* Defina uma função int minInd (int v[], int n) que, dado um vector v com n inteiros, retorna o 
índice do menor elemento do vector.
*/

int minInd (int v[], int n) {
    int i;
    int a=v[0];
    int r=-1;
    if(n==0) return r;
    r=0;
    for(i=0;i<n;i++){
        if (a>=v[i]) {
            a=v[i];
            r=i;
        }
    }
    return r;
}

// exercício 38

/* a função void somasAc (int v[], int Ac [], int N) que preenche o vector Ac com as somas acumuladas do vector v. 
Por exemplo, o elemento na posição Ac[3] deve ser calculado como v[0]+v[1]+v[2]+v[3].
*/

void somasAc (int v[], int Ac [], int N){
    int i;
    int j;
    int a;
    for(i=0;i<N;i++){
        for(j=0;j<=N;j++){
            a += v[j];
            Ac[i] = a;
        }
    }
}

// exercício 39

/*
Defina uma função "int triSup (int N, int m [N][N])" que testa se uma matriz quadrada é triangular superior,
i.e., que todos os elementos abaixo da diagonal são zeros.
*/

int triSup (int N, int m [N][N]) {
    int l,c;
    for(l=1;l<N;l++){
        for(c=0;c<l;c++){
            if(m[l][c]!=0) return 0;
        }
    }
    return 1;
}

// exercício 40

/*
  Defina uma função "void transposta (int N, float m[N][N])" que transforma
  uma matriz na sua transposta.
*/

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

// exercício 41

/*
  Defina uma função "void addTo (int N, int M, int a [N][M], int b[N][M])"
  que adiciona a segunda matriz à primeira.
*/

void addTo(int N, int M, int a[N][M], int b[N][M]){
    int i,j;
    for(i=0;i<N;i++){
        for(j=0;j<M;j++){
            a[i][j] += b[i][j];
        }
    }
}

// exercício 42

/* 
A função int unionSet (int N, int v1[N], int v2[N], int r[N]) que coloca no array \texttt{r} o resultado da união 
dos conjuntos v1 e v2.
*/

int unionSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0;i<N;i++){
        if( v1[i]==1 || v2[i]==1 ) {r[i]=1;}
        else {r[i]=0;}
    }
    return 0;
}

// exercício 43

/* 
A função int intersectSet (int N, int v1[N], int v2[N], int r[N]) que coloca no array r o resultado da intersecção 
dos conjuntos v1 e v2.
*/

int intersectSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0;i<N;i++){
        if ( v1[i]==0 || v2[i]==0 ) {r[i]=0;}
        else {r[i]=1;}
    }
    return 0;
}

// exercício 44

/* 
A função int intersectMSet (int N, int v1[N], int v2[N], int r[N]) que coloca no array r o resultado da intersecção 
dos multi-conjuntos v1 e v2.
*/

int intersectMSet (int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0; i<N; i++){
        if(v1[i] > v2[i]) r[i] = v2[i];
        else r[i]=v1[i];
    }
    return 0;
}

// exercício 45

/* 
A função int unionMSet (int N, int v1[N], int v2[N], int r[N]) que coloca no array r o resultado da união dos 
multi-conjuntos v1 e v2.
*/

int unionMSet(int N, int v1[N], int v2[N], int r[N]){
    int i;
    for(i=0; i<N ;i++){
        if(v1[i]>v2[i]) r[i] = v1[i];
        else r[i]=v2[i];
    }
    return 0;
}

// exercício 46

/* 
A função int cardinalMSet (int N, int v[N]) que calcula o 
número de elementos do multi-conjunto v.
*/

int cardinalMSet (int N, int v[N]){
    int i;
    int r=0;
    for(i=0;i<N;i++){
        r += v[i];
    }
    return r;
}

// exercício 47

typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;

typedef struct posicao {
   int x, y;
} Posicao;

Posicao posFinal (Posicao inicial, Movimento mov [], int N);

Posicao posFinal (Posicao inicial, Movimento mov[], int N){
    // dada uma posição inicial e um array mov com N movimentos, 
    // calcula a posição final do robot depois de efectuar essa sequencia de movimentos
    int i;
    for(i=0; i<N; i++){
        if (mov[i] == Norte) inicial.y++;
        else if(mov[i] == Sul) inicial.y--;
        else if(mov[i] == Oeste) inicial.x--;
        else if(mov[i] == Este) inicial.x++;
    }
    return inicial;
}

// exercício 48

int caminho (Posicao inicial, Posicao final, Movimento mov[], int N){
    // Dadas as posições inicial e final do robot, preenche o array mov com os movimentos 
    // suficientes para que o robot passe de uma posição para a outra.
    // A função deverá preencher no máximo N elementos do array e retornar o nú́mero de elementos preenchidos.
    // Se não for possível atingir a posição final com N movimentos, a função deverá retornar um nú́mero negativo.
    int i;
    int r=0;
    for(i=0;(inicial.x != final.x || inicial.y != final.y);i++){
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
        r++;
    }
    if (r>N) return -1;
    return r;
}

// exercício 49

typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;

typedef struct posicao {
   int x, y;
} Posicao;

// função auxiliar que calcula a distância de um ponto à origem

int dist(Posicao pos){
    int distancia;
    distancia = sqrt((pos.x)*(pos.x) + (pos.y)*(pos.y))
    return distancia;
}

int maiscentral (Posicao pos[], int N){
    int i;
    int r=0;
    int min=dist(pos[0]);
    int aux=0;
    for(i=0;i<N;i++){
        aux=dist(pos[i])
        if(aux<min) {
            r=i;
            min=pos[i];
        }
    }
    return r;
}

// exercício 50

typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;

typedef struct posicao {
   int x, y;
} Posicao;

// Função auxilixar que vê se os pontos são vizinhos ou não

int saovizinhos(Posicao p, Posicao pos){
    int r=1;
    if (p.x==pos.x && p.y== pos.y + 1) {break;}
    else if(p.x==pos.x && p.y == pos.y - 1) {break;}
    else if(p.y==pos.y && p.x == pos.x + 1) {break;}
    else if(p.y==pos.y && p.x == pos.x -1) {break;}
    else r=0;
    return r;
}

int vizinhos (Posicao p, Posicao pos[], int N) {
    int i;
    int contavizinhos = 0;
    for(i=0;i<N;i++){
        if (saovizinhos(p,pos[i])) {contavizinhos++;}
    }
    return contavizinhos;
}



