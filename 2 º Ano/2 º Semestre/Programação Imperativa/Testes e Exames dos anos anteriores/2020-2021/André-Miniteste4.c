#include <stdio.h>
#include <stdlib.h>

int soma(char s[]){
    int i=0,c=0;
    for(;s[i]!='\0';i++){
        c+=s[i]-'0';
    }
    return c;
}

void corrige(char s[]) {
    int i;
    int tam=soma(s);
    for(i=0;tam<17;i++){
        if(s[i]=='0') {
            if((17-tam)>9)s[i]=9+'0';
            else s[i]=17-tam+'0';
            tam=soma(s);
        }
    }
}
#include <stdio.h>
#include <stdlib.h>
#include "posicao.h"

int main(){
    char s[]="932010";
    corrige(s);
    printf("%s\n",s);
    
    Posicao p[4];
    p[0].x=4;
    p[0].y=3;
    p[1].x=3;
    p[1].y=2;
    p[2].x=5;
    p[2].y=1;
    p[3].x=0;
    p[3].y=1;
    Posicao x=nesimo(p,4);
    printf("(%d,%d)\n",x.x,x.y);
    
    //Posicao y=nesimo2(p,4);
    //printf("(%d,%d)",y.x,y.y);
}
#include <stdio.h>
#include <stdlib.h>
#include "posicao.h"

int dist(Posicao p){
    return p.x*p.x + p.y*p.y;
}

void sort(Posicao l[], int N){
    int i, j;
    Posicao temp;

    for(i = 0; i < N; i++){
        for(j = i + 1; j < N; j++){
            if(dist(l[i]) > dist(l[j])){
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
#include <stdio.h>
#include <stdlib.h>
#include "posicao.h"

void rm(Posicao s[], int n, int N){
    int i;
    for(i = n+1; i < N; i++, n++){
        s[n] = s[i];
    }
}

int distOrigem(int x, int y){
    return(abs(x - 0) + abs(y - 0));
}

Posicao nesimo2(Posicao a[], int N) {
    int ind = 0, i, r = 0;
    while(r < 4){
        int closest = distOrigem(a[0].x, a[0].y);
        for(i = 0; i < N; i++){
            if(distOrigem(a[i].x, a[i].y) < closest){
                ind = i;
                closest = distOrigem(a[i].x, a[i].y);
            }
        }
        rm(a, ind, N);
        N -= 1;
        r++;
        }
    return a[ind];
}