//
//  main.c
//  HW9_with_C
//
//  Created by GONG, YI-JHONG on 2016/1/12.
//  Copyright © 2016年 GONG, YI-JHONG. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <emmintrin.h> // SSE 2
#include <mmintrin.h>
#include <immintrin.h> // AVX 2

#define MAX_SIZE 200
#define BASIS_NUM 12

#define INPUT_FILE_LOCATION "/Users/GaryGong/Desktop/data.txt"
#define OUTPUT_FILE_LOCATION "/Users/GaryGong/Desktop/output.txt"

#define OUTPUT_SSE2_FILE_LOCATION "/Users/GaryGong/Desktop/output_SSE.txt"
#define OUTPUT_AVX_FILE_LOCATION "/Users/GaryGong/Desktop/output_AVX.txt"

int main(int argc, const char * argv[])
{
    
    double begin_time, end_time;
    
    /*
     * RANDOM NUMBER GENERATOR
     */
    
    /*---------------- START GENERATING NUMBERS --------------*/
    
    // Declare Something Necessary
    
    srand((unsigned int)time(NULL));
    
    FILE *inputFile, *outputFile;
    
    inputFile = freopen(INPUT_FILE_LOCATION, "w", stdout);
    
    // Handle the Exception From Reading Input Error
    
    if (!inputFile) {
        puts("Fatal Error: Could Not Open the File.\n");
        exit(1);
    }
    
    // Generate the Random Number
    
    for (int i = 0; i < MAX_SIZE; i++) {
        for (int j = 0; j < MAX_SIZE; j++) {
            printf("%f", (double) (rand() % 100) / BASIS_NUM);
            (j != MAX_SIZE - 1) ? printf(" ") : printf("\n");
        }
    }
    
    
    /*---------------- END of GENERATING NUMBERS --------------*/
    
    /*
     * MATRIX CALCULATOR
     */
    
    /*---------------- START CALCULATING NUMBERS --------------*/
    
    // Declare Something Necessary
    
    inputFile = freopen(INPUT_FILE_LOCATION, "r", stdin);
    outputFile = freopen(OUTPUT_FILE_LOCATION, "w", stdout);
    
    double input[MAX_SIZE][MAX_SIZE] = {0};
    double output[MAX_SIZE] = {0};
    
    // Read the Input File from Data
    
    for (int i = 0; i < MAX_SIZE; i++) {
        for (int j = 0; j < MAX_SIZE; j++) {
            scanf("%lf", &input[i][j]);
        }
    }
    
    // Matrix Calculation
    
    begin_time = clock();
    
    for (int i = 0; i < MAX_SIZE; i++) {
        for (int j = 0; j < MAX_SIZE; j++) {
            for (int k = 0; k < MAX_SIZE; k++) {
                output[i] += input[i][k] * input[j][k];
            }
        }
        printf("%.6f\n", output[i]);
    }
    
    end_time = clock();
    
    printf("CALCULATION WITHOUT SIMD: %lf", (double)(end_time - begin_time) / CLOCKS_PER_SEC);
    
    /*---------------- END of CALCULATING NUMBERS --------------*/
    
    /*
     * SIMD INSTRUCTION OF CALCULATING MATRIX's SUM WITH SSE 2
     */
    
    /*---------- START CALCULATING NUMBERS with SSE 2---------*/
    
    inputFile = freopen(INPUT_FILE_LOCATION, "r", stdin);
    outputFile = freopen(OUTPUT_SSE2_FILE_LOCATION, "w", stdout);
    
    // For Double Precision Float, ALIGNED SHOULD BE 64 BITS
    
    double input_SSE2[MAX_SIZE][MAX_SIZE] __attribute__((aligned(64)));
    double tmpMulArray_SSE2[2] __attribute__((aligned(64)));
    double tmpSumArray_SSE2[2] __attribute__((aligned(64)));
    
    __m128d *tmp1_SSE2, *tmp2_SSE2;
    
    // Read the Input File from Data
    
    for (int i = 0; i < MAX_SIZE; i++) {
        for (int j = 0; j < MAX_SIZE; j++) {
            scanf("%lf", &input_SSE2[i][j]);
        }
    }
    
    // Matrix Calculation
    
    begin_time = clock();
    
    for (int i = 0; i < MAX_SIZE; i++) {
        
        // Initialize the m128 tmpSum Array and Assign tmpSumArray with Force Convert to it.
        
        __m128d *tmpSum_SSE2 = (__m128d *) tmpSumArray_SSE2;
        
        for (int j = 0; j < MAX_SIZE; j++) {
            
            // Assign i-th row and j-th row of input_SIMD to tmp1 and tmp2.
            
            tmp1_SSE2 = (__m128d *) input_SSE2[i];
            tmp2_SSE2 = (__m128d *) input_SSE2[j];
            
            for (int k = 0; k < MAX_SIZE / 2; k++) {
                
                // MAX_SIZE / 2 : Because of _mm_***_pd does 2 data stream at once.
                // Initialize the m128 tmpMul Array and Assign tmpMulArray with Force Convert to it.
                // Do Multiple and Summation
                
                __m128d *tmpMul_SSE2 = (__m128d *) tmpMulArray_SSE2;
                
                *tmpMul_SSE2 = _mm_mul_pd(tmp1_SSE2[k], tmp2_SSE2[k]);
                *tmpSum_SSE2 = _mm_add_pd(*tmpMul_SSE2, *tmpSum_SSE2);
                
            }
        }
        
        // Print the first two Summation Array
        // Reset the temp. Summation
        
        printf("%.6f\n", tmpSumArray_SSE2[0] + tmpSumArray_SSE2[1]);
        memset(tmpSumArray_SSE2, 0, sizeof(tmpSumArray_SSE2));
    }
    
    end_time = clock();
    
    printf("CALCULATION WITH SSE2: %lf", (double)(end_time - begin_time) / CLOCKS_PER_SEC);
    
    
    // Reference: https://msdn.microsoft.com/en-us/library/7xzea3d6(v=vs.80).aspx
    // For Explaining _mm_***_pd Usage.
    
    /*---------- END of CALCULATING NUMBERS with SSE 2---------*/
    
    /*
     * SIMD INSTRUCTION OF CALCULATING MATRIX's SUM WITH AVX 2
     */
    
    /*---------- START CALCULATING NUMBERS with AVX 2---------*/
    
    inputFile = freopen(INPUT_FILE_LOCATION, "r", stdin);
    outputFile = freopen(OUTPUT_AVX_FILE_LOCATION, "w", stdout);
    
    // For Double Precision Float, ALIGNED SHOULD BE 64 BITS
    
    double input_AVX2[MAX_SIZE][MAX_SIZE] __attribute__((aligned(64)));
    double tmpMulArray_AVX2[4] __attribute__((aligned(64)));
    double tmpSumArray_AVX2[4] __attribute__((aligned(64)));
    
    __m256d *tmp1_AVX2, *tmp2_AVX2;
    
    // Read the Input File from Data
    
    for (int i = 0; i < MAX_SIZE; i++) {
        for (int j = 0; j < MAX_SIZE; j++) {
            scanf("%lf", &input_AVX2[i][j]);
        }
    }
    
    // Matrix Calculation
    
    begin_time = clock();
    
    for (int i = 0; i < MAX_SIZE; i++) {
        
        // Initialize the m128 tmpSum Array and Assign tmpSumArray with Force Convert to it.
        
        __m256d *tmpSum_AVX2 = (__m256d *) tmpSumArray_AVX2;
        
        for (int j = 0; j < MAX_SIZE; j++) {
            
            // Assign i-th row and j-th row of input_SIMD to tmp1 and tmp2.
            
            tmp1_AVX2 = (__m256d *) input_AVX2[i];
            tmp2_AVX2 = (__m256d *) input_AVX2[j];
            
            for (int k = 0; k < MAX_SIZE / 4; k++) {
                
                // MAX_SIZE / 2 : Because of _mm_***_pd does 2 data stream at once.
                // Initialize the m128 tmpMul Array and Assign tmpMulArray with Force Convert to it.
                // Do Multiple and Summation
                
                __m256d *tmpMul_AVX2 = (__m256d *) tmpMulArray_AVX2;
                
                *tmpMul_AVX2 = _mm256_mul_pd(tmp1_AVX2[k], tmp2_AVX2[k]);
                *tmpSum_AVX2 = _mm256_add_pd(*tmpMul_AVX2, *tmpSum_AVX2);
                
            }
        }
        
        // Print the first two Summation Array
        // Reset the temp. Summation
        
        printf("%.6f\n", tmpSumArray_AVX2[0] + tmpSumArray_AVX2[1] + tmpSumArray_AVX2[2] + tmpSumArray_AVX2[3]);
        memset(tmpSumArray_AVX2, 0, sizeof(tmpSumArray_AVX2));
    }
    
    end_time = clock();
    
    printf("CALCULATION WITH AVX2: %lf", (double)(end_time - begin_time) / CLOCKS_PER_SEC);
    
    
    // Reference: https://msdn.microsoft.com/en-us/library/7xzea3d6(v=vs.80).aspx
    // For Explaining _mm_***_pd Usage.
    
    /*---------- END of CALCULATING NUMBERS with AVX 2---------*/
    return 0;
}
