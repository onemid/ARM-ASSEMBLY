	.section .text
	.global main
	.type main, %function
main:
	MOV r0, #26	@ Assign the first number 26 to r0
	MOV r1, #91	@ Assign the second number 91 to r1
LOOP:
	CMP r0, #1	@ if r0 == 1, means no GCD between two values
	CMPNE r1, #1	@ if r1 == 1, means no GCD between two values
	MOVEQ r0, #1	@ if r1 == 1, move 1 to r0
	CMPNE r0, r1	@ if not equals to 1, compare r0 and r1
	BEQ EXIT        @ if r0 equals to r1, then jump to EXIT	
	SUBLT r1, r1, r0	@ if r0 < r1, then r1 := r1 - r0
	SUBGT r0, r0, r1	@ if r0 > r1, then r0 := r0 - r1
        BNE LOOP	@ if not equal, then jump to LOOP again
EXIT:
	nop	@ do nothing in a cycle
	.end	@ end the program


