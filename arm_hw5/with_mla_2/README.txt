0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program.

1. 程式內容： 
這裡是突破天際的第三版程式，把觀察矩陣乘法的規律，然後把暫存器再有效分配，整體程式碼比第二版少 13 行，比第一版程式少 34 行，然後我的腦袋為了分配暫存器真的快打結了。

作法請參照 ARM_HW5_WITHOUT_MLA 的 README

第三版程式改進內容：
(1) 觀察第二版程式之規律，發現還是有東西做兩次：Matrix B row1 row2 row3 也各會重複載入兩次，也是將他們改成 LDMIA 一口氣載入至 r5-r10，不過問題就出現了，用直覺寫 registers 不夠用，所以要先把可以不用再用到的暫存器拿過來幫忙，乘法步驟一樣，只不過要有效的利用暫存器；經過繞來繞去的寫法，我們終於把大部分的 LDR 指令通通消除了！！！！


執行環境及結果也請參照 ARM_HW5_WITHOUT_MLA 的 README

