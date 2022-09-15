#include <stdio.h>
#include <string.h>

//////////////FUNcOES AUXILIARES /////////////////

//isVogal() -> testa se o char recebido é uma vogal (maiuscula ou minuscula)
int isVogal(char a) {

    return ( a=='a' || a=='A' ||
             a=='e' || a=='E' ||
             a=='i' || a=='I' ||
             a=='o' || a=='O' ||
             a=='u' || a=='U' );
}

//swap() -> troca o valor das posicoes 'i' e 'c' do vetor 'v'~
void swap(int v[], int i, int j) {
  //linhas de codigo em comentario podem substituir as anteriores

    int tmp = *(v+i);
    //int tmp = v[i];

    *(v+i) = *(v+j);
    //v[i] = v[j];

    *(v+j) = tmp;
    //v[j] = tmp;

}

//simNao() -> retorna "nao" se tiver como argumento o boleano False/0
void simNao (int x){
    if (!x) printf (" nao");
}

//imparr() -> imprime um array 'v' com tamanho 'N'
void imparr(int v[], int N) {
    printf("{ ");
    for(int i = 0; i<N; i++) {
        printf("%d, ",v[i]);
    }
    printf("\b\b }");     //o uso de '\b' apaga o ultimo caracter, ao colocar dois pretendo apagar o ', '
} 

/////////////////////////////////////////////////

////FUNCOES SOBRE STRINGS

//ex.1
int contavogais (char *s) {
    int i, c=0;

    for(i=0; s[i]!='\0'; i++) {
        if (isVogal(s[i])) {c++;}
    }

    return c;
}

//ex.2.1 (c/array_aux)
int retiraVogaisRep1(char *s) {
    int i,j,t;
    int c;

    for (t=0; s[t]!='\0'; t++) {;}
    char aux[t];

    for(i=0,j=0; s[i]!='\0'; i++) {
        if (isVogal(s[i])) {
            if (s[i] != s[i+1]) {
                aux[j]=s[i];
                j++;
            }
        }
        else { aux[j]=s[i];
               j++;
        }
    }
    aux[j]='\0';

    c= t-j;

    for(i=0; aux[i]!='\0';i++) { s[i]= aux[i];}
    s[i]='\0';

    return c;
}

//ex.2.2 (s/array_aux)
int retiraVogaisRep2(char *s) {
    int i,j;
    int c;

    for(i=0,j=0; s[i]!='\0'; i++) {
        if (isVogal(s[i])) {
            if (s[i]!=s[i+1]) {
                s[j]=s[i];
                j++;
            
            }
        }
        else { s[j]=s[i];
               j++;
        }
    }

    s[j]='\0';
    c = i-j;

    return c;
}

//ex.3.1 (c/array_aux)
int duplicaVogais1(char *s) {
    int i,j;
    int c;

    char aux[2*strlen(s)];

    for(i=0,j=0; s[i]!='\0'; i++) {
        if (isVogal(s[i])) {
            aux[j]=s[i];
            aux[j+1]=s[i];
            j+=2;
        }
        else { aux[j]=s[i];
               j++;
        }
    }
    aux[j]='\0';
    
    c=j-i;
    
    for (j=0; aux[j]!='\0'; j++) { s[j]= aux[j];}
    s[j]='\0';

    return c;
}

//ex.3.2 (s/array_aux)
int duplicaVogais2(char *s) {
    int i,j,t;
    int c=0;

    for(t=0; s[t]!='\0'; t++) {;}

    for(i=t; i>=0; i--) {
        if (isVogal(s[i])) {
            for(j=t; j>=i; j--) {
                s[j+1] = s[j];
            }
            t++;
            c++;
        }
    }
    return c;
}

////ARRAYS ORDENADOS

//ex.1
int ordenado (int v[], int N) {
    int i;

    for(i=0; i<N-1 && v[i]<=v[i+1]; i++) {;}

    if (i==N-1) {return 1;}  //TRUE -> 1

    return 0;   //FALSE -> 0

    //return (i==N-1);      //alternativa as duas ultimas linhas de codigo acima
}

//ex.2
void merge (int a[], int na, int b[], int nb, int r[]) {
    int i=0, j=0, k=0;
    //primeiro analisamos ate ao indice que corresponde ao menor comprimento dos arrays a e b
    while(i<na && j<nb){
        if (a[i] < b[j]){
            r[k] = a[i];
            i++;
            k++;
        }
        else {
            r[k] = b[j];
            j++;
            k++;
        }
    }

    //se por ventura ainda existiam elemento no array a que nao tinham sido colocados (pois no array b os
    //elementos eram todos menores que esses restantes elementos do array a )
    while(i<na){
        r[k]=a[i];
        k++;
        i++;
    }

    //o mesmo pode acontecer para o array b
    while(j<nb){
        r[k]=b[j];
        j++;
        k++;
    }
}

//ex.3.1.1 (c/array_aux)
int partition11 (int v[], int N, int x) {
    int i, j=0, c=0;

    int aux[N];

    for(i=0; i<N; i++) {
        if (v[i]<=x) {
            aux[j]=v[i];
            j++;
            c++;
        }
    }
    for (i=0; i<N; i++) {
        if (v[i]>x) {
            aux[j]= v[i];
            j++;
        }
    }

    for (i=0; i<N;i++) {
        v[i]=aux[i];
    }

    return c;
}

//ex.3.1.2 (c/array_aux) (OUTRA VERSAO)
int partition12 (int v[], int N, int x) {
    int i, il=0, ir=N-1;
    int aux[N];

    for(i=0; i<N; i++) {

        if (v[i]<=x) { aux[il++]=v[i]; }

        else { aux[ir--]=v[i]; }
    }

    for (i=0; i<N;i++) {
        v[i]=aux[i];
    }

    return il;
}

//ex.3.2 (s/array_aux)
int partition2 (int v[], int N, int x) {
    int i, c=0;

    for (i=0; i<N; i++) {
        if (v[i]<=x) {
            swap(v,i,c);
            c++;
        }
    }

    return c;
}

/////////////////////////////////////////////////

int main() {

    // //FUNCOES SOBRE STRINGS
    // char s1 [100] = "Estaa e umaa string coom duuuplicadoos";
    // int x;
    // printf("String original: \"%s\" \n", s1);
    
    // //ex.1
    // printf ("A string \"%s\" tem %d vogais\n", s1, contavogais(s1));
    
    // //ex.2.1
    // x = retiraVogaisRep1(s1);
    // printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s1);

    // //ex.2.2
    // x = retiraVogaisRep2 (s1);
    // printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s1);

    // //ex.3.1
    // x = duplicaVogais1(s1);
    // printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s1);

    // //ex.3.2
    // x = duplicaVogais2(s1);
    // printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s1);    

    // //ARRAYS ORDENADOS
    // int a [15] = {10, 3,45,56, 8,23,13,42,77,31,18,88,24,45, 1},
    //     b [10] = { 4,12,34,45,48,52,61,73,84,87}, 
    //     c [10] = { 1, 3, 8,22,33,35,38,41,44,49}, 
    //     d [50];
    // int x;

    // //ex.1
    // printf ("O array "); imparr(a,15);
    // simNao (ordenado (a,15)); printf (" esta ordenado.\n");
    // printf ("O array "); imparr(b,10);
    // simNao (ordenado (b,10)); printf (" esta ordenado.\n");    

    // //ex.2
    // printf ("\n\nMerge dos arrays "); imparr (b,10);
    // printf ("\ne                "); imparr (c,10); 
    // merge (b, 10, c, 10, d);
    // printf ("\nresulta em       "); imparr (d,20);

    // //ex.3.1.1
    // printf ("\n\n\nA particao do array  "); 
    // imparr (a,15);
    // printf ("\nusando 30 resulta em "); 
    // x = partition11 (a,15,30); 
    // imparr (a,15); printf (" e retorna %d \n", x);

    // //ex.3.1.2
    // printf ("\n\n\nA particao do array  "); 
    // imparr (a,15);
    // printf ("\nusando 30 resulta em "); 
    // x = partition12 (a,15,30); 
    // imparr (a,15); printf (" e retorna %d \n", x);

    // //ex.3.2
    // printf ("\n\n\nA particao do array  "); 
    // imparr (a,15);
    // printf ("\nusando 30 resulta em "); 
    // x = partition2 (a,15,30); 
    // imparr (a,15); printf (" e retorna %d \n", x);

    return 0;
}
