	.data
numbers:.word 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75
target:	.space 4
mes1:	.asciz "Found\n"
mes2:	.asciz "Not Found\n"

	.text
main:	la 	t0, target	# int *t0=&target[0]
	li	a7, 5		# syscall 5 (ReadInt)
	ecall
	sw 	a0, 0(t0)	# *t0=a0
	mv	t0, a0		# t0=a0, t0: input number(target)
	
	la	t1, numbers	# int *t1=&numbers[0]
	li	t2, 0		# int i=0
	li	t3, 15		# int N=15

loop:	lw	a0, 0(t1)	# a0=*numbers
	beq	t0, a0, fnd	# if (target==numbers[i]) goto fnd
	addi	t2, t2, 1	# i++
	addi	t1, t1, 4	# numbers+1(4 in bits)
	blt	t2, t3, loop	# if (i<N) goto loop
	jal	nfnd		# jump to nfnd
fnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes1	# argument a0=mes1(found)
	jal	end		# goto end
nfnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes2	# argument a0=mes2(found)
end:	ecall