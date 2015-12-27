#include <stdio.h>
#include <string.h>

extern int* NumSort (int*, int);
extern char* FileOutput (char*, int);

int main(void){
        int i;
        int* result;
	char content[30];
        int array[10] = {8,9,3,5,1,4,2,10,7,0};
        result = NumSort(array, 4*9);

        for (i = 0; i < 10; i++){
                printf ("%d ", result[i]);
	}

	sprintf(content,"%d %d %d %d %d %d %d %d %d %d\n", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9]);
	
	if(!FileOutput(content, 20)){ printf("\nFile Output Successfully.\n");}
        return 0;
}
