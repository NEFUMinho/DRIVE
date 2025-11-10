
#include <stdio.h>
#include <string.h>

// switch these coments to test both hash tables implementations
#include "chaining.c"
// #include "open_adressing.c"

int main() {
    THash t;
    initEmpty(t);

    printf("After init:\n");
    show(t);

    printf("\nAdding some elements...\n");
    add("apple", t);
    add("banana", t);
    add("apple", t);
    add("orange", t);
    add("banana", t);
    show(t);

    printf("\nLookup tests:\n");
    printf("apple -> %d\n", lookup("apple", t));
    printf("banana -> %d\n", lookup("banana", t));
    printf("orange -> %d\n", lookup("orange", t));
    printf("grape -> %d\n", lookup("grape", t));

    printf("\nRemoving elements...\n");
    removeT("banana", t);
    removeT("apple", t);
    show(t);

    printf("\nAfter removing all apples:\n");
    removeT("apple", t);
    show(t);

    return 0;
}
