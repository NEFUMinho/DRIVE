#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define Size 10
typedef struct nodo {
    char *chave; int ocorr;
    struct nodo *prox;
} Nodo, *THash [Size];


/* hash function */
unsigned hash(char *str){
    unsigned hash = 5381;
    int c;

    while (c = *str++) {
        /* hash * 33 + c */
        hash = ((hash << 5) + hash) + c;
    }

    return hash;
}

/* initializes the hash table with empty positions */
void initEmpty (THash t) {
    for (unsigned i = 0; i < Size; i++) {
        t[i] = NULL;
    }
}

/* adds an ocorrence of a word */
void add (char *s, THash t) {
    unsigned index = hash(s) % Size;

    Nodo * temp = t[index];
    // find the word in the corresponding chain
    while (temp != NULL && strcmp(temp->chave, s) != 0) {
        temp = temp->prox;
    }

    if (temp != NULL) {
        temp->ocorr++;
    } else {
        // create a new node if the word does not exist
        Nodo *new = malloc(sizeof(Nodo));
        new->ocorr = 1;
        new->chave = s;

        // insert at the begining
        new->prox = t[index];
        t[index] = new;
    }
}

/* searches s in the table */
int lookup (char *s, THash t) {
    unsigned index = hash(s) % Size;

    Nodo * temp = t[index];
    // find the word in the corresponding chain
    while (temp != NULL && strcmp(temp->chave, s) != 0) {
        temp = temp->prox;
    }

    if (temp != NULL)
        return temp->ocorr;
    return 0;
}

/* removes an ocurrence of s */
int removeT (char *s, THash t) {
    unsigned index = hash(s) % Size;

    Nodo ** temp = &(t[index]);
    // find the word in the corresponding chain
    while (*temp != NULL && strcmp((*temp)->chave, s) != 0) {
        temp = &((*temp)->prox);
    }

    if (*temp != NULL) {
        (*temp)->ocorr--;

        // if there are no more ocurrences of the word, free it
        if ((*temp)->ocorr == 0) {
            Nodo *aux = (*temp)->prox;
            free(*temp);
            *temp = aux;
        }

        return 0;
    }

    return 1;
}

void show(THash t) {
    Nodo * n = NULL;
    for (int i = 0; i < Size; i++) {
        printf("index [%d]\n", i);
        n = t[i];
        while (n != NULL) {
            printf("\t%s -> %d\n", n->chave, n->ocorr);
            n = n->prox;
        }
    }
}