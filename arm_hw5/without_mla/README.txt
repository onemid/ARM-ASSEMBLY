0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program.

1. 程式內容： 
此次程式啊，看似很容易，做起來卻頗為繁複，不過看完智勝敲出的三分砲，心情舒爽，很快就寫完了；基本上只要會矩陣乘法的算法，都可以開始動工啦；這次作業隨附三個版本的程式：一個是沒有用 MLA 語法 （hw5.s/hw5.exe）（也就是兩個 registers 相乘之後再加一個 register 的值），一個是有用 MLA 語法，以及觀察矩陣乘法的規律，善用暫存器空間，把不必要的程式碼刪除（hw5_2.s/hw5_2.exe）（後來翻翻書偶然間看到，然後很開心用了～）；第二個版本的程式比第一版的程式，整體程式碼少 23 行，接下來就是突破天際的第三版程式，把觀察矩陣乘法的規律，然後把暫存器再有效分配，整體程式碼比第二版少 13 行，比第一版程式少 34 行，然後我的腦袋為了分配暫存器真的快打結了。

今天給定一個 A B C 矩陣，其中 A 是 2*3 矩陣，B 是 3*2 矩陣，C 是 2*2 矩陣， 求 (A*B)+C 的結果。

看個精美的圖解：

MATRIX A
+---+---+---+
| a | b | c |
+---+---+---+
| d | e | f |
+---+---+---+
MATRIX B
+---+---+
| a | b |
+---+---+
| c | d |
+---+---+
| e | f |
+---+---+
MATRIX X ( [A]*[B] )
+---+---+
| 1 | 2 |
+---+---+
| 3 | 4 |
+---+---+

原則上矩陣乘法給予下列公式：

1 = aAaB + bAcB + cAeB
2 = aAaB + bAdB + cAfB
3 = dAaB + eAcB + fAeB
4 = dAbB + eAdB + fAfB

我們舉 元素 1 的運算方法為例：
接著我們把這 matrix A 記憶體位置利用 LDR 搬給 r11，利用 LDR 指令依序將

[a] 第一個元素（也就是 A(1,1), aA）搬進 r2(Or any you want, and following operating registers would be the same.)
[b] 第一個元素（也就是 B(1,1), aB）搬進 r3，
再用 MUL 乘起來放在 r4，

再載入 [a] 第二個元素（也就是 A(1,2), bA）搬進 r2，
[b] 第三個元素（也就是 B(2,1), cB）搬進 r3，
再用 MUL 乘起來放在 r5，
然後 r4 := r4 + r5

最後再載入 [a] 第三個元素（也就是 A(1,3), bA）搬進 r2，
[b] 第五個元素（也就是 B(3,1), cB）搬進 r3，
再用 MUL 乘起來放在 r5，
然後 r4:=r4+r5 得出本次 X 矩陣的第一個元素；最後利用 STR 存進 mem32[r1]。

然後以此類推，做四次矩陣乘法，依序得出 Matrix X。

接下來把 C 載入至 r11，利用 LIMIA 一次從 mem32[r11] 載入多個值至 r2-r5，
再載入剛剛得出的 x （存放於 mem32[r1] 之中），載入至 r6-r9，
兩兩依序相加，再用 STMIA 存入 mem32[r1] 之中，得出 Matrix D 也就是本次題目最後的結果。

原則上就完成此次的矩陣加乘法囉！

第二版程式改進內容：
(1) 將部分 MUL 語法與 ADD 語法合併為 MLA
(2) 觀察第一版程式之規律，發現：Matrix A row 1 row 2 各會重複載入兩次，故將重複載入改為 LDMIA 一口氣載入並分配到 r2-r4，然後再做矩陣乘法。

第三版程式改進內容：
(1) 觀察第二版程式之規律，發現還是有東西做兩次：Matrix B row1 row2 row3 也各會重複載入兩次，也是將他們改成 LDMIA 一口氣載入至 r5-r10，不過問題就出現了，用直覺寫 registers 不夠用，所以要先把可以不用再用到的暫存器拿過來幫忙，乘法步驟一樣，只不過要有效的利用暫存器；經過繞來繞去的寫法，我們終於把大部分的 LDR 指令通通消除了！！！！


2. 程式執行環境：  
Ubuntu 15.10 x64

3. 編譯及執行程式：  
~$ ./foo/bin/arm-elf-gcc -g -O0 hw5.s -o hw5.exe #編譯程式
~$ ./foo/bin/arm-elf-insight hw5.exe #利用 insight 執行並偵錯程式
** insight 執行時，target 設定為 SIMULATOR。
~$ ./foo/bin/arm-elf-run hw5.exe #這樣也是可以執行程式啦，但是會哭哭看不出來你到底執行了什麼。 
 
4. 執行結果：
matrix A = [ 1 2 3 4 5 6 ] (2*3)
matrix B = [ 1 2 3 4 5 6 ] (3*2)
matrix C = [ 1 2 3 4 ] (2*2) //自訂 Matrix A B C

r1 = 0x1ffff8 (Matrix D’s memory location)
r11 = 0x1a750 (Matrix A’s memory location)
r12 = 0x1a768 (Matrix B’s memory location)

矩陣乘法後：

(mem32[r1]) 0x1ffff8-  (Matrix D 也就是暫時的 Matrix X) 
0 : 0x16 (22) --> X(1,1)
4 : 0x1c (28) --> X(1,2)
8 : 0x31 (49) --> X(2,1)
C : 0x40 (64) --> X(2,2)

之後再載入 Matrix C
r11 = 0x1a780 (Matrix C’s memory location)

矩陣加法後：

(mem32[r1]) 0x1ffff8-  (Matrix D) 
0 : 0x17 (23) --> D(1,1)
4 : 0x1e (30) --> D(1,2)
8 : 0x34 (52) --> D(2,1)
C : 0x44 (68) --> D(2,2)

//END THE PROGRAM


5. 請助教笑納，事事順心～ ^___^
