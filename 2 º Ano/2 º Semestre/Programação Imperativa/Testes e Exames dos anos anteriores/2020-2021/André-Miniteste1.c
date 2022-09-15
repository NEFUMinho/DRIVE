/* Main function of the C program. */

#include <stdio.h>
#include <stdlib.h>

void func(){
    int x,y;
    for (y=0;y<8;y++) {
        for (x=0;x<8;x++) {
            if (x-y<0) putchar('.');
            else putchar('#');
        }
        putchar('\n');
    }
}

int func1(int x) {
  int r = 0;
  while (x > 0) {
    r += 2;
    x = x - r;
  }
  return r;
}

int main(){
    func();
    printf("%d",func1(12));
    return 0;
}
