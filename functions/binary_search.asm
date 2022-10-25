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
	mv	t0, a0		#t0=target
	# decide upper, lower, make length(15) a constant (put it in a non-temporary register)
	