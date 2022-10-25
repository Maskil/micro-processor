	.data
numbers:.word 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75
target:	.space 4
mes1:	.asciz "Found\n"
mes2:	.asciz "Not Found\n"

	.text
main:	la 	s1, target
	li	a7, 5
	ecall
	mv	s1, a0		# s1=target
	
	li	s2, 15		# N=15

	la	t0, numbers	# int *s2=&numbers[0]
	# t1: lower=0, t2: upper=15
	li	t2, 15		# N=15
	srli	t3, t2, 1	# t3: middle index
	jal	iiter
loop:	lw	a0, 0(t0)
	beq	s1, a0, fnd
	blt	s1, a0, sml
	jal	big
sml:	beq	t1, t2, nfnd
	mv	t2, t3
	add	t3, t1, t2
	srli	t3, t3, 1
	sub	t5, t2, t3
	jal	miter
big:	beq	t1, t2, nfnd
	mv	t1, t3
	add	t3, t1, t2
	srli	t3, t3, 1
	sub	t5, t3, t1
	jal 	piter
miter:	addi	t0, t0, -4
	addi	t6, t6, 1
	blt	t6, t5, miter
	li	t6, 0
	jal loop
piter:	addi	t0, t0, 4
	addi	t6, t6, 1
	blt	t6, t5, miter
	li	t6, 0
	jal loop
biter:	addi	t0, t0, 4
	addi	t6, t6, 1
	blt	t6, t5, miter
	li	t6, 0
	jal loop
iiter:	addi	t0, t0, 4
	addi 	t6, t6, 1
	blt 	t6, t3, iiter
	li	t6, 0
	jal	loop
fnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes1	# argument a0=mes1(found)
	jal	end
nfnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes2	# argument a0=mes2(found)
end:	ecall