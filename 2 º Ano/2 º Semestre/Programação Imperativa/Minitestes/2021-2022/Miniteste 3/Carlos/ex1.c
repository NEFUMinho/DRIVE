#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "ex1.h"

void corrige(char s[]) {
    
    int i;
    int total = 17;
    int ptotal = 0;
    
    for(i=0;s[i]!='\0';i++) {
        ptotal += (s[i]-'0');
    }    
    
    int dif = total - ptotal;
    
    int c = 0;
    
    for (c=0; dif>0 && s[c]!='\0'; c++) {
        if (s[c] == '0') {
            if (dif>9) {
                s[c] = 9 + '0';
                dif = dif - 9;
            }
            else {
                s[c] = dif + '0';
                dif = 0;
            }
        }
    }
} 


int main(){
    char s[]="932010";
    corrige(s);
    printf("%s",s);
}