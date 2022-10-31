	.data
numbers:.word	2 4 8 16 32 64 128 256 512 1024

	.text
	la	t0, numbers
	li	t1, 0
	li 	t2, 10
loop:	lw 	a0, 0(t0)
	li 	a7, 1
	ecall
	li 	a0, '\n'
	li 	a7, 11
	ecall
	addi	t1, t1, 1
	addi	t0, t0, 4
	blt	t1, t2, loop