.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- a string "Hello ARM" --- */
content:
	.ascii "Hello ARM\n"
filename:
	.ascii "demo.txt\000"

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.string:
	.word content
.open_param:
	.word filename
	.word 0x4
	.word 0x8
.write_param:
	.space 4   /* file descriptor */
	.space 4   /* address of the string */
	.space 4   /* length of the string */
.close_param:
	.space 4
main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4

        /* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2, r0                /* r2 is file descriptor */
      
        /* write "Hello ARM" to a file */
	adr r1, .write_param
	str r2, [r1, #0]          /* store file descriptor */
	
	ldr r3, .string
	str r3, [r1, #4]          /* store the address of string */

	mov r3, #9
	str r3, [r1, #8]          /* store the length of the string */

	mov r0, #SWI_Write
	swi AngelSWI

	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	
	mov r0, #SWI_Close
	swi AngelSWI

	ldmea fp, {fp, sp, pc}

