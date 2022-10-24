	.data
numbers:.word 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75
target:	.space 4
mes1:	.asciz "Found\n"
mes2:	.asciz "Not Found\n"

	.text
main:	la 	t0, target
	li	a7, 5
	ecall
	sw 	a0, 0(t0)
	mv	t0, a0
	
	la	t1, numbers
	li	t2, 15
	mv	t3, t2
	srli	t3, t3, 1
	addi	t1, t1, t3
	
	# decide upper,lower values
	
loop:	lw	a0, 0(t1)
	beq	t0, a0, fnd
	blt	t0, a0, left
	

fnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes1	# argument a0=mes1(found)
	jal	end		# goto end
nfnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes2	# argument a0=mes2(found)
end:	ecall	