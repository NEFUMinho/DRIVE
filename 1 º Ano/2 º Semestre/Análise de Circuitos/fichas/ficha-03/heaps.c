

/*
Exercicio 1
a)   (2 * i) + 1
b)   (2 * i) + 2
c)   (i - 2) / 2
d)   N / 2

N == número de elementos na heap
*/

#define PARENT ((i - 1) / 2)
#define LEFT   ((2 * i) + 1)
#define RIGHT  ((2 * i) + 2)

/* troca os valores nos indices i e j */
void swap(int array[], int i, int j) {
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

void bubbleUp (int i, int h[]) {
    int father = PARENT(i);

    while (i > 0 && h[father] > h[i]) {
        swap(h, father, i);
        i = father;
        father = PARENT(i);
    }
}

/*
Pior caso do bubbleUp:
    elemento está no último nivel da heap e tem de ser levado até à raiz
Complexidade:
    O(log(N))
*/

void bubbleDown (int i, int h[], int N) {
    int left = LEFT(i), right = 0;

    while (left < N) {
        right = RIGHT(i);
        if (right < N && h[right] < h[left])
            left = right;

        if (h[i] < h[left])
            break;
        swap(h, i, left);
        i = left;
        left = LEFT(i);
    }
}

/*
Pior caso do bubbleDown:
    elemento está na raiz e tem de ser levado até ao último nível
Complexidade:
    O(log(N))
*/

#define Max 100

typedef struct pQueue {
    int valores [Max];
    int tamanho;
} PriorityQueue;

void empty (PriorityQueue *q) {
    q->tamanho = 0;
}

int isEmpty (PriorityQueue *q) {
    return q->tamanho == 0;
}

int add (int x, PriorityQueue *q) {
    int result = 1;
    if (q->tamanho < Max) {
        q->valores[q->tamanho] = x;
        bubbleUp(q->tamanho, q->valores);
        q->tamanho++;

        result = 0;
    }

    return result;
}

int remove (PriorityQueue *q, int *rem) {
    int result = 1;
    if (q->tamanho > 0) {
        *rem = q->valores[0];

        q->tamanho--;
        // colocar o último elemento na raiz, e traze-lo para baixo
        q->valores[0] = q->valores[q->tamanho];
        bubbleDown(0, q->valores, q->tamanho);

        result = 0;
    }

    return result;
}

/* heapify -> top-down */
void heapify_TP (int v[], int N) {
    for (int i = 1; i < N; i++) {
        bubbleUp(i, v);
    }
}

/* heapify -> bottom-up */
void heapify_BU (int v[], int N) {
    for (int i = (N / 2) - 1; i >= 0; i--) {
        bubbleDown(i, v, N);
    }
}


/*
Estratégia top-down:
    T(N) = sum {i = 1, N} log2(N) = 
                            O(N * log(N))

Estratégia bottom-up:
    T(N) = sum {i = 0, N/2 - 1} log2(N) = N/2 * log2(N) =
                                                O(N * log(N))
*/

void ordenaHeap (int h[], int N) {
    for (int i = N - 1; i > 0; i--) {
        swap(h, 0, i);
        bubbleDown(0, h, i);
    }
}


/*
Exercicio 7

pior caso:
    sequência de valores está ordenada por ordem crescente

passo 1:
    inserir os k primeiros valores na heap, e como cada valor 
    seguinte é maior do que o anterior, bubble up não será feito, logo:
        T(k) = sum {i = 1, k} 1 = O(K)

passo 2:
    inserir os N-k elementos, que em cada iteração são maiores, logo a inserção tem apenas um custo de O(1),
    mas a remoção do menor elemento tem um custo de O(log(k)), logo:
        T(N-k) = sum {i = 1, N-k} log(k) = (N-k)*log(k)

Complexidade final:
    Sendo que k é (tipicamente) muito menor que N, o custo desta operação será:
        T(N) = k + (N-k)*log(k) = O(N)

    complexidade linear
*/

