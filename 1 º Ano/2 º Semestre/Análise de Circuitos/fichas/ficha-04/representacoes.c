#include "grafos.h"
#include <stdlib.h>

/* complexidade: O(V^2) */
void fromMat(GrafoM in, GrafoL out) {
    int i, j;
    LAdj temp = NULL;
    for (i = 0; i < NV; i++) {
        out[i] = NULL;
        for (j = NV - 1; j >= 0; j--) {
            if (in[i][j] != 0) {
                temp = malloc(sizeof(struct aresta));
                temp->dest = j;
                temp->custo = in[i][j];
                temp->prox = out[i];
                out[i] = temp;
            }
        }
    }
}

/* complexidade: O(V + E) */
void inverte(GrafoL in, GrafoL out) {
    int i;
    for (i = 0; i < NV; i++)
        out[i] = NULL;

    LAdj temp = NULL, build = NULL;
    for (i = NV - 1; i >= 0; i--) {
        temp = in[i];

        while (temp != NULL) {
            build = malloc(sizeof(struct aresta));
            build->dest = i;
            build->custo = temp->custo;

            build->prox = out[temp->dest];
            out[temp->dest] = build,

            temp = temp->prox;
        }
    }
}

/* complexidade: O(V + E) */
int inDegree(GrafoL g) {
    int graus[NV];
    int i, max = 0;

    for (i = 0; i < NV; i++)
        graus[i] = 0;

    LAdj temp = NULL;
    for (i = 0; i < NV; i++) {
        temp = g[i];
        while (temp != NULL) {
            graus[temp->dest]++;
            if (graus[temp->dest] > graus[max])
                max = temp->dest;

            temp = temp->prox;
        }
    }

    return graus[max];
}

/* complexidade: O(V + E) */
int colorOK(GrafoL g, int cor[]) {
    int i;
    LAdj temp = NULL;
    char cond = 1;

    for (i = 0; i < NV && cond != 0; i++) {
        temp = g[i];
        while (temp != NULL && cond != 0) {
            cond = cor[i] != cor[temp->dest];
            temp = temp->prox;
        }
    }

    return cond;
}

/* complexidade: O(V + E) */
int homomorfOK(GrafoL g, GrafoL h, int f[]) {
    int i;
    LAdj temp = NULL, other = NULL;

    for (i = 0; i < NV; i++) {
        for (temp = g[i]; temp != NULL; temp = temp->prox) {
            for (other = h[f[i]]; other != NULL; other = other->prox)
                if (temp->dest == f[other->dest])
                    break;

            if (other == NULL)
                return 0;
        }
    }

    return 1;
}
