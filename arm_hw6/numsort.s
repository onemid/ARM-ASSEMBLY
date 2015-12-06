	.section .text
	.global NumSort
	.type NumSort, %function

NumSort:
	mov ip, sp
	stmfd sp!, {r0-r10, fp, ip, lr, pc}
	sub fp, ip, #4

	ldr r5, [ip], #4	@ Size input
	ldr r6, [ip], #4	@ Array input
	ldr r5, [r5]	@ Loading Array Size
	
	mov r0, #-4	@ ini. the outer loop counter
	mov r2, #0	@ ini. the COPY loop counter
COPY:	@ copy array content from [r6] to [r8]
	ldr r3, [r6, r2]	@ load [r6] content with pre-index to r3
	str r3, [r8, r2]	@ store content in r3 to [r8]
	add r2, r2, #4	@ add 4 to renew the load store pre-index counter
	cmp r2, r5	@ compare r2 with array size r5, if equal than exit the COPY loop
	bne COPY	@ branch to COPY
	sub r5, r5, #4	@ creating the new upper bound for next looping

OUTERLOOP:
	add r0, r0, #4	@ add 4 for outercounter
	mov r1, #-4	@ ini. the first inner loop counter
	mov r2, #0	@ ini. the second inner loop counter
INNERLOOP:
	add r1, r1, #4	@ add 4 for first innercounter
	add r2, r2, #4	@ add 4 for second innercounter
	ldr r3, [r8, r1]	@ load from [r8] array first content by first inner counter
	ldr r4, [r8, r2]	@ load from [r8] array second content by second inner counter
	cmp r3, r4	@ compare r3 r4
	strgt r4, [r8, r1]	@ if r3 > r4 then change
	strgt r3, [r8, r2]
	cmp r2, r5	@ compare r2 r5
	bne INNERLOOP	@ if not equal then continue the INNERLOOP
	cmp r0, r5	@ compare r0 r5
	bne OUTERLOOP	@ if not equan then continue the OUTERLOOP

	nop
	ldmea fp, {r0-r10, fp, sp, pc}
	.end
