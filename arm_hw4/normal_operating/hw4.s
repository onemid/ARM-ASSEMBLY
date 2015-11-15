	.section .text
	.global main
	.type main, %function
main:
	MOV r0, #26	@ Assign the first number 26 to r0
	MOV r1, #91	@ Assign the second number 91 to r1
SWAP:
	CMP r0, r1	@ Compare r0 and r1
	BGT LOOP	@ if r0 > r1 then jump to LOOP
	EOR r0, r0, r1	@ Otherwise, with following XOR commands to swap the number
	EOR r1, r0, r1
	EOR r0 ,r0 ,r1	@ PS: it seems need ARMv8 to execute the command SWP
LOOP:
	CMP r0, r1	@ Compare r0 and r1
	BLT SWAP	@ if r0 < r1 then jump to SWAP
        BEQ EXIT	@ if r0 equals to r1, then jump to EXIT
	SUB r0, r0, r1	@ Otherwise, r0 := r0 - r1
        BNE LOOP	@ if not equal, then jump to LOOP again
EXIT:
	nop	@ do nothing in a cycle
	.end	@ end the program

