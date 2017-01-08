#include <stdio.h>
#include <stdlib.h>

#define INPUT_FILE "a_large.in"
#define OUTPUT_FILE "a_large.out"

int seenAll(int seen[10]) {
    int i;
    for(i = 0; i < 10; ++i) {
        if(seen[i] == 0) {
            return 0;
        }
    }
    return 1;
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
        int seen[10];
        for(j = 0; j < 10; ++j) {
            seen[j] = 0;
        }
        fscanf(pFile, "%d", &n);
        if(n == 0) {
            //printf("Case #%d: INSOMNIA\n", i);
            fprintf(qFile, "Case #%d: INSOMNIA\n", i);
            continue;
        }
        r = 0;
        do {
            int temp;
            r += n;
            temp = r;
            //printf("%d ", r);
            while(temp > 0) {
                seen[temp%10] = 1;
                temp /= 10;
            }
        } while(!seenAll(seen));
        fprintf(qFile, "Case #%d: %d\n", i, r);
        //printf("Case #%d: %d\n", i, r);
    }
    fclose(pFile);
    fclose(qFile);
}
    


