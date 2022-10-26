 	.data
numbers:.word 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75
target:	.space 4
mes1:	.asciz "Found\n"
mes2:	.asciz "Not Found\n"

	.text
main:	la 	s1, target	# load address of s1 and put keyboard input number in it
	li	a7, 5		# read keyboard input (ReadInt)
	ecall
	mv	s1, a0		# s1=target
	la	t0, numbers	# *numbers 
	li	t2, 15		# t1: lower=0, t2: upper=15
	srli	t3, t2, 1	# t3: middle index
	jal	iiter		# make the address at the middle
loop:	lw	a0, 0(t0)	# loads the number at middle
	beq	s1, a0, fnd	# found if target and current loaded number are equal
	blt	s1, a0, sml	# else, check if target is smaller. go to sml if true
	jal	big		# can only be bigger, therefore go to big
sml:	beq	t1, t2, nfnd	# lower and upper are equal = only one number left = not found
	mv	t2, t3		# make upper the middle index
	add	t3, t1, t2
	srli	t3, t3, 1	# calculate the new middle point
	sub	t5, t2, t3	# calculate the distance between upper and middle point
	jal	miter
big:	beq	t1, t2, nfnd
	mv	t1, t3		# make lower the middle index
	add	t3, t1, t2	
	srli	t3, t3, 1	
	sub	t5, t3, t1	
	jal 	piter
miter:	addi	t0, t0, -4	# since middle point is on the left side of upper, decrease by 4
	addi	t6, t6, 1	# iter until t6 = distance between upper and middle
	blt	t6, t5, miter	
	li	t6, 0		# reinitialize t6
	jal loop
piter:	addi	t0, t0, 4	# since middle point is on the right side of lower, increase by 4
	addi	t6, t6, 1	
	blt	t6, t5, piter
	li	t6, 0
	jal loop
iiter:	addi	t0, t0, 4
	addi 	t6, t6, 1
	blt 	t6, t3, iiter	# iter until t6=t3(middle)
	li	t6, 0
	jal	loop
fnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes1		# argument a0=mes1(found)
	jal	end
nfnd:	li 	a7, 4		# syscall 4 (PrintString)
	la	a0, mes2		# argument a0=mes2(found)
end:	ecall
