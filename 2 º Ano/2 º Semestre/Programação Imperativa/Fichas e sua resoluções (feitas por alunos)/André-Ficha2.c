int fib (int n){
    if(n<2) return 1;
    return fib(n-1)+fib(n-2);
}

int fastfib (int n){
    int f1 , f2, i;
    f1=f2=1;
    for(i=2;i<=n;i++){
        int tmp=f2;
        f2=f1;
        f1+=tmp;
    }
    return f1;
}
#define MIN(A,B) (A<B ? A:B)

int mdc1 (int a, int b){
    int d;
    d = MIN(a,b);
    while(d){
        if(a%d==0 && b%d==0) break;
        d--;
    }
    return d;
}
int mdc2 (int a, int b){
    while (a!=0 && b!=0){
        if (b>a){
            b = b-a;
        } else {
            a = a-b;
        }
    }
    return a+b;
}
int mdc3 (int a, int b, int *count){
    int d;
    int k=0;
    d = MIN(a,b);
    while(d){
        if(a%d==0 && b%d==0) break;
        d--;
        k+=1;
    }
    *count=k;
    return d;
}
int mdc4 (int a, int b, int *count){
    int k=0;
    while (a!=0 && b!=0){
        k+=1;
        if (b>a){
            b = b-a;
        } else {
            a = a-b;
        }
    }
    *count=k;
    return a+b;
}
float multInt1 (int n, float m){
    float r;
    while(n--){
        r+=m;
    }
    return r;

}

float multInt2 (int n, float m){
    float r=0;
    while(n){
        if (n%2){r+=m;}
        m*=2;
        n/=2;
    }
    return r;

}

float multInt3 (int n, float m, int *count){
    float r=0;
    int k=0;
    while(n){
        if (n%2){
            r+=m;
            k+=1;
        }
        m*=2;
        k+=1;
        n/=2;
    }
    *count=k;
    return r;
}