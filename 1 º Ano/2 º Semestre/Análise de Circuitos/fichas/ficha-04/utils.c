#include "grafos.h"
#include <stdio.h>

static void lines(int N) {
    for (int i = 0; i < N; i++)
        printf("-");
    printf("\n");
}

void showGrafoL(GrafoL g, int type) {
    int i;
    LAdj temp = NULL;

    lines(NV * 4);

    for (i = 0; i < NV; i++) {
        printf("%2d | ->", i);
        temp = g[i];

        while (temp != NULL) {
            if (type == GP)
                printf("%2d -%2d ->", temp->custo, temp->dest);
            else
                printf("%2d ->", temp->dest);
            temp = temp->prox;
        }

        printf(" X\n");
    }

    lines(NV * 4);

    printf("\n");
}

void showGrafoM(GrafoM g, int type) {
    int i, j;

    lines(NV * 2 + 6);

    printf("   |");
    for (i = 0; i < NV; i++)
        printf("%2d", i);
    printf(" |\n");

    lines(NV * 2 + 6);

    for (i = 0; i < NV; i++) {
        printf("%2d |", i);
        for (j = 0; j < NV; j++) {
            if (g[i][j] == 0)
                printf(" -");
            else {
                if (type == GP)
                    printf("%2d", g[i][j]);
                else
                    printf(" X");
            }
        }
        printf(" |\n");
    }

    lines(NV * 2 + 6);
    printf("\n");
}

static int DFRec(GrafoL g, int or, int v[], int p[], int l[]) {
    int i;
    LAdj a;
    i = 1;
    v[or] = -1;

    for (a = g[or]; a != NULL; a = a->prox) {
        if (!v[a->dest]) {
            p[a->dest] = or;
            l[a->dest] = 1 + l[or];
            i += DFRec(g, a->dest, v, p, l);
        }
    }

    v[or] = 1;

    return i;
}

int DF(GrafoL g, int or, int v[], int p[], int l[]) {
    int i;
    for (i = 0; i < NV; i++) {
        v[i] = 0;
        p[i] = -1;
        l[i] = -1;
    }

    p[or] = -1;
    l[or] = 0;

    return DFRec(g, or, v, p, l);
}

int BF(GrafoL g, int or, int v[], int p[], int l[]) {
    int i, x;
    LAdj a;
    int q[NV], front, end;

    for (i = 0; i < NV; i++) {
        v[i] = 0;
        p[i] = -1;
        l[i] = -1;
    }

    front = end = 0;
    q[end++] = or; // enqueue
    v[or] = 1;
    l[or] = 0;
    p[or] = -1; // redundante
    i = 1;

    while (front != end) {
        x = q[front++]; // dequeue
        for (a = g[x]; a != NULL; a = a->prox) {
            if (!v[a->dest]) {
                i++;
                v[a->dest] = 1;
                p[a->dest] = x;
                l[a->dest] = 1 + l[x];
                q[end++] = a->dest; // enqueue
            }
        }
    }

    return i;
}

void swap(int array[], int i, int j) {
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

int minIndPeso(int v[], int pesos[], int N) {
    int i, r = 0;
    for (i = 1; i < N; i++)
        if (pesos[v[i]] < pesos[v[r]])
            r = i;

    return r;
}

int dijkstraSP(GrafoL g, int or, int pais[], int pesos[]) {
    int r, i, v, cor[NV], orla[NV], tam;
    LAdj x;

    // inicializacoes
    for (i = 0; i < NV; i++) {
        pais[i] = -2;
        cor[i] = 0; // nao visitado
    }

    r = 0;
    orla[0] = or;
    tam = 1;
    pesos[or] = 0;
    pais[or] = -1;
    cor[or] = 1; // na orla

    // ciclo
    while (tam > 0) {
        // seleccionar vertice de menor peso
        i = minIndPeso(orla, pesos, tam);
        swap(orla, i, --tam);
        v = orla[tam];
        r++;
        cor[v] = 2; // visitado

        for (x = g[v]; x != NULL; x = x->prox) {
            if (cor[x->dest] == 0) {
                cor[x->dest] = 1;
                orla[tam++] = x->dest;
                pais[x->dest] = v;
                pesos[x->dest] = pesos[v] + x->custo;
            } else if (cor[x->dest] == 1 && pesos[v] + x->custo < pesos[x->dest]) {
                pais[x->dest] = v;
                pesos[x->dest] = pesos[v] + x->custo;
            }
        }
    }

    return r;
}
