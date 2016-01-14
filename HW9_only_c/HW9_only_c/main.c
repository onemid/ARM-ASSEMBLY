//
//  main.c
//  HW9_only_c
//
//  Created by GONG, YI-JHONG on 2016/1/14.
//  Copyright © 2016年 GONG, YI-JHONG. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_SIZE 200
#define BASIS_NUM 12

#define INPUT_FILE_LOCATION "data.txt"
#define OUTPUT_FILE_LOCATION "output.txt"

#define OUTPUT_SSE2_FILE_LOCATION "output_SSE.txt"
#define OUTPUT_AVX_FILE_LOCATION "output_AVX.txt"

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
    return 0;
}