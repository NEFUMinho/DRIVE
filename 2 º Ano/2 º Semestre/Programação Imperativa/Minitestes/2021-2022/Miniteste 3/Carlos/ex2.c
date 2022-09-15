#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "ex2.h"

int dist_center(Posicao p){
    return p.x*p.x + p.y*p.y;
}

void sort(Posicao l[], int N){
    int i, j;
    Posicao temp;

    for(i = 0; i < N; i++){
        for(j = i + 1; j < N; j++){
            if(dist_center(l[i]) > dist_center(l[j])){
                temp = l[i];
                l[i] = l[j];
                l[j] = temp;
            }
        }
    }
}

Posicao nesimo(Posicao a[], int N) {

    sort(a,N);

    return a[3-1];
}