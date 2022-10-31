	.data
idata:	.space	40

	.text
main:	la	t0, idata
	li	t1, 0
	li 	t2, 5
loop:	li	a7, 5
	ecall
	sw	a0, 0(t0)
	addi	t1, t1, 1
	addi 	t0, t0, 4
	blt	t1, t2, loop