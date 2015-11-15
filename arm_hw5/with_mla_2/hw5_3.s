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
	
	ldmia r11!, {r2-r4}	@ Loading first row of [a] elements into r2-r4
	ldmia r12, {r5-r10}	@ Loading all elements of [b] into r5-r10
loop:
	mul r0, r2, r5  @ Multiply r2 r5 into unused r0
	mul r12, r2, r6 @ Multiply r2 r6 into r12 (We temporarily used r12 to saved [b]'s memory location before, but now useless.)
	mla r0, r3, r7, r0      @ Multiply r3 r7 and add r0 to r0
	mla r12, r3, r8, r12    @ Multiply r3 r8 and add r12 to r12
	mla r0, r4, r9, r0      @ Multiply r4 r9 and add r0 to r0
	mla r12, r4, r10, r12   @ Multiply r4 r10 and add r12 to r12
	cmp r11, #0	@ Compare r11 and 0
	blt exit	@ If not less than 0 then continue, or break
	stmia r1, {r0, r12}	@ Saving r0 r12 into mem32[r1]
	ldmia r11, {r2-r4}	@ Loading second row of [a] elements into r2-r4
	mov r11, #-1	@ Set r11 be -1
	b loop	@ Looping again
exit:
	ldr r10, .matrix + 8	@ Loading matrix c's (We called [c] below) memory location to r10
	ldmia r1, {r6,r7}	@ Loading values of mem32[r1] to r6 r7
	ldmia r10, {r2-r5}	@ Loading r10 ([c]) and increase　memory location after loading each value to r2-r5
	add r2, r2, r6	@ Add r2 r6 into r2 ( c(1,1)+x(1,1) )
	add r3, r3, r7	@ Add r3 r7 into r3 ( c(1,2)+x(1,2) )
	add r4, r4, r0	@ Add r4 r0 into r4 ( c(2,1)+x(2,1) )
	add r5, r5, r12	@ Add r5 r12 into r5 ( c(2,2)+x(2,2) )
	stmia r1, {r2-r5}	@ Storing r2-r5 value with increaing memory location after saving each register value into mem32[r1]
	nop
	.end
