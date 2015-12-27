	.section .text
	.global NumSort
	.type NumSort, %function

NumSort:
	mov ip, sp
	stmfd sp!, {r0-r10, fp, ip, lr, pc}
	sub fp, ip, #4

	mov r8, #-4	@ ini. the outer loop counter
	mov r2, #0	@ ini. the COPY loop counter

OUTERLOOP:
	add r8, r8, #4	@ add 4 for outercounter
	mov r2, #-4	@ ini. the first inner loop counter
	mov r3, #0	@ ini. the second inner loop counter
INNERLOOP:
	add r2, r2, #4	@ add 4 for first innercounter
	add r3, r3, #4	@ add 4 for second innercounter
	ldr r4, [r0, r2]	@ load from [r0] array first content by first inner counter
	ldr r5, [r0, r3]	@ load from [r0] array second content by second inner counter
	cmp r4, r5	@ compare r4 r5
	strgt r5, [r0, r2]	@ if r4 > r5 then change
	strgt r4, [r0, r3]
	cmp r3, r1	@ compare r3 r1
	bne INNERLOOP	@ if not equal then continue the INNERLOOP
	cmp r8, r1	@ compare r8 r1
	bne OUTERLOOP	@ if not equan then continue the OUTERLOOP

	nop
	ldmea fp, {r0-r10, fp, sp, pc}
	
	.section .data
	.type result, %object

result:
	mov r0, #40
	bl malloc
