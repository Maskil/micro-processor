	.data
numbers:.word 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75
target:	.space 4
mes1:	.asciz "Found\n"
mes2:	.asciz "Not Found\n"

	.text
main:	la 	t0, target	# load address of t0 and put keyboard input number in it
	li	a7, 5		# read keyboard input (ReadInt)
	ecall
	mv	t0, a0		# t0=target
	la	t1, numbers	# *numbers
	li	t2, 0		# iterator t2=0
	li	t3, 15		# array size t3=15

loop:	lw	a0, 0(t1)	# a0=*numbers
	beq	t0, a0, fnd	# if (target==numbers[i]) goto fnd
	addi	t2, t2, 1	# i++
	addi	t1, t1, 4	# numbers+1(4 in bits)
	blt	t2, t3, loop	# if (i<N) goto loop
	jal	nfnd
fnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes1		# argument a0=mes1(found)
	jal	end
nfnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes2		# argument a0=mes2(found)
end:	ecall
