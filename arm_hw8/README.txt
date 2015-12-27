403410006 龔逸中 * Assembly Language * HW-8
  
0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program

1. 程式內容：   
此次程式包含三個部分，第一個檔案 call_numsort.c 為傳參數，第二個檔案 numsort.s 則是存放執行排序的 function，第三個檔案 output.s 則是將排序結果輸出至 sort_result.txt，三個檔案編譯為 hw8.exe ，由於此次使用 APCS 規範，所以傳參數的第一值即放入 r0 第二值 即放入 r1，回傳值統一傳回 r0。
  
參數給予後程式呼叫 NumSort 跳轉至 NumSort function，其中此排序函式採用 bubble sort 排序法，亦即陣列元素與下一元素互相比較，若該元素大於下一元素時，互相交換，重複此行為直到由小到大排序完成。

接後呼叫 FileOutput function 利用 Software Interrupt 執行 File I/O 之動作輸出排序檔案。

2. 程式執行環境：  
Ubuntu 15.10 x64

3. 編譯及執行程式：  
~$ ./foo/bin/arm-elf-gcc -g -O0 output.s call_numsort.c numsort.s -o hw8.exe #編譯程式
~$ ./foo/bin/arm-elf-insight hw8.exe #利用 insight 執行並偵錯程式
** insight 執行時，target 設定為 SIMULATOR。
~$ ./foo/bin/arm-elf-run hw8.exe #顯示 printf 後排序結果，並輸出檔案顯示其排序結果，輸出完成會在螢幕上顯示 File Output Successfully 字樣。 
 
4. 執行結果（以下皆為十進位表示）（以 hw8.exe 為例）：
sorting_array = {8,9,3,5,1,4,2,10,7,0} //欲排序的陣列內容
array_size = 10*4(half-word) //陣列大小
======================================================
排序後螢幕輸出結果：

0 1 2 3 4 5 7 8 9 10
File Output Successfully.

排序後檔案輸出結果（sort_result.txt）：

0 1 2 3 4 5 7 8 9 10

//END THE PROGRAM

5. 請助教笑納 ^^