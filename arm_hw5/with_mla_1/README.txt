0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program.

1. 程式內容： 
此為第二個版本的程式比第一版的程式，整體程式碼少 23 行。

若要看作法及執行結果請至 ARM_HW5_WITHOUT_MLA

第二版程式改進內容：
(1) 將部分 MUL 語法與 ADD 語法合併為 MLA
(2) 觀察第一版程式之規律，發現：Matrix A row 1 row 2 各會重複載入兩次，故將重複載入改為 LDMIA 一口氣載入並分配到 r2-r4，然後再做矩陣乘法。