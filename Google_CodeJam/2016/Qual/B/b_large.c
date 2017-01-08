#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "b_large.in"
#define OUTPUT_FILE "b_large.out"

void flip(char *p, int a, int b) {
    int i;
    for(i = 0; i < (b-a)/2; ++i) {
        char temp;
        temp = p[a+i];
        p[a+i] = (p[b-i-1] == '-') ? '+' : '-';
        p[b-i-1] = (temp == '-') ? '+' : '-';
    }
    if((b-a) %2 == 1) {
        p[(b-a)/2] = (p[(b-a)/2] == '-') ? '+' : '-';
    }
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
        char * p = (char *) malloc(100*sizeof(char));
        char temp;
        fscanf(pFile, "%s", p);
        r = 0;
        temp = p[0];
        n = strlen(p);
        for(j = 1; j < n; ++j) {
            if(p[j] != temp) {
                temp = (temp == '-') ? '+' : '-';
                r++;
            }
        }
        if(p[n-1] == '-') {
            r++;
        }
        free(p);
        printf("Case #%d: %d\n", i, r);
        fprintf(qFile, "Case #%d: %d\n", i, r);
    }
    fclose(pFile);
    fclose(qFile);
}
    


