#include <stdio.h>
#include <string.h>

int e_vogal (char c){
    return (c=='A') || (c=='a') || (c=='E') || (c=='e') || (c=='I') || (c=='i') || (c=='O') || (c=='o') || (c=='U') || (c=='u');
}

int contaVogais (char *s) {
    int c=0,i;
    for(i=0;s[i]!='\0';i++){
        if(e_vogal(s[i])) c++;
    }
    return c;
}

int retiraVogaisRep1 (char *s){
    char tmp[strlen(s)+1];
    int i,j,c=0;
    for (i=0,j=0;s[i]!='\0';i++){
        tmp[j++]=s[i];
        if (e_vogal(s[i])){
            while (s[i+1]==s[i]){
                i++;
                c++;
            }
        }
    }
    for (i=0;i<j;i++) s[i]=tmp[i];
    s[j]='\0';
    return c;
}

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

int duplicaVogais1 (char *s){
    int c=0,i,j;
    char tmp[strlen(s)*2];
    for(i=0,j=0;s[i]!='\0';i++){
        tmp[j++]=s[i];
        if(e_vogal(s[i])){ 
            tmp[j++]=s[i];
            c++;
        }
    }
    for (i=0;i<j;i++){ 
        s[i]=tmp[i];
    }
    s[j]='\0';
    return c;
}

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

void dumpV (int v[], int N){
    int i;
    putchar ('{');
    for (i=0; i<N; i++) printf ("%2d ", v[i]);
    putchar ('}');
}
void simNao (int x){
    if (!x) printf (" não ");
}

int ordenado (int a[], int N){
    int i;
    for(i=1;i<N && a[i]>=a[i-1];i++);
    if(i==N) return 1;
    return 0;
}

void merge (int a[], int na, int b[], int nb, int r[]){
    int i,ja=0,jb=0;
    for(i=0;ja<na && jb<nb;i++){
        if(a[ja]<b[jb]) r[i]=a[ja++];
        else r[i]=b[jb++];
    }
    if(ja!=na){
        while(ja<na) r[i++]=a[ja++];
    }
    if(jb!=nb){
        while(jb<nb) r[i++]=b[jb++];
    }
}

void swap (int *x, int *y){
    int tmp=*x;
    *x=*y;
    *y=tmp;
}

int partition (int v[], int N, int x){
    int i=0,a=N-1;
    while(i<a){
        if(v[i]>x) {swap(v+i,v+a);a--;}
        else i++;
    }
    return a;
}

int main(){   
    char s1 [100] = "Estaa e umaa string coom duuuplicadoos";
    int x;
    
    printf ("Testes\n");
    printf ("A string \"%s\" tem %d vogais\n", s1, contaVogais (s1));
    
    x = retiraVogaisRep1 (s1);
    printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s1);
    
    char s2 [100] = "Estaa e umaa string coom duuuplicadoos";
    x = retiraVogaisRep2 (s2);
    printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s2);
    
    x = duplicaVogais1 (s1);
    printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s1);
    
    x = duplicaVogais2 (s2);
    printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s2);
    
    printf ("\nFim dos testes\n");
    
    int a [15] = {10, 3,45,56, 8,23,13,42,77,31,18,88,24,45, 1},
        b [10] = { 4,12,34,45,48,52,61,73,84,87}, 
        c [10] = { 1, 3, 8,22,33,35,38,41,44,49}, 
        d [50];
    int y;
    
    printf ("Testes\n\n");

    printf ("O array "); dumpV(a,15);
    simNao (ordenado (a,15)); printf (" está ordenado\n");
    printf ("O array "); dumpV(b,10);
    simNao (ordenado (b,10)); printf (" está ordenado\n");
    
    printf ("\n\nMerge dos arrays "); dumpV (b,10);
    printf ("\ne                "); dumpV (c,10); 
    merge (b, 10, c, 10, d);
    printf ("\nresulta em       "); dumpV (d,20);

    printf ("\n\n\nA partição do array  "); dumpV (a,15);
    printf ("\nusando 30 resulta em "); 
    y = partition (a,15,30); 
    dumpV (a,15); printf (" e retorna %d \n", y);

    printf ("\nFim dos testes\n");
    return 0;
}