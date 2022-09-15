/* Main function of the C program. */

#include <stdio.h>
#include <stdlib.h>

int fibonacci (int n) {
  int a = 0, b = 1, aux,c=0;
  for (; n > 0; n--) {
    printf("%d\n",a);
    if(a%2!=0) c++;
    aux = a;
    a = b;
    b = (b + aux) % 10000;
  }
  return c;
}

int main()
{
    printf("abundantes%d",fibonacci(55));
    return EXIT_SUCCESS;
}