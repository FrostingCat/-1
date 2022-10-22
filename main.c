 #include <stdio.h>
#include <stdlib.h> 
#include <string.h>

int get(int *a, int n, FILE* file) {
    int last = 0;
    if (!file) {
        for (int i = 0; i < n; i++) {
            scanf("%d", &a[i]);
            if (a[i] > 0) {
                last = i + 1;
            }
        }
        return last;
    } else {
        int last = 0;
        for (int i = 0; i < n; i++) {
            fscanf(file, "%d", &a[i]);
            if (a[i] > 0) {
                last = i + 1;
            }
        }
        return last;
    }
}

void form(int *a, int *b, int first, int last) {
    int j = 0;
    for (int i = first; i < last; i++) {
        b[j] = a[i];
        j++;
    }
}

void print(int *b, int size, int file) {
    if (!file) {
        for (int i = 0; i < size; i++) {
            printf("%d ", b[i]);
        }
    } else {
        FILE *output;
        output = fopen("output.txt", "w");
        for (int i = 0; i < size; i++) {
            fprintf(output, "%d ", b[i]);
        }
        fclose(output);
    }   
}

int main(int argc, char *argv[]) {
    int n;
    int *a;
    int first, size;
    int file = 0;

    if (argc != 1) {
        if (!strcmp(argv[1], "F1")) {
            FILE *F1;
            F1 = fopen("F1.txt", "r");
            fscanf(F1, "%d", &n);
            a = malloc(n * sizeof(int));
            first = get(a, n, F1);
            fclose(F1);
        } else if (!strcmp(argv[1], "F2")) {
            FILE *F2;
            F2 = fopen("F2.txt", "r");
            fscanf(F2, "%d", &n);
            a = malloc(n * sizeof(int));
            first = get(a, n, F2);
            fclose(F2);
        } else if (!strcmp(argv[1], "F3")) {
            FILE *F3;
            F3 = fopen("F3.txt", "r");
            fscanf(F3, "%d", &n);
            a = malloc(n * sizeof(int));
            first = get(a, n, F3);
            fclose(F3);
        }
        file = 1;
    } else {
        scanf("%d", &n);
        a = malloc(n * sizeof(int));
        first = get(a, n, 0);
    }
    
    size = n - first;

    int *b = malloc(size * sizeof(int));
    if (first != 0) {
        form(a, b, first, n);
        print(b, size, file);
    }
    
    free(a);
    free(b);
    
    return 0;
}