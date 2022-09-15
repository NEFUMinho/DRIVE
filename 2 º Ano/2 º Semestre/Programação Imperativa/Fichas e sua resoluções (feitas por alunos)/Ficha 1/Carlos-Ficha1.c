#include <stdio.h>

////1.3
//
// int main()
// {
//     char a, b, c;
//     a = 'A'; b= ' '; c = '0';
    
//     printf("%c %d \n",a,a);

//     a = a+1; c= c+2;
//     printf("%c %d %c %d\n", a, a, c, c);

//     c = a + b; 
//     printf("%c %d \n", c, c);
    
//     return 0;
// }
//////////////////////////////////////////////////////////////

////2.1.(d)
//
// void f (int n) {
//     while (n>0) {
//         if (n%2 == 0) putchar ('0');
//         else putchar ('1');
//         n = n/2;
//     }
//     putchar ('\n');
// }

// int main () {
//     int i;

//     for (i=0;(i<16);i++)

//         f (i);

//     return 0;
// }
//////////////////////////////////////////////////////////////

////3.1
//
// void quadrado(int);

// int main() {

//     int n = 5;

//     quadrado(5);

//     return 0;
// }

// void quadrado(int n) {

//     int i,j;

//     for(i=0; i<n; i++) {

//         for (j=0; j<n; j++) {

//             putchar('#');

//         }

//         printf("\n");
//     }
    
// }
//////////////////////////////////////////////////////////////

////3.2
//
// void xadrez(int);

// int main() {

//     int n = 5;

//     xadrez(5);

//     return 0;
// }

// void xadrez(int n) {

//     int i,j;
//     int c = 0;

//     for(i=0; i<n; i++) {

//         for (j=0; j<n; j++) {

//             if (c%2==0) {putchar('#');}
            
//             else {putchar('_');}
            
//             c++;

//         }

//         printf("\n");
//     }
    
// }
//////////////////////////////////////////////////////////////

////3.3
//
//void nputchar(int,char);

// //triangulo vertical
// int main() {

//     int n = 5;
//     int i,j;

//     //first cicle
//     for (i=1; i<=n; i++) {

//         nputchar(i,'#');
//         putchar('\n');

//     }    

//     //second cicle
//     for(i=n-1; i>0; i--) {

//         nputchar(i,'#');
//         putchar('\n');

//     }

//     return 0;
// }

// void nputchar(int a, char b){
    
//     int i;

//     for(i=0; i<a; i++) {
//         putchar(b);
//     }

// }

// //triangulo horizontal

// int main(){

//     int n = 5;
//     int i;

//     for(i=1; i<=n; i++) {

//         nputchar( n-i , ' ' );
//         nputchar( 2*i-1 , '#' );
//         putchar('\n');
    
//     }

//     return 0;
// }
//////////////////////////////////////////////////////////////

////3.3
//
int main(){

    // int n = 4;
    // int i;

    // for (i = 1; i<=n; i++){
        
    //     nputchar( n-i+1 , ' ' );
    //     nputchar( 2*i-1 , '#' );
    //     putchar('\n');

    // }

    // for (i = n; i>=0; i--){
        
    //     nputchar( n-i , ' ' );
    //     nputchar( 2*i+1 , '#' );
    //     putchar('\n');

    // }

    int x,y;

    for (y=0;y<8;y++) {    
        for (x=0;x<8;x++) {
            if (x - y == 0) putchar('#');
            else putchar('.');
        }
        putchar('\n');
    }

    return 0;
}
