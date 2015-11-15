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
	mov r4, #255	/* PUT 255 into r4 for mask */
	AND r1, r0, r4	/* r1 := r0 AND r4 */
	mov r4, r4, LSL #8	/* then Logical Left Shift r4 for 8 bits be the next mask for r2 */
	AND r2, r0, r4	/* r2 := r0 AND r4 */
	mov r2, r2, LSR #8	/* using LSR to truncate the first 8 bits from LSB */
	mov r4, #255	/* PUT 255 into r4 for mask */
	mov r4, r4, LSL #23	/* using LSL to add 23 0s (in binary) from the LSB */
	mov r5, #31	/* assign 31 to r5 */
	mov r5, r5, LSL #18	/*using LSL to add 18 0s (in binary) from the LSB */
	ADD r5, r4, r5	/* r5 := r4 + r5  for another mask*/

	/* We noticed that the arm "MOV" could move 4000(in dec) at once, so we use two times to build the r3's mask (at the begin, we move #8191 to r4 but failed when assembling, thus, we move it two times.)*/

	AND r3, r0, r5 	/* r1 := r0 AND r2 */
	mov r3, r3, LSR #18	/*using LSR ro truncate the first 18 bits from LSB */
	nop
	.end
