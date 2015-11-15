/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- variable a --- */
	.type a, %object
	.size a, 24
a:
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6

/* --- variable b --- */
	.type b, %object
	.size b, 24
b:
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6

/* --- variable c --- */
	.type c, %object
	.size c, 16
c:
	.word 1
	.word 2
	.word 3
	.word 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main, %function

.matrix:
	.word a
	.word b
	.word c

main:
	ldr r11, .matrix	@ Loading matrix a's (We called [a] below) memory location to r11
	ldr r12, .matrix + 4	@ Loading matrix b's (We called [b] below) memory location to r12
	
	ldmia r11!, {r2-r4}	@ Loading [a]'s first element a(1,1) into r2
	ldr r5, [r12] 	@ Loading [b]'s first element b(1,1) into r5
	mul r6, r2, r5	@ Multiply r2 r5 into r6
	ldr r5, [r12, #8]	@ Loading [b]'s third element b(2,1) into r5
	mla r6, r3, r5, r6	@ Multiply r3 r5 and add r6 to r4
	ldr r5, [r12, #16]	@ Loading [b]'s fifth element b(3,1) into r5
	mla r6, r4, r5, r6	@ Multiply r4 r5 and add r6 to r6

	ldr r5, [r12, #4]	@ Loading [b]'s second element b(1,2) into r5
	mul r7, r2, r5	@ Multiply r2 r5 into r7
	ldr r5, [r12, #12]	@ Loading [b]'s forth element b(2,2) into r5
	mla r7, r3, r5, r7	@ Multiply r3 r5 and add r7 to r7
	ldr r5, [r12, #20]	@ Loading [b]'s sixth element b(3,2) into r5
	mla r7, r4, r5, r7	@ Multiply r4 r5 and add r7 to r7

	ldmia r11, {r2-r4}
	ldr r5, [r12]	@ Loading [b]'s first element b(1,1) into r5
	mul r8, r2, r5	@ Multiply r2 r5 into r8
	ldr r5, [r12, #8]	@ Loading [b]'s third element b(2,1) into r5
	mla r8, r3, r5, r8	@ Multiply r2 r5 and add r8 to r8
	ldr r5, [r12, #16]	@ Loading [b]'s fifth element b(3,1) into r5
	mla r8, r4, r5, r8	@ Multiply r2 r5 and add r8 to r8

	ldr r5, [r12, #4]	@ Loading [b]'s second element b(1,2) into r5
	mul r9, r2, r5	@ Multiply r2 r5 into r9
	ldr r5, [r12, #12]	@ Loading [b]'s forth element b(2,2) into r5
	mla r9, r3, r5, r9	@ Multiply r3 r5 and add r9 to r9
	ldr r5, [r12, #20]	@ Loading [b]'s sixth element b(3,2) into r5
	mla r9, r4, r5, r9	@ Multiply r4 r5 and add r9 to r9

	ldr r11, .matrix + 8	@ Loading matrix c's (We called [c] below) memory location to r11
	ldmia r11, {r2-r5}	@ Loading r11 ([c]) and increase　memory location after loading each value to r2-r5
	add r2, r2, r6	@ Add r2 r6 into r2 ( c(1,1)+x(1,1) )
	add r3, r3, r7	@ Add r3 r7 into r3 ( c(1,2)+x(1,2) )
	add r4, r4, r8	@ Add r4 r8 into r4 ( c(2,1)+x(2,1) )
	add r5, r5, r9	@ Add r5 r9 into r5 ( c(2,2)+x(2,2) )
	stmia r1, {r2-r5}	@ Storing r2-r5 value with increaing memory location after saving each register value into mem32[r1]
	nop
	.end
