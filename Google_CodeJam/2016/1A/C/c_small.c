#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "c_small.in"
#define OUTPUT_FILE "c_small.out"

int recurse(int *bff, int *dist, int *l, int pos) {
    if(dist[pos] > 0) {
        return dist[pos];
    }
    if(l[pos] > 0) {
        return 0;
    }
    l[pos] = 1;
    int res = recurse(bff, dist, l, bff[pos]) + 1;
    dist[pos] = res;
    return res;
}

int main() {
    FILE * pFile;
    FILE * qFile;
    int t, i;

    pFile = fopen(INPUT_FILE, "r");
    qFile = fopen(OUTPUT_FILE, "w");
    fscanf(pFile, "%d", &t);
    for(i = 1; i <= t; ++i) {
        int n, j, r, temp;
        fscanf(pFile, "%d", &n);
        int *bff = (int*) malloc(sizeof(int)*n);
        int *l = (int*) malloc(sizeof(int)*n);
        int *dist = (int*) malloc(sizeof(int)*n);
        for(int j = 0; j < n; ++j) {
            fscanf(pFile, "%d", &temp);
            bff[j] = temp-1;
            l[j] = 0;
            dist[j] = 0;
        }
        int max = 0;
        for(int j = 0; j < n; ++j) {
            if(dist[j] > 0) {
                continue;
            }
            for(int k = 0; k < n; ++k) {
                l[k] = 0;
            }
            int count = recurse(bff, dist, l, j);
            if(count > max) {
                max = count;
            }
        }
        for(int j = 0; j < n; ++j) {    
            printf("%d ", dist[j]);
        }
        printf("\n");
        printf("Case #%d: %d\n", i, max);
        fprintf(qFile, "Case #%d: %d\n", i, max);
    }
    fclose(pFile);
    fclose(qFile);
}
    


