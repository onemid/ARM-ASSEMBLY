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
	
	ldr r2, [r11]	@ Loading [a]'s first element a(1,1) into r2
	ldr r3, [r12] 	@ Loading [b]'s first element b(1,1) into r3
	mul r4, r2, r3	@ Multiply r2 r3 into r4
	ldr r2, [r11, #4]	@ Loading [a]'s second element a(1,2) into r2
	ldr r3, [r12, #8]	@ Loading [b]'s third element b(2,1) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	ldr r2, [r11, #8]	@ Loading [a]'s third element a(1,3) into r2
	ldr r3, [r12, #16]	@ Loading [b]'s fifth element b(3,1) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	str r4, [r1]	@ Store r4 into mem32[r1]

	ldr r2, [r11]	@ Loading [a]'s first element a(1,1) into r2
	ldr r3, [r12, #4]	@ Loading [b]'s second element b(1,2) into r3
	mul r4, r2, r3	@ Multiply r2 r3 into r4
	ldr r2, [r11, #4]	@ Loading [a]'s second element a(1,2) into r2
	ldr r3, [r12, #12]	@ Loading [b]'s forth element b(2,2) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	ldr r2, [r11, #8]	@ Loading [a]'s third element a(1,3) into r2
	ldr r3, [r12, #20]	@ Loading [b]'s sixth element b(3,2) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	str r4, [r1, #4]	@ Store r4 into mem32[r1+4]

	ldr r2, [r11, #12]	@ Loading [a]'s forth element a(2,1) into r2
	ldr r3, [r12]	@ Loading [b]'s first element b(1,1) into r3
	mul r4, r2, r3	@ Multiply r2 r3 into r4
	ldr r2, [r11, #16]	@ Loading [a]'s fifth element a(2,2) into r2
	ldr r3, [r12, #8]	@ Loading [b]'s third element b(2,1) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	ldr r2, [r11, #20]	@ Loading [a]'s sixth element a(2,3) into r2
	ldr r3, [r12, #16]	@ Loading [b]'s fifth element b(3,1) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	str r4, [r1, #8]	@ Store r4 into mem32[r1+8]

	ldr r2, [r11, #12]	@ Loading [a]'s forth element a(2,1) into r2
	ldr r3, [r12, #4]	@ Loading [b]'s second element b(1,2) into r3
	mul r4, r2, r3	@ Multiply r2 r3 into r4
	ldr r2, [r11, #16]	@ Loading [a]'s fifth element a(2,1) into r2
	ldr r3, [r12, #12]	@ Loading [b]'s forth element b(2,2) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	ldr r2, [r11, #20]	@ Loading [a]'s sixth element a(2,3) into r2
	ldr r3, [r12, #20]	@ Loading [b]'s sixth element b(3,2) into r3
	mul r5, r2, r3	@ Multiply r2 r3 into r5
	add r4, r4, r5	@ Add r4 r5 into r4
	str r4, [r1, #12]	@ Store r4 into mem32[r1+12], then we called this matrix [x] with multiplying [a] [b] 

	ldr r11, .matrix + 8	@ Loading matrix c's (We called [c] below) memory location to r11
	ldmia r1, {r2-r5}	@ Loading r1 and increase memory location after loading each value to r2-r5
	ldmia r11, {r6-r9}	@ Loading r11 ([c]) and increase　memory location after loading each value to r6-r9
	add r2, r2, r6	@ Add r2 r6 into r2 ( c(1,1)+x(1,1) )
	add r3, r3, r7	@ Add r3 r7 into r3 ( c(1,2)+x(1,2) )
	add r4, r4, r8	@ Add r4 r8 into r4 ( c(2,1)+x(2,1) )
	add r5, r5, r9	@ Add r5 r9 into r5 ( c(2,2)+x(2,2) )
	stmia r1, {r2-r5}	@ Storing r2-r5 value with increaing memory location after saving each register value into mem32[r1]
	nop
	.end
