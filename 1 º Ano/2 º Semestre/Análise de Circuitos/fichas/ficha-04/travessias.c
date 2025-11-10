#include "grafos.h"
#include <stdio.h>

int maisLonga(GrafoL g, int or, int p[]) {
    int q[NV], front, end;
    int vis[NV], dist[NV], pais[NV];
    int max = or;
    LAdj a;

    for (int i = 0; i < NV; i++) {
        vis[i] = 0;
        dist[i] = -1;
        pais[i] = -1;
    }

    front = end = 0;
    q[end++] = or;
    vis[or] = 1;
    dist[or] = 0;
    max = or;

    while (front != end) {
        or = q[front++];
        for (a = g[or]; a != NULL; a = a->prox)
            if (!vis[a->dest]) {
                vis[a->dest] = 1;
                pais[a->dest] = or;
                dist[a->dest] = 1 + dist[or];
                q[end++] = a->dest;
                if (dist[max] < dist[a->dest])
                    max = a->dest;
            }
    }
    
    int next = max;
    for (int i = dist[max]; i >= 0 && next != -1; i--) {
        p[i] = next;
        next = pais[next];
    }

    return dist[max];
}

int componentesRec(GrafoL g, int * stamp, int v, int estado[], int temp[], int c[]) {
    LAdj it;
    int r = 0;

    estado[v] = 1; // em visita
    c[v] = temp[v] = *stamp++;

    for (it = g[v]; it != NULL; it = it->prox)
        if (estado[it->dest] != 2) { // não visitado ou em visita
            if (estado[it->dest] == 0) // não visitado
                r += componentesRec(g, stamp, it->dest, estado, temp, c);
            if (c[it->dest] < c[v])
                c[v] = c[it->dest];
        }

    if (c[v] == temp[v])
        r++;
    
    estado[v] = 2; // visitado
    return r;
}

int componentes(GrafoL g, int c[]) {
    int estado[NV], temp[NV];
    int i, r, stamp = 0;

    for (i = 0; i < NV; i++)
        estado[i] = 0; // não visitado

    for (i = 0; i < NV; i++)
        if (estado[i] == 0)
            r += componentesRec(g, &stamp, i, estado, temp, c);

    return r;
}

int ordTop(GrafoL g, int ord[]) {
    LAdj it;
    int v, inicio, fim;
    int nant[NV]; // número de antecessores

    // calculo do grau de entrada
    for (v = 0; v < NV; v++)
        nant[v] = 0;
    for (v = 0; v < NV; v++)
        for (it = g[v]; it != NULL; it = it->prox)
            nant[it->dest]++;
    
    // inicializacao da queue
    inicio = fim = 0; // queue vazia
    for (v = 0; v < NV; v++)
        if (nant[v] == 0)
            ord[fim++] = v; // enqueue(v)

    // construção da ordenação
    while (inicio < fim) { // queue não vazia
        v = ord[inicio++]; // dequeue()
        for (it = g[v]; it != NULL; it = it->prox) {
            nant[it->dest]--;
            if (nant[it->dest] == 0)
                ord[fim++] = it->dest; // enqueue(it->dest)
        }
    }

    return inicio;
}

int cicloRec(GrafoL g, int v, int vis[], int pai[], int c[], int *cicloSize) {
    vis[v] = 1; // em visita

    int w;
    for (LAdj a = g[v]; a != NULL; a = a->prox) {
        w = a->dest;
        if (vis[w] == 0) {
            pai[w] = v;
            if (cicloRec(g, w, vis, pai, c, cicloSize) != 0)
                return 1;
        } else if (vis[w] == 1) {
            // existe ciclo: reconstruir
            int tmp[NV];
            int len = 0;

            tmp[len++] = w; // inicio do ciclo
            while (v != w) {
                tmp[len++] = v;
                v = pai[v];
            }

            // copiar ciclo para array c
            for (v = 0; v < len; v++)
                c[v] = tmp[len - 1 - v];
            
            *cicloSize = len;
            return 1;
        }
    }

    vis[v] = 2; // visitado
    return 0;
}

int ciclo(GrafoL g, int c[]) {
    int vis[NV] = {0};
    int pai[NV];
    int cicloSize = 0, i;

    for (i = 0; i < NV; i++)
        pai[i] = -1;

    for (i = 0; i < NV; i++)
        if (vis[i] == 0)
            if (cicloRec(g, i, vis, pai, c, &cicloSize) != 0)
                return cicloSize;

    return 0; // sem ciclos
}

struct ponto {
    int x;
    int y;
    int dist;
};

int caminho(int L, int C, char *mapa[L], int ls, int cs, int lf, int cf) {
    // movimentos possíveis (N, S, E, O)
    int dx[4] = {1, -1, 0, 0};
    int dy[4] = {0, 0, 1, -1};

    int i, j, nx, ny;
    int vis[L][C];
    for (i = 0; i < L; i++)
        for (j = 0; j < C; j++)
            vis[i][j] = 0;

    struct ponto fila[NV * NV];
    struct ponto atual;
    int inicio = 0, fim = 0;

    fila[fim++] = (struct ponto) {ls, cs, 0};
    vis[ls][cs] = 1;

    while (inicio < fim) {
        atual = fila[inicio++];
        // chegou ao ponto final
        if (atual.x == lf && atual.y == cf)
            return atual.dist;

        for (i = 0; i < 4; i++) {
            nx = atual.x + dx[i];
            ny = atual.y + dy[i];

            // verifica se as vizinhanças não são obstáculos, fora do mapa ou se já foram visitados
            if (nx >= 0 && nx < L && ny >= 0 && ny < C && !vis[nx][ny] && mapa[nx][ny] != '#') {
                vis[nx][ny] = 1;
                fila[fim++] = (struct ponto) {nx, ny, atual.dist + 1};
            }
        }
    }

    // se não houver caminho
    return -1;
}


void caminhoShow(int L, int C, char *mapa[L], int ls, int cs, int lf, int cf) {
    // movimentos possíveis (N, S, E, O)
    int dx[4] = {1, -1, 0, 0};
    int dy[4] = {0, 0, 1, -1};

    // associar movimentos
    char direcao[4] = {'S', 'N', 'E', 'O'};
    int visitado[L][C];
    // guarda o pai de cada célula
    struct ponto pai[L][C];
    // guarda o movimento que levou até lá
    char mov[L][C];
    int i, j, nx, ny;

    for (i = 0; i < L; i++)
        for (j = 0; j < C; j++) {
            visitado[i][j] = 0;
            pai[i][j].x = pai[i][j].y = -1;
            mov[i][j] = '?';
        }

    struct ponto fila[NV * NV];
    struct ponto atual;
    int inicio = 0, fim = 0;

    fila[fim++] = (struct ponto) {ls, cs, 0};
    visitado[ls][cs] = 1;

    while (inicio < fim) {
        atual = fila[inicio++];
        // encontrou ponto final
        if (atual.x == lf && atual.y == cf) {
            // reconstruir caminho
            char caminho_str[NV * NV];
            int len = 0;

            int x = lf, y = cf;
            // se não for o ponto de partida
            while (!(x == ls && y == cs)) {
                caminho_str[len++] = mov[x][y];
                nx = pai[x][y].x;
                ny = pai[x][y].y;
                x = nx;
                y = ny;
            }

            // inverter
            for (i = len - 1; i >= 0; i--)
                printf("%c ", caminho_str[i]);
            printf("\n");
        }

        for (i = 0; i < 4; i++) {
            nx = atual.x + dx[i];
            ny = atual.y + dy[i];

            // verifica se as vizinhanças não são obstáculos, fora do mapa ou se já foram visitados
            if (nx >= 0 && nx < L && ny >= 0 && ny < C && !visitado[nx][ny] && mapa[nx][ny] != '#') {
                visitado[nx][ny] = 1;
                pai[nx][ny] = (struct ponto){atual.x, atual.y, 0};
                mov[nx][ny] = direcao[i];
                fila[fim++] = (struct ponto){nx, ny, atual.dist + 1};
            }
        }
    }
}
