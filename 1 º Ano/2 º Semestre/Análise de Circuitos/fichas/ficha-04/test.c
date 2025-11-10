#include "grafos.h"
#include <stdio.h>

int main(void) {

    GrafoM gm1 = {{0, 5, 0, 2, 0, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 8, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 2 ,0, 0, 0, 2}
                 ,{0, 0, 0, 0, 0, 0 ,2, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 8, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 1, 0, 0}
                 ,{0, 0, 0, 2, 7, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 3, 0 ,0, 0, 0, 4}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 0, 0}
                 };
    GrafoM gm2 = {{0, 0, 1, 0, 0, 1 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 1, 0}
                 ,{0, 0, 0, 1, 0, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 0, 1}
                 ,{0, 0, 0, 1, 0, 0 ,1, 0, 0, 0}
                 ,{0, 0, 0, 1, 0, 0 ,0, 0, 0, 0}
                 ,{0, 0, 0, 1, 0, 1 ,0, 0, 0, 0}
                 ,{0, 0, 0, 0, 1, 0 ,0, 1, 0, 1}
                 ,{0, 0, 0, 0, 0, 0 ,0, 0, 0, 0}
                 };
    
    GrafoL gl1, gl2, gl3, gl4;
    fromMat(gm1, gl1);
    fromMat(gm2, gl2);

    showGrafoM(gm1, GP);
    showGrafoM(gm2, GNP);

    showGrafoL(gl1, GP);
    showGrafoL(gl2, GNP);

    inverte(gl1, gl3);
    inverte(gl2, gl4);

    showGrafoL(gl3, GP);
    showGrafoL(gl4, GNP);

    // inDegree

    printf("inDegree(gl1): %d\n", inDegree(gl1));
    printf("inDegree(gl2): %d\n", inDegree(gl2));
    printf("inDegree(gl3): %d\n", inDegree(gl3));
    printf("inDegree(gl4): %d\n", inDegree(gl4));

    // colorOk

    int cores1[NV] = {1,2,3,4,5,6,7,8,9,10};
    printf("\ncolorOK(gl1, cores1) == %s\n", colorOK(gl1, cores1) ? "true" : "false");
    printf("colorOK(gl2, cores1) == %s\n", colorOK(gl2, cores1) ? "true" : "false");
    int cores2[NV] = {1, 2, 1, 2, 1, 3, 3, 4, 0, 2};
    printf("colorOK(gl1, cores2) == %s\n", colorOK(gl1, cores2) ? "true" : "false");
    printf("colorOK(gl2, cores2) == %s\n", colorOK(gl2, cores2) ? "true" : "false");
    int cores3[NV] = {0,0,0,0,0,0,0,0,0,0};
    printf("colorOK(gl1, cores3) == %s\n", colorOK(gl1, cores3) ? "true" : "false");
    printf("colorOK(gl2, cores3) == %s\n", colorOK(gl2, cores3) ? "true" : "false");

    // homomorfOK
    // TODO: testar homomorfOK()

    
    int path[NV];
    for (int i = 0; i < NV; i++)
        path[i] = -1;
    
    // maisLonga
    
    int len = maisLonga(gl1, 0, path);
    printf("\nmaisLonga(gl1, 0, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i <= len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    len = maisLonga(gl1, 2, path);
    printf("maisLonga(gl1, 2, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i <= len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    // componentes

    printf("\ncomponentes(gl1, path): %d\n", componentes(gl1, path));
    printf("path: [");
    for (int i = 0; i < NV; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    printf("componentes(gl2, path): %d\n", componentes(gl2, path));
    printf("path: [");
    for (int i = 0; i < NV; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    // ordTop

    len = ordTop(gl1, path);
    printf("\nordTop(gl1, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i < len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    len = ordTop(gl2, path);
    printf("ordTop(gl2, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i < len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    // ciclo

    len = ciclo(gl1, path);
    printf("\nciclo(gl1, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i < len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    len = ciclo(gl2, path);
    printf("ciclo(gl2, path): %d\n", len);
    printf("path: [");
    for (int i = 0; i < len; i++)
        printf("%2d", path[i]);
    printf(" ]\n");

    // caminho

    char *mapa [10] = {"##########"
                      ,"# #   #  #"
                      ,"# # # #  #"
                      ,"#   # #  #"
                      ,"##### #  #"
                      ,"#     #  #"
                      ,"## ####  #"
                      ,"#  #     #"
                      ,"#     #  #"
                      ,"##########"};

    printf("\ncaminho (10, 10, mapa, 1,1,1,8): %d\n", caminho(10, 10, mapa, 1,1,1,8));
    caminhoShow(10, 10, mapa, 1,1,1,8);
    printf("caminho (10, 10, mapa, 7,1,8,8): %d\n", caminho(10, 10, mapa, 7,1,8,8));
    caminhoShow(10, 10, mapa, 7,1,8,8);
    printf("caminho (10, 10, mapa, 8,3,0,0): %d\n", caminho(10, 10, mapa, 8,3,0,0));
    caminhoShow(10, 10, mapa, 8,3,0,0);
    printf("caminho (10, 10, mapa, 8,8,1,8): %d\n", caminho(10, 10, mapa, 8,8,1,8));
    caminhoShow(10, 10, mapa, 8,8,1,8);
    

    // excentricidadeV

    printf("\nexcentricidadeV(gl1, 0): %d\n", excentricidadeV(gl1, 0));
    printf("excentricidadeV(gl1, 2): %d\n", excentricidadeV(gl1, 2));
    printf("excentricidadeV(gl1, 8): %d\n", excentricidadeV(gl1, 8));
    printf("excentricidadeV(gl1, 6): %d\n", excentricidadeV(gl1, 6));

    int pesos[NV];
    for (int i = 0; i < NV; i++)
        pesos[i] = -1;

    printf("\ngeraCaminhoAutonomia(gl1, 0, path, pesos, 6): %d\n", geraCaminhoAutonomia(gl1, 0, path, pesos, 6));
    printf("path: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", path[i]);
    printf(" ]\n");
    printf("pesos: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", pesos[i]);
    printf(" ]\n");

    for (int i = 0; i < NV; i++)
        pesos[i] = -1;

    printf("geraCaminhoAutonomia(gl1, 2, path, pesos, 6): %d\n", geraCaminhoAutonomia(gl1, 2, path, pesos, 6));
    printf("path: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", path[i]);
    printf(" ]\n");
    printf("pesos: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", pesos[i]);
    printf(" ]\n");

    for (int i = 0; i < NV; i++)
        pesos[i] = -1;

    // Prim

    printf("\nPrim(gl1, pesos, path): %d\n", Prim(gl1, pesos, path));
    printf("path: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", path[i]);
    printf(" ]\n");
    printf("pesos: [");
    for (int i = 0; i < NV; i++)
        printf("%3d", pesos[i]);
    printf(" ]\n");


    // diametro

    printf("\ndiametro(gl1): %d\n", diametro(gl1));
    for (int i = 0; i < NV; i++)
        printf("excentricidadeV(gl1, %d): %d\n", i, excentricidadeV(gl1, i));
    

    return 0;
}