#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_FILE "a_large.in"
#define OUTPUT_FILE "a_large.out"

int main() {
    FILE * pFile;
    FILE * qFile;
    int t, i;

    pFile = fopen(INPUT_FILE, "r");
    qFile = fopen(OUTPUT_FILE, "w");
    fscanf(pFile, "%d", &t);
    //fprintf(qFile, "%d\n", t);
    for(i = 1; i <= t; ++i) {
        int n, head, tail;
        char * str = (char *) malloc(1002*sizeof(char)); 
        char * res = (char *) malloc(1002*sizeof(char)); 
        fscanf(pFile, "%s", str); 
        n = strlen(str);
        printf("%d: %s\n", n, str);
        char * head_stack = (char *) malloc(1002*sizeof(char));
        char * tail_stack = (char *) malloc(1002*sizeof(char));
        tail = 1;
        head = 1;
        head_stack[0] = str[0];
        tail_stack[0] = str[0];
        for(int j = 1; j < n; ++j) {
            if(head_stack[head-1] <= str[j]) {
                head_stack[head++] = str[j];
            } else {
                tail_stack[tail++] = str[j];
            }
        }
        //printf("Head_stack: %s\n", head_stack);
        //printf("Tail_stack: %s\n", tail_stack);
        //printf("%d %d\n", head, tail);

        int tt = 0;
        for(int j = 0; j < n; ++j) {
            if(head > 1) {
                res[j] = head_stack[--head];
            } else {
                res[j] = tail_stack[tt++];
            }
        }

        fprintf(qFile, "Case #%d: %s\n", i, res);
        printf("Case #%d: %s\n", i, res);
    }
    fclose(pFile);
    fclose(qFile);
}
    


