#include <stdio.h>
#include <stdlib.h>

typedef struct celula {
    char *palavra;
    int ocorr;
    struct celula * prox;
} * Palavras;

void libertaLista (Palavras);
int quantasP (Palavras);
void listaPal (Palavras);
char * ultima (Palavras);
Palavras acrescentaInicio (Palavras , char *);
Palavras acrescentaFim (Palavras, char *);
Palavras acrescenta (Palavras, char *);
struct celula * maisFreq (Palavras);
/*Versão recurssiva:
void libertaLista (Palavras l){
    if(l!=NULL){
        libertaLista(l->prox);
        free(l);
    }
}
*/

void libertaLista (Palavras l){
    Palavras aux=l;
    while(aux!=NULL){
        Palavras tmp=aux->prox;
        free(aux);
        aux=tmp;
    }
}

int quantasP (Palavras l){
    int c;
    while(l!=NULL){
        c++;
        l=l->prox;
    }
    return c;
}

void listaPal (Palavras l){
    while(l!=NULL){
        printf("%s:%d\n",l->palavra,l->ocorr);
        l=l->prox;
    }
}
char * ultima (Palavras l){
    if (l==NULL) {return NULL;}
    while(l->prox!=NULL) {l=l->prox;}
    return l->palavra;
}
Palavras acrescentaInicio (Palavras l, char *p){
    Palavras aux=malloc(sizeof(struct celula));
    aux->palavra=p;
    aux->ocorr=1;
    aux->prox=l;
    return aux;
}
Palavras acrescentaFim (Palavras l, char *p){
    Palavras inicio=l,nova = malloc(sizeof(struct celula));
    nova->palavra=p;
    nova->ocorr=1;
    nova->prox=NULL;
    if(l==NULL) {return nova;}
    while(l->prox!=NULL) {l=l->prox;}
    l->prox=nova;
    return inicio;
}
Palavras acrescenta (Palavras l, char *p){
    Palavras aux,nova;
    if(l==NULL||strcmp(l->palavra,p)>0){
        return acrescentaInicio(l,p);
    }
    if (strcmp(l->palavra,p)==0){l->ocorr++;}
    else {
        for(aux=l;aux->prox!=NULL||strcmp(aux->prox->palavra,p)<0;aux=aux->prox){
            if(aux->prox==NULL||strcmp(aux->prox->palavra,p)>0){
                aux->prox=acrescentaInicio(aux->prox,p);
            }
            else { aux->prox->ocorr++; }
        }
    }
    return l;
}
struct celula * maisFreq (Palavras l){
    struct celula * max=NULL;
    int maxp=0;
    while(l!=NULL){
        if(l->ocorr>maxp) {max=l;maxp=l->ocorr;}
        l=l->prox;
    }
    return max;
}

int main () {
    Palavras dic = NULL;

    char * canto1 [44] = {"as", "armas", "e", "os", "baroes", "assinalados",
                          "que", "da", "ocidental", "praia", "lusitana", 
                          "por", "mares", "nunca", "de", "antes", "navegados",
                          "passaram", "ainda", "alem", "da", "taprobana",
                          "em", "perigos", "e", "guerras", "esforcados",
                          "mais", "do", "que", "prometia", "a", "forca", "humana",
                          "e", "entre", "gente", "remota", "edificaram", 
                          "novo", "reino", "que", "tanto", "sublimaram"};

    printf ("\n_____________ Testes _____________\n\n");

    int i; struct celula *p;
    for (i=0;i<44;i++) {dic=acrescentaInicio (dic, canto1[i]);}

    printf ("Foram inseridas %d palavras\n", quantasP (dic));
    printf ("palavras existentes:\n");
    listaPal (dic);
    printf ("última palavra inserida: %s\n", ultima (dic));

    libertaLista (dic);

    dic = NULL;

    srand(42);
    
    for (i=0; i<1000; i++)
        dic = acrescenta (dic, canto1 [rand() % 44]);
    
    printf ("Foram inseridas %d palavras\n", quantasP (dic));
    printf ("palavras existentes:\n");
    listaPal (dic);
    printf ("última palavra inserida: %s\n", ultima (dic));
    
    p = maisFreq (dic);
    //printf ("Palavra mais frequente: %s (%d)\n", p->palavra, p->ocorr);
    
    printf ("\n_________ Fim dos testes _________\n\n");

    return 0;
}

