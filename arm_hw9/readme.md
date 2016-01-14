#* Assembly Language * HW-9
  
##0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program

##1. 程式內容：   
此次程式包含兩個部分，第一個檔案 hw9.c 為無 SIMD 指令進行矩陣運算，第二個檔案 hw9simd.c 則利用 SIMD 搭配 SSE 2 以及 AVX 2 指令進行矩陣運算，各編譯為 hw9.exe 及 hw9simd.exe，兩者程式不外乎利用迴圈，固定 1 row 與其他 row 進行乘法加總，但利用 SIMD 指令可以單一指令處理多資料，處理速度較無使用該指令者快上大約 22% (Without SIMD vs SSE 2) 及 51% (Without SIMD vs AVX 2)（註一）。

註一：於 Build Machine 進行測試。

2. 程式執行環境：  

###(1)
Build Machine 配備：MacBook Air 13” 2014 Late

CPU: Intel® Core™ i7-4650U Processor (4M Cache, up to 3.30 GHz) with SSE4.1/4.2, AVX 2.0

OS: OS X El Capitan

測試結果：
>Output without SIMD : 0.022895 sec

>Output with SSE 2 : 0.018143 sec 

>>(22% Promotion Performance with without SIMD)

>Output with AVX 2 : 0.011084 sec

>>(50% Promotion Performance with without SIMD)

>>(40% Promotion Performance with SSE 2)

###(2)
系上主機測試環境（一）：linux.cs.ccu.edu.tw

CPU: Intel® Core™ i7-920 Processor (8M Cache, 2.66 GHz, 4.80 GT/s Intel® QPI) with SSE 4.2

OS: Ubuntu 14.04.3 LTS

測試結果：
>Output without SIMD : 0.047503 sec

>Output with SSE 2 : 0.040095 sec

>>(16% Promotion Performance with without SIMD)

>Output with AVX 2 : NO DATA; THIS CPU DOES NOT SUPPORT AVX

###(3)
系上主機測試環境（二）：mcore8.cs.ccu.edu.tw

CPU: Intel® Xeon® Processor E5405  (12M Cache, 2.00 GHz, 1333 MHz FSB) with SSE4.1

OS: Ubuntu 14.04.3 LTS

測試結果：
>Output without SIMD : 0.060207 sec

>Output with SSE 2 : 0.055032 sec

>>(8% Promotion Performance with without SIMD)

>Output with AVX 2 : NO DATA; THIS CPU DOES NOT SUPPORT AVX

##3. 編譯及執行程式：  

*編譯參數： -std=c99 -msse4 -mavx2

~$ make #編譯程式

~$ make without_avx #只編譯 SSE2 及 無 SIMD 指令版本

~$ ./hw9.exe #執行 無 SIMD 指令版本

~$ ./hw9simd.exe #執行 含 SSE 之 SIMD 指令版本

~$ ./hw9simd_avx.exe #執行 含 AVX 之 SIMD 指令版本

