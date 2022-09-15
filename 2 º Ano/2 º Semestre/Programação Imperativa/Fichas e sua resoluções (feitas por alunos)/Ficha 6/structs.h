// struct staticStack {
//     int sp;
//     int values[Max];
// } STACK, *SStack;

// struct staticQueue {
//     int front;
//     int length;
//     int values[Max];
// } QUEUE, *SQueue;

#define Max 10

typedef struct staticStack {
    int sp;
    int values[Max];
} STACK, *SStack;

typedef struct staticQueue {
    int front;
    int length;
    int values[Max];
} QUEUE, *SQueue;

typedef struct dinQueue {
    int size;
    int front;
    int length;
    int *values;
} *DQueue;

typedef struct dinStack {
    int size;
    int sp;
    int *values;
} *DStack;