	/*=======================
	*
	*  author: 403410006
	*  problem: assembly hw3
	*
	========================*/

	.section .text
	.global main
	.type main, %function
main:
	mov r0, #4000	/* r0 = 4000 */
	mov r1, r0, LSL #24	@ Logical Left Shift 24 bits to discard useless info
	mov r1, r1, LSR #24	@ Logical Right Shift 24 bits to obtain correct answer
	mov r2, r0, LSL	#16	@ Logical Left Shift 16 bits to discard 31 ~ 16 bits
	mov r2, r2, LSR #24	@ Logical Right Shift 24 bits to discard before 8th bits data and obtain the correct answer
	mov r3, r0, LSL #1	@ Logical Left Shift 1 bit to discard 31st bit
	mov r3, r3, LSR #19	@ Logical Right Shift 19 bits to discard before 18th bits data and get the right answer
	nop
	.end
