#include <stdio.h>

extern int* NumSort (int, int*);

int main(void){
        int i;
        int* result;
        int array[10] = {8,9,3,5,1,4,2,10,7,0};
        result = NumSort(array, 4*10);
        for (i = 0; i < 10; i++){
                printf ("%d ", result[i]);
	}
        return 0;
}
