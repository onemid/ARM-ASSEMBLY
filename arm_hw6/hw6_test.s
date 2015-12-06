	.section .text
	.global main
	.type main, %function

main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	
	mov r0, #100
	mov r1, #200
	@ r0 indicate that memory location 100 in decimal would be the place for saving array content
	@ r1 indicate that memory location 200 in decimal would be the place for saving array size

	str r0, [sp, #-4]!
	str r1, [sp, #-4]!
	bl NumSort
	nop
	ldmea fp, {fp, sp, pc}
	.end
