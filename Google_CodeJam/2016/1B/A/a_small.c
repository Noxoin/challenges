#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "a_small.in"
#define OUTPUT_FILE "a_small.out"

int main() {
    FILE * pFile;
    FILE * qFile;
    int t, i;

    pFile = fopen(INPUT_FILE, "r");
    qFile = fopen(OUTPUT_FILE, "w");
    fscanf(pFile, "%d", &t);
    for(i = 1; i <= t; ++i) {
        char *input = (char *) malloc(sizeof(char)*2002);
        fscanf(pFile, "%s", input);
        //printf("%s\n", input);
        int *freq = (int *) malloc(sizeof(int)*26);
        int *count = (int *) malloc(sizeof(int)*26);
        for(int j = 0; j < 26; ++j) {
            freq[j] = 0;
            count[j] = 0;
        }
        for(int j = 0; j < strlen(input); ++j) {
            freq[input[j]-65]++;
        }

        if(freq['Z'-65] > 0) { // check zero
            int x = freq['Z' - 65];
            count[0] = x;
            freq['Z'-65] -= x;
            freq['E'-65] -= x;
            freq['R'-65] -= x;
            freq['O'-65] -= x;
        }

        if(freq['G'-65] > 0) { // check eight
            int x = freq['G' - 65];
            count[8] = x;
            freq['E'-65] -= x;
            freq['I'-65] -= x;
            freq['G'-65] -= x;
            freq['H'-65] -= x;
            freq['T'-65] -= x;
        }

        if(freq['X'-65] > 0) { // check six
            int x = freq['X' - 65];
            count[6] = x;
            freq['S'-65] -= x;
            freq['I'-65] -= x;
            freq['X'-65] -= x;
        }

        if(freq['S'-65] > 0) { // check seven
            int x = freq['S' - 65];
            count[7] = x;
            freq['S'-65] -= x;
            freq['E'-65] -= x;
            freq['V'-65] -= x;
            freq['E'-65] -= x;
            freq['N'-65] -= x;
        }

        if(freq['V'-65] > 0) { // check five
            int x = freq['V' - 65];
            count[5] = x;
            freq['F'-65] -= x;
            freq['I'-65] -= x;
            freq['V'-65] -= x;
            freq['E'-65] -= x;
        }

        if(freq['F'-65] > 0) { // check four
            int x = freq['F' - 65];
            count[4] = x;
            freq['F'-65] -= x;
            freq['O'-65] -= x;
            freq['U'-65] -= x;
            freq['R'-65] -= x;
        }

        if(freq['W'-65] > 0) { // check two
            int x = freq['W' - 65];
            count[2] = x;
            freq['T'-65] -= x;
            freq['W'-65] -= x;
            freq['O'-65] -= x;
        }

        if(freq['I'-65] > 0) { // check nine
            int x = freq['I' - 65];
            count[9] = x;
            freq['N'-65] -= x;
            freq['I'-65] -= x;
            freq['N'-65] -= x;
            freq['E'-65] -= x;
        }

        if(freq['T'-65] > 0) { // check three
            int x = freq['T' - 65];
            count[3] = x;
            freq['T'-65] -= x;
            freq['H'-65] -= x;
            freq['R'-65] -= x;
            freq['E'-65] -= x;
            freq['E'-65] -= x;
        }
        
        if(freq['O'-65] > 0) { // check one
            int x = freq['O' - 65];
            count[1] = x;
            freq['O'-65] -= x;
            freq['N'-65] -= x;
            freq['E'-65] -= x;
        }

        printf("Case #%d: ", i);
        fprintf(qFile, "Case #%d: ", i);

        for(int j = 0; j < 10; ++j) {
            for(int k = 0; k < count[j]; ++k) {
                printf("%d", j);
                fprintf(qFile, "%d", j);
            }
        }
        printf("\n");
        fprintf(qFile, "\n");

        free(freq);
        free(count);
        free(input);
        
        //fprintf(qFile, "Case #%d: %s\n", i, res);
        //printf("Case #%d: %s\n", i, res);
    }
    fclose(pFile);
    fclose(qFile);
}
    


