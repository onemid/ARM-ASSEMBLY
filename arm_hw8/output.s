.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4
filename:
	.ascii "sort_result.txt\000"

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global FileOutput
	.type FileOutput,%function
.open_param:
	.word filename
	.word 0x4
	.word 0xf
.write_param:
	.space 4   /* file descriptor */
	.space 4   /* address of the string */
	.space 4   /* length of the string */
.close_param:
	.space 4
FileOutput:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4

	mov r8, r0	@ Move r0 to r8 previously for avoiding the conflict
	mov r9, r1	@ Move r1 ro r9 previously for avoiding the conflict
	
        /* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2, r0	@ r2 is file descriptor

	/* write a file */
	adr r1, .write_param
	str r9, [r1, #8]	@ the content length
	str r8, [r1, #4]	@ the string location
	str r2, [r1, #0]	@ the file descriptor

	mov r0, #SWI_Write
	swi AngelSWI

	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	
	mov r0, #SWI_Close
	swi AngelSWI

	ldmea fp, {fp, sp, pc}

