#ifndef GRAFOS_H
#define GRAFOS_H

// grafo pesado
#define GP 1
// grafo não pesado
#define GNP 0

#define NV 10

typedef struct aresta {
    int dest;
    int custo;
    struct aresta *prox;
} *LAdj, *GrafoL[NV];

typedef int GrafoM[NV][NV];

/* utils */
void showGrafoL(GrafoL g, int type);
void showGrafoM(GrafoM g, int type);
int DF(GrafoL g, int or, int v[], int p[], int l[]);
int BF(GrafoL g, int or, int v[], int p[], int l[]);
void swap(int array[], int i, int j);
int minIndPeso(int v[], int pesos[], int N);
int dijkstraSP(GrafoL g, int or, int pais[], int pesos[]);

/* representacoes */
void fromMat(GrafoM in, GrafoL out);
void inverte(GrafoL in, GrafoL out);
int inDegree(GrafoL g);
int colorOK(GrafoL g, int cor[]);
int homomorfOK(GrafoL g, GrafoL h, int f[]);

/* travessias */
int maisLonga(GrafoL g, int or, int p[]);
int componentes(GrafoL g, int c[]);
int ordTop(GrafoL g, int ord[]);
int ciclo(GrafoL g, int c[]);
int caminho(int L, int C, char *mapa[L], int ls, int cs, int lf, int cf);
void caminhoShow(int L, int C, char *mapa[L], int ls, int cs, int lf, int cf);

/* grafos pesados */
int excentricidadeV(GrafoL g, int v);
int geraCaminhoAutonomia(GrafoL g, int or, int pais[], int pesos[], int autonomia);
int Prim(GrafoL g, int pesos[], int pais[]);
int diametro(GrafoL g);


#endif