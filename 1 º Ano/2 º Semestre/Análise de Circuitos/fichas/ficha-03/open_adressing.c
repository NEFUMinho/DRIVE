#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define Size 10

#define Free 0
#define Used 1
#define Del 2

typedef struct bucket {
    int status; // Free | Used | Del
    char *chave; int ocorr;
} THash [Size];

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

/* finds the index in which s is, or should be */
int where (char *s, THash t) {
    unsigned index = hash(s) % Size;

    unsigned i;
    // find s or the first non used position
    for (i = 0; i < Size && t[index].status == Used && strcmp(t[index].chave, s) != 0; i++) {
        index = (index + 1) % Size;
    }

    unsigned pos = Size;
    if (i < Size) {
        // first non used position
        pos = index;
        if (t[index].status != Used) {

            // search for s
            for (i = 0; i < Size && t[index].status != Free && strcmp(t[index].chave, s) != 0; i++) {
                index = (index + 1) % Size;
            }

            // found s
            if (i < Size && t[index].status == Used)
                pos = index;
        }
    }

    return pos;
}

/* initializes the hash table with empty positions */
void initEmpty (THash t) {
    for (unsigned i = 0; i < Size; i++)
        t[i].status = Free;
}

/* adds an ocorrence of a word */
void add (char *s, THash t) {
    unsigned index = where(s, t);

    if (index < Size) {
        if (t[index].status == Used)
            t[index].ocorr++;
        else {
            t[index].status = Used;
            t[index].ocorr = 1;
            t[index].chave = s;
        }
    }
}

/* searchs for s in the table */
int lookup (char *s, THash t) {
    unsigned index = where(s, t);

    if (index < Size && t[index].status == Used)
        return t[index].ocorr;

    return 0;
}

/* removes an ocurrence of s */
int removeT (char *s, THash t) {
    unsigned index = where(s, t);

    if (index < Size && t[index].status == Used) {
        t[index].ocorr--;
        if (t[index].ocorr == 0)
            t[index].status = Del;

        return 0;
    }

    return 1;
}

/* cleans the table */
int garb_collection (THash t) {
    THash temp;
    unsigned i = 0, index = 0;

    for (i = 0; i < Size; i++) {
        temp[i].status = Free;
    }

    // fill the temporary array
    for (i = 0; i < Size; i++) {
        if (t[i].status == Used) {
            index = where(t[i].chave, temp);

            temp[index].status = Used;
            temp[index].ocorr = t[i].ocorr;
            temp[index].chave = t[i].chave;
        }

        t[i].status = Free;
        t[i].ocorr = 0;
        t[i].chave = NULL;
    }

    // fill the table
    for (i = 0; i < Size; i++) {
        t[i].status = temp[i].status;
        t[i].ocorr = temp[i].ocorr;
        t[i].chave = temp[i].chave;
    }

    return 0;
}


/*
Complexidade de garbage_collection:
    a tabela é percorrida 3 vezes, logo terá uma complexidade de O(N)
*/


void show(THash t) {
    for (int i = 0; i < Size; i++) {
        printf("index [%d] | status [%d]\n", i, t[i].status);
        if (t[i].status == Used)
            printf("\tchave: '%s' | ocorr: %d\n", t[i].chave, t[i].ocorr);
    }
}