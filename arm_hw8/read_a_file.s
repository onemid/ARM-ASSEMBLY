.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set SWI_WriteC, 0x3
.set SWI_Write, 0x5
.set SWI_Read, 0x6
.set AngelSWI, 0x123456


/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- a string --- */
.filename_addr:
	.ascii "demo.txt\000"
.readbuffer:
	.space 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.filename:
	.word .filename_addr
.open_param:
	.word .filename_addr
	.word 0x2
	.word 0x8
.read_param:
	.space 4
	.word .readbuffer
	.space 4
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
      
        /* read from a file */
	adr r1, .read_param
	str r2, [r1, #0]          /* store file descriptor */

	ldr r5, [r1, #4]          /* r5 is the address of readbuffer */

	mov r3, #1
	str r3, [r1, #8]          /* store the length of the string */

	mov r0, #SWI_Read
	swi AngelSWI
	ldrb r4, [r5, #0]         /* r4 is the read data */

	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]

	mov r0, #SWI_Close
	swi AngelSWI

	ldmea fp, {fp, sp, pc}

