403410006 龔逸中 * Assembly Language * HW-4
  
0. 題目：  
“README.txt” file describes the features in your program and how to compile and run your program

1. 程式內容： 
此次程式的做法參考簡報中 Euclidean algorithm 的精神實作；由於在 arm 指令中的 SDIV 和 UDIV 只支援 ARMv7 以上，我們這邊似乎只有 ARMv6，實作除法有一定難度，故此次將 Euclidean ALG. 之取餘數轉化成互減之方法，在數學精神上並無差異。

然後此次作業也做了一份有 SWAP 版本還有一份沒有 SWAP 版本。

(1) Program with SWAP function code (hw4.s / hw4.exe)
首先先指定 a, b 兩值個別存放於 r0, r1 之中；再去比對兩值，若 r0 < r1 則進行 SWAP[*註一]，否則直接進入 LOOP 中進行互減，在每次互減後，將會比對 r0 與 r1 ，若 r0 > r1 則跳回 SWAP ，若 r0 == r1 則跳離，否則繼續 LOOP 相減。

註一：此次 SWAP 採三次 XOR(as EOR in instruction) 指令進行交換值。

(2) Program without SWAP function code (hw4-2.s / hw4-2.exe)
此版本的程式很讚的把 SWAP 拿掉，原本 SWAP 作用是若 r0 < r1 則互換，以利一直減下去；那麼如果用 condition code 的話或許就不用那麼麻煩了，所以最後把 SUB r0, r0, r1 改成兩條含有 condition code 的 SUBGT r0, r0, r1 和 SUBLT r1, r1, r0 ，這樣也可以，而且還省了不少步驟，最後還做了一點小優化，就是當兩數互質時，r0 或 r1 如果已經減到 1 那就直接停止運算，不要再減到 r0 == r1，這樣會少了額外的運算。

最後存放的 r0 將會放置此次計算後的 GCD ，若 a, b 為互質，則 GCD(r0) 為 1 。

2. 程式執行環境：  
Ubuntu 15.10 x64

3. 編譯及執行程式：  
~$ ./foo/bin/arm-elf-gcc -g -O0 hw4.s -o hw4.exe #編譯程式
~$ ./foo/bin/arm-elf-insight hw4.exe #利用 insight 執行並偵錯程式
** insight 執行時，target 設定為 SIMULATOR。
~$ ./foo/bin/arm-elf-run hw4.exe #這樣也是可以執行程式啦，但是會哭哭看不出來你到底執行了什麼。 
 
4. 執行結果（以下皆為十進位表示）（以 hw4.exe 為例）：
r0 = 26 //自訂為26
r1 = 91 //自訂為91；r0 < r1 go SWAP
SWAP 1 ==============================================
r0 = 91
r1 = 26 
LOOP 1 ==============================================
r0 = 65
r1 = 26 // r0 > r1 continue LOOP
LOOP 2 ==============================================
r0 = 39
r1 = 26 // r0 > r1 continue LOOP
LOOP 3 ==============================================
r0 = 13
r1 = 26 // r0 < r1 go SWAP
SWAP 2 ==============================================
r0 = 26
r1 = 13 
LOOP 4 ==============================================
r0 = 13
r1 = 13 // r0 == r1 EXIT
//END THE PROGRAM

5. 請助教笑納 ^^
6. 參考資料：  
http://www.rigwit.co.uk/ARMBook/slides/slides06.pdf
http://cseweb.ucsd.edu/~airturk/CSE30/topic07.pdf