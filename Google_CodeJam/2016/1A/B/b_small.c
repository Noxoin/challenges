#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "b_small.in"
#define OUTPUT_FILE "b_small.out"

void printGrid(int **q, int n) {
    printf("==========\n");
    for(int i = 0; i < n; ++i) {
        for(int j = 0; j < n; ++j) {
            printf("%d ", q[i][j]);
        }
        printf("\n");
    }
}

int cmpfunc(const void *a, const void *b) {
    return ((*(int **)a)[0] - (*(int**)b)[0]);
}

int checkRow(int **q, int **p, int n, int row, int k) {
    //printf("Checking %d with %d\n", row, k);
    for(int i = 0; i < n; ++i) {
        if(q[row][i] != p[k][i]) {
            return 0;
        }
    }
    return 1;
}

int checkValidCol(int **q, int n, int col) {
    if(col == 0) {
        return 1;
    }
    for(int i = 0; i < n; ++i) {
        if(q[i][col-1] >= q[i][col]) {
            return 0;
        }
    }
    return 1;
}

int fillIn(int **p, int **q, int * qu, int n, int col) {
    if(col == n) { //check with only qu == 0 statements
        int k = 0;
        int missing = -1;
        /*
        printGrid(q, n);
        for(int i = 0; i < 2*n-1; ++i) {
            printf("%d ",qu[i]);
        }
        printf("\n");
        */
        for(int i = 0; i < n; ++i) {
            while(k < 2*n-1 && qu[k] > 0) {
                k++;
            }
            if(k == 2*n-1) {
                if(missing < 0) {
                    missing = i;
                }
                break;
            }
            // check row i with k
            int res = checkRow(q, p, n, i, k);
            if(res == 0) {
                if(missing < 0) {
                    //printf("Setting missing to %d from %d\n", i, k);
                    missing = i;
                } else {
                    return -1;
                }
            } else {
                k++;
            }
        }

        //printf("This Worked: %d\n", missing);
        return missing;
    }

    for(int i = 0; i < 2*n-1; ++i) {
        if(qu[i] == 0) { // means line has not been used
            qu[i] = 1;
            for(int j = 0; j < n; ++j) {
                q[j][col] = p[i][j];
            }
            if(checkValidCol(q, n, col) == 1) {
                int ret = fillIn(p, q, qu, n, col+1);
                if(ret >= 0) {
                    return ret;
                }
            }
            qu[i] = 0;
        }
    }
    for(int j = 0; j < n; ++j) {
        q[j][col] = 0;
    }
    return -1;
}

int main() {
    FILE * pFile;
    FILE * qFile;
    int t, i;

    pFile = fopen(INPUT_FILE, "r");
    qFile = fopen(OUTPUT_FILE, "w");
    fscanf(pFile, "%d", &t);
    for(i = 1; i <= t; ++i) {
        int n, j, r;
        fscanf(pFile, "%d", &n);
        int** p = (int **) malloc((2*n-1)*sizeof(int *));
        int** q = (int **) malloc(n*sizeof(int *));
        int * qu = (int *) malloc((2*n-1)*sizeof(int));
        for(int j = 0; j < 2*n-1; ++j) {
            p[j] = (int *) malloc(n*sizeof(int));
            qu[j] = 0;
        }
        for(int j = 0; j < n; ++j) {
            q[j] = (int *) malloc(n*sizeof(int));
            for(int k = 0; k < n; ++k) {
                q[j][k] = 0;
            }
        }

        for(int j = 0; j < 2*n-1; ++j) {
            for(int k = 0; k < n; ++k) {
                fscanf(pFile, "%d", &p[j][k]);
            }
        }
        
        qsort(p, 2*n-1, sizeof(int *), cmpfunc);
        int row = fillIn(p, q, qu, n, 0);
        if(row < 0) {
            printf("FUK\n");
        } else {
            //printGrid(q, n);
        }

        printf("Case #%d: ", i);
        fprintf(qFile, "Case #%d: ", i);
        for(int j = 0; j < n; ++j) {
            printf("%d ", q[row][j]);
            fprintf(qFile, "%d ", q[row][j]);
        }
        printf("\n");
        fprintf(qFile, "\n");
        //fprintf(qFile, "Case #%d: %d\n", i, r);
    }
    fclose(pFile);
    fclose(qFile);
}
    


