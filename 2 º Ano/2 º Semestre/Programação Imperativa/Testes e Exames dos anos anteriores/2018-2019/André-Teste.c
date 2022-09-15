#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct slist{
    int valor;
    struct slist *prox;
} *LInt;

typedef struct nodo{
    int valor;
    struct nodo *esq,*dir;
} *ABin;

//Parte A
//1
void strrev(char s[]){
    int len = strlen(s);
    int i,j;
    for(i=0,j=len-1;i<j;i++,j--){
        int tmp = s[i];
        s[i]=s[j];
        s[j]=tmp;
    }
}

//2
int remRep(char s[]){
    int i,j=0;
    for(i=0;s[i]!='\0';i++){
        s[j++]=s[i];
        while(s[i+1]==s[i]) i++;
    }
    s[j]='\0';
    return j;
}

//3
void merge(int r[], int a[], int b[], int na, int nb){
    int ja, jb,i;
    for(ja=0,jb=0,i=0;ja<na && jb<nb;i++){
        if(a[ja]<=b[jb]) r[i]=a[ja++];
        else r[i]=b[jb++];
    }
    if(ja==na) for(i;jb<nb;i++,jb++) r[i]=b[jb];
    if(jb==nb) for(i;ja<na;i++,ja++) r[i]=a[ja];
}

//4
int maiores(int x,ABin a){
    if(!a) return 1;
    return (x<a->valor) && maiores(x,a->esq) && maiores(x,a->dir);
}

int menores(int x,ABin a){
    if(!a) return 1;
    return (x>a->valor) && menores(x,a->esq) && menores(x,a->dir);
}

int deProcura(ABin a){
    if(!a) return 1;
    int x = a->valor;
    return maiores(x,a->dir) && menores(x,a->esq) && deProcura(a->esq) && deProcura(a->dir);
}

//5
int freeAB (ABin a) {
    if(!a) return 0;
    free(a);
    return 1 + freeAB(a->esq) + freeAB(a->dir);
}

int pruneAB (ABin *a, int l) {
    if(!*a) return 0;
    if(!l){
        int c = freeAB(*a);
        *a = NULL;
        return c;
    }
    return pruneAB(&(*a)->esq,l-1)+pruneAB(&(*a)->dir,l-1);
}


//Parte B
typedef struct digito{
    unsigned char val;
    struct digito *prox;
} *Num;

//1
//a)
Num fromInt(unsigned int i){
    Num c = NULL;
    Num *end = &c;
    while(i){
        *end = malloc(sizeof(struct digito));
        (*end)->val = i%10;
        i/=10;
        end=&(*end)->prox;
    }
    return c;
}

//b)
unsigned int toInt(Num n){
    if(!n) return 0;
    return n->val+(10*toInt(n->prox));
}

//2
Num addNum(Num a,Num b){
    Num c = NULL;
    Num *end= &c;
    int s, r=0;
    while(a && b){
        *end = malloc(sizeof(struct digito));
        s = a->val+b->val+r;
        (*end)->val = s%10;
        r = (s>9) ? 1 : 0;
        end=&(*end)->prox;
        a=a->prox;
        b=b->prox;
    }
    while(a){
        *end = malloc(sizeof(struct digito));
        s = a->val + r;
        (*end)->val = s%10;
        r = (s>9) ? 1 : 0;
        end=&(*end)->prox;
        a=a->prox;
    }
    while(b){
        *end = malloc(sizeof(struct digito));
        s = b->val+r;
        (*end)->val = s%10;
        r = (s>9) ? 1 : 0;
        end=&(*end)->prox;
        b=b->prox;
    }
    if(r){
        *end = malloc(sizeof(struct digito));
        (*end)->val = r;
    }
    return c;
}

//3
Num mulDig(unsigned char dig,Num a){
    int i = dig - '0';
    int r=0,s;
    Num c = NULL;
    Num *end = &c;
    while(a){
        *end = malloc(sizeof(struct digito));
        s = a->val*i+r;
        (*end)->val = s%10;
        r = s/10;
        end=&(*end)->prox;
        a=a->prox;
    }
    if(r){
        *end = malloc(sizeof(struct digito));
        (*end)->val = r;
    }
    return c;
}

//4
Num mulNum(Num a,Num b){
    Num c = NULL;
    Num *end = &c;
    int e=1,i;
    while(b){
        char x = b->val + '0';
        for(i=0;i<e;i++){
            *end= addNum(*end,mulDig(x,a));
        }
        e*=10;
        b=b->prox;
    }
    return c;
}

int main()
{
    char s[] = "A BASE DO TETO DESABA";
    strrev(s);
    printf("Parte A:\n%s\n",s);
    
    char s2[] = "aaabaaabbbaaa";
    int x = remRep(s2);
    printf("A string ficou assim \"%s\" e com comprimento %i\n",s2,x);
    
    int na,nb,N;
    na=8;
    nb=7;
    N=na+nb;
    int a[]={1,3,5,7,9,10,11,12};
    int b[]={2,4,6,8,10,20,40};
    int r[N];
    merge(r,a,b,na,nb);
    int i;
    printf("A junção das listas ficou assim [");
    for(i=0;i<N-1;i++){
        printf("%i,",r[i]);
    }
    printf("%i]\n",r[i]);
    
    Num n1a = fromInt(123);
    Num *end1a = &n1a;
    printf("\nParte B:\nResultado = ");
    for(;(*end1a)->prox;end1a=&(*end1a)->prox) printf("%i->",(*end1a)->val);
    printf("%i\n",(*end1a)->val);
    
    printf("Voltando para int:%i\n",toInt(n1a));
    
    Num n1 = fromInt(120);
    
    Num n2 = fromInt(907);
    
    Num *end1 = &n1;
    printf("a = ");
    for(;(*end1)->prox;end1=&(*end1)->prox) printf("%i->",(*end1)->val);
    printf("%i\n",(*end1)->val);
    printf("a = %i\n",toInt(n1));
    
    Num *end2 = &n2;
    printf("b = ");
    for(;(*end2)->prox;end2=&(*end2)->prox) printf("%i->",(*end2)->val);
    printf("%i\n",(*end2)->val);
    printf("b = %i\n",toInt(n2));
    
    Num n3 = addNum(n1,n2);
    Num *end3 = &n3;
    printf("c = ");
    for(;(*end3)->prox;end3=&(*end3)->prox) printf("%i->",(*end3)->val);
    printf("%i\n",(*end3)->val);
    printf("c = %i\n",toInt(n3));
    
    char c = '3';
    printf("%c x %i = %i\n",c,toInt(n3),toInt(mulDig(c,n3)));
    
    Num n4 = mulNum(n1,n2);
    printf("%i x %i = %i",toInt(n1),toInt(n2),toInt(n4));
}
