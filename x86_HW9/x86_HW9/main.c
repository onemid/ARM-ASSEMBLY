//
//  main.c
//  x86_HW9
//
//  Created by GONG, YI-JHONG on 2015/12/30.
//  Copyright © 2015年 GONG, YI-JHONG. All rights reserved.
//

#include <mmintrin.h>
#include <xmmintrin.h>
#include <stdio.h>
#include <string.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    float A[200][200] __attribute__ ((aligned(32)));
    float sum[2] __attribute__((aligned(32)));
    
    __m128 *a, *b, *c;
    
    a = (__m128*)A;
    
    FILE *input;
    input = fopen("/Users/GaryGong/Downloads/data.txt","r");
    int i, j;
    for(i = 0; i < 200; i++){
        for (j = 0; j < 200; j++) {
            fscanf(input, "%f", &A[i][j]);
        }
    }
    
    for (int i = 0; i < 200; i++) { // first term counter
        
        memset(sum, 0, sizeof(sum));
        __m128d *mm_sum = (__m128d *)sum;
        for (int j = 0; j < 200; j++) { // second term counter
            __m128d *row1 = (__m128d *)A[i];
            __m128d *row2 = (__m128d *)A[j];
            
            for (int k = 0; k < 200 / 4; k++) { // calculate the dot product
                float tmp[2] __attribute__((aligned(32)));
                memset(tmp, 0, sizeof(tmp));
                __m128d *mm_tmp = (__m128d *)tmp;
                
                *mm_tmp = _mm_mul_pd(row1[k], row2[k]);
                
                *mm_sum = _mm_add_pd(*mm_tmp, *mm_sum);
                //printf("%d %d %d: %f %f\n", i, j, k, sum[0], sum[1]);
            }
        }
        
        // output to only 3 dicimal digits to avoid rounding errors
        printf("%.3f\n", sum[0] + sum[1]);
    }
    
    
    return 0;
}
