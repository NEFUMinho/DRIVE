#include "grafos.h"
#include <stdio.h>


int excentricidadeV(GrafoL g, int v) {
    int i, tam, cor[NV], orla[NV], pesos[NV];
    int maxV = v;
    LAdj x;

    // inicializacoes
    for (i = 0; i < NV; i++)
        cor[i] = 0; // nao visitado

    orla[0] = v;
    tam = 1;
    pesos[v] = 0;
    cor[v] = 1; // na orla

    while (tam > 0) {
        // seleccionar vertice de menor peso
        i = minIndPeso(orla, pesos, tam);
        swap(orla, i, --tam);
        v = orla[tam];
        cor[v] = 2; // visitado

        for (x = g[v]; x != NULL; x = x->prox) {
            if (cor[x->dest] == 0) {
                cor[x->dest] = 1;
                orla[tam++] = x->dest;
                pesos[x->dest] = pesos[v] + x->custo;
            } else if (cor[x->dest] == 1 && pesos[v] + x->custo < pesos[x->dest])
                pesos[x->dest] = pesos[v] + x->custo;

            if (pesos[maxV] < pesos[x->dest])
                maxV = x->dest;
        }
    }

    return pesos[maxV];
}

int geraCaminhoAutonomia(GrafoL g, int or, int pais[], int pesos[], int autonomia) {
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
                pesos[x->dest] = pesos[v] + x->custo;
                if (x->custo < autonomia) {
                    orla[tam++] = x->dest;
                    pais[x->dest] = v;
                }
            } else if (cor[x->dest] == 1 && pesos[v] + x->custo < pesos[x->dest]) {
                pesos[x->dest] = pesos[v] + x->custo;
                if (x->custo < autonomia)
                    pais[x->dest] = v;
            }
        }
    }

    return r;
}

typedef struct fringe {
    int size;
    int edges[NV];
} * Fringe;

int initFringe(Fringe f) {
    f->size = 0;
    return 0;
}

int addEdgeFringe(Fringe f, int v, int custo[]) {
    f->edges[f->size++] = v;
    return 0;
}

int updateFringe(Fringe f, int v, int pesos[]) {
    return 0;
}

int getEdge(Fringe f, int pesos[]) {
    int i, minInd = 0, r;

    for (i = 1; i < f->size; i++)
        if (pesos[f->edges[i]] < pesos[f->edges[minInd]])
            minInd = i;

    r = f->edges[minInd];
    f->size--;
    f->edges[minInd] = f->edges[f->size];

    return r;
}

int Prim(GrafoL g, int pesos[], int pais[]) {
    int res = 0, v;
    LAdj it;
    int cor[NV];
    struct fringe f;
    int fringeSize;

    for (v = 0; v < NV; v++)
        cor[v] = 0; // nao visitado

    initFringe(&f);
    fringeSize = 0;
    v = 0;

    cor[v] = 1; // em visita
    pesos[v] = 0;
    addEdgeFringe(&f, v, pesos);
    fringeSize++;

    while (fringeSize > 0) {
        v = getEdge(&f, pesos);
        fringeSize--;
        res += pesos[v];
        cor[v] = 2; // visitado

        for (it = g[v]; it != NULL; it = it->prox)
            // vértice não visitado ou em visita com menor custo
            if ((cor[it->dest] == 0) || (cor[it->dest] == 1 && pesos[it->dest] > it->custo)) {
                pais[it->dest] = v;
                pesos[it->dest] = it->custo;
                if (cor[it->dest] == 0) {
                    addEdgeFringe(&f, it->dest, pesos);
                    fringeSize++;
                } else
                    updateFringe(&f, it->dest, pesos);
            }
    }

    return res;
}

int diametro(GrafoL g) {
    int custo = 0, max = 0;
    LAdj it;
    int u, v, x;
    GrafoM gm;

    // inicializacao da matriz
    for (u = 0; u < NV; u++) {
        for (v = 0; v < NV; v++)
            gm[u][v] = 0;
        for (it = g[u]; it != NULL; it = it->prox)
            gm[u][it->dest] = it->custo;
    }

    // adição de arestas
    for (x = 0; x < NV; x++)
        for (u = 0; u < NV; u++)
            if (gm[u][x] != 0)
                for (v = 0; v < NV; v++)
                    if (gm[x][v] != 0) {
                        custo = gm[u][x] + gm[x][v];
                        if (gm[u][v] == 0 || gm[u][v] > custo) {
                            gm[u][v] = custo;
                            if (custo > max)
                                max = custo;
                        }
                    }

    return max;
}

/*
    Análise de complexidade:
        - chamar repetidamente a função dijkstraSP():
                O(V * (V * V + E)) = O(V^3 + V * E)
        - algoritmo de Floyd Warshal (dado pelos 3 ciclos):
            O(V * V * V) = O(V^3)
*/
